Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33784C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E3D20722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgCZVKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:10:36 -0400
Received: from sauhun.de ([88.99.104.3]:54466 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgCZVKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:10 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id BC8592C1F99;
        Thu, 26 Mar 2020 22:10:08 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] drm/radeon: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:10:04 +0100
Message-Id: <20200326211005.13301-7-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
References: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 4 ++--
 drivers/gpu/drm/radeon/radeon_combios.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 848ef68d9086..5d2591725189 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -2111,7 +2111,7 @@ static int radeon_atombios_parse_power_table_1_3(struct radeon_device *rdev)
 								    ucOverdriveThermalController];
 			info.addr = power_info->info.ucOverdriveControllerAddress >> 1;
 			strlcpy(info.type, name, sizeof(info.type));
-			i2c_new_device(&rdev->pm.i2c_bus->adapter, &info);
+			i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 		}
 	}
 	num_modes = power_info->info.ucNumOfPowerModeEntries;
@@ -2351,7 +2351,7 @@ static void radeon_atombios_add_pplib_thermal_controller(struct radeon_device *r
 				const char *name = pp_lib_thermal_controller_names[controller->ucType];
 				info.addr = controller->ucI2cAddress >> 1;
 				strlcpy(info.type, name, sizeof(info.type));
-				i2c_new_device(&rdev->pm.i2c_bus->adapter, &info);
+				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 			}
 		} else {
 			DRM_INFO("Unknown thermal controller type %d at 0x%02x %s fan control\n",
diff --git a/drivers/gpu/drm/radeon/radeon_combios.c b/drivers/gpu/drm/radeon/radeon_combios.c
index c3e49c973812..d3c04df7e75d 100644
--- a/drivers/gpu/drm/radeon/radeon_combios.c
+++ b/drivers/gpu/drm/radeon/radeon_combios.c
@@ -2704,7 +2704,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 				const char *name = thermal_controller_names[thermal_controller];
 				info.addr = i2c_addr >> 1;
 				strlcpy(info.type, name, sizeof(info.type));
-				i2c_new_device(&rdev->pm.i2c_bus->adapter, &info);
+				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 			}
 		}
 	} else {
@@ -2721,7 +2721,7 @@ void radeon_combios_get_power_modes(struct radeon_device *rdev)
 				const char *name = "f75375";
 				info.addr = 0x28;
 				strlcpy(info.type, name, sizeof(info.type));
-				i2c_new_device(&rdev->pm.i2c_bus->adapter, &info);
+				i2c_new_client_device(&rdev->pm.i2c_bus->adapter, &info);
 				DRM_INFO("Possible %s thermal controller at 0x%02x\n",
 					 name, info.addr);
 			}
-- 
2.20.1

