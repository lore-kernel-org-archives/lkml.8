Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A16BC2BA80
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64C72072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kc/5ZrJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDIAnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:43:12 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35640 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgDIAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:43:11 -0400
Received: by mail-pj1-f68.google.com with SMTP id mn19so566181pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 17:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VJUF1SB/P+2GwzxWVksYTgRtuu1H7WnENANWehljizI=;
        b=Kc/5ZrJZnJkC11ySxO/gJzQyEAk6OPdFPfkF5ZgjaSuNGTjG7wB+ioLu7Qvf6mKKzO
         5tdTKmtw/7Z/YzkiO+vW2qRM442A9cvZP4QroD8pq5Ur8UHI0Pm57r/UYuDzAx+Xn+0P
         lSim0dvF+QHWkMATuiS52pgYsBOsZDI8da5GR0Kn7cRz3H4mr9eKl0DHGv8QFoYAnUPM
         +zgPbYzkniSuhrpKQrTfUFofwxNjO9gYoKm3QVHF+FpHuIXqlsCIMXEoSc80arSr2+ue
         EnBiJOJxrnjQbiXgrTm4Br9TUD9/BLP39NAq3LL2oXb7rZJc/6hLFoD2d7flTL/LnRE0
         dmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VJUF1SB/P+2GwzxWVksYTgRtuu1H7WnENANWehljizI=;
        b=Z2Xc2GnSFcP5xBSUh8wsrME3Vv7CVUahB9kinkKlB0a+InZY1zL5oj9CpD0STuwEJC
         wDl9mh69vISo+GLr2Z06JrItDqpXCvZEhVIwGY0tMhjRdb8FLqad0/bJ89ypz+FTgtmp
         /76XxTOac9cIM8XhQkqpDsQpUYm3jepeLbe0C/hYFkJNUO0pLsXHB9rifnbBdKfJxDhe
         Veg86z8HFWxMVX1VSCIezW+eFi0gVOuwUROygmI4sLWvZnE4uIhm1IapTczsPQv+slw8
         YJgN+xeVf3yfCN3bwlI0iAUeqbwuBE3gfU78/BNZtMTwR5dFKGSXpJkyzDl9EzC2yCCE
         zLoA==
X-Gm-Message-State: AGi0PuYoqcx0Q2ZY5YtU0vyAl4CAs9/HqOinUhLFzg/U3RXvRqzt0iu+
        IGE5jE9T286TVy4wXTOCG0XJ2X0V5mY=
X-Google-Smtp-Source: APiQypIFE2K88ws272Mk4HBlN//iOn6YSF2U0g12SuRati06xtmisiTS9XLJL76/Ccgl2aIj49TSJw==
X-Received: by 2002:a17:90a:2e15:: with SMTP id q21mr8390108pjd.166.1586392991078;
        Wed, 08 Apr 2020 17:43:11 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d21sm17705783pfo.49.2020.04.08.17.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 17:43:10 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Xu YiPing <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm: kirin: Revert change to add register connect helper functions
Date:   Thu,  9 Apr 2020 00:43:06 +0000
Message-Id: <20200409004306.18541-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel noted[1] that commit d606dc9a6323 ("drm: kirin: Add
register connect helper functions in drm init") was unnecessary
and incorrect, as drm_dev_register does register connectors for
us.

Thus, this patch reverts the change as suggested by Daniel.

[1]: https://lore.kernel.org/lkml/CAKMK7uHr5U-pPsxdQ4MpfK5v8iLjphDFug_3VTiUAf06nhS=yQ@mail.gmail.com/

Cc: Xu YiPing <xuyiping@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../gpu/drm/hisilicon/kirin/kirin_drm_ade.c   |  1 -
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   | 43 -------------------
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.h   |  1 -
 3 files changed, 45 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index 86000127d4ee..c339e632522a 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -940,7 +940,6 @@ static struct drm_driver ade_driver = {
 };
 
 struct kirin_drm_data ade_driver_data = {
-	.register_connects = false,
 	.num_planes = ADE_CH_NUM,
 	.prim_plane = ADE_CH1,
 	.channel_formats = channel_formats,
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index d3145ae877d7..4349da3e2379 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -219,40 +219,6 @@ static int kirin_drm_kms_cleanup(struct drm_device *dev)
 	return 0;
 }
 
-static int kirin_drm_connectors_register(struct drm_device *dev)
-{
-	struct drm_connector *connector;
-	struct drm_connector *failed_connector;
-	struct drm_connector_list_iter conn_iter;
-	int ret;
-
-	mutex_lock(&dev->mode_config.mutex);
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		ret = drm_connector_register(connector);
-		if (ret) {
-			failed_connector = connector;
-			goto err;
-		}
-	}
-	drm_connector_list_iter_end(&conn_iter);
-	mutex_unlock(&dev->mode_config.mutex);
-
-	return 0;
-
-err:
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-		if (failed_connector == connector)
-			break;
-		drm_connector_unregister(connector);
-	}
-	drm_connector_list_iter_end(&conn_iter);
-	mutex_unlock(&dev->mode_config.mutex);
-
-	return ret;
-}
-
 static int kirin_drm_bind(struct device *dev)
 {
 	struct kirin_drm_data *driver_data;
@@ -279,17 +245,8 @@ static int kirin_drm_bind(struct device *dev)
 
 	drm_fbdev_generic_setup(drm_dev, 32);
 
-	/* connectors should be registered after drm device register */
-	if (driver_data->register_connects) {
-		ret = kirin_drm_connectors_register(drm_dev);
-		if (ret)
-			goto err_drm_dev_unregister;
-	}
-
 	return 0;
 
-err_drm_dev_unregister:
-	drm_dev_unregister(drm_dev);
 err_kms_cleanup:
 	kirin_drm_kms_cleanup(drm_dev);
 err_drm_dev_put:
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index 4d5c05a24065..dee8ec2f7f2e 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -37,7 +37,6 @@ struct kirin_drm_data {
 	u32 channel_formats_cnt;
 	int config_max_width;
 	int config_max_height;
-	bool register_connects;
 	u32 num_planes;
 	u32 prim_plane;
 
-- 
2.17.1

