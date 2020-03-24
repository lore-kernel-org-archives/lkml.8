Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294C0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0178320775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585057442;
	bh=PIDxz4PON1tXTrgxL90qolW3m/5TZ0UEZSh0QEWn66Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x5FFGyZhPbI1VUAfy5YBi0uCFaqzUpBn9fkAdFuAhBw0Uq9dwa1pjqM8r2nu0htuX
	 ijVyL6Thq79NDWwLdBZXT169eY4DqlmU1WmZtmKV+TvWwbth+skT3piQkpA68jEJ73
	 o7fMxK+gs77dnJs63+1Mt08hyAIhz6UEUsrMsTWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgCXNoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgCXNnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:20 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B026A20BED;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=PIDxz4PON1tXTrgxL90qolW3m/5TZ0UEZSh0QEWn66Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FowH8EHT5y4CafiZ1wdO/DYHYALzrruiGe0qNkXCCCYqExZ0icZWW8omVLGLrBKI8
         9Rp2rjHKZUSA3XgnLEDRyrRt6gXmOvrgsU3Wq+UqeF6rSJFHNXyayPGluJUv7yx6Yn
         ks57d9aAqDPjBJAFuSQ5SxQvhBjZVMYLgl44RA/A=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025rf-V6; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 13/20] media: Kconfig: move V4L2 subdev API to v4l2-core/Kconfig
Date:   Tue, 24 Mar 2020 14:43:06 +0100
Message-Id: <0d4e432860f3f56e13d5dcda414f5f142831c04a.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option is part of V4L2 API extra functionality set.
Move it to be at the v4l2-core/Kconfig, where it belongs,
cleaning the main Kconfig file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig           | 9 ---------
 drivers/media/v4l2-core/Kconfig | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 44aceb5e5b63..d6fb8411a8de 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -140,15 +140,6 @@ config VIDEO_DEV
 	depends on MEDIA_SUPPORT
 	default MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT || V4L_PLATFORM_DRIVERS
 
-config VIDEO_V4L2_SUBDEV_API
-	bool "V4L2 sub-device userspace API"
-	depends on VIDEO_DEV && MEDIA_CONTROLLER
-	help
-	  Enables the V4L2 sub-device pad-level userspace API used to configure
-	  video format, size and frame rate between hardware blocks.
-
-	  This API is mostly used by camera interfaces in embedded platforms.
-
 source "drivers/media/v4l2-core/Kconfig"
 
 #
diff --git a/drivers/media/v4l2-core/Kconfig b/drivers/media/v4l2-core/Kconfig
index 26276b257eae..33aa7fe571f8 100644
--- a/drivers/media/v4l2-core/Kconfig
+++ b/drivers/media/v4l2-core/Kconfig
@@ -16,6 +16,15 @@ config VIDEO_V4L2_I2C
 	depends on I2C && VIDEO_V4L2
 	default y
 
+config VIDEO_V4L2_SUBDEV_API
+	bool "V4L2 sub-device userspace API"
+	depends on VIDEO_DEV && MEDIA_CONTROLLER
+	help
+	  Enables the V4L2 sub-device pad-level userspace API used to configure
+	  video format, size and frame rate between hardware blocks.
+
+	  This API is mostly used by camera interfaces in embedded platforms.
+
 config VIDEO_ADV_DEBUG
 	bool "Enable advanced debug functionality on V4L2 drivers"
 	help
-- 
2.24.1

