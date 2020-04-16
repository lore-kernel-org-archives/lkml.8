Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2131CC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA012076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046757;
	bh=MnuWYLFkdb1YHimhXS6d0CxSVI1WAlx/FlXUz917YfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KKiU0s+sKAqDbDHY70h3DzencTDlYyeaQlaEgZasD8GnXIrsysYOrI8o3w2AunMjl
	 FGub/hsvHWuPYJSBIMmjxlxFGyiy2ddJ3mLQXCX6eGeZLfdS5+Y92B7tN5D4CEQ2ul
	 GjZu372zVkedlXRpWHsj9JSefv9ZTGy6vGaGPABk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442374AbgDPOTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503837AbgDPNxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:53:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 192B720732;
        Thu, 16 Apr 2020 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045212;
        bh=MnuWYLFkdb1YHimhXS6d0CxSVI1WAlx/FlXUz917YfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDOsbKTZ3N2+sdUVSzzm1zktlRUlkxAVhvbKjIUdLcNc+8JiwYyMD4ckpdKtaWS5M
         zt3GX3HlBE3un9/HIjHwhuXF/8pQFprlx4UU0P+7rwUCohx3PqmssNWB4mlWFF0AkS
         KxoPx+DU78k9NL8IoPhwzKlEWDjwD88ecOD7jzMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, rdunlap@infradead.org,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 041/254] media: i2c: video-i2c: fix build errors due to imply hwmon
Date:   Thu, 16 Apr 2020 15:22:10 +0200
Message-Id: <20200416131330.993957329@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Ranostay <matt.ranostay@konsulko.com>

[ Upstream commit 64d4fc9926f09861a35d8f0f7d81f056e6d5af7b ]

Fix build fault when CONFIG_HWMON is a module, and CONFIG_VIDEO_I2C
as builtin. This is due to 'imply hwmon' in the respective Kconfig.

Issue build log:

ld: drivers/media/i2c/video-i2c.o: in function `amg88xx_hwmon_init':
video-i2c.c:(.text+0x2e1): undefined reference to `devm_hwmon_device_register_with_info

Cc: rdunlap@infradead.org
Fixes: acbea6798955 (media: video-i2c: add hwmon support for amg88xx)
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/video-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 078141712c887..0b977e73ceb29 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -255,7 +255,7 @@ static int amg88xx_set_power(struct video_i2c_data *data, bool on)
 	return amg88xx_set_power_off(data);
 }
 
-#if IS_ENABLED(CONFIG_HWMON)
+#if IS_REACHABLE(CONFIG_HWMON)
 
 static const u32 amg88xx_temp_config[] = {
 	HWMON_T_INPUT,
-- 
2.20.1



