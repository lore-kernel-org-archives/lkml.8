Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD94C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C65B207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QVTFmZER";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cyjiHUF9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHTIgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:36:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45566 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:36:49 -0400
Date:   Thu, 20 Aug 2020 08:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597912607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPQJ7JrZ5CqhutwMz/C3oOY0pZOyWqVbytGXXAMpzag=;
        b=QVTFmZERZoCIU0TxvjF+Y8dooP3OYwR2l8gX1nlklLGhlDzaVoBv0xBwQgNhWQhvyPS8xt
        u+i+W89uJGWzYmWmHC2uQBQF+pS42ygAUK7bwPNzx1J/G888Jqata4pk17pFK/NLYcFQFN
        KxGBb9MbAqwGkIsjfhS2765bsw5nW1N/+ObuzoMykSROg6mOhaeSGcqVV37Mq+lYvQbscF
        8WcJIZHhn1o6ErJzQCUu6R7GobkDHZnEI/EytekXPKeWlqHUj4YFQsXVCzDNZuDi0TWyJB
        krwJEFN7TMFo7y4iX5gCr9Zq8GA2KzywK7RQcADXukSv8FbWlZOz4tljyk7ZmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597912607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPQJ7JrZ5CqhutwMz/C3oOY0pZOyWqVbytGXXAMpzag=;
        b=cyjiHUF9WBN1ClWM8l5G6XyCY3FAckUPYv/BqHwLSYDK3W7EbnhL/Cm3ITmj0VOS30D+zj
        IEs46C8cXKVLBnBw==
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
Message-ID: <159791260687.3192.7735800847323223994.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     85e6084e0b436cabe9c909e679937998ffbf9c9d
Gitweb:        https://git.kernel.org/tip/85e6084e0b436cabe9c909e679937998ffbf9c9d
Author:        Luca Stefani <luca.stefani.ge1@gmail.com>
AuthorDate:    Wed, 05 Aug 2020 11:57:08 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 20 Aug 2020 10:33:33 +02:00

RAS/CEC: Fix cec_init() prototype

late_initcall() expects a function that returns an integer. Update the
function signature to match.

 [ bp: Massage commit message into proper sentences. ]

Fixes: 9554bfe403bd ("x86/mce: Convert the CEC to use the MCE notifier")
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
 
