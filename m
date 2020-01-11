Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5B4C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CEE20848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737415;
	bh=rn+RqjIAdDdOswpcLXNztAWhWJuyC+dPZFWOqYFTTr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v3rQujxnqPLsdwTcbG4u2oNROPdG398ZtAu0krVOcp+bd7U9AmWyJO9Th+pw8Y2cN
	 G8G2yuh/5PJB/8fMQr3q3cVpQoefa3b7F9sYdoTQftpwSf8XOXo5UGR+eDMiEv1ZmQ
	 tJjzYvBE0b8OinCyvc9hlzNppBzfjHyJzEpIzgsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgAKKKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:10:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729467AbgAKKKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:10:11 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB0D2082E;
        Sat, 11 Jan 2020 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737411;
        bh=rn+RqjIAdDdOswpcLXNztAWhWJuyC+dPZFWOqYFTTr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZP/A+6mHqT3UMgScm7JC5IIjKb2vQVOcEAWB5XdvPVLWbVTp9A3OJNCnZFT2TUDA
         vt+maWe7gWPxPfEs5mCePkyP9Otg1Yfdm7x5LXkVAZWNX0Q5bcvpcRNkhbcTt+la5/
         wOmelyhMby0H+gHfgqEsw2bdZfTLDyqUpbR7fTbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 15/62] spi: spi-cavium-thunderx: Add missing pci_release_regions()
Date:   Sat, 11 Jan 2020 10:49:57 +0100
Message-Id: <20200111094843.145609763@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094837.425430968@linuxfoundation.org>
References: <20200111094837.425430968@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit a841e2853e1afecc2ee692b8cc5bff606bc84e4c ]

The driver forgets to call pci_release_regions() in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191206075500.18525-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cavium-thunderx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index 877937706240..828fbbebc3c4 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -81,6 +81,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 
 error:
 	clk_disable_unprepare(p->clk);
+	pci_release_regions(pdev);
 	spi_master_put(master);
 	return ret;
 }
@@ -95,6 +96,7 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 		return;
 
 	clk_disable_unprepare(p->clk);
+	pci_release_regions(pdev);
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
 }
-- 
2.20.1



