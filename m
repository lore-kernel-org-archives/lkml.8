Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8302C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C4A20725
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEGLZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:25:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3889 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbgEGLZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:25:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8738379BE6317962F8C;
        Thu,  7 May 2020 19:25:03 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:24:57 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <Aric.Cyr@amd.com>, <Rodrigo.Siqueira@amd.com>, <sam@ravnborg.org>,
        <Su.Chung@amd.com>, <Anthony.Koo@amd.com>, <murton.liu@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <christian.koenig@amd.com>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH -next] drm/amd/dc: Remove a useless comparison
Date:   Thu, 7 May 2020 19:24:12 +0800
Message-ID: <20200507112412.10829-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

'en' is uint32_t and can never be negative.

drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_hpd.c:132:10: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/hw_generic.c:109:10: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
  if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c | 2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
index f9e847e6555d..6cd50232c432 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_generic.c
@@ -106,7 +106,7 @@ void dal_hw_generic_init(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
+	if (en > GPIO_DDC_LINE_MAX) {
 		ASSERT_CRITICAL(false);
 		*hw_generic = NULL;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
index 692f29de7797..f91f426699c0 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
@@ -129,7 +129,7 @@ void dal_hw_hpd_init(
 	enum gpio_id id,
 	uint32_t en)
 {
-	if ((en < GPIO_DDC_LINE_MIN) || (en > GPIO_DDC_LINE_MAX)) {
+	if (en > GPIO_DDC_LINE_MAX) {
 		ASSERT_CRITICAL(false);
 		*hw_hpd = NULL;
 	}
-- 
2.22.0

