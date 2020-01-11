Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4EEC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C6720848
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738180;
	bh=LXSItio5r38Tkfc003AwtVAQ31ISjAGXhsab1xkw3Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjJwMEXiXzYeXz3lbNnCTv7Y5W7DCr4HPXvH0wbH2CKD17AD422nrr/BtyjY2BV77
	 sZmoufCW+B1aTHxoR2i8iuMohFZTqU2S027R+XMVhr+maMZudAfaYuJRIulmsAmKmz
	 vXjt+RaaVav6tpP1XQExnbQyIadvTssRBkQ8Sw/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgAKKW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgAKKWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:22:54 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B068820848;
        Sat, 11 Jan 2020 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738174;
        bh=LXSItio5r38Tkfc003AwtVAQ31ISjAGXhsab1xkw3Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YctXUry8x5DylFygSny3cxgZqscq3fg11DHUm28h41Rw/NM1l7HBBZd+tfYsZvDW6
         d1YUc7uUI0uB2Q7UL/W+GUhLiFlu3OTP7BYG9JDGrDBjEostBZ5dVBXQhk1QUqBvRD
         Fsdv+On9M4nlkfPKfyb7sgt6SHBTpAxJ3q7WeR2w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/165] spi: spi-cavium-thunderx: Add missing pci_release_regions()
Date:   Sat, 11 Jan 2020 10:49:22 +0100
Message-Id: <20200111094924.523980135@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
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
index d12e149f1a41..fd6b9caffaf0 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -82,6 +82,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 
 error:
 	clk_disable_unprepare(p->clk);
+	pci_release_regions(pdev);
 	spi_master_put(master);
 	return ret;
 }
@@ -96,6 +97,7 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 		return;
 
 	clk_disable_unprepare(p->clk);
+	pci_release_regions(pdev);
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
 }
-- 
2.20.1



