Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1257CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCCBF24125
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865909;
	bh=iONcR0lsEY9tloT3W/e7oiBJ/zAaQD8DgJ7MKHKb7rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yRNUnfMlJSWNvNOjO/HQOa6Y93I+D2zNrmP3kwWQVkZi1dwuRarG2I96Bad+5xWsN
	 P342X20NyxhloFBNe/nTcwZOdHDLvizHNwIIlvx3JE3mMIlzWgbq6x9M19gsrZohX0
	 ughzBzC+AbQ76s0VCmBR45DcdER09FKbnJPJRDeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391691AbgAXL2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:28:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391312AbgAXL2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:28:30 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2062B20704;
        Fri, 24 Jan 2020 11:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865310;
        bh=iONcR0lsEY9tloT3W/e7oiBJ/zAaQD8DgJ7MKHKb7rQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BGtC5nLPoxeDN9MeA9YZohfYxXcBShQGC5Dhn0b8k8202BKDHBmgHZIBKfu/JeJ+C
         9z8NW11QIB3axva32UszMrKXI2p2GZpcjoaAONhRLMjTFROPUVcsWpPZnLQa6g74vh
         aStEAewarZPb496j1W9Y4f+R4DQsnsfpd1kgtsxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 498/639] spi: bcm-qspi: Fix BSPI QUAD and DUAL mode support when using flex mode
Date:   Fri, 24 Jan 2020 10:31:08 +0100
Message-Id: <20200124093151.164503950@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

[ Upstream commit 79629d0f7ce5b38515c1716911a0181f01b91102 ]

Fix data transfer width settings based on DT field 'spi-rx-bus-width'
to configure BSPI in single, dual or quad mode by using data width
and not the command width.

Fixes: 5f195ee7d830c ("spi: bcm-qspi: Implement the spi_mem interface")

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Link: https://lore.kernel.org/r/1565086070-28451-1-git-send-email-rayagonda.kokatanur@broadcom.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 584bcb018a62d..285a6f463013b 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -354,7 +354,7 @@ static int bcm_qspi_bspi_set_flex_mode(struct bcm_qspi *qspi,
 {
 	int bpc = 0, bpp = 0;
 	u8 command = op->cmd.opcode;
-	int width  = op->cmd.buswidth ? op->cmd.buswidth : SPI_NBITS_SINGLE;
+	int width = op->data.buswidth ? op->data.buswidth : SPI_NBITS_SINGLE;
 	int addrlen = op->addr.nbytes;
 	int flex_mode = 1;
 
@@ -992,7 +992,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 	if (mspi_read)
 		return bcm_qspi_mspi_exec_mem_op(spi, op);
 
-	ret = bcm_qspi_bspi_set_mode(qspi, op, -1);
+	ret = bcm_qspi_bspi_set_mode(qspi, op, 0);
 
 	if (!ret)
 		ret = bcm_qspi_bspi_exec_mem_op(spi, op);
-- 
2.20.1



