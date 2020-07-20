Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B4DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D522064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260005;
	bh=cnGdhLX3OX47LwPLNQMdxtiWeUvP28zzYPAcYex2Z7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=njpO4i8JlZm49WVOZuLOBce43zvzioFk7o8hMGhdzjGhppxV13ijLd5OGvHUcZ1Dq
	 rZAOhf4F+H9zSY8d0Pa3rgiIQfsYh1bNoH7duSXhpUPaiIWvsD/RrGVn4/DAI3SwE2
	 zTMfZpNOR7sbbnenZDBWepCHgg0yOFPLJMPtJNgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgGTPqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730677AbgGTPqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:46:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A192065E;
        Mon, 20 Jul 2020 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259998;
        bh=cnGdhLX3OX47LwPLNQMdxtiWeUvP28zzYPAcYex2Z7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XDmwr61nnp7S76Npx118nkcLovXuKGzGetaqTcwuNXiXJBMQi2BsS5rknQ5pB1gW
         bAP+nfJKVsEtJpIeMqSd5G8zNUB8Nts8R5WTk80tJdHExQ5guAYaREJ/tRmv6L+/Jg
         bGgltJbSgGmfGLwuZHrjJP/nkzYxe2Rk2/Vl1/Ig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Angelo Dureghello <angelo@sysam.it>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 070/125] spi: fix initial SPI_SR value in spi-fsl-dspi
Date:   Mon, 20 Jul 2020 17:36:49 +0200
Message-Id: <20200720152806.402266827@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Angelo Dureghello <angelo@sysam.it>

[ Upstream commit aa54c1c9d90e6db75190813907190fadcce1bf45 ]

On ColdFire mcf54418, using DSPI_DMA_MODE mode, spi transfers
at first boot stage are not succeding:

m25p80 spi0.1: unrecognized JEDEC id bytes: 00, 00, 00

The reason is the SPI_SR initial value set by the driver, that
is not clearing (not setting to 1) the RF_DF flag. After a tour
on the dspi hw modules that use this driver(Vybrid, ColdFire and
ls1021a) a better init value for SR register has been set.

Signed-off-by: Angelo Dureghello <angelo@sysam.it>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index cce9e34306787..6da70a62e1964 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -76,7 +76,7 @@
 #define SPI_SR			0x2c
 #define SPI_SR_EOQF		0x10000000
 #define SPI_SR_TCFQF		0x80000000
-#define SPI_SR_CLEAR		0xdaad0000
+#define SPI_SR_CLEAR		0x9aaf0000
 
 #define SPI_RSER_TFFFE		BIT(25)
 #define SPI_RSER_TFFFD		BIT(24)
-- 
2.25.1



