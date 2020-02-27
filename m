Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE20C52D29
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B022084E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811825;
	bh=GVGRG8gK82aBCwUZLoqTcSU04M881wJnQ7d3V3BZkjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B5iYD6GiOjX9JxK0/L6nw8UBXsyYufmiUBTh42CJSbCPxORn9WbFeXQmDbdbxO5vy
	 Zs/Xt0EFBiagyJkcNGqyircwIzfBLE32j57ACkgKKOftl4aQKTUYZjoB+vaq2kDhGT
	 v8lCMSNhum5UjMfBZXEzQucblLlrH4+yy1W10peQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgB0N5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732015AbgB0N4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:56:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58612073D;
        Thu, 27 Feb 2020 13:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811814;
        bh=GVGRG8gK82aBCwUZLoqTcSU04M881wJnQ7d3V3BZkjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2QvHD0+JfaHPBKujeFtVhJ59SadobQdxMjDgb6IGa6VNaRszK6v0k4ZAE+aNoAb0B
         PwB+Pg/TQpIgEFNe8i4ersbPw6jd65VGfTNtt5TECl3eZd2Yp7ZmimPzl668U1kmqB
         HQFMoTcyk6VY3aGsr54dHBaPghEDB+WHbs6+F2j4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 110/237] ASoC: atmel: fix build error with CONFIG_SND_ATMEL_SOC_DMA=m
Date:   Thu, 27 Feb 2020 14:35:24 +0100
Message-Id: <20200227132304.988250589@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 4a56f3dfba513..23887613b5c39 100644
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



