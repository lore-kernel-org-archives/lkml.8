Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC30C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A0020732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgDMOGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:06:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2311 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbgDMOGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:06:43 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 11DA4C60BE33694BA829;
        Mon, 13 Apr 2020 22:06:39 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 22:06:31 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/radeon: remove defined but not used variables in ci_dpm.c
Date:   Mon, 13 Apr 2020 22:33:00 +0800
Message-ID: <20200413143300.23244-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/gpu/drm/radeon/ci_dpm.c:82:36: warning: ‘defaults_saturn_pro’
defined but not used [-Wunused-const-variable=]
 static const struct ci_pt_defaults defaults_saturn_pro =
                                    ^~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/radeon/ci_dpm.c:68:36: warning: ‘defaults_bonaire_pro’
defined but not used [-Wunused-const-variable=]
 static const struct ci_pt_defaults defaults_bonaire_pro =
                                    ^~~~~~~~~~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index a9257bed3484..134aa2b01f90 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -65,13 +65,6 @@ static const struct ci_pt_defaults defaults_bonaire_xt =
 	{ 0x17C, 0x172, 0x180, 0x1BC, 0x1B3, 0x1BD, 0x206, 0x200, 0x203, 0x25D, 0x25A, 0x255, 0x2C3, 0x2C5, 0x2B4 }
 };
 
-static const struct ci_pt_defaults defaults_bonaire_pro =
-{
-	1, 0xF, 0xFD, 0x19, 5, 45, 0, 0x65062,
-	{ 0x8C,  0x23F, 0x244, 0xA6,  0x83,  0x85,  0x86,  0x86,  0x83,  0xDB,  0xDB,  0xDA,  0x67,  0x60,  0x5F  },
-	{ 0x187, 0x193, 0x193, 0x1C7, 0x1D1, 0x1D1, 0x210, 0x219, 0x219, 0x266, 0x26C, 0x26C, 0x2C9, 0x2CB, 0x2CB }
-};
-
 static const struct ci_pt_defaults defaults_saturn_xt =
 {
 	1, 0xF, 0xFD, 0x19, 5, 55, 0, 0x70000,
@@ -79,13 +72,6 @@ static const struct ci_pt_defaults defaults_saturn_xt =
 	{ 0x187, 0x187, 0x187, 0x1C7, 0x1C7, 0x1C7, 0x210, 0x210, 0x210, 0x266, 0x266, 0x266, 0x2C9, 0x2C9, 0x2C9 }
 };
 
-static const struct ci_pt_defaults defaults_saturn_pro =
-{
-	1, 0xF, 0xFD, 0x19, 5, 55, 0, 0x30000,
-	{ 0x96,  0x21D, 0x23B, 0xA1,  0x85,  0x87,  0x83,  0x84,  0x81,  0xE6,  0xE6,  0xE6,  0x71,  0x6A,  0x6A  },
-	{ 0x193, 0x19E, 0x19E, 0x1D2, 0x1DC, 0x1DC, 0x21A, 0x223, 0x223, 0x26E, 0x27E, 0x274, 0x2CF, 0x2D2, 0x2D2 }
-};
-
 static const struct ci_pt_config_reg didt_config_ci[] =
 {
 	{ 0x10, 0x000000ff, 0, 0x0, CISLANDS_CONFIGREG_DIDT_IND },
-- 
2.21.1

