Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA81C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787CB20749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584094048;
	bh=lS+qwx9mm8I2t3RkiOHXznQAfI14rFMap31xJBPpUeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AnsbaIsKsECcT+uu7cH4zmVOTw6DeZTSsU7Dq1ROh0Pd03W+N5Jf7kTjSoPmgRmoF
	 VsgoW7pFlsOp7F5ZWXAFzfr+8jOoeUNgnsueszGA+A1BS9jdHGaBaXtSl6klirINtI
	 RliwWlOp4ANaDsuyVarwFpS311uLuhRA9IR8BYvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMKH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgCMKH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:07:27 -0400
Received: from localhost.localdomain (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1DE620746;
        Fri, 13 Mar 2020 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584094046;
        bh=lS+qwx9mm8I2t3RkiOHXznQAfI14rFMap31xJBPpUeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9hznwMzcjGQjsqGtzfdE82DknA6ShqCZTwLOp/v0ka/nAx6na5sIdZBg3LHfxyZf
         iqM7z7pvHtA/C54fog+kzF8icaE1c5/0AngYMS6lII3/iYP0uWVramsSRqTqdrocd0
         ajZIfvqrPwUKzTbYBnmXU9skZIV0LEt9GYV3/qTw=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] ALSA: compress: add wma codec profiles
Date:   Fri, 13 Mar 2020 15:37:00 +0530
Message-Id: <20200313100708.1558658-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200313095318.1555163-2-vkoul@kernel.org>
References: <20200313095318.1555163-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some codec profiles were missing for WMA, like WMA9/10 lossless and
wma10 pro, so add these profiles

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/sound/compress_params.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index 9c96fb0e4d90..a47d9df0fd7b 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -142,6 +142,9 @@
 #define SND_AUDIOPROFILE_WMA8                ((__u32) 0x00000002)
 #define SND_AUDIOPROFILE_WMA9                ((__u32) 0x00000004)
 #define SND_AUDIOPROFILE_WMA10               ((__u32) 0x00000008)
+#define SND_AUDIOPROFILE_WMA9_PRO            ((__u32) 0x00000010)
+#define SND_AUDIOPROFILE_WMA9_LOSSLESS       ((__u32) 0x00000020)
+#define SND_AUDIOPROFILE_WMA10_LOSSLESS      ((__u32) 0x00000040)
 
 #define SND_AUDIOMODE_WMA_LEVEL1             ((__u32) 0x00000001)
 #define SND_AUDIOMODE_WMA_LEVEL2             ((__u32) 0x00000002)
-- 
2.24.1

