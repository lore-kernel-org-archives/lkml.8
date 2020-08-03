Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2BBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093A72068F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHCJHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:07:36 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:48577 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgHCJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:07:35 -0400
X-Originating-IP: 93.29.109.196
Received: from localhost.localdomain (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8AE664000C;
        Mon,  3 Aug 2020 09:07:32 +0000 (UTC)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH] media: ov5640: Correct Bit Div register in clock tree diagram
Date:   Mon,  3 Aug 2020 11:06:58 +0200
Message-Id: <20200803090658.10073-1-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the code is correct and doing the right thing, the clock diagram
showed the wrong register for the bit divider, which had me doubting the
understanding of the tree. Fix this to avoid doubts in the future.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/media/i2c/ov5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 854031f0b64a..fe08a45b0426 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -751,7 +751,7 @@ static int ov5640_mod_reg(struct ov5640_dev *sensor, u16 reg,
  *               +->| PLL Root Div | - reg 0x3037, bit 4
  *                  +-+------------+
  *                    |  +---------+
- *                    +->| Bit Div | - reg 0x3035, bits 0-3
+ *                    +->| Bit Div | - reg 0x3034, bits 0-3
  *                       +-+-------+
  *                         |  +-------------+
  *                         +->| SCLK Div    | - reg 0x3108, bits 0-1
-- 
2.26.2

