Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3177C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 708AF20752
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="blhPcHYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgEDR0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729896AbgEDR0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:26:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59495C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 10:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1LTa3+KheQ5v1ObwivcHllaOHb1LlbllYguCQhIzs40=; b=blhPcHYL04vlWWEZqgtWh1cCVm
        7f5FZUTBaX2XlwjygqrDkbbVgc9FU/SOKpUR+fkbp9eikZZwG06DhKDaS629B7dMLkJyGbdv1rlf+
        d39DilZDs5e7QBSssmI33YmqFPP1bjHy5u5OEIgw8B3IQrAPM5C4bQZxRsUiX/ReS9h2P4RpCWYcU
        ca1rHcxV5ThyAXmph0NkTEZVnX41JqDDiQtnRzBNkgsYZzeMTtkp8LpQScatNBUecZFhcS24qUdCp
        GGRiIpL+s3kRv3X1F4qH620iS89T0Dc/i6C1KJDTxVvZ2dyxt3jxb3FQsehRgt4NROkPlRdqzsZmg
        cJYOVl+A==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVerS-0003jr-A3; Mon, 04 May 2020 17:26:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Mike Travis <mike.travis@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] x86/uv: Unexport symbols only used by x2apic_uv_x.c
Date:   Mon,  4 May 2020 19:15:20 +0200
Message-Id: <20200504171527.2845224-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504171527.2845224-1-hch@lst.de>
References: <20200504171527.2845224-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uv_bios_set_legacy_vga_target, uv_bios_freq_base, uv_bios_get_sn_info,
uv_type, system_serial_number and sn_region_size are only used in
x2apic_uv_x.c, which can't be modular.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/platform/uv/bios_uv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 5d675c4f459b4..4494589a288ae 100644
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
-- 
2.26.2

