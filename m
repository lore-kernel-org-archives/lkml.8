Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D54BC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8B82073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgAQNna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:43:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56203 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgAQNna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:43:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isRuH-0000sJ-JM; Fri, 17 Jan 2020 14:43:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DA3001C19DF;
        Fri, 17 Jan 2020 14:43:24 +0100 (CET)
Date:   Fri, 17 Jan 2020 13:43:24 -0000
From:   "tip-bot2 for Wei Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/hyperv] x86/hyper-v: Add "polling" bit to hv_synic_sint
Cc:     Wei Liu <wei.liu@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191222233404.1629-1-wei.liu@kernel.org>
References: <20191222233404.1629-1-wei.liu@kernel.org>
MIME-Version: 1.0
Message-ID: <157926860444.396.6394055329835484109.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/hyperv branch of tip:

Commit-ID:     538f127cd3bcf76071139f4bfe9cc3b2a46f3b3d
Gitweb:        https://git.kernel.org/tip/538f127cd3bcf76071139f4bfe9cc3b2a46f3b3d
Author:        Wei Liu <wei.liu@kernel.org>
AuthorDate:    Sun, 22 Dec 2019 23:34:04 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jan 2020 14:38:21 +01:00

x86/hyper-v: Add "polling" bit to hv_synic_sint

That bit is documented in TLFS 5.0c as follows:

  Setting the polling bit will have the effect of unmasking an
  interrupt source, except that an actual interrupt is not generated.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20191222233404.1629-1-wei.liu@kernel.org

---
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 5f10f7f..92abc1e 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -809,7 +809,8 @@ union hv_synic_sint {
 		u64 reserved1:8;
 		u64 masked:1;
 		u64 auto_eoi:1;
-		u64 reserved2:46;
+		u64 polling:1;
+		u64 reserved2:45;
 	} __packed;
 };
 
