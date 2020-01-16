Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C1BC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BE72081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193201;
	bh=N4rYiCfLiFPq3Jr96nV115rnHp8H/x4+c7d7Dn7Afr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t9c2RTK6LUblT/VAZR8qDPh6NAKa/B+AxjBrr3xqNW6Lol5l6V4xtF8efWT5gTsHJ
	 RRL32RHfFITitqbYXkjGYi1fm6cFG77TVJ+YRVG5f/R0rfVg+6UkgNVnKxJIspo7rL
	 YsSmDfugQiWd7PZdq48aD5YEQRgm2MHdGVqWZBh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgAPQqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgAPQqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:46:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EBDE214AF;
        Thu, 16 Jan 2020 16:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193197;
        bh=N4rYiCfLiFPq3Jr96nV115rnHp8H/x4+c7d7Dn7Afr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DO00mwYCQfPKLSGXm4lAoGXcS6DJQ4MazuRa8Lpx2ErVdvc2kOyaHszoPeon3cCf+
         RBMg2K3tm2z2+oo7YVxDvGLlOkd4bU+PkEJ2IFGInvA/15tb9hOBJTBpfHaSiUszvD
         ed4rguj9CeueICTjto55cFD0yGRIdxqY8DAOBl2E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yong Wu <yong.wu@mediatek.com>, Anan Sun <anan.sun@mediatek.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 044/205] memory: mtk-smi: Add PM suspend and resume ops
Date:   Thu, 16 Jan 2020 11:40:19 -0500
Message-Id: <20200116164300.6705-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yong Wu <yong.wu@mediatek.com>

[ Upstream commit fb03082a54acd66c61535edfefe96b2ff88ce7e2 ]

In the commit 4f0a1a1ae351 ("memory: mtk-smi: Invoke pm runtime_callback
to enable clocks"), we use pm_runtime callback to enable/disable the smi
larb clocks. It will cause the larb's clock may not be disabled when
suspend. That is because device_prepare will call pm_runtime_get_noresume
which will keep the larb's PM runtime status still is active when suspend,
then it won't enter our pm_runtime suspend callback to disable the
corresponding clocks.

This patch adds suspend pm_ops to force disable the clocks, Use "LATE" to
make sure it disable the larb's clocks after the multimedia devices.

Fixes: 4f0a1a1ae351 ("memory: mtk-smi: Invoke pm runtime_callback to enable clocks")
Signed-off-by: Anan Sun <anan.sun@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/mtk-smi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 439d7d886873..a113e811faab 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -366,6 +366,8 @@ static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 
 static const struct dev_pm_ops smi_larb_pm_ops = {
 	SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 };
 
 static struct platform_driver mtk_smi_larb_driver = {
@@ -507,6 +509,8 @@ static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
 
 static const struct dev_pm_ops smi_common_pm_ops = {
 	SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 };
 
 static struct platform_driver mtk_smi_common_driver = {
-- 
2.20.1

