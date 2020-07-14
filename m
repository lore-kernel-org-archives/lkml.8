Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9B6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7FEF229CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753282;
	bh=oP9oRKShRp2RQ3tQ8/TjGD6USDkXdIPoWEx+AmqqTPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aKZaBey8bGLLDqyg+0rimoaXcbNUcZB6XqWag7T27fgcm414iBVbbL3LzVnmCnz/g
	 HHtavCBiEbDHk1WsAUPon+AkxpUYDqLkjcpFxu61UxnSdNxR9rGMH3itA1WPt+kOiJ
	 whP4Eos+n2g9GOCVQ+bIOvB1ZEAh71HpOYj8xNQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgGNTBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730812AbgGNTAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:00:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40F4122AAD;
        Tue, 14 Jul 2020 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753208;
        bh=oP9oRKShRp2RQ3tQ8/TjGD6USDkXdIPoWEx+AmqqTPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1zesSEo37XsRFcvm4ZYDfBuWAdJjsr92+UB8aIrq1ykwrnZ77yQOVFllqr08yboT
         el5Mo9VBxJ+zq8GHOJ9dz8GXmnFHdk8KwDzr4GSb/p+OcjAFzKoBDQDuXJR/+sb1iW
         eb8yb7bEbn4uQ9ZyTOPAsKV4EjNmAN+73sjlWZE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.7 131/166] kprobes: Do not expose probe addresses to non-CAP_SYSLOG
Date:   Tue, 14 Jul 2020 20:44:56 +0200
Message-Id: <20200714184122.106286875@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit 60f7bb66b88b649433bf700acfc60c3f24953871 upstream.

The kprobe show() functions were using "current"'s creds instead
of the file opener's creds for kallsyms visibility. Fix to use
seq_file->file->f_cred.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 81365a947de4 ("kprobes: Show address of kprobes if kallsyms does")
Fixes: ffb9bd68ebdb ("kprobes: Show blacklist addresses as same as kallsyms does")
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2362,7 +2362,7 @@ static void report_probe(struct seq_file
 	else
 		kprobe_type = "k";
 
-	if (!kallsyms_show_value(current_cred()))
+	if (!kallsyms_show_value(pi->file->f_cred))
 		addr = NULL;
 
 	if (sym)
@@ -2463,7 +2463,7 @@ static int kprobe_blacklist_seq_show(str
 	 * If /proc/kallsyms is not showing kernel address, we won't
 	 * show them here either.
 	 */
-	if (!kallsyms_show_value(current_cred()))
+	if (!kallsyms_show_value(m->file->f_cred))
 		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL,
 			   (void *)ent->start_addr);
 	else


