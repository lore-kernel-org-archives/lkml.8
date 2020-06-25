Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FBFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2139020702
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404418AbgFYLxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404374AbgFYLxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323C3C061573;
        Thu, 25 Jun 2020 04:53:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRh-0005sf-Qz; Thu, 25 Jun 2020 13:53:33 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 69F5D1C0092;
        Thu, 25 Jun 2020 13:53:33 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:33 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] objtool: Don't consider vmlinux a C-file
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200618144801.701257527@infradead.org>
References: <20200618144801.701257527@infradead.org>
MIME-Version: 1.0
Message-ID: <159308601322.16989.8335361589316062237.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     734d099ba644f5a92c70efa3d54d0ba2500ce162
Gitweb:        https://git.kernel.org/tip/734d099ba644f5a92c70efa3d54d0ba2500ce162
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 17 Jun 2020 18:22:31 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:39 +02:00

objtool: Don't consider vmlinux a C-file

Avoids issuing C-file warnings for vmlinux.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200618144801.701257527@infradead.org
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3e214f8..d8eaa7d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2772,7 +2772,7 @@ int check(const char *_objname, bool orc)
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
-	file.c_file = find_section_by_name(file.elf, ".comment");
+	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
 
