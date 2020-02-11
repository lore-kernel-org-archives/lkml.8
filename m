Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8330C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984C120637
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgBKMrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:47:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45917 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgBKMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:47:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Ux0-0007X1-Ql; Tue, 11 Feb 2020 13:47:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C6911C2019;
        Tue, 11 Feb 2020 13:47:38 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:47:38 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/objtool] objtool: Fail the kernel build on fatal errors
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158142525822.411.5401976987070210798.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/objtool branch of tip:

Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00

objtool: Fail the kernel build on fatal errors

When objtool encounters a fatal error, it usually means the binary is
corrupt or otherwise broken in some way.  Up until now, such errors were
just treated as warnings which didn't fail the kernel build.

However, objtool is now stable enough that if a fatal error is
discovered, it most likely means something is seriously wrong and it
should fail the kernel build.

Note that this doesn't apply to "normal" objtool warnings; only fatal
ones.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Julien Thierry <jthierry@redhat.com>
Link: https://lkml.kernel.org/r/f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4768d91..796f6a1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2491,8 +2491,14 @@ int check(const char *_objname, bool orc)
 out:
 	cleanup(&file);
 
-	/* ignore warnings for now until we get all the code cleaned up */
-	if (ret || warnings)
-		return 0;
+	if (ret < 0) {
+		/*
+		 *  Fatal error.  The binary is corrupt or otherwise broken in
+		 *  some way, or objtool itself is broken.  Fail the kernel
+		 *  build.
+		 */
+		return ret;
+	}
+
 	return 0;
 }
