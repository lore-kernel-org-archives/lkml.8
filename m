Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5A8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C642100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392315AbgFSRtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbgFSRtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:49:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9572C06174E;
        Fri, 19 Jun 2020 10:49:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmL8R-0006PS-A6; Fri, 19 Jun 2020 19:49:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CF5441C0085;
        Fri, 19 Jun 2020 19:49:02 +0200 (CEST)
Date:   Fri, 19 Jun 2020 17:49:02 -0000
From:   "tip-bot2 for Tom Rini" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] initrd: Remove erroneous comment
Cc:     Tom Rini <trini@konsulko.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200619143056.24538-1-trini@konsulko.com>
References: <20200619143056.24538-1-trini@konsulko.com>
MIME-Version: 1.0
Message-ID: <159258894258.16989.15930098471806969630.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     eacb0c101a0bdf14de77cc9d107493e2d8d6389c
Gitweb:        https://git.kernel.org/tip/eacb0c101a0bdf14de77cc9d107493e2d8d6389c
Author:        Tom Rini <trini@konsulko.com>
AuthorDate:    Fri, 19 Jun 2020 10:30:56 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 19 Jun 2020 19:23:54 +02:00

initrd: Remove erroneous comment

Most architectures have been passing the location of an initrd via the
initrd= option since their inception.  Remove the comment as it's both
wrong and unrelated to the commit that introduced it.

For a bit more context, I assume there's been some confusion between
"initrd" being a keyword in things like extlinux.conf and also that for
quite a long time now initrd information is passed via device tree and
not the command line on relevant architectures. But it's still true that
it's been a valid command line option to the kernel since the 90s. It's
just the case that in 2018 the code was consolidated from under arch/
and in to this file.

 [ bp: Move the context clarification up into the commit message proper. ]

Fixes: 694cfd87b0c8 ("x86/setup: Add an initrdmem= option to specify initrd physical address")
Signed-off-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200619143056.24538-1-trini@konsulko.com
---
 init/do_mounts_initrd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index d72beda..53314d7 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -45,11 +45,6 @@ static int __init early_initrdmem(char *p)
 }
 early_param("initrdmem", early_initrdmem);
 
-/*
- * This is here as the initrd keyword has been in use since 11/2018
- * on ARM, PowerPC, and MIPS.
- * It should not be; it is reserved for bootloaders.
- */
 static int __init early_initrd(char *p)
 {
 	return early_initrdmem(p);
