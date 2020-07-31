Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2793DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D5120829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731035AbgGaBHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:07:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8862 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728080AbgGaBHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:07:10 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BBBFCF5543E1A3EA348;
        Fri, 31 Jul 2020 09:07:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 31 Jul 2020 09:06:59 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon 0/2] hibmc clean up 
Date:   Fri, 31 Jul 2020 09:05:06 +0800
Message-ID: <1596157506-49928-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some refactoring of the code, #1 is clean up, #2 is for
code refactoring. 

Tian Tao (2):
  drm/hisilicon: Remove the unnecessary header files
  drm/hisilicon: Code refactoring for hibmc_drv_de

 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c   | 58 ++++++------------------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c  |  5 --
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h  |  2 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c |  2 -
 4 files changed, 15 insertions(+), 52 deletions(-)

-- 
2.7.4

