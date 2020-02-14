Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6448C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDFE20656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699934;
	bh=3kbU4PpQCtspoH5V5Ms/X/D2pQJR9+ziZQiWMj764e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iPircrHEy99Mp92/mo1tuVnYIjjBydhnBDzEUfQlbLkUFrCNCnjpeqfOh6/XUsjFs
	 g/kdaDWuvgCZ0hDyVa5AF6sRtxM2+81Vj8E0S74M5kwuqZCKV5fyb1UDY/XQAkzojd
	 Mnqrw4WhauzlWUOgaBqIuL9qzdTYzZXBk6sk+ys8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404721AbgBNRFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404076AbgBNQPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:15:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7EC4246E6;
        Fri, 14 Feb 2020 16:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696905;
        bh=3kbU4PpQCtspoH5V5Ms/X/D2pQJR9+ziZQiWMj764e8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmSSGRew/47yA0yEBxLwKTOqXE0TvQtg3hyll+OPj9M4tSid3rRH6zcf6HFjWRC/N
         /kHtoHE88BBhXRJbt5y1CBQ/383FYe70m7HXBHaO9WgbkciFlnoOh1er2eoamcltZk
         hN1enDJj3whD4owIIuJvhpSRqApNj9hn4y7hughA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen Zhou <chenzhou10@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 155/252] ASoC: atmel: fix build error with CONFIG_SND_ATMEL_SOC_DMA=m
Date:   Fri, 14 Feb 2020 11:10:10 -0500
Message-Id: <20200214161147.15842-155-sashal@kernel.org>
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
index 64b784e96f844..dad778e5884bd 100644
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

