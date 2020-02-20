Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6CBC34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940C724656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hE28D14b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBTGXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33564 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgBTGXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id n7so1405414pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KDL37BgDk/5hTL1aygm8F5m/3WsNy7EX3MegTZpHh8A=;
        b=hE28D14boNTmJ1vj0aiii9wgqR4x726AYt0+Ugz1vZZxyNY/ZjRyjStYJ/E86o9UZQ
         m+ILEBowROnzV6IEZacRqVHipZV2ubqx1exLZGnLz532+kkOuDI07VE0085ZhhSVT6BX
         PBBz06hnw5jDBaa5zAzGTaC7k047+cizE829A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KDL37BgDk/5hTL1aygm8F5m/3WsNy7EX3MegTZpHh8A=;
        b=mi7H9VFjOkPeHG7w3xmz6JU1PLq6hubvLYfsHYqzcnNEkgExMOF7vxcEa40fPTBjIr
         4/Ve2188f/Yp6FH3m5HvutFfxazO+reWn88H16IU+QE4V6+MHu8iBg9rljkMSPNGtv0E
         TuYbaZ9aUXJu+vx4SdiCXgms9bXVrtwvLkfhhNGQ/lNDTE62agep+u34TMm8iTlV7onb
         obs3yHbzdxnhgxgO49qUGCLunteP+u0mLcWsDMRMPd27s43DUHSzY1yopC+IytJ0gr5u
         fsD72aYdwOg9jfq7Qmj0i0ScemvlNZm+Oohm+dbonGKkjCx4RjHj6TWTNrmuVtscbhxq
         x7Bg==
X-Gm-Message-State: APjAAAWkxdGXf6ufunPWsIGRrqwkhAfNNmHPyVJw6lAT5Z000VgjoRu3
        rneCyYfDRv2go76RDfHbU4Uq4w==
X-Google-Smtp-Source: APXvYqwClzmaR771bSUMDQ76QXcQ9gHM+Y7s77UVkVWl9nHyOMS3rkIB6M1k/7iT21xhJ1goPJEBhg==
X-Received: by 2002:a62:1cd6:: with SMTP id c205mr30460282pfc.179.1582179779343;
        Wed, 19 Feb 2020 22:22:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a35sm1886088pgl.20.2020.02.19.22.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:22:58 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fcntl: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:22:43 -0800
Message-Id: <20200220062243.68809-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

fs/fcntl.c: In function ‘send_sigio_to_task’:
fs/fcntl.c:738:20: warning: statement will never be executed [-Wswitch-unreachable]
  738 |   kernel_siginfo_t si;
      |                    ^~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/fcntl.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9bc167562ee8..2e4c0fa2074b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -735,8 +735,9 @@ static void send_sigio_to_task(struct task_struct *p,
 		return;
 
 	switch (signum) {
-		kernel_siginfo_t si;
-		default:
+		default: {
+			kernel_siginfo_t si;
+
 			/* Queue a rt signal with the appropriate fd as its
 			   value.  We use SI_SIGIO as the source, not 
 			   SI_KERNEL, since kernel signals always get 
@@ -769,6 +770,7 @@ static void send_sigio_to_task(struct task_struct *p,
 			si.si_fd    = fd;
 			if (!do_send_sig_info(signum, &si, p, type))
 				break;
+		}
 		/* fall-through - fall back on the old plain SIGIO signal */
 		case 0:
 			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);

