Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E32C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5171207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="any8Nbub";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fQz8yGbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHSX0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgHSX0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:26:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 16:26:35 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597879593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMf/nT9eL9kC96IVIdb2DFMZa/yCkHHfjYi/F1/+S+4=;
        b=any8NbubutrdkhAty88kVs5CgqM/2zVy3VwdeRv1MDXYSw6p97oMrOMc5wx8Y9IdCXRD50
        NKM9XMIiAurfTmlYsBsa8GMvKAUPBfC4nZcoSoHJ5q/xFiUnJb3ZILHvMKII2E9eP8/muq
        OcouL0kyajwxO6MfsedBY+UAD5PQFVMxEvYtPiO9CoXcoS+qtR39LK4t49oqBg6M2/xb/c
        eT1TmCfYp+o+2ViMrY9NIj0NFVzvqZy2PBMzFOZfOfySZLo3A58+tbmVvNtq7vk2CKuUNh
        7CaW5f0c07MTcrM7hFqZTkCcK1zzgbNa++Rb7grtyKFh2qanObU36NWjt7oGmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597879593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMf/nT9eL9kC96IVIdb2DFMZa/yCkHHfjYi/F1/+S+4=;
        b=fQz8yGbxegioyjmvCZ1t9pk9enn+j+aP/6lvSL1qeC5GR5s8r9c7uNwYLD/vCkltGFErLt
        aAhAUR2Zl/VVpGAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] sysrq: use pr_cont_t for cont messages
Date:   Thu, 20 Aug 2020 01:32:29 +0206
Message-Id: <20200819232632.13418-3-john.ogness@linutronix.de>
In-Reply-To: <20200819232632.13418-1-john.ogness@linutronix.de>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pr_cont_t mechanism.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/sysrq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index a8e39b2cdd55..be2aa816c444 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -572,7 +572,9 @@ void __handle_sysrq(int key, bool check_mask)
 			console_loglevel = orig_log_level;
 		}
 	} else {
-		pr_info("HELP : ");
+		pr_cont_t c;
+
+		pr_cont_begin(&c, KERN_INFO "HELP : ");
 		/* Only print the help msg once per handler */
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
 			if (sysrq_key_table[i]) {
@@ -583,10 +585,10 @@ void __handle_sysrq(int key, bool check_mask)
 					;
 				if (j != i)
 					continue;
-				pr_cont("%s ", sysrq_key_table[i]->help_msg);
+				pr_cont_append(&c, "%s ", sysrq_key_table[i]->help_msg);
 			}
 		}
-		pr_cont("\n");
+		pr_cont_end(&c);
 		console_loglevel = orig_log_level;
 	}
 	rcu_read_unlock();
-- 
2.20.1

