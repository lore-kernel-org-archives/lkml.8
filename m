Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0150CC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB2A20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgEGOIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgEGOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:07:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D6C05BD09;
        Thu,  7 May 2020 07:07:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhBL-00028f-PW; Thu, 07 May 2020 16:07:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B9BA1C03AB;
        Thu,  7 May 2020 16:07:23 +0200 (CEST)
Date:   Thu, 07 May 2020 14:07:23 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Unexport symbols only used by
 x2apic_uv_x.c
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russ Anderson <rja@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200504171527.2845224-5-hch@lst.de>
References: <20200504171527.2845224-5-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158886044339.8414.8479291364368978114.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     2bd04b6fe4fc46f3a358b62deac4912e778f36a4
Gitweb:        https://git.kernel.org/tip/2bd04b6fe4fc46f3a358b62deac4912e778f36a4
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 04 May 2020 19:15:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:32:20 +02:00

x86/platform/uv: Unexport symbols only used by x2apic_uv_x.c

uv_bios_set_legacy_vga_target, uv_bios_freq_base, uv_bios_get_sn_info,
uv_type, system_serial_number and sn_region_size are only used in
x2apic_uv_x.c, which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Not-acked-by:  Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Link: https://lkml.kernel.org/r/20200504171527.2845224-5-hch@lst.de

---
 arch/x86/platform/uv/bios_uv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 5d675c4..4494589 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -83,10 +83,7 @@ long sn_coherency_id;
 long sn_region_size;
 EXPORT_SYMBOL_GPL(sn_region_size);
 long system_serial_number;
-EXPORT_SYMBOL_GPL(system_serial_number);
 int uv_type;
-EXPORT_SYMBOL_GPL(uv_type);
-
 
 s64 uv_bios_get_sn_info(int fc, int *uvtype, long *partid, long *coher,
 		long *region, long *ssn)
@@ -113,7 +110,6 @@ s64 uv_bios_get_sn_info(int fc, int *uvtype, long *partid, long *coher,
 		*ssn = v1;
 	return ret;
 }
-EXPORT_SYMBOL_GPL(uv_bios_get_sn_info);
 
 int
 uv_bios_mq_watchlist_alloc(unsigned long addr, unsigned int mq_size,
@@ -164,7 +160,6 @@ s64 uv_bios_freq_base(u64 clock_type, u64 *ticks_per_second)
 	return uv_bios_call(UV_BIOS_FREQ_BASE, clock_type,
 			   (u64)ticks_per_second, 0, 0, 0);
 }
-EXPORT_SYMBOL_GPL(uv_bios_freq_base);
 
 /*
  * uv_bios_set_legacy_vga_target - Set Legacy VGA I/O Target
@@ -183,7 +178,6 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
 	return uv_bios_call(UV_BIOS_SET_LEGACY_VGA_TARGET,
 				(u64)decode, (u64)domain, (u64)bus, 0, 0);
 }
-EXPORT_SYMBOL_GPL(uv_bios_set_legacy_vga_target);
 
 int uv_bios_init(void)
 {
