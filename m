Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E1CC33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CC724725
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196596;
	bh=lUlCwCexTDZ3NR5DpiFBuA6C6iX4HlYozf/mvEvlh3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UzHR4+m+YIQah7E/1naF1HWCf+o7DNjhahCvItFuUyBCVYXUTvCkzEI2UzLU6aM9A
	 AxxCYeyv05nBRqxFFFrpHqVTwrNNzekdzt92sQVialejPmZDKS4PIDwNh5LcCCZMCt
	 Sl0T56dXhPdsrawd1iSBgLsUfPF4m31wWLRziECU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393897AbgAPRnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393862AbgAPRnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCAE24718;
        Thu, 16 Jan 2020 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196585;
        bh=lUlCwCexTDZ3NR5DpiFBuA6C6iX4HlYozf/mvEvlh3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gn8jDO7tK8qCN8K8umtt1Y++z2tyFGfcfcTTjtAosjyWRuRLNqmT/7GnKeKxrZ/BY
         +I/25Zj1FU7ZqiQl/K2NJymKYKNzhifHYIJ9PZ3AB4ag8vRSCMNqJasecTSSTRpKuZ
         DZbg8vCPxUu5+0TpJzroSiV+F3JRuYqY2ttTGMR0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 010/174] pinctrl: sh-pfc: r8a7740: Add missing LCD0 marks to lcd0_data24_1 group
Date:   Thu, 16 Jan 2020 12:40:07 -0500
Message-Id: <20200116174251.24326-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116174251.24326-1-sashal@kernel.org>
References: <20200116174251.24326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 96bb2a6ab4eca10e5b6490b3f0738e9f7ec22c2b ]

The lcd0_data24_1_pins[] array contains the LCD0 D1[2-5] pin numbers,
but the lcd0_data24_1_mux[] array lacks the corresponding pin marks.

Fixes: 06c7dd866da70f6c ("sh-pfc: r8a7740: Add LCDC0 and LCDC1 pin groups and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index aa7c346dff6d..bc2ee07fa92f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2155,6 +2155,7 @@ static const unsigned int lcd0_data24_1_mux[] = {
 	LCD0_D0_MARK, LCD0_D1_MARK, LCD0_D2_MARK, LCD0_D3_MARK,
 	LCD0_D4_MARK, LCD0_D5_MARK, LCD0_D6_MARK, LCD0_D7_MARK,
 	LCD0_D8_MARK, LCD0_D9_MARK, LCD0_D10_MARK, LCD0_D11_MARK,
+	LCD0_D12_MARK, LCD0_D13_MARK, LCD0_D14_MARK, LCD0_D15_MARK,
 	LCD0_D16_MARK, LCD0_D17_MARK, LCD0_D18_PORT163_MARK,
 	LCD0_D19_PORT162_MARK, LCD0_D20_PORT161_MARK, LCD0_D21_PORT158_MARK,
 	LCD0_D22_PORT160_MARK, LCD0_D23_PORT159_MARK,
-- 
2.20.1

