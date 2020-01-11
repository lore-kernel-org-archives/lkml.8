Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B2DC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 07:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807152072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 07:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgAKHq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 02:46:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728507AbgAKHq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 02:46:28 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 58AB45A5CF57F5601BCD;
        Sat, 11 Jan 2020 15:46:26 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 15:46:20 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next v2] drm/mgag200: Fix typo in module parameter description
Date:   Sat, 11 Jan 2020 07:42:06 +0000
Message-ID: <20200111074206.68290-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110012523.33053-1-weiyongjun1@huawei.com>
References: <20200110012523.33053-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was a typo in the MODULE_PARM_DESC(). It said that the
module parameter was "modeset" but it's actually the description
for "hw_bug_no_startadd".

Fixes: 3cacb2086e41 ("drm/mgag200: Add module parameter to pin all buffers at offset 0")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
v1 -> v2: Fix the description
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 7a5bad2f57d7..2236f8ef20a4 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -28,7 +28,7 @@ MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, mgag200_modeset, int, 0400);
 
 int mgag200_hw_bug_no_startadd = -1;
-MODULE_PARM_DESC(modeset, "HW does not interpret scanout-buffer start address correctly");
+MODULE_PARM_DESC(hw_bug_no_startadd, "HW does not interpret scanout-buffer start address correctly");
 module_param_named(hw_bug_no_startadd, mgag200_hw_bug_no_startadd, int, 0400);
 
 static struct drm_driver driver;



