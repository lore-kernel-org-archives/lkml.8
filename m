Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D43C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521C221739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221141;
	bh=7QA7qgFZCNdK9gpFujJdT8gQYE0kxWucy0+YdY9HZzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OR3if4W4rwRYUvmdiSs5IbzbkRWv0jOSnZx6TSumnB+1STM3ziTFBM4IvouGQ0j0z
	 Vv6lvJTRwmC+UHAPy+1EEibwu/kyDai9hXd5ZLHQsc5D5b5Euqt40w9s2qyWoJmkIq
	 zHrLAaIQBLo+ZQeayhdw9MrHRIk5r8tbbTpOsSwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730792AbgA1OTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730772AbgA1OS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:18:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3D7C24698;
        Tue, 28 Jan 2020 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221137;
        bh=7QA7qgFZCNdK9gpFujJdT8gQYE0kxWucy0+YdY9HZzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g20n700f4d8PA7BhKpmarffjWIk5nNVSbZdtb38UTX/ejG7vjwI4yHIDY+d6FlC5F
         lRwbN/UE/p6GTRibSQw3IyxeVFjFs0/H6I/D/egHHULTosJnRoLz3L/5DTjJTJ0HcJ
         E4WqaenfbYnYqnGW7DrqjQ8r/rRuNNEJCMa7bNMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 102/271] regulator: tps65086: Fix tps65086_ldoa1_ranges for selector 0xB
Date:   Tue, 28 Jan 2020 15:04:11 +0100
Message-Id: <20200128135900.185717220@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Lin <axel.lin@ingics.com>

[ Upstream commit e69b394703e032e56a140172440ec4f9890b536d ]

selector 0xB (1011) should be 2.6V rather than 2.7V, fit ix.

Table 5-4. LDOA1 Output Voltage Options
VID Bits VOUT VID Bits VOUT VID Bits VOUT VID Bits VOUT
0000     1.35 0100     1.8  1000     2.3  1100     2.85
0001     1.5  0101     1.9  1001     2.4  1101     3.0
0010     1.6  0110     2.0  1010     2.5  1110     3.3
0011     1.7  0111     2.1  1011     2.6  1111     Not Used

Fixes: d2a2e729a666 ("regulator: tps65086: Add regulator driver for the TPS65086 PMIC")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/tps65086-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps65086-regulator.c b/drivers/regulator/tps65086-regulator.c
index 6dbf3cf3951e2..12d26261394f1 100644
--- a/drivers/regulator/tps65086-regulator.c
+++ b/drivers/regulator/tps65086-regulator.c
@@ -89,8 +89,8 @@ static const struct regulator_linear_range tps65086_buck345_25mv_ranges[] = {
 static const struct regulator_linear_range tps65086_ldoa1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1350000, 0x0, 0x0, 0),
 	REGULATOR_LINEAR_RANGE(1500000, 0x1, 0x7, 100000),
-	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xA, 100000),
-	REGULATOR_LINEAR_RANGE(2700000, 0xB, 0xD, 150000),
+	REGULATOR_LINEAR_RANGE(2300000, 0x8, 0xB, 100000),
+	REGULATOR_LINEAR_RANGE(2850000, 0xC, 0xD, 150000),
 	REGULATOR_LINEAR_RANGE(3300000, 0xE, 0xE, 0),
 };
 
-- 
2.20.1



