Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E184BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29A020775
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgHCAky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 20:40:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9312 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727865AbgHCAko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:40:44 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B8C9AF18077B779422B4;
        Mon,  3 Aug 2020 08:40:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 3 Aug 2020 08:40:29 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon v2 0/3] hibmc clean up and code refactoring
Date:   Mon, 3 Aug 2020 08:38:31 +0800
Message-ID: <1596415114-21175-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch #1 and #3 is clean up, patch #2 is for code refactoring

Changes since v1:
- Rewrite the commits messages and patch name in #1
- Rewrite the commits message in #2.
- Add the new patch #3

Tian Tao (3):
  drm/hisilicon: Remove the unused include statements
  drm/hisilicon: Code refactoring for hibmc_drv_de
  drm/hisilicon: Rename variables to represent the correct meaning

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 58 ++++++------------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  5 --
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 -
 4 files changed, 15 insertions(+), 52 deletions(-)

-- 
2.7.4

