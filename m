Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D61C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A85A20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135959;
	bh=wZ6hWFVHebHKlu0oRvqogBMKz/TtomOnDbtYE2fN/oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WbneILG9wb/HOT3t15y5YJQapyc5YtHDRiCyNmsssPSaqAIUCtySTz9KAse77nf9F
	 iCxkO376uMrqmnUAk+Yp4Zx2yCKNd+fJePvfTIUQnRZLeYRyhf+F/7YkcWLkj/pO4w
	 3cjr+ACnC2qNqFhAT9nDNjnXQ/O6TiDn/8duMaQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgGGPVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgGGPVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:21:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD792065D;
        Tue,  7 Jul 2020 15:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135306;
        bh=wZ6hWFVHebHKlu0oRvqogBMKz/TtomOnDbtYE2fN/oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ox5KZa2mgE4u56fou4tuP7GSiUe2E7MBpImaXyhkzTZhSZCKl9E+yavPsfnvlPZj8
         ChPtSx5J04/speN/QXGa5gReIF4l90uGUCVKp5yzcBy20BJT/evW+7VLVOLxzd8wNT
         bqAdoqk3pKI7sZelQ7jpV2OD1v45cJTAxNUomXhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.4 54/65] MIPS: lantiq: xway: sysctrl: fix the GPHY clock alias names
Date:   Tue,  7 Jul 2020 17:17:33 +0200
Message-Id: <20200707145755.074049343@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit 03e62fd67d3ab33f39573fc8787d89dc9b4d7255 upstream.

The dt-bindings for the GSWIP describe that the node should be named
"switch". Use the same name in sysctrl.c so the GSWIP driver can
actually find the "gphy0" and "gphy1" clocks.

Fixes: 14fceff4771e51 ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/xway/sysctrl.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -514,8 +514,8 @@ void __init ltq_soc_init(void)
 		clkdev_add_pmu("1e10b308.eth", NULL, 0, 0, PMU_SWITCH |
 			       PMU_PPE_DP | PMU_PPE_TC);
 		clkdev_add_pmu("1da00000.usif", "NULL", 1, 0, PMU_USIF);
-		clkdev_add_pmu("1e108000.gswip", "gphy0", 0, 0, PMU_GPHY);
-		clkdev_add_pmu("1e108000.gswip", "gphy1", 0, 0, PMU_GPHY);
+		clkdev_add_pmu("1e108000.switch", "gphy0", 0, 0, PMU_GPHY);
+		clkdev_add_pmu("1e108000.switch", "gphy1", 0, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "afe", 1, 2, PMU_ANALOG_DSL_AFE);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);
@@ -538,8 +538,8 @@ void __init ltq_soc_init(void)
 				PMU_SWITCH | PMU_PPE_DPLUS | PMU_PPE_DPLUM |
 				PMU_PPE_EMA | PMU_PPE_TC | PMU_PPE_SLL01 |
 				PMU_PPE_QSB | PMU_PPE_TOP);
-		clkdev_add_pmu("1e108000.gswip", "gphy0", 0, 0, PMU_GPHY);
-		clkdev_add_pmu("1e108000.gswip", "gphy1", 0, 0, PMU_GPHY);
+		clkdev_add_pmu("1e108000.switch", "gphy0", 0, 0, PMU_GPHY);
+		clkdev_add_pmu("1e108000.switch", "gphy1", 0, 0, PMU_GPHY);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
 		clkdev_add_pmu("1e116000.mei", "dfe", 1, 0, PMU_DFE);


