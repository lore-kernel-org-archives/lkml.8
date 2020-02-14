Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D18CC3B1A1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A2120656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699858;
	bh=IBGB+xDX7Tk9f82+ViaLQcfskmpjmicN/oxDPAoTq6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EVxFYbzhvrl6puHCLWu9s2iSOvZygSbaogO65Lq/hF/PyYQVYvG5z4xXow3V7vm9N
	 Bg3eER1sNjQgoc9Yn8hoxmuMt17Y8152XPjiH52sB7DwqJDcoK6MjtDfvQpS8Q4rPO
	 RdFffoHlG41V4Wwg+D33KckVFuzJ3RqYFoYeXlIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391757AbgBNQPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392363AbgBNQOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:14:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C15CD246E0;
        Fri, 14 Feb 2020 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696881;
        bh=IBGB+xDX7Tk9f82+ViaLQcfskmpjmicN/oxDPAoTq6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wPkprbZUFyqb/JA39AE1UgbnlLJCK5xvJEMM0/pcxJTPiKSCcU1AF5KIXq5kkwaie
         CoddkStmsHI4ZcDTGubJV5DdUXqpJsGLxwDLmW91bM8HQneK25rPjur21ftHP2cMLk
         8UFgg3zFe1yu/qHv0JxfN0KZlb1CTaNMH+yHN8cI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Zhou <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 136/252] drm/gma500: remove set but not used variables 'hist_reg'
Date:   Fri, 14 Feb 2020 11:09:51 -0500
Message-Id: <20200214161147.15842-136-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

[ Upstream commit 72f775611daf3ce20358388facbaf11f22899fa2 ]

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/gma500/psb_irq.c: In function psb_irq_turn_off_dpst:
drivers/gpu/drm/gma500/psb_irq.c:473:6:
	warning: variable hist_reg set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191227114811.14907-1-chenzhou10@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/gma500/psb_irq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
index f75f199c84311..518d7b4456bf1 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -471,12 +471,11 @@ void psb_irq_turn_off_dpst(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv =
 	    (struct drm_psb_private *) dev->dev_private;
-	u32 hist_reg;
 	u32 pwm_reg;
 
 	if (gma_power_begin(dev, false)) {
 		PSB_WVDC32(0x00000000, HISTOGRAM_INT_CONTROL);
-		hist_reg = PSB_RVDC32(HISTOGRAM_INT_CONTROL);
+		PSB_RVDC32(HISTOGRAM_INT_CONTROL);
 
 		psb_disable_pipestat(dev_priv, 0, PIPE_DPST_EVENT_ENABLE);
 
-- 
2.20.1

