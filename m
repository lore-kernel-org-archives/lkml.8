Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D33C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAB9220661
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmnTM02F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgD1HQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:16:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32768 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgD1HQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588058211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0B3gnfAi+vC2wNO8K4I/DfPuZmGhtWSGMZXgFSeqqJA=;
        b=TmnTM02FZkvw3FiJSOb01mbRKqrPYsYi7yD06BBxEQObplgrgy0Rs95LQBED7sekuyiaPW
        hmXUBNJ6Lf1JZuAZ6GttsXi34IOFeNyiDIcuM0Y6hPQKLNHTRN6j7JRzzxXFzkOb2SvHOm
        Vx+FnF6Mja54BCYfNYF456Ug8sM76Uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-NMKKXlh1OaaR_bN8nV9F5A-1; Tue, 28 Apr 2020 03:16:45 -0400
X-MC-Unique: NMKKXlh1OaaR_bN8nV9F5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C04F107ACCD;
        Tue, 28 Apr 2020 07:16:43 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4814F5C1B2;
        Tue, 28 Apr 2020 07:16:41 +0000 (UTC)
Date:   Tue, 28 Apr 2020 02:16:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/unwind/orc: Move ORC sorting variables under
 CONFIG_MODULE
Message-ID: <20200428071640.psn5m7eh3zt2in4v@treble>
References: <20200428162910.0dee6f52@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428162910.0dee6f52@canb.auug.org.au>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings seen with !CONFIG_MODULE:

  arch/x86/kernel/unwind_orc.c:29:26: warning: 'cur_orc_table' defined but not used [-Wunused-variable]
     29 | static struct orc_entry *cur_orc_table = __start_orc_unwind;
        |                          ^~~~~~~~~~~~~
  arch/x86/kernel/unwind_orc.c:28:13: warning: 'cur_orc_ip_table' defined but not used [-Wunused-variable]
     28 | static int *cur_orc_ip_table = __start_orc_unwind_ip;
        |             ^~~~~~~~~~~~~~~~

Fixes: 153eb2223c79 ("x86/unwind/orc: Convert global variables to static")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 0ebc11a8bb45..5b0bd8581fe6 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -24,10 +24,6 @@ extern struct orc_entry __stop_orc_unwind[];
 static bool orc_init __ro_after_init;
 static unsigned int lookup_num_blocks __ro_after_init;
 
-static DEFINE_MUTEX(sort_mutex);
-static int *cur_orc_ip_table = __start_orc_unwind_ip;
-static struct orc_entry *cur_orc_table = __start_orc_unwind;
-
 static inline unsigned long orc_ip(const int *ip)
 {
 	return (unsigned long)ip + *ip;
@@ -192,6 +188,10 @@ static struct orc_entry *orc_find(unsigned long ip)
 
 #ifdef CONFIG_MODULES
 
+static DEFINE_MUTEX(sort_mutex);
+static int *cur_orc_ip_table = __start_orc_unwind_ip;
+static struct orc_entry *cur_orc_table = __start_orc_unwind;
+
 static void orc_sort_swap(void *_a, void *_b, int size)
 {
 	struct orc_entry *orc_a, *orc_b;
-- 
2.21.1

