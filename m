Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07642C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01BE2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgG3WSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:18:34 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:41307 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbgG3WSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:18:34 -0400
Received: from localhost.localdomain (unknown [46.106.42.139])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 2AB1D100003;
        Thu, 30 Jul 2020 22:18:26 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     dan.carpenter@oracle.com, andy.shevchenko@gmail.com
Cc:     andriy.shevchenko@linux.intel.com, cengiz@kernel.wtf,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, sakari.ailus@linux.intel.com
Subject: [PATCH v2] staging: atomisp: move null check to earlier point
Date:   Fri, 31 Jul 2020 01:17:38 +0300
Message-Id: <20200730221737.51569-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730084545.GB1793@kadam>
References: <20200730084545.GB1793@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`find_gmin_subdev` function that returns a pointer to `struct
gmin_subdev` can return NULL.

In `gmin_v2p8_ctrl` there's a call to this function but the possibility
of a NULL was not checked before its being dereferenced. ie:

```
/* Acquired here --------v */
struct gmin_subdev *gs = find_gmin_subdev(subdev);

/*  v------Dereferenced here */
if (gs->v2p8_gpio >= 0) {
    ...
}
```

To avoid the issue, null check has been moved to an earlier point
and return semantics has been changed to reflect this exception.

Please do note that this change introduces a new return value to
`gmin_v2p8_ctrl`.

[NEW] - raise a WARN and return -ENODEV if there are no subdevices.
      - return result of `gpio_request` or `gpio_direction_output`.
      - return 0 if GPIO is ON.
      - return results of `regulator_enable` or `regulator_disable`.
      - according to PMIC type, return result of `axp_regulator_set`
        or `gmin_i2c_write`.
      - return -EINVAL if unknown PMIC type.

Caught-by: Coverity Static Analyzer CID 1465536
Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
index 0df46a1af5f0..1ad0246764a6 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_gmin_platform.c
@@ -871,6 +871,9 @@ static int gmin_v2p8_ctrl(struct v4l2_subdev *subdev, int on)
 	int ret;
 	int value;
 
+	if (WARN_ON(!gs))
+		return -ENODEV;
+
 	if (gs->v2p8_gpio >= 0) {
 		pr_info("atomisp_gmin_platform: 2.8v power on GPIO %d\n",
 			gs->v2p8_gpio);
@@ -881,7 +884,7 @@ static int gmin_v2p8_ctrl(struct v4l2_subdev *subdev, int on)
 			pr_err("V2P8 GPIO initialization failed\n");
 	}
 
-	if (!gs || gs->v2p8_on == on)
+	if (gs->v2p8_on == on)
 		return 0;
 	gs->v2p8_on = on;
 
-- 
2.27.0

