Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98946C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506B720658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595066;
	bh=d5CrpnaLe/hzDWsm51N0bFeSs/nJtCjmHu60f90JOmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Vq3+43AeP/Xp5g3pcEkdixmE2eEjfDn95QIAIKEJ9+cd6p2ekN/EkAe2I0ODNyu5
	 se5htOYWzTCpamDjVFocxviHmyj3/My8dl2YEB4IpaL5SFRgyFd0EAUMNgc2B019Et
	 mWrQVNL3l0S01xbsJC9Js3R8WqTJeJ36qtsNFG3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbgIHT5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbgIHPfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7ABB2253A;
        Tue,  8 Sep 2020 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579306;
        bh=d5CrpnaLe/hzDWsm51N0bFeSs/nJtCjmHu60f90JOmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XruphBz39kWy3UDqzhZ51I/LYHFzbs6tF04ff40rBgl5aBPJVJCrRzK4xECGfBkvF
         CzzY/ouHwxOSJiGDyGdgbJhFUbAKJchV7ja0Fy4HLinxTYy+A2o1UjWiFCxOxJ1gS7
         HsuDn+2E+AeRKsTG2LbF7rTug39hiR9ntQLbIyrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 023/186] i2c: iproc: Fix shifting 31 bits
Date:   Tue,  8 Sep 2020 17:22:45 +0200
Message-Id: <20200908152242.780369073@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ray Jui <ray.jui@broadcom.com>

[ Upstream commit 0204081128d582965e9e39ca83ee6e4f7d27142b ]

Fix undefined behaviour in the iProc I2C driver by using 'BIT' marcro.

Reported-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
[wsa: in commit msg, don't say 'checkpatch' but name the issue]
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-bcm-iproc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
index 688e928188214..d8295b1c379d1 100644
--- a/drivers/i2c/busses/i2c-bcm-iproc.c
+++ b/drivers/i2c/busses/i2c-bcm-iproc.c
@@ -720,7 +720,7 @@ static int bcm_iproc_i2c_xfer_internal(struct bcm_iproc_i2c_dev *iproc_i2c,
 
 			/* mark the last byte */
 			if (!process_call && (i == msg->len - 1))
-				val |= 1 << M_TX_WR_STATUS_SHIFT;
+				val |= BIT(M_TX_WR_STATUS_SHIFT);
 
 			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
 		}
@@ -738,7 +738,7 @@ static int bcm_iproc_i2c_xfer_internal(struct bcm_iproc_i2c_dev *iproc_i2c,
 		 */
 		addr = i2c_8bit_addr_from_msg(msg);
 		/* mark it the last byte out */
-		val = addr | (1 << M_TX_WR_STATUS_SHIFT);
+		val = addr | BIT(M_TX_WR_STATUS_SHIFT);
 		iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
 	}
 
-- 
2.25.1



