Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB49C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947B320639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgHRGyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:54:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbgHRGyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:54:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2A4A0217B627E9D100EC;
        Tue, 18 Aug 2020 14:53:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 14:53:48 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon 0/4] Use drv_err instead of DRM_ERROR in hibmc driver 
Date:   Tue, 18 Aug 2020 14:51:40 +0800
Message-ID: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 is using the drv_err instead of DRM_ERROR in hibmc_ttm.c
patch #2 is using the drv_err instead of DRM_ERROR in hibmc_drm_vdac.c
patch #3 is using the drv_err and drm_dbg_atomic  instead of DRM_ERROR
and DRM_DEBUG_ATOMIC  in hibmc_drm_de.c
patch #4 is using the drv_err and drm_warn instead of DRM_ERROR and
DRM_WARN in hibmc_drm_drv.c

Tian Tao (4):
  drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_ttm
  drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_vdac
  drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_de
  drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_drv

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 14 +++++++-------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  | 24 ++++++++++++------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  4 ++--
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c      |  2 +-
 4 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.7.4

