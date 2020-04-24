Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D72C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF8320736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587724213;
	bh=EK33FmOk+ha98O+uI3Cs0pGl+RYBYtokDBlp6oaw4LU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iUxhdfaA5s3iWJOmN9eLJqa2F9Wsy/bVcG3dB5hu88a2ONslHcJt2o4qrmK5EFcbQ
	 T2RI+jdn0JxlgJgHwbvuqKr+1g4Etk0olaFC1rg543CdTWe3fs4lrY7IEbhBUlOJLR
	 1cmevmxPAhnWIgyhvbgPS+NiEpTdiJ1RDHM6gp3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgDXKaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgDXKaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:30:10 -0400
Received: from localhost.localdomain (unknown [117.99.83.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA00F2071E;
        Fri, 24 Apr 2020 10:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587724210;
        bh=EK33FmOk+ha98O+uI3Cs0pGl+RYBYtokDBlp6oaw4LU=;
        h=From:To:Cc:Subject:Date:From;
        b=0+4R6LQdseuGlJ8FsJA28AgJpnFebAo9u4pH9xtbpAap3FVD7Ujq1nei+3+KN4TnR
         lBSeYsaiSBIOQnBu6mW/HytjSee/xE8lPscbx3c0uurTorJH5sZnu1oiYSlMKyroT6
         dyK21RjRA5RkdOb5G471skJVds063O85T0rkM9Xs=
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable SM8250 GCC driver
Date:   Fri, 24 Apr 2020 15:59:43 +0530
Message-Id: <20200424102943.2368764-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SM8250 GCC driver so that we can boot to shell with defconfig

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a546a153604f..3b67211aa2f7 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -809,6 +809,7 @@ CONFIG_SDM_GCC_845=y
 CONFIG_SDM_GPUCC_845=y
 CONFIG_SDM_DISPCC_845=y
 CONFIG_SM_GCC_8150=y
+CONFIG_SM_GCC_8250=y
 CONFIG_QCOM_HFPLL=y
 CONFIG_HWSPINLOCK=y
 CONFIG_HWSPINLOCK_QCOM=y
-- 
2.25.1

