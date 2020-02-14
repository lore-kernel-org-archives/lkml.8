Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8BC3B1AF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA90F206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702865;
	bh=BUOOIABxjFARvL7gHrijQqmmIT1LUnzmkZ+eCUq/m8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gFeokNVpOl/erv3spF0mhjzJGysQG5iDn0KIE15GyIQoyT2qTkp3nEezrZeh6sazQ
	 eBvANXRgk9k8n1EOG3OPh26miU5YL3ZHuQfnGOOmDS+YnNUaNIgPdnGpvKhQjhcy/W
	 0URrgVoe1Sk4gWJ1Xe/LtpwlQ6IT/9XWmWIxQiLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbgBNRyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:54:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388460AbgBNP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2DDE206D7;
        Fri, 14 Feb 2020 15:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695884;
        bh=BUOOIABxjFARvL7gHrijQqmmIT1LUnzmkZ+eCUq/m8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvFSGCg7IZe9r59r2Tgv66+Mrc9EVHdhh7eeD+cvETPm549G73fbgtLl1aXflgYdd
         eVX6ZvHlMiJEKgqN8RlDwJizilFHmFXj0VByCHYy8Xo+DeuotWZpbR6P/RkWWAvupT
         MRqYsemlHDjxcw2dl/o4EuqVDvelshT1j9xnGuq0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 428/542] spi: spi-fsl-qspi: Ensure width is respected in spi-mem operations
Date:   Fri, 14 Feb 2020 10:47:00 -0500
Message-Id: <20200214154854.6746-428-sashal@kernel.org>
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

From: Michael Walle <michael@walle.cc>

[ Upstream commit b0177aca7aea7e8917d4e463334b51facb293d02 ]

Make use of a core helper to ensure the desired width is respected
when calling spi-mem operators.

Otherwise only the SPI controller will be matched with the flash chip,
which might lead to wrong widths. Also consider the width specified by
the user in the device tree.

Fixes: 84d043185dbe ("spi: Add a driver for the Freescale/NXP QuadSPI controller")
Signed-off-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20200114154613.8195-1-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 79b1558b74b8a..e8a499cd1f135 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -410,7 +410,7 @@ static bool fsl_qspi_supports_op(struct spi_mem *mem,
 	    op->data.nbytes > q->devtype_data->txfifo)
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static void fsl_qspi_prepare_lut(struct fsl_qspi *q,
-- 
2.20.1

