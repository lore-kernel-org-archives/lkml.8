Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5327C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACBDB21D7D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgIINWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:22:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730236AbgIINSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:18:43 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65E8EBEA3453F427F1BC;
        Wed,  9 Sep 2020 21:00:33 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:00:25 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool warning
Date:   Wed, 9 Sep 2020 21:07:12 +0800
Message-ID: <20200909130720.105234-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zheng Bin (8):
  drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in
    amdgpu_atpx_handler.c
  drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c

 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
 drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
 8 files changed, 11 insertions(+), 11 deletions(-)

--
2.26.0.106.g9fadedd

