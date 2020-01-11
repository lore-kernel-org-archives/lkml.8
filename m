Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE87C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D1220842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738562;
	bh=N0ebsgcUGh9PNCm8/eL8/9B2lBOlU4cHFC0L/BnKwMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rM8MirMUf+qWZU0h307PENRfWQG4febrbqiReJ4MbA+Qby8pOO+zUFdshnKFX27Jp
	 c8gRUWGdNFjmhQCC1F0El4HXW8r3Cb/6KJFX2Voz7CXtR8rYTfZYV0i/jsCkoIrIdi
	 hHl5eeT0WYjg0vQ6L8/xSWCJongEd7CPritHc7j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbgAKK3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:29:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgAKK3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:29:21 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CB1E205F4;
        Sat, 11 Jan 2020 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738560;
        bh=N0ebsgcUGh9PNCm8/eL8/9B2lBOlU4cHFC0L/BnKwMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQnDS6sYjGTewyyWCP/Mxu8RnDO6qdx/0CJGGzGVstBcSV9D8XP2qx4I/XTwdyq/r
         R8qqywnEbtQFt+emt9gHl67PIEKihWVFxV4qWsEo4uhQy/6mpWxjByYDSf+5ggz6Ca
         0IfiWbhT2wViYS+ci/JG2ZcpdV/w6Fx/L9m4JgtQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Inki Dae <inki.dae@samsung.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 117/165] drm/exynos: gsc: add missed component_del
Date:   Sat, 11 Jan 2020 10:50:36 +0100
Message-Id: <20200111094932.833126423@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 84c92365b20a44c363b95390ea00dfbdd786f031 ]

The driver forgets to call component_del in remove to match component_add
in probe.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Inki Dae <inki.dae@samsung.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 7ae087b0504d..88b6fcaa20be 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1313,6 +1313,7 @@ static int gsc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
+	component_del(dev, &gsc_component_ops);
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 
-- 
2.20.1



