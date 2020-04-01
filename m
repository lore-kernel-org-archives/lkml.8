Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75372C2BA15
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F0020719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759297;
	bh=T7EptmKtFcmwZNYtW2NJwIhPk4hbrAUxmdJ1+Wx/nAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NSCTlC4IeNx7FQFJK5oTKBUtDEHeWnj46zPMP2lr23MwlZ8IdNQEgZ+v8j9ZYRjiN
	 Ulj1X71GdVRPFUpjF1kIK8TLdM/Ek+zidJeReu4frbYwhSTQez+a0P8zXKCWp3J/V8
	 H3I84x2SbXRn4Ip79i6AlI0EIdv7Q+OyKFA/NU3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbgDAQlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389417AbgDAQla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:41:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D354620658;
        Wed,  1 Apr 2020 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759289;
        bh=T7EptmKtFcmwZNYtW2NJwIhPk4hbrAUxmdJ1+Wx/nAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nbal/R2DtRiD6l6DD4ouYlztcL84y0lB4GjaWHnFYnx8rAY1bhaCiieEgiP00zNly
         xXSYOyGSgFn/Gc/8ZL5402830cEA0xMk/DVNRy2rqmQfPclEspFmPVHpS/3kIMId43
         G2Dq8pOdNmTwmkzAVKQoFMAui52RoFJl6JaRxjlk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thommy Jakobsson <thommyj@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 005/148] spi/zynqmp: remove entry that causes a cs glitch
Date:   Wed,  1 Apr 2020 18:16:37 +0200
Message-Id: <20200401161552.730250784@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thommy Jakobsson <thommyj@gmail.com>

[ Upstream commit 5dd8304981ecffa77bb72b1c57c4be5dfe6cfae9 ]

In the public interface for chipselect, there is always an entry
commented as "Dummy generic FIFO entry" pushed down to the fifo right
after the activate/deactivate command. The dummy entry is 0x0,
irregardless if the intention was to activate or deactive the cs. This
causes the cs line to glitch rather than beeing activated in the case
when there was an activate command.

This has been observed on oscilloscope, and have caused problems for at
least one specific flash device type connected to the qspi port. After
the change the glitch is gone and cs goes active when intended.

The reason why this worked before (except for the glitch) was because
when sending the actual data, the CS bits are once again set. Since
most flashes uses mode 0, there is always a half clk period anyway for
cs to clk active setup time. If someone would rely on timing from a
chip_select call to a transfer_one, it would fail though.

It is unknown why the dummy entry was there in the first place, git log
seems to be of no help in this case. The reference manual gives no
indication of the necessity of this. In fact the lower 8 bits are a
setup (or hold in case of deactivate) time expressed in cycles. So this
should not be needed to fulfill any setup/hold timings.

Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
Reviewed-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Link: https://lore.kernel.org/r/20200224162643.29102-1-thommyj@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-zynqmp-gqspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 18aeaceee2862..d26c0eda2d9ea 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -415,9 +415,6 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
 
-	/* Dummy generic FIFO entry */
-	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
-
 	/* Manually start the generic FIFO command */
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
 			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-- 
2.20.1



