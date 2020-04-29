Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0817BC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF41C2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgD2JtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgD2JtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:49:00 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410BA20775;
        Wed, 29 Apr 2020 09:48:59 +0000 (UTC)
Date:   Wed, 29 Apr 2020 05:48:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200429054857.66e8e333@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Tzvetomir was adding a feature to trace-cmd that would allow the user
to specify filtering on process IDs within a tracing instance (or
buffer). When he added this feature and tested it on tracing PIDs 1 and
2, it caused his kernel to hang.

He sent me his code and I was able to reproduce the hang as well. I
bisected it down to this commit 763802b53a42 ("x86/mm: split
vmalloc_sync_all()"). It was 100% reproducible. With the commit it
would hang, and reverting the commit, it would work.

Adding a bunch of printk()s, I found where it locked up. It was after
the recording was finished, and a write of "0" to
tracefs/instance/foo/events/enable. And in the code, it was:

(you may skip to the end of the chain)

system_enable_write() {
  __ftrace_set_clr_event() {
    __ftrace_set_clr_event_nolock() {
      ftrace_event_enable_disable() {
        __ftrace_event_enable_disable() {
          call->class->reg() <trace_event_reg()> {
            trace_point_probe_unregister() {
              tracepoint_remove_func() {
                static_key_slow_dec() {
                  __static_key_slow_dec() {

    <continued>

  __static_key_slow_dec_cpus_locked() {
    jump_label_update() {
      __jump_label_update()
        arch_jump_label_transform() {
          jump_label_transform() {
            __jump_label_transform() {
              text_poke_bp() {
                text_poke_bp_batch() {
                  text_poke() {
                    __text_poke() {

    <continued> (This is where you want to see)

  use_temporary_mm() {
    switch_mm_irqs_off() {
      load_new_mm_cr3() {
        write_cr3() <<--- Lock up!

The really strange part about this, is that this only crashes if we
filter the PIDs on an instance (and via trace-cmd, which does some
initial clean ups). But it works fine when doing from the top level
tracing buffer, or by doing this manually. I'm not sure how vmalloc
gets involved with this. Anyway, I tried the following patch, and it
fixes the lockup for both myself and Tzvetomir. But since I'm not 100%
sure what broke, I'm sending this out as an RFC.

Fixes: 763802b53a42 ("x86/mm: split vmalloc_sync_all()")
Reported-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7867dfb3963e..015dd30a2260 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -802,6 +802,8 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 	 */
 	BUG_ON(!after_bootmem);
 
+	vmalloc_sync_mappings();
+
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		if (cross_page_boundary)
