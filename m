Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8887CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8FC2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KRvNnNJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEOO1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:27:50 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:49885 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgEOO1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589552869; x=1621088869;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0AgeZMJbdU9KyuRMCIUBu9McO6vER1rNgjfIxpR274I=;
  b=KRvNnNJB0HVfuseGhqUR63+tun9Xkdo6d/3QrajlL0Tfh9Jc17y170Yb
   kD5c6nM5fsesBe8rS6H9hUsJnZ2/MllbY+3agriQnImwOTuvQU/IpWC78
   q/BYCzaviqRISummCmCUx5TMKcILJX3IShHMHWWHo5Vll2S5TudZtTvhd
   zqDBWWQKG1WeC7l4ud8e2Gej1WV55kea+4SUCAT94hTPuIUnN12Ktrh9P
   sVTfoHV5xjJzWssdjN0rATcCGmTU23Jv+AJTxQR/i6/5OI7a+qsTwHc6Y
   NiXmo2A6NGJ+4rn5Y2/6OoiGefoR3T9jUZ/A4o/yIA2XSbzp6CFtDyn7u
   A==;
IronPort-SDR: zUxu1mdSuJ3C0VOKq9t5RCnhqUBxbNxPvczwXo6LzTRvz2lQnXu5v7wXQKdVigzrMMpTz+EdSc
 /MirwJyXyPyEidppEp8ncornFCklQ36fIhbgdDnhbU8rN9l6orsNmkgOhAjAEXM8UuqQ/ySa5E
 +a7PjsZosn5Ix6XFhtnJfPzZ3yXxevmfP4rlZunzd5bqvt19NPOqhgDkrvvj98X+VjL5NxGyoj
 i1pXdHglL1KVHqkuXR/eAM1KydX0NQ9Ueihi0USx9WZ4syPGEFkz2ZHuDoruZcE7S6ETh73DxU
 aJg=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="73584368"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 07:27:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 07:27:50 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 15 May 2020 07:27:30 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <eugen.hristev@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH] clk: at91: Add peripheral clock for PTC
Date:   Fri, 15 May 2020 17:27:20 +0300
Message-ID: <20200515142720.290206-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PMC generates the peripheral clock for the PTC.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/clk/at91/sama5d2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
index ff7e3f727082..73b287fbecb8 100644
--- a/drivers/clk/at91/sama5d2.c
+++ b/drivers/clk/at91/sama5d2.c
@@ -89,6 +89,7 @@ static const struct {
 	{ .n = "i2s1_clk",    .id = 55, .r = { .min = 0, .max = 83000000 }, },
 	{ .n = "can0_clk",    .id = 56, .r = { .min = 0, .max = 83000000 }, },
 	{ .n = "can1_clk",    .id = 57, .r = { .min = 0, .max = 83000000 }, },
+	{ .n = "ptc_clk",     .id = 58, .r = { .min = 0, .max = 83000000 }, },
 	{ .n = "classd_clk",  .id = 59, .r = { .min = 0, .max = 83000000 }, },
 };
 
-- 
2.25.1

