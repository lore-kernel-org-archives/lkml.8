Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DCB2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579781419;
	bh=xVC+of4wwHUmBPk3J4W40b+AoZu4hwXIqW9ignswEJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J9qeodCtFmoM7PHV5UpCiTYg3R/0g5g5QktR6Stk54IQ1QbnssOOBhuYsNJPGgs9i
	 8I84tWmlBV7XnA9fy7CUM85JMeXXxQF4SmB/RP22YgAUAW0g+CufLMDJCJGidr8fmz
	 /GjXhPe+iSQPZumaoAKg80w07jdRpdsBLNzEcxC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAWMKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:10:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgAWMKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:10:18 -0500
Received: from linux-8ccs (x2f7fea8.dyn.telefonica.de [2.247.254.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 368AE2253D;
        Thu, 23 Jan 2020 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579781417;
        bh=xVC+of4wwHUmBPk3J4W40b+AoZu4hwXIqW9ignswEJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W4eKy3R8Ayy+tpLYSr62z7a1B4h4BFSIyBoED+15X/BvAa8a3ydZvATj73fi9Hpxj
         qd7W6qYOq1/6VmSHRnQvmcLYLykfIfdFgBFaYUrSpYGtjk1bItgtB8LfdU/HvgBf/+
         6jZidqSQ2dhAoyNEQG8i7kFw4MW+hxqJ1TbEA6NE=
Date:   Thu, 23 Jan 2020 13:10:10 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] kernel: module: Pass lockdep expression to RCU lists
Message-ID: <20200123121010.GA9011@linux-8ccs>
References: <20200121124745.14864-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200121124745.14864-1-frextrite@gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Amol Grover [21/01/20 18:17 +0530]:
>modules is traversed using list_for_each_entry_rcu outside an
>RCU read-side critical section but under the protection
>of module_mutex or with preemption disabled.
>
>Hence, add corresponding lockdep expression to silence false-positive
>lockdep warnings, and harden RCU lists.
>
>list_for_each_entry_rcu when traversed inside a preempt disabled
>section, doesn't need an explicit lockdep expression since it is
>implicitly checked for.
>
>Add macro for the corresponding lockdep expression.
>
>Signed-off-by: Amol Grover <frextrite@gmail.com>

Hi Amol!

Masami already submitted a patch for this, it's been in linux-next for
a while. See commit bf08949cc8b9 ("modules: lockdep: Suppress
suspicious RCU usage warning").

Thanks!

Jessica

>---
> kernel/module.c | 12 +++++++-----
> 1 file changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/kernel/module.c b/kernel/module.c
>index b56f3224b161..2425f58159dd 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -84,6 +84,8 @@
>  * 3) module_addr_min/module_addr_max.
>  * (delete and add uses RCU list operations). */
> DEFINE_MUTEX(module_mutex);
>+#define module_mutex_held() \
>+	lockdep_is_held(&module_mutex)
> EXPORT_SYMBOL_GPL(module_mutex);
> static LIST_HEAD(modules);
>
>@@ -214,7 +216,7 @@ static struct module *mod_find(unsigned long addr)
> {
> 	struct module *mod;
>
>-	list_for_each_entry_rcu(mod, &modules, list) {
>+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> 		if (within_module(addr, mod))
> 			return mod;
> 	}
>@@ -448,7 +450,7 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
> 	if (each_symbol_in_section(arr, ARRAY_SIZE(arr), NULL, fn, data))
> 		return true;
>
>-	list_for_each_entry_rcu(mod, &modules, list) {
>+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> 		struct symsearch arr[] = {
> 			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
> 			  NOT_GPL_ONLY, false },
>@@ -616,7 +618,7 @@ static struct module *find_module_all(const char *name, size_t len,
>
> 	module_assert_mutex_or_preempt();
>
>-	list_for_each_entry_rcu(mod, &modules, list) {
>+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
> 			continue;
> 		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
>@@ -2040,7 +2042,7 @@ void set_all_modules_text_rw(void)
> 		return;
>
> 	mutex_lock(&module_mutex);
>-	list_for_each_entry_rcu(mod, &modules, list) {
>+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> 		if (mod->state == MODULE_STATE_UNFORMED)
> 			continue;
>
>@@ -2059,7 +2061,7 @@ void set_all_modules_text_ro(void)
> 		return;
>
> 	mutex_lock(&module_mutex);
>-	list_for_each_entry_rcu(mod, &modules, list) {
>+	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> 		/*
> 		 * Ignore going modules since it's possible that ro
> 		 * protection has already been disabled, otherwise we'll
>-- 
>2.24.1
>
