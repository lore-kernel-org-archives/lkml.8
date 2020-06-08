Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12BDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32D520888
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591660212;
	bh=xZpGO2Wpg8bkbZbIwKzLlhUpZOxh3/2ANTJ01WCWS6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HIHhFm7uAsh214MHi/RgIgwg+fw3agtnJd6Y4Q3f+ghAQizOB4hgNWnb115hHRS7j
	 JjCAu/EvnDwJVagqUYB/aun2aAoIfZD21AVRqmNBCYelg4K7Vta/gYU5kkPFx9OBpu
	 ioaUsBzbgtUOSSHR2MkMeL5CxKHXpfgSQRkldAwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgFHXuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731465AbgFHXZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:25:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24DF82072F;
        Mon,  8 Jun 2020 23:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658726;
        bh=xZpGO2Wpg8bkbZbIwKzLlhUpZOxh3/2ANTJ01WCWS6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wrnmnr9nRcXtGec+Zld5ILCDQCFezjAilWBzqf/iQt3zw3HNaojIZY+de6iFL6Ksm
         KzW0LoUFCg8EzcKtt7GuJWbqlpLu2IewdkuEpzYu1By6yDZPT7ji4WpNBKGCrn8let
         dD1o8ZzfEwVA3/M47W2Jrxqlg/ZPR07rsSIauvI8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/72] spi: dw: Fix Rx-only DMA transfers
Date:   Mon,  8 Jun 2020 19:24:07 -0400
Message-Id: <20200608232500.3369581-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232500.3369581-1-sashal@kernel.org>
References: <20200608232500.3369581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Serge Semin <Sergey.Semin@baikalelectronics.ru>

[ Upstream commit 46164fde6b7890e7a3982d54549947c8394c0192 ]

Tx-only DMA transfers are working perfectly fine since in this case
the code just ignores the Rx FIFO overflow interrupts. But it turns
out the SPI Rx-only transfers are broken since nothing pushing any
data to the shift registers, so the Rx FIFO is left empty and the
SPI core subsystems just returns a timeout error. Since DW DMAC
driver doesn't support something like cyclic write operations of
a single byte to a device register, the only way to support the
Rx-only SPI transfers is to fake it by using a dummy Tx-buffer.
This is what we intend to fix in this commit by setting the
SPI_CONTROLLER_MUST_TX flag for DMA-capable platform.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
Link: https://lore.kernel.org/r/20200529131205.31838-9-Sergey.Semin@baikalelectronics.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index b461200871f8..26ed3b4233a2 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -526,6 +526,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 			dws->dma_inited = 0;
 		} else {
 			master->can_dma = dws->dma_ops->can_dma;
+			master->flags |= SPI_CONTROLLER_MUST_TX;
 		}
 	}
 
-- 
2.25.1

