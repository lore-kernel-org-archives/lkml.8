Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F283C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B932080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgCXWc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:32:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46384 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgCXWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:32:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGs5m-0006rZ-Hl; Tue, 24 Mar 2020 23:32:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2F9A71C0470;
        Tue, 24 Mar 2020 23:32:14 +0100 (CET)
Date:   Tue, 24 Mar 2020 22:32:13 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] hwrng: via_rng: Convert to new X86 CPU match macros
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320131510.793641638@linutronix.de>
References: <20200320131510.793641638@linutronix.de>
MIME-Version: 1.0
Message-ID: <158508913387.28353.5741696862858938987.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     315d01d1ad39f940c5156d6b2653bf89182422a9
Gitweb:        https://git.kernel.org/tip/315d01d1ad39f940c5156d6b2653bf89182422a9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 20 Mar 2020 14:14:06 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Mar 2020 21:36:26 +01:00

hwrng: via_rng: Convert to new X86 CPU match macros

The new macro set has a consistent namespace and uses C99 initializers
instead of the grufty C89 ones.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/20200320131510.793641638@linutronix.de
---
 drivers/char/hw_random/via-rng.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
index ffe9b0c..39943bc 100644
--- a/drivers/char/hw_random/via-rng.c
+++ b/drivers/char/hw_random/via-rng.c
@@ -209,20 +209,19 @@ static int __init mod_init(void)
 out:
 	return err;
 }
+module_init(mod_init);
 
 static void __exit mod_exit(void)
 {
 	hwrng_unregister(&via_rng);
 }
-
-module_init(mod_init);
 module_exit(mod_exit);
 
 static struct x86_cpu_id __maybe_unused via_rng_cpu_id[] = {
-	X86_FEATURE_MATCH(X86_FEATURE_XSTORE),
+	X86_MATCH_FEATURE(X86_FEATURE_XSTORE, NULL),
 	{}
 };
+MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
 
 MODULE_DESCRIPTION("H/W RNG driver for VIA CPU with PadLock");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
