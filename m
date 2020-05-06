Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E1BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21690206B9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZYuPX2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEFXDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgEFXDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:03:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8911FC061A41
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 16:03:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s10so1266284plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 16:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UeM5IRsRnStDlAAc1OBZrO/PpgJ1sNAvS3ZP+2/6Z+k=;
        b=OZYuPX2S5ZWoQsz3JlyUfgm7faGJYkdHFfhl1pTJfp0Fy8Uytvm1TohSILkdM+SukY
         0ZTQB3Lq15a+uGMMvULtadQyPPwYIq0rspD0dPwv7MjOsjtB2ZXJwNxsZPzMLqT1j1n3
         i9BS6W+Bo9lXlVc6bvWzf/t3rUoekBUzWn5O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UeM5IRsRnStDlAAc1OBZrO/PpgJ1sNAvS3ZP+2/6Z+k=;
        b=DlqdMfU1R7Yo00zwWhUm5fmg00NETeSaqaliu7y8WY1NzWapbG3EB9YpbLc37g0LC/
         J2JI8RG6SUpKe1/YFZJwShaSJ4VZnefIIA17+bJ5WT7TadEvnvt6u5ito+0Uvxe/VN32
         Gpv473DAKvkvHv/UZJxjKnQkUjRHgSljlen+wy/RifrEKdzxh1PLekImzJj643RuWrWd
         V+L0hSNKD64El+QUVm6qzWB5i3X/lvcQ9sOU3YEl0jsoqjRiVisBVDP7r8m/M7dolzdC
         YsPZifQtjDwoGdaFki1rHfzMMY8r3iA1cWNkIDDOlmK+j+cez6y7vNTklSmme/i/q+uP
         KeKQ==
X-Gm-Message-State: AGi0Pub34ZSC3DXgt2A3ihzKcGpqqqXC1m0Jgqw8cQ7BhNCsBO4dHBL5
        B+Pi0IvetpX/ynngOdW8UujCrw==
X-Google-Smtp-Source: APiQypL7Njfu/Eb5/3HGyvbMHDoG4E7X5U4dWIHfbHWKzKP+OqiE5RxvNQzRoK+89RvGazd5CMGp7A==
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr12373542pjb.25.1588806213979;
        Wed, 06 May 2020 16:03:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id v1sm5631496pjs.36.2020.05.06.16.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 16:03:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, jic23@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 1/3] iio: Add in_illumincance vectors in different color spaces
Date:   Wed,  6 May 2020 16:03:22 -0700
Message-Id: <20200506230324.139241-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200506230324.139241-1-gwendal@chromium.org>
References: <20200506230324.139241-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define 2 spaces for defining color coming from color sensors:
RGB and XYZ: Both are in lux.
RGB is the raw output from sensors (Red, Green and Blue channels), in
addition to the existing clear channel (C).
The RGBC vector goes through a matrix transformation to produce the XYZ
vector. Y is illumincance, and XY caries the chromaticity information.
The matrix is model specific, as the color sensor can be behing a glass
that can filter some wavelengths.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
New in v2.

 Documentation/ABI/testing/sysfs-bus-iio | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d3e53a6d8331b..256db6e63a25e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1309,6 +1309,33 @@ Description:
 		Illuminance measurement, units after application of scale
 		and offset are lux.
 
+What:		/sys/.../iio:deviceX/in_illuminance_red_raw
+What:		/sys/.../iio:deviceX/in_illuminance_green_raw
+What:		/sys/.../iio:deviceX/in_illuminance_blue_raw
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Illuminance measuremed in red, green or blue channels, units
+		after application of scale and offset are lux.
+
+What:		/sys/.../iio:deviceX/in_illuminance_x_raw
+What:		/sys/.../iio:deviceX/in_illuminance_y_raw
+What:		/sys/.../iio:deviceX/in_illuminance_z_raw
+KernelVersion:	5.7
+Contact:	linux-iio@vger.kernel.org
+Description:
+		lluminance measured in the CIE 1931 color space (XYZ).
+		in_illuminance_y_raw is a measure of the brightness, and is
+		identical in_illuminance_raw.
+		in_illuminance_x_raw and in_illuminance_z_raw carry chromacity
+		information.
+		in_illuminance_x,y,z_raw are be obtained from the sensor color
+		channels using color matching functions that may be device
+		specific.
+		Units after application of scale and offset are lux.
+		The measurments can be used to represent colors in the CIE
+		xyY color space
+
 What:		/sys/.../iio:deviceX/in_intensityY_raw
 What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
 What:		/sys/.../iio:deviceX/in_intensityY_both_raw
-- 
2.26.2.526.g744177e7f7-goog

