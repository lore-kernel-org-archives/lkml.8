Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7803206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nLitFGMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgGBX0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgGBX0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:26:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B754BC08C5E3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:26:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s14so11895115plq.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1PVeb6fv9O4tcp1xeI7Kv1tDhwIRUamp8uOCGfdP9I=;
        b=nLitFGMZ3iJQ+NRe4yjSjJbhuNgzdznGk3v2RtpFpP1PwlQyUH1mf7WdnvMVmN1Cnh
         xvPi9UCeh1KJ97EtRpXU8S0CGS0Ah25ME5FCI5J+l7/VWtNFrQ49fbHVY7DSeQEHd6Wr
         7fXIVlmNBDLWtmc/JFkRnpElggzpZi018W3FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1PVeb6fv9O4tcp1xeI7Kv1tDhwIRUamp8uOCGfdP9I=;
        b=QauWaNlOoU/jA8wr+xAuI1BbAtGpaDUOs16ODy5PMyVcWZmslf6m5/v9JzHpQSn4x0
         kaKCzxghKcrlwZsByOKcYRLv/107u5G9hOBoLYdKXwvF7oO2smIVNXl8tBB8bJRNEEov
         jmXpK9G57Cp2AoCmgPzYA5NVnDQ/TNDVB11WvuRsgxabRRdxduv8+RE7ARvnffquOijM
         4FrzZBdMrz7+EzZ6yF6WvAu/uFK/2MweK+jmh/wHP4HBWLAeh7g9VvZ1OKmDic3/FpMR
         H5ugQf0/vl4IoBhDQ/+HowRRDseXmyxU5CWskUwPnWSYcfGLb/klqTOWeHxPwddN140Q
         DLjQ==
X-Gm-Message-State: AOAM531u1lv3Tovh2GvuYREDuMdyJzcFVTjE0dO0c/4b/gZkEdtMP95U
        JtTqIR5/Up3s0desgbrdUgP9Ww==
X-Google-Smtp-Source: ABdhPJyfu/BBE/tRGfv7q63oFA9soDlr/Q/7lQtwkudUknUb/EPWGsu38RkavOGbv6Eo5VV1Ay7F3w==
X-Received: by 2002:a17:90a:840b:: with SMTP id j11mr26740951pjn.188.1593732403292;
        Thu, 02 Jul 2020 16:26:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6sm2120192pfh.176.2020.07.02.16.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:26:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Dominik Czarnota <dominik.czarnota@trailofbits.com>
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matteo Croce <mcroce@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] kprobes: Do not expose probe addresses to non-CAP_SYSLOG
Date:   Thu,  2 Jul 2020 16:26:37 -0700
Message-Id: <20200702232638.2946421-5-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702232638.2946421-1-keescook@chromium.org>
References: <20200702232638.2946421-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kprobe show() functions were using "current"'s creds instead
of the file opener's creds for kallsyms visibility. Fix to use
seq_file->file->f_cred.

Cc: stable@vger.kernel.org
Fixes: 81365a947de4 ("kprobes: Show address of kprobes if kallsyms does")
Fixes: ffb9bd68ebdb ("kprobes: Show blacklist addresses as same as kallsyms does")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index d4de217e4a91..2e97febeef77 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2448,7 +2448,7 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 	else
 		kprobe_type = "k";
 
-	if (!kallsyms_show_value(current_cred()))
+	if (!kallsyms_show_value(pi->file->f_cred))
 		addr = NULL;
 
 	if (sym)
@@ -2540,7 +2540,7 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 	 * If /proc/kallsyms is not showing kernel address, we won't
 	 * show them here either.
 	 */
-	if (!kallsyms_show_value(current_cred()))
+	if (!kallsyms_show_value(m->file->f_cred))
 		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL,
 			   (void *)ent->start_addr);
 	else
-- 
2.25.1

