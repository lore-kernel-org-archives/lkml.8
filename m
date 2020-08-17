Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820E6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6437B204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690337;
	bh=wyke/k5vsBrPRhrkuRFm7GHoHj8TO6le21J0rUSiew8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZmjVxnnz9SwhjNWEVAN+WHRPXav7IJaHd4DL1Xn41JZg1OCJTQKCu4lO2FAkyRPrW
	 C0k1fYaURV4uy5NpthdEi/vyM6NLqNjMXQYXcHuIo8YlGS8+wT0wI7BsLQkauf9EaT
	 BX/QIgbpFTFu7pX2nJkiOij3XQeiheujWmpGfgLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403928AbgHQSwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387850AbgHQPwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:52:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686C22063A;
        Mon, 17 Aug 2020 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679543;
        bh=wyke/k5vsBrPRhrkuRFm7GHoHj8TO6le21J0rUSiew8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guTTlHnZZPAKcmXixzKZ847+s1V0rp6tyk7V1Y5wW+8oLycgg+mHrgSxU0yyQXs3J
         nutkpvkNtFhFfmqaRAp5kFVcBcl/zyH4m1WqF2Fcs6srL4B1tNyuXDMy0ZJh2mmYj9
         4cg5JkHX1D8FoJmQ34dB947yeVj5SsXvaTQZsMWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 222/393] gpu: ipu-v3: Restore RGB32, BGR32
Date:   Mon, 17 Aug 2020 17:14:32 +0200
Message-Id: <20200817143830.391871704@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Longerbeam <slongerbeam@gmail.com>

[ Upstream commit 22b2cfad752d4b278ea7c38c0ee961ca50198ce8 ]

RGB32 and BGR32 formats were inadvertently removed from the switch
statement in ipu_pixelformat_to_colorspace(). Restore them.

Fixes: a59957172b0c ("gpu: ipu-v3: enable remaining 32-bit RGB V4L2 pixel formats")
Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index ee2a025e54cfe..b3dae9ec1a38b 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -124,6 +124,8 @@ enum ipu_color_space ipu_pixelformat_to_colorspace(u32 pixelformat)
 	case V4L2_PIX_FMT_RGBX32:
 	case V4L2_PIX_FMT_ARGB32:
 	case V4L2_PIX_FMT_XRGB32:
+	case V4L2_PIX_FMT_RGB32:
+	case V4L2_PIX_FMT_BGR32:
 		return IPUV3_COLORSPACE_RGB;
 	default:
 		return IPUV3_COLORSPACE_UNKNOWN;
-- 
2.25.1



