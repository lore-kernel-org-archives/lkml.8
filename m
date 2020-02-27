Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C79C54FF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F39C24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812755;
	bh=Tjc+VNTIwPmQo8lQytQmKQARh+VJKu0de2ydV+Hpy3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YwXcs2YKIsc6ZfPT49JL3KwmfqCNglaGng+NGDwbqHqExKEa8+kWdgtp0lkQRa7Fm
	 uSn5jLauKYUYJwwRoKSo+B6IlXAJI+YYYB1IVJEXmKeRO/dPr5CD5mlB3ptX0XcnMH
	 MtrVhicHx49mWA87wiVEj2pYOTqHxtDKkJxM6FqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbgB0OMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:12:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730886AbgB0OMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:12:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66DCD20578;
        Thu, 27 Feb 2020 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812749;
        bh=Tjc+VNTIwPmQo8lQytQmKQARh+VJKu0de2ydV+Hpy3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KLqL0t/hSBpR+m9gG/fhsykQ3FI0tBFYqZkblPG+u8tEiCDycTq+/a1QeZYIvKX4R
         bwbz8jWBmespnxMJMPx4kMhADebD/81BN1XYS4xQ+18pHKthXBnd4q2v3QAdZloCvR
         LlYPW6LcMqvpBI4gByvL/JyOVJSqN9+DqVDhxRXQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: [PATCH 5.4 106/135] drm/msm/dpu: fix BGR565 vs RGB565 confusion
Date:   Thu, 27 Feb 2020 14:37:26 +0100
Message-Id: <20200227132245.163850701@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

commit 8fc7036ee652207ca992fbb9abb64090c355a9e0 upstream.

The component order between the two was swapped, resulting in incorrect
color when games with 565 visual hit the overlay path instead of GPU
composition.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -255,13 +255,13 @@ static const struct dpu_format dpu_forma
 
 	INTERLEAVED_RGB_FMT(RGB565,
 		0, COLOR_5BIT, COLOR_6BIT, COLOR_5BIT,
-		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
+		C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
 		false, 2, 0,
 		DPU_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(BGR565,
 		0, COLOR_5BIT, COLOR_6BIT, COLOR_5BIT,
-		C1_B_Cb, C0_G_Y, C2_R_Cr, 0, 3,
+		C2_R_Cr, C0_G_Y, C1_B_Cb, 0, 3,
 		false, 2, 0,
 		DPU_FETCH_LINEAR, 1),
 


