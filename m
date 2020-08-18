Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D62DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3CA206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kSkjdapH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p+ULuIdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHRJCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:02:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE3DC061389;
        Tue, 18 Aug 2020 02:02:54 -0700 (PDT)
Date:   Tue, 18 Aug 2020 09:02:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597741369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4wqRwdS6S/rMMZ0V1KXv9qTHVRSZDZYPTwkqnmIat4=;
        b=kSkjdapHvC0769w0zlx2uC3jx9xWvonSDAIOsFl9IhsDU+THtGQ5EKfKXsADL1gBbc08IY
        udvtbao8maovqmZXgswgaNA6TcWpGkmvv9pKsFEDCpCOXtYiSnldsahhbyV777XmWKuSsS
        GcjFyOM8ZWiupaF7qIY42vuFaGEko2BLyzEWd4wiqdw6spBoVvdCpkfDxcK8mHdmnZLjnE
        B240UkOx1+SftlOeJN+pFd5ZQtnN2xxr4wBbYQ0eVGnA5ei0q6alhpzBJI6tkwUywOVWPR
        XgDGUrdMkiHh6113/oC5rTOO1OtkmaddXzxqGOYl13oK8o9FbyRWcRWLJNElTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597741369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4wqRwdS6S/rMMZ0V1KXv9qTHVRSZDZYPTwkqnmIat4=;
        b=p+ULuIdx2GXIZl/GxUWp4CyMDoGT5AsGCgQmNGVwvNBsNhiTcV6KNFItDs87Qaav5TTaAx
        8g2m0ExI7os0czAg==
From:   "tip-bot2 for Luca Stefani" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] RAS/CEC: Fix cec_init() prototype
Cc:     Luca Stefani <luca.stefani.ge1@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
References: <20200805095708.83939-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Message-ID: <159774136801.3192.8560665046309043144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     71aefb9a89d4ad751726ff5b902896c35c7df5b9
Gitweb:        https://git.kernel.org/tip/71aefb9a89d4ad751726ff5b902896c35c7df5b9
Author:        Luca Stefani <luca.stefani.ge1@gmail.com>
AuthorDate:    Wed, 05 Aug 2020 11:57:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 18 Aug 2020 10:50:07 +02:00

RAS/CEC: Fix cec_init() prototype

late_initcall() expects a function that returns an integer. Update the
function signature to match.

 [ bp: Massage commit message into proper sentences. ]

Fixes: 9554bfe403nd ("x86/mce: Convert the CEC to use the MCE notifier")
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20200805095708.83939-1-luca.stefani.ge1@gmail.com
---
 drivers/ras/cec.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 569d9ad..6939aa5 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -553,20 +553,20 @@ static struct notifier_block cec_nb = {
 	.priority	= MCE_PRIO_CEC,
 };
 
-static void __init cec_init(void)
+static int __init cec_init(void)
 {
 	if (ce_arr.disabled)
-		return;
+		return -ENODEV;
 
 	ce_arr.array = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!ce_arr.array) {
 		pr_err("Error allocating CE array page!\n");
-		return;
+		return -ENOMEM;
 	}
 
 	if (create_debugfs_nodes()) {
 		free_page((unsigned long)ce_arr.array);
-		return;
+		return -ENOMEM;
 	}
 
 	INIT_DELAYED_WORK(&cec_work, cec_work_fn);
@@ -575,6 +575,7 @@ static void __init cec_init(void)
 	mce_register_decode_chain(&cec_nb);
 
 	pr_info("Correctable Errors collector initialized.\n");
+	return 0;
 }
 late_initcall(cec_init);
 
