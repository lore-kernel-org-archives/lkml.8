Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602A5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFD320848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703473;
	bh=qylBH5YcfQTK+S1FKPcZxOPzCVgqwh/KiSNuFJFHugE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VcYzN88/sqxA/R41za8Zis2cnVo19yJaqHU1HS7BaOl3jMdI62jhRAEDZFoDXHEUL
	 BJ8EQ6CRi/qonh8drM3VUNntucr88SsS0P/QRBwUi8QMuyN6yoDjlSf8PcELp7wUxY
	 8/4FwUBp0GWWJYpx4+J7ChypSRBPDN7IXqUhe/k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbgBNPzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731744AbgBNPzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:55:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC7FF24676;
        Fri, 14 Feb 2020 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695722;
        bh=qylBH5YcfQTK+S1FKPcZxOPzCVgqwh/KiSNuFJFHugE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkFPZnNsQe3Hfz2gPdhTWleK3RlOHQEUPQ4htquRLvZ1Elc9GQgvwFRAz9wxCUMOB
         /NMZQNNX/VYn641mJzty0SzJ+AU0EYkOQe6uo1hXQ//sz4Bu4r88ltLgEHvke2IajA
         rJVzYPugr1kNtScRZnxOLy73Gg2wyA7X9bWKKHvA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Zhou <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 299/542] drm/gma500: remove set but not used variables 'hist_reg'
Date:   Fri, 14 Feb 2020 10:44:51 -0500
Message-Id: <20200214154854.6746-299-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
index dc6a73ab9777c..f29061061debf 100644
--- a/drivers/gpu/drm/gma500/psb_irq.c
+++ b/drivers/gpu/drm/gma500/psb_irq.c
@@ -458,12 +458,11 @@ void psb_irq_turn_off_dpst(struct drm_device *dev)
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

