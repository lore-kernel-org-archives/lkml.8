Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C35C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF5820722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgCZVLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:11:45 -0400
Received: from sauhun.de ([88.99.104.3]:54366 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgCZVKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:10:06 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id 710E62C1F8A;
        Thu, 26 Mar 2020 22:10:05 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [PATCH 0/6] gpu: convert to use new I2C API
Date:   Thu, 26 Mar 2020 22:09:58 +0100
Message-Id: <20200326211005.13301-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are deprecating calls which return NULL in favor of new variants which
return an ERR_PTR. Only build tested.


Wolfram Sang (6):
  drm/amdgpu: convert to use i2c_new_client_device()
  drm/gma500: convert to use i2c_new_client_device()
  drm/i2c/sil164: convert to use i2c_new_client_device()
  drm/i2c/tda998x: convert to use i2c_new_client_device()
  drm/nouveau/therm: convert to use i2c_new_client_device()
  drm/radeon: convert to use i2c_new_client_device()

 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c        | 2 +-
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c     | 8 ++++----
 drivers/gpu/drm/i2c/sil164_drv.c               | 7 +++++--
 drivers/gpu/drm/i2c/tda998x_drv.c              | 6 +++---
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/ic.c | 4 ++--
 drivers/gpu/drm/radeon/radeon_atombios.c       | 4 ++--
 drivers/gpu/drm/radeon/radeon_combios.c        | 4 ++--
 7 files changed, 19 insertions(+), 16 deletions(-)

-- 
2.20.1

