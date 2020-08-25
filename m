Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A09FC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF9320738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgHYE53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:57:29 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:35694 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728749AbgHYE5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:57:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9C175180A7FD3;
        Tue, 25 Aug 2020 04:57:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: net87_2b0b7db27059
X-Filterd-Recvd-Size: 3347
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Aug 2020 04:57:07 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/29] media: Avoid comma separated statements
Date:   Mon, 24 Aug 2020 21:56:11 -0700
Message-Id: <5f2ac0ba683d4e5d3449395721788527b8487a57.1598331149.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1598331148.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use semicolons and braces.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/media/i2c/msp3400-kthreads.c      | 12 ++++++++----
 drivers/media/pci/bt8xx/bttv-cards.c      |  6 ++++--
 drivers/media/pci/saa7134/saa7134-video.c |  7 +++++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/media/i2c/msp3400-kthreads.c b/drivers/media/i2c/msp3400-kthreads.c
index d3b0d1c18efd..ac8752c63266 100644
--- a/drivers/media/i2c/msp3400-kthreads.c
+++ b/drivers/media/i2c/msp3400-kthreads.c
@@ -549,8 +549,10 @@ int msp3400c_thread(void *data)
 			val = msp_read_dsp(client, 0x1b);
 			if (val > 32767)
 				val -= 65536;
-			if (val1 < val)
-				val1 = val, max1 = i;
+			if (val1 < val) {
+				val1 = val;
+				max1 = i;
+			}
 			dev_dbg_lvl(&client->dev, 1, msp_debug,
 				"carrier1 val: %5d / %s\n", val, cd[i].name);
 		}
@@ -586,8 +588,10 @@ int msp3400c_thread(void *data)
 			val = msp_read_dsp(client, 0x1b);
 			if (val > 32767)
 				val -= 65536;
-			if (val2 < val)
-				val2 = val, max2 = i;
+			if (val2 < val) {
+				val2 = val;
+				max2 = i;
+			}
 			dev_dbg_lvl(&client->dev, 1, msp_debug,
 				"carrier2 val: %5d / %s\n", val, cd[i].name);
 		}
diff --git a/drivers/media/pci/bt8xx/bttv-cards.c b/drivers/media/pci/bt8xx/bttv-cards.c
index 16148802dabb..ca20b806e82d 100644
--- a/drivers/media/pci/bt8xx/bttv-cards.c
+++ b/drivers/media/pci/bt8xx/bttv-cards.c
@@ -3934,8 +3934,10 @@ static void osprey_eeprom(struct bttv *btv, const u8 ee[256])
 			if (checksum != ee[21])
 				return;
 			cardid = BTTV_BOARD_OSPREY1x0_848;
-			for (i = 12; i < 21; i++)
-				serial *= 10, serial += ee[i] - '0';
+			for (i = 12; i < 21; i++) {
+				serial *= 10;
+				serial += ee[i] - '0';
+			}
 		}
 	} else {
 		unsigned short type;
diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index a8ac94fadc14..f673cda57f30 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -868,8 +868,11 @@ static int buffer_activate(struct saa7134_dev *dev,
 		lines_uv = dev->height >> dev->fmt->vshift;
 		base2    = base + bpl * dev->height;
 		base3    = base2 + bpl_uv * lines_uv;
-		if (dev->fmt->uvswap)
-			tmp = base2, base2 = base3, base3 = tmp;
+		if (dev->fmt->uvswap) {
+			tmp = base2;
+			base2 = base3;
+			base3 = tmp;
+		}
 		video_dbg("uv: bpl=%ld lines=%ld base2/3=%ld/%ld\n",
 			bpl_uv,lines_uv,base2,base3);
 		if (V4L2_FIELD_HAS_BOTH(dev->field)) {
-- 
2.26.0

