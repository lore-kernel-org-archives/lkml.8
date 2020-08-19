Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C99BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDAB2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597838845;
	bh=lD1z+6B6Hv/5RcoylS7Y5W+SmGK/qiZiuARtEnKUb9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pUFuEy4pmjez4gOe0rZOWe9Rj4RsLoI+luUCXNk0o2OLrLLUmtXq4aNftqjE65npX
	 HqHcbuqCyGNfSciD9zGjwXfGrLEYkRZGRwQJwn9u3gjCw9eC46/eMEFTX7bx7ubwzG
	 3nSrs9iYA/8JeJ6mKsHysbZNnJZss4aYrHh2nKtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHSMGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:06:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728211AbgHSLrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:40 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A40C72083B;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=lD1z+6B6Hv/5RcoylS7Y5W+SmGK/qiZiuARtEnKUb9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fl0qUJV+Ju9cogwWDawaevyvFcOjBYfxwTK+81xiX8TPzd+EmfzYvfailIXS9FKaF
         hY1d4bxk0Kq1nOhb+zkLfCE0wV0SoKlH4QpyxZJxDxulQuYkKI75WcNwm4LALA8twn
         oAfzl97CdUFCwjF2bP8MdGM+BIM79RnWMdaDVdH8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00EubA-Fp; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/49] staging: hikey9xx/gpu: remove an uneeded hack
Date:   Wed, 19 Aug 2020 13:45:56 +0200
Message-Id: <b9ad9a5922a9e53cac02af1c2c74f4a7d2fa262d.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least on current upstream Kernels, forcing an event parse
during init time isn't needed anymore.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
index 44f7c15f386a..3d1b5f738a7f 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_drv.c
@@ -122,11 +122,6 @@ static int kirin_drm_kms_init(struct drm_device *dev)
 	/* init kms poll for handling hpd */
 	drm_kms_helper_poll_init(dev);
 
-#if 1
-	/* force detection after connectors init */
-	(void)drm_helper_hpd_irq_event(dev);
-#endif
-
 	return 0;
 
 err_unbind_all:
-- 
2.26.2

