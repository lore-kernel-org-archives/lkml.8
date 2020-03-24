Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E55FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFD0206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585057481;
	bh=PMZLvau6l0DTq6hZbaVXDrSebT6xY40VOvUd+dhMy3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Cy7HAEIr7oG/wvuMIDNyC584jPkhgFSXY7JzXQc9rYa/ObKC9gNnZyaKQtBW+HAxo
	 a7IiNTbz3M0w46t7URB3+3IvriuFr8VMMW564BEFQrJbk9H0Sd00uAJDlbhfJeB/R8
	 82igrwfb03qeOXDITOvcOrGopKmKrnDQKQwkAVCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCXNoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbgCXNnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:43:19 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D97620775;
        Tue, 24 Mar 2020 13:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585057398;
        bh=PMZLvau6l0DTq6hZbaVXDrSebT6xY40VOvUd+dhMy3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlfvLdNZIVNPTe6OqjJRVqjsE6p1mfs/LB/TnEMooKS/ceswfZAvTKghG2c4IU1hN
         arSkY81jXxlV3e9J4FbrW/Wi3iolJ4Powe0bIRd+R23FUrhHJ3iyU+PAqJsCC75X/M
         Rdfe0cAbwvbcnBZiTvo3Wdmmstx9G+3TcChohrwM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jGjps-0025ql-Hb; Tue, 24 Mar 2020 14:43:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 02/20] media: Kconfig: not all V4L2 platform drivers are for camera
Date:   Tue, 24 Mar 2020 14:42:55 +0100
Message-Id: <e39e656c49c05829f0cf9affd7918818351d09e6.1585057134.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1585057134.git.mchehab+huawei@kernel.org>
References: <cover.1585057134.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the platform drivers got added, they were all part of
complex camera support. This is not the case anymore, as we
now have codecs and other stuff there too.

So, fix the dependencies, in order to not require users to
manually select something that it doesn't make sense.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/Kconfig          | 3 +--
 drivers/media/platform/Kconfig | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/Kconfig b/drivers/media/Kconfig
index 9dfea5c4b6ab..4af21fa73fcf 100644
--- a/drivers/media/Kconfig
+++ b/drivers/media/Kconfig
@@ -99,8 +99,7 @@ source "drivers/media/mc/Kconfig"
 config VIDEO_DEV
 	tristate
 	depends on MEDIA_SUPPORT
-	depends on MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT
-	default y
+	default MEDIA_CAMERA_SUPPORT || MEDIA_ANALOG_TV_SUPPORT || MEDIA_RADIO_SUPPORT || MEDIA_SDR_SUPPORT || V4L_PLATFORM_DRIVERS
 
 config VIDEO_V4L2_SUBDEV_API
 	bool "V4L2 sub-device userspace API"
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index e01bbb9dd1c1..34f40c2c8c45 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -5,7 +5,6 @@
 
 menuconfig V4L_PLATFORM_DRIVERS
 	bool "V4L platform devices"
-	depends on MEDIA_CAMERA_SUPPORT
 	help
 	  Say Y here to enable support for platform-specific V4L drivers.
 
-- 
2.24.1

