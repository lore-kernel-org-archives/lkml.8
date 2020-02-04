Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A789EC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C442082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mvX97Tfq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBDWMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:12:45 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43186 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgBDWMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:12:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id s1so44330pfh.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJphzd4Uf85jJrjWhKW7N0t3rDrhEm6RJEDIyC2Wp+M=;
        b=mvX97Tfq4mMzpXUDFwBDvSHaJpQdGdWGprU6RSPFTeqOFWvaP9yMs0ykI/wg4BBnmn
         PoCAX3HBcsnBFzCr4gsesH4ApFy3w+j2kQvW20NSu3FxGvnClvuPCTxQ4T9DuW9QQyka
         4Aumr3CkYWlSSuyWU+MJEH+IAaMQW4yPR5fGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LJphzd4Uf85jJrjWhKW7N0t3rDrhEm6RJEDIyC2Wp+M=;
        b=FuogslKqjTSpMfPebBmxm/lud0rBesvOUqOs2mzDi1U1P83OXbn9S7Mu1mTG4hOGCW
         8lw6owHzRRQ8veWyRn80eqQWWYhPOor9BtI9TZlDyLNPV45tBMnx1/2d8EK0U/weA8WH
         oZPb6/+s1/FHq8JtnhX56hFhkBk8m8hN8w2BbG9J7GxhUU/dezA/mkJfB5amqHKOoc3W
         khFAqgXbkSSEs4LKltyeKnXilszWwZZ6jMGyEHigRqnPnbZ6Qm5Ofu6f0fzQmQXr7IHc
         OCuR+QBpScol4EZlLW5bbtwuMXnjxsFmNg3d3rlev+qXc75JN4te12YPf0D68CsQraDO
         6y8A==
X-Gm-Message-State: APjAAAV00W5Xx0yeTDNhN/MF/ORlxDNIqLuHaPGeotTT6A5E+4LSyFvF
        Fb4YXgXTq0gXF+b5wMPboqnRFw==
X-Google-Smtp-Source: APXvYqxCQdUqXfhZc+Oe9uYvCKV/DUPxqKgxt4to10QLL9Kq/2IQ/TU+fehc8Lr/r4dYpQ9nDv6Z4w==
X-Received: by 2002:a63:ce03:: with SMTP id y3mr21880478pgf.427.1580854363613;
        Tue, 04 Feb 2020 14:12:43 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q21sm25033209pff.105.2020.02.04.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 14:12:43 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Anatoly Pugachev <matorola@gmail.com>
Cc:     sparclinux@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] kdb: Fix compiling on architectures w/out DBG_MAX_REG_NUM defined
Date:   Tue,  4 Feb 2020 14:12:25 -0800
Message-Id: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd"
if current task has no regs") I tried to clean things up by using "if"
instead of "#ifdef".  Turns out we really need "#ifdef" since not all
architectures define some of the structures that the code is referring
to.

Let's switch to #ifdef again, but at least avoid using it inside of
the function.

Fixes: bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd" if current task has no regs")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't have a sparc64 compiler but I'm pretty sure this should work.
Testing appreciated.

 kernel/debug/kdb/kdb_main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index b22292b649c4..c84e61747267 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1833,6 +1833,16 @@ static int kdb_go(int argc, const char **argv)
 /*
  * kdb_rd - This function implements the 'rd' command.
  */
+
+/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
+#if DBG_MAX_REG_NUM <= 0
+static int kdb_rd(int argc, const char **argv)
+{
+	if (!kdb_check_regs())
+		kdb_dumpregs(kdb_current_regs);
+	return 0;
+}
+#else
 static int kdb_rd(int argc, const char **argv)
 {
 	int len = 0;
@@ -1847,12 +1857,6 @@ static int kdb_rd(int argc, const char **argv)
 	if (kdb_check_regs())
 		return 0;
 
-	/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
-	if (DBG_MAX_REG_NUM <= 0) {
-		kdb_dumpregs(kdb_current_regs);
-		return 0;
-	}
-
 	for (i = 0; i < DBG_MAX_REG_NUM; i++) {
 		rsize = dbg_reg_def[i].size * 2;
 		if (rsize > 16)
@@ -1896,6 +1900,7 @@ static int kdb_rd(int argc, const char **argv)
 
 	return 0;
 }
+#endif
 
 /*
  * kdb_rm - This function implements the 'rm' (register modify)  command.
-- 
2.25.0.341.g760bfbb309-goog

