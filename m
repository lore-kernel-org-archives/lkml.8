Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60C2206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RavDLxpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGIWkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGIWkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:40:04 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1698C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 15:40:03 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id g18so4038197edu.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iqosYcn7kQPjocZvyi+NfPVq5PvGqtnjSCLp5/oKQXs=;
        b=RavDLxpZJLKohKgWzL6HD55f+hMB3P+QQOus0wp2wrm4kjDav0qJeK3m9hcaCT18yu
         Hv4gzTPyp79k4xoYh9DrZ/tikObbYHo7i01guwW7nYM0fGhuR2TGRiXcRUd5dLqUwiDp
         WYRU0DbPe0chjytzjudEN4s1tZvCVVQaAjol4GX+jD0q9X4qLqRrzPnB/NSYDrzCJ8Ht
         zkG7/CZTplxCkk19echChOtumQe6CWncIyFj0CObyLO8bXqKl6qYlpC+qzeFo/dacHvV
         edQADHrxMeOUOXch9kqvdPFx15QbuQ0yHqmdOSVoXDIs6XK3aaS/wsTjcgxxBymtBkI4
         yhMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iqosYcn7kQPjocZvyi+NfPVq5PvGqtnjSCLp5/oKQXs=;
        b=h5pYa0KieDRa962ncdWzzvqqjwGiTQtfVXWIl0W6Maom75Eka6G5JWGWzHuIezl9LV
         W0xPX0y0Xk5gKJY96OFQMlie+gifwgtukL599v/D8X/GMnAYazo457RlMHm9bmZaUH7G
         L7veG9QR97A9ypoAmxwLBoprsX/x6yXOTqLtRFfFlxx7INVJV6VeK42yoNIe9cPWD5b1
         iQPO+4uDZY8YDI9xiUAsCEXwW3f12WjrDjlpvJQX/DAZmGDQSNfHIgCc5OBM59LWq0RV
         O9Rwt1kwQnkB3b+wBC6HWNMcuG2MoAHdSXe8p7vyoQ99ufhwOHupXh9xPLgGN0EUkQKA
         DCDQ==
X-Gm-Message-State: AOAM530IjWPQWV/ve4k4fU8hctiW9S7V2Uv76QgY+fXU/wCFLl+sv7T8
        i7OZoYUcjCVDGhG9rPnn6H81UmL2RA==
X-Google-Smtp-Source: ABdhPJx7YKdcI+dRFIHHz7zvtqV/mFv+19PzycpPNaLcc/1csUi0EEyliqdHL9qrUiIPnuZFFldHqQa2+w==
X-Received: by 2002:a17:906:a055:: with SMTP id bg21mr54361093ejb.516.1594334402107;
 Thu, 09 Jul 2020 15:40:02 -0700 (PDT)
Date:   Fri, 10 Jul 2020 00:39:48 +0200
Message-Id: <20200709223948.1051613-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH resend] binder: Prevent context manager from incrementing ref 0
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>
Cc:     devel@driverdev.osuosl.org, Mattias Nissler <mnissler@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binder is designed such that a binder_proc never has references to
itself. If this rule is violated, memory corruption can occur when a
process sends a transaction to itself; see e.g.
<https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d>.

There is a remaining edgecase through which such a transaction-to-self
can still occur from the context of a task with BINDER_SET_CONTEXT_MGR
access:

 - task A opens /dev/binder twice, creating binder_proc instances P1
   and P2
 - P1 becomes context manager
 - P2 calls ACQUIRE on the magic handle 0, allocating index 0 in its
   handle table
 - P1 dies (by closing the /dev/binder fd and waiting a bit)
 - P2 becomes context manager
 - P2 calls ACQUIRE on the magic handle 0, allocating index 1 in its
   handle table
   [this triggers a warning: "binder: 1974:1974 tried to acquire
   reference to desc 0, got 1 instead"]
 - task B opens /dev/binder once, creating binder_proc instance P3
 - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
   transaction)
 - P2 receives the handle and uses it to call P3 (two-way transaction)
 - P3 calls P2 (via magic handle 0) (two-way transaction)
 - P2 calls P2 (via handle 1) (two-way transaction)

And then, if P2 does *NOT* accept the incoming transaction work, but
instead closes the binder fd, we get a crash.

Solve it by preventing the context manager from using ACQUIRE on ref 0.
There shouldn't be any legitimate reason for the context manager to do
that.

Additionally, print a warning if someone manages to find another way to
trigger a transaction-to-self bug in the future.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Signed-off-by: Jann Horn <jannh@google.com>
---
sending again because I forgot to CC LKML the first time... sorry about
the spam.

 drivers/android/binder.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f50c5f182bb5..cac65ff3a257 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2982,6 +2982,12 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_dead_binder;
 		}
 		e->to_node = target_node->debug_id;
+		if (WARN_ON(proc == target_proc)) {
+			return_error = BR_FAILED_REPLY;
+			return_error_param = -EINVAL;
+			return_error_line = __LINE__;
+			goto err_invalid_target_handle;
+		}
 		if (security_binder_transaction(proc->tsk,
 						target_proc->tsk) < 0) {
 			return_error = BR_FAILED_REPLY;
@@ -3635,10 +3641,16 @@ static int binder_thread_write(struct binder_proc *proc,
 				struct binder_node *ctx_mgr_node;
 				mutex_lock(&context->context_mgr_node_lock);
 				ctx_mgr_node = context->binder_context_mgr_node;
-				if (ctx_mgr_node)
+				if (ctx_mgr_node) {
+					if (ctx_mgr_node->proc == proc) {
+						binder_user_error("%d:%d context manager tried to acquire desc 0\n");
+						mutex_unlock(&context->context_mgr_node_lock);
+						return -EINVAL;
+					}
 					ret = binder_inc_ref_for_node(
 							proc, ctx_mgr_node,
 							strong, NULL, &rdata);
+				}
 				mutex_unlock(&context->context_mgr_node_lock);
 			}
 			if (ret)

base-commit: 2a89b99f580371b86ae9bafd6cbeccd3bfab524a
-- 
2.27.0.389.gc38d7665816-goog

