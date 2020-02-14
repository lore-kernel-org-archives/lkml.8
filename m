Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293BAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E00217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698354;
	bh=dyJB4AbiRs8UTaYPM1R1ihsyd+1yCPfzHhcMjATqpkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ktft6YNJGgxWR+Ii53Ka5jx7JSw49rATz1m4TazkcIHZIc/wVWGrar5X6zV/ry7/c
	 N5845BvuZ3FW0RnyC144zVdr8MbVB2Kmh9Iun8Tyh01VvtIHdmdnNFseaD5r/cACin
	 +uYtDw2jSc0E4rctd1Xcld/qvdHBApDX22JGLG2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393903AbgBNQjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:39:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405573AbgBNQXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:23:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F1B24764;
        Fri, 14 Feb 2020 16:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697396;
        bh=dyJB4AbiRs8UTaYPM1R1ihsyd+1yCPfzHhcMjATqpkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNztqH8a/7lg1iFB5xyvjVavR1YSNR2UCIRMFmotyqieeZCQci9O9YVkdMr3OV6tS
         H9ySMa6PiHr/8pZ1uZr4QEPR6TMzb+5ZyyOFqR9PA4/DYfBguR4shZXv5jlGHmVDQm
         wKC2QCzM/cR0kejBZnr466ZKJ2QMDoakOaN+YgIs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Zhou <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 090/141] ASoC: atmel: fix build error with CONFIG_SND_ATMEL_SOC_DMA=m
Date:   Fri, 14 Feb 2020 11:20:30 -0500
Message-Id: <20200214162122.19794-90-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Zhou <chenzhou10@huawei.com>

[ Upstream commit 8fea78029f5e6ed734ae1957bef23cfda1af4354 ]

If CONFIG_SND_ATMEL_SOC_DMA=m, build error:

sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
(.text+0x7cd): undefined reference to `atmel_pcm_dma_platform_register'

Function atmel_pcm_dma_platform_register is defined under
CONFIG SND_ATMEL_SOC_DMA, so select SND_ATMEL_SOC_DMA in
CONFIG SND_ATMEL_SOC_SSC, same to CONFIG_SND_ATMEL_SOC_PDC.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Link: https://lore.kernel.org/r/20200113133242.144550-1-chenzhou10@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/atmel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index 22aec9a1e9a49..838d03a138ca2 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -25,6 +25,8 @@ config SND_ATMEL_SOC_DMA
 
 config SND_ATMEL_SOC_SSC_DMA
 	tristate
+	select SND_ATMEL_SOC_DMA
+	select SND_ATMEL_SOC_PDC
 
 config SND_ATMEL_SOC_SSC
 	tristate
-- 
2.20.1

