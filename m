Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BF9C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED86A20737
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326159;
	bh=ZimnssbihiT/CUcvGjrmtWm5fbdnfn+B5wH6DVTDZMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zSSiTzaUX68SsjSbOG8rFPvSxbADjP+VZmQG+VaXmFr5cZOVxdFOPgn/qqdR2QyGn
	 kSj3qUC821iXn1Apba0uDd0RS18GgMmj49lUynwknXJw+SVHSwWBhg75zCLtZ8/ckO
	 9UlD/EGIVePc+kXOlRSchUVarWb2Bln/LqyH1a0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgCPCf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:40750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730287AbgCPCfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:35:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5672074C;
        Mon, 16 Mar 2020 02:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326153;
        bh=ZimnssbihiT/CUcvGjrmtWm5fbdnfn+B5wH6DVTDZMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lcy+SkQYUCJqEpLLtN5fjgSp4a19uFUYFSR6kOJatsRalMGE+INAVofAAKgKIDZq6
         nYUTCxxG+pLrA7hd5FWmm43PlBiwVgZ4h6iGqbDWxHzF+QH5z4+1xIGVOGgZJdSDio
         BNlmssaUhL+8DkVB3gEBJHadHsHZkLJTeVIMXCQw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thommy Jakobsson <thommyj@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.4 4/7] spi/zynqmp: remove entry that causes a cs glitch
Date:   Sun, 15 Mar 2020 22:35:44 -0400
Message-Id: <20200316023548.2347-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023548.2347-1-sashal@kernel.org>
References: <20200316023548.2347-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index f23f36ebaf3dc..bd3945a5660a5 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -414,9 +414,6 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
 
 	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
 
-	/* Dummy generic FIFO entry */
-	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
-
 	/* Manually start the generic FIFO command */
 	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
 			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
-- 
2.20.1

