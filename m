Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE7BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1B8E2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135599;
	bh=wZ6hWFVHebHKlu0oRvqogBMKz/TtomOnDbtYE2fN/oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ycsKsjC3Y8dblHbpHQ94XBwmSd7gqvprY9YoiQA0MpIUPgXeECCwFiHBE+N2Bvrvm
	 lQOxIcBM/vcrTwK79HwK2Fyt8jRg5OeU8oyZfAyc76z+sWOaaaVHVwItZoCOZTGt91
	 vo54UP6CUIFT+h4nYvc7H20Bv6wYfemo7Zqmvh4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgGGP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgGGP01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:26:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870FE2078D;
        Tue,  7 Jul 2020 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135587;
        bh=wZ6hWFVHebHKlu0oRvqogBMKz/TtomOnDbtYE2fN/oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkPv5XydyxzltyZf4vKbKoHSTrMYisV8kiz4Pf0YUgCH0w6z8XJRtoTX4pgESVbDc
         zis/uCcYl5hal2iXvh0DwQfMNBB90gtnr1SfVQNyxXh+B1L4Ai9GgZLQBCZrNY+3eq
         D4dkmJ3GTe43Rf7lz32XjQHpNCPEC2wYtqDYjCmg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.7 100/112] MIPS: lantiq: xway: sysctrl: fix the GPHY clock alias names
Date:   Tue,  7 Jul 2020 17:17:45 +0200
Message-Id: <20200707145805.733083820@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
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


