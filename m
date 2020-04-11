Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FE3C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8DF3206E9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586647369;
	bh=k+HtzTIFd+fXXiVKekcLzGuQPzWQbVWRP6oOPwdIAbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWyb7Sg+GdrNap5mIhJSo90Ty4E1k0HrETPNsKcmol4nu6uAJyjqWhyRbBD+W33Nn
	 xLsXxLiwMUMz7vXHQ6mhrftMHdh4a+mqHX8AIGCr//yylXnKqzw/8lPRsz5anm5xEk
	 fcrWAT5TAKHUlobNhTmznCdfKp2dDtumApfzyd/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgDKXNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:13:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730316AbgDKXNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:13:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEFB21835;
        Sat, 11 Apr 2020 23:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646781;
        bh=k+HtzTIFd+fXXiVKekcLzGuQPzWQbVWRP6oOPwdIAbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgfqJaGO0yLAy0xanJPbZ4R74e97JrdCnDRpPgZmNvNg0ODMQ6T4jflDrkkzuUEsx
         REcMJjswK1s3RaGeV9qCGY18Kcf8CmlY/pcq7+qNHOAccX7oVp/eeKJJi9EqADwqNO
         ISX7q3o+3vwpNnxKSgIRZQ6vMqn/0LYAb1YqVYIw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pavel Machek <pavel@denx.de>, Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 47/66] drm/msm: fix leaks if initialization fails
Date:   Sat, 11 Apr 2020 19:11:44 -0400
Message-Id: <20200411231203.25933-47-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231203.25933-1-sashal@kernel.org>
References: <20200411231203.25933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@denx.de>

[ Upstream commit 66be340f827554cb1c8a1ed7dea97920b4085af2 ]

We should free resources in unlikely case of allocation failure.

Signed-off-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 6f81de85fb860..01524009dede8 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -495,8 +495,10 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
 	if (!dev->dma_parms) {
 		dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
 					      GFP_KERNEL);
-		if (!dev->dma_parms)
-			return -ENOMEM;
+		if (!dev->dma_parms) {
+			ret = -ENOMEM;
+			goto err_msm_uninit;
+		}
 	}
 	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
 
-- 
2.20.1

