Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A60C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F0820639
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063434;
	bh=vbQF66iKfyJ7E6H+ff93dGs/2GYrxlcC/G916kKGy4E=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=RQRvGvWlhy42x+T2sLTTU/lgkCs7nNdTt2c5wBDDvXlYz2N6rUhnfR3K7XjKvvl41
	 BK1Z/ZuBJNJpLALN+K4hY8TYuBvlfmK3NpTLWTBV6YrdAucaxwvQF8yjYgkEXZ/Qm8
	 5Mc6AC9iy+w6ykWz3ZfQJUaljAf72XAtEpULY0fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgIBQRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbgIBQK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:10:56 -0400
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0766D2168B;
        Wed,  2 Sep 2020 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063046;
        bh=vbQF66iKfyJ7E6H+ff93dGs/2GYrxlcC/G916kKGy4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=geuusIYWolZAHBYtCkbEgiXNwSPLwg11C84pGwBvD5aeWsskXpag5zZz1chnORRY6
         1vcg2vjCMlpdpCfC20sFlrjtKdIl3KxMGDp/+Rglaer+0YI+XkqSGFL7zQQteCPDRD
         nvTAQ9Io/mXWnvuvdSZpyNQRnTmrJI4mB3NJiYFA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kDVLQ-000tAh-8s; Wed, 02 Sep 2020 18:10:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 23/38] media: saa7134: avoid a shift overflow
Date:   Wed,  2 Sep 2020 18:10:26 +0200
Message-Id: <6ee0a9ec8855f0388fee8cd183abeb60e28b293f.1599062230.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599062230.git.mchehab+huawei@kernel.org>
References: <cover.1599062230.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by smatch:
	drivers/media/pci/saa7134//saa7134-tvaudio.c:686 saa_dsp_writel() warn: should 'reg << 2' be a 64 bit type?

On a 64-bits Kernel, the shift might be bigger than 32 bits.

In real, this should never happen, but let's shut up the warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/pci/saa7134/saa7134-tvaudio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/pci/saa7134/saa7134-tvaudio.c b/drivers/media/pci/saa7134/saa7134-tvaudio.c
index 79e1afb71075..5cc4ef21f9d3 100644
--- a/drivers/media/pci/saa7134/saa7134-tvaudio.c
+++ b/drivers/media/pci/saa7134/saa7134-tvaudio.c
@@ -683,7 +683,8 @@ int saa_dsp_writel(struct saa7134_dev *dev, int reg, u32 value)
 {
 	int err;
 
-	audio_dbg(2, "dsp write reg 0x%x = 0x%06x\n", reg << 2, value);
+	audio_dbg(2, "dsp write reg 0x%x = 0x%06x\n",
+		  (reg << 2) & 0xffffffff, value);
 	err = saa_dsp_wait_bit(dev,SAA7135_DSP_RWSTATE_WRR);
 	if (err < 0)
 		return err;
-- 
2.26.2

