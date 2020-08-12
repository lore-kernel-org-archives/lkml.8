Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A532076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHEE6gYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHLUuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgHLUuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597265417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aCTPdh49E5sDGn5ZzKjWvZXNyAaCov7XSPlzHVRd6H8=;
        b=OHEE6gYaAGAS4Cw03GC8A/Q0WPoevIPGFvor/8xwJrXjFTJ2DbHRTHeHHGkQq7VKuSSHw3
        1duTmmtze5p+7x+IWTZZYhjD4kWYyL5Nz3xIkMSdXhS6h7Ebny72B9ctDh3A1In9n6hfXc
        etVfYYJW97j0eKpMFHPSrSklEGtQvOQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-Nv_qU_DbNYGbrWEoeDF2xg-1; Wed, 12 Aug 2020 16:50:16 -0400
X-MC-Unique: Nv_qU_DbNYGbrWEoeDF2xg-1
Received: by mail-qt1-f199.google.com with SMTP id s29so2783004qtc.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 13:50:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aCTPdh49E5sDGn5ZzKjWvZXNyAaCov7XSPlzHVRd6H8=;
        b=adv8xnS5pp5JN7ubnWFYVDg6ipvUH79VN5qejeH7KHDN0rgllagvsSs0xLpYGOz4Yt
         FaDUNjuNV5x3rfUY45Jr5rNGA43GoERrkHKwoX55iH3qAmLlTuvRdJH7vsdP6Ge8NfhJ
         f7zoRHSQ0RT7h5QfuEYSD9UTRC0NCqBxwRRAeH86Pw6u4TWm3a1NesXTTiLDcY7GqOsg
         T4r2jS79PtVh3ACK9IWfLtjggS/remVyhgvPKt/Oh84V8Vm96gwrZYF4hr5BB7njI88L
         /evDZfu27MGRtYp1/fW3Fz1T3Cdenm81WkLnrknhXRfat3Gh2nWta38DfW+yk1DDafox
         6Faw==
X-Gm-Message-State: AOAM533pRsxLsuA14JApIf0Xdcgv9LrCoPyMM7sL6Ip0kwB7n3txRgHL
        qA7MLomMW25Ej0B3ELni2FOeEIHdtAbcOc5yI0336ci676VNXbGNVMTrPV7HNORuK9EGYKgnQ3u
        u+P6s6RLlFmQgsABo7+9ym8TN
X-Received: by 2002:ac8:776b:: with SMTP id h11mr1626443qtu.59.1597265415501;
        Wed, 12 Aug 2020 13:50:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDKBegQFFmZIxmsrmwndXdaMUq1PsUfcrePGLpzHuDwoACHNZ2R/9aaSb7HxZTiv4ujX+EDg==
X-Received: by 2002:ac8:776b:: with SMTP id h11mr1626422qtu.59.1597265415272;
        Wed, 12 Aug 2020 13:50:15 -0700 (PDT)
Received: from dev.jcline.org.com ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id o13sm3692400qko.48.2020.08.12.13.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 13:50:14 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <kherbst@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] drm/nouveau: Add fine-grain temperature reporting
Date:   Wed, 12 Aug 2020 16:49:52 -0400
Message-Id: <20200812204952.1921587-1-jcline@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d32656373857 ("drm/nouveau/therm/gp100: initial implementation of
new gp1xx temperature sensor") added support for reading finer-grain
temperatures, but continued to report temperatures in 1 degree Celsius
increments via nvkm_therm_temp_get().

Rather than altering nvkm_therm_temp_get() to report finer-grain
temperatures, which would be inconvenient for other users of the
function, a second interface has been added to line up with hwmon's
native unit of temperature.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 .../drm/nouveau/include/nvkm/subdev/therm.h   | 18 +++++++++++++
 drivers/gpu/drm/nouveau/nouveau_hwmon.c       |  4 +--
 .../gpu/drm/nouveau/nvkm/subdev/therm/base.c  | 16 ++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/therm/gp100.c | 25 +++++++++++++++++--
 .../gpu/drm/nouveau/nvkm/subdev/therm/priv.h  |  1 +
 5 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
index 62c34f98c930..7b9928dd001c 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/therm.h
@@ -100,6 +100,24 @@ struct nvkm_therm {
 };
 
 int nvkm_therm_temp_get(struct nvkm_therm *);
+
+/**
+ * nvkm_therm_temp_millidegree_get() - get the temperature in millidegrees
+ * @therm: The thermal device to read from.
+ *
+ * This interface reports temperatures in units of millidegree Celsius to
+ * align with the hwmon API. Some cards may only be capable of reporting in
+ * units of Celsius, and those that report finer grain temperatures may not be
+ * capable of millidegree Celsius accuracy,
+ *
+ * For cases where millidegree temperature is too fine-grain, the
+ * nvkm_therm_temp_get() interface reports temperatures in one degree Celsius
+ * increments.
+ *
+ * Return: The temperature in millidegrees Celsius, or -ENODEV if temperature
+ *         reporting is not supported.
+ */
+int nvkm_therm_temp_millidegree_get(struct nvkm_therm *therm);
 int nvkm_therm_fan_sense(struct nvkm_therm *);
 int nvkm_therm_cstate(struct nvkm_therm *, int, int);
 void nvkm_therm_clkgate_init(struct nvkm_therm *,
diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index 1c3104d20571..e96355f93ce5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -428,8 +428,8 @@ nouveau_temp_read(struct device *dev, u32 attr, int channel, long *val)
 	case hwmon_temp_input:
 		if (drm_dev->switch_power_state != DRM_SWITCH_POWER_ON)
 			return -EINVAL;
-		ret = nvkm_therm_temp_get(therm);
-		*val = ret < 0 ? ret : (ret * 1000);
+		ret = nvkm_therm_temp_millidegree_get(therm);
+		*val = ret;
 		break;
 	case hwmon_temp_max:
 		*val = therm->attr_get(therm, NVKM_THERM_ATTR_THRS_DOWN_CLK)
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
index 4a4d1e224126..e655b32c78b8 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c
@@ -34,6 +34,22 @@ nvkm_therm_temp_get(struct nvkm_therm *therm)
 	return -ENODEV;
 }
 
+int
+nvkm_therm_temp_millidegree_get(struct nvkm_therm *therm)
+{
+	int ret = -ENODEV;
+
+	if (therm->func->temp_millidegree_get)
+		return therm->func->temp_millidegree_get(therm);
+
+	if (therm->func->temp_get) {
+		ret = therm->func->temp_get(therm);
+		if (ret > 0)
+			ret *= 1000;
+	}
+	return ret;
+}
+
 static int
 nvkm_therm_update_trip(struct nvkm_therm *therm)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
index 9f0dea3f61dc..4c3c2895a3cb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c
@@ -24,7 +24,7 @@
 #include "priv.h"
 
 static int
-gp100_temp_get(struct nvkm_therm *therm)
+gp100_temp_get_raw(struct nvkm_therm *therm)
 {
 	struct nvkm_device *device = therm->subdev.device;
 	struct nvkm_subdev *subdev = &therm->subdev;
@@ -37,14 +37,35 @@ gp100_temp_get(struct nvkm_therm *therm)
 
 	/* device valid */
 	if (tsensor & 0x20000000)
-		return (inttemp >> 8);
+		return inttemp;
 	else
 		return -ENODEV;
 }
 
+static int
+gp100_temp_millidegree_get(struct nvkm_therm *therm)
+{
+	int raw_temp = gp100_temp_get_raw(therm);
+
+	if (raw_temp < 0)
+		return raw_temp;
+	return raw_temp * 1000 >> 8;
+}
+
+static int
+gp100_temp_get(struct nvkm_therm *therm)
+{
+	int raw_temp = gp100_temp_get_raw(therm);
+
+	if (raw_temp < 0)
+		return raw_temp;
+	return raw_temp >> 8;
+}
+
 static const struct nvkm_therm_func
 gp100_therm = {
 	.temp_get = gp100_temp_get,
+	.temp_millidegree_get = gp100_temp_millidegree_get,
 	.program_alarms = nvkm_therm_program_alarms_polling,
 };
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
index 21659daf1864..a53068b4f0b9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h
@@ -92,6 +92,7 @@ struct nvkm_therm_func {
 	int (*pwm_clock)(struct nvkm_therm *, int line);
 
 	int (*temp_get)(struct nvkm_therm *);
+	int (*temp_millidegree_get)(struct nvkm_therm *therm);
 
 	int (*fan_sense)(struct nvkm_therm *);
 
-- 
2.26.2

