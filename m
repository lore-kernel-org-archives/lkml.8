Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DF0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C7E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218482;
	bh=A69Yjn+0hqvyqX8LOalUa/LcXZPSxXGdX21+SlYfcgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XOqy9ygeHdVFA3nyUzvqYGhDEt/1t9qniz0A2pGk0pgW7uE5GV28wtq1S+5ilm4sZ
	 xhMXE94g6FIGPbHCYo0nnxJMrSElbFE6879ueGzzxrGcd+gZwsex/8gOPp7gs8dDkV
	 255axE+WjaiJkN+GkItmZzJ18knkZQwZr/8OsMm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389182AbgAPXUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390575AbgAPXUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:20:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3200A20684;
        Thu, 16 Jan 2020 23:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216809;
        bh=A69Yjn+0hqvyqX8LOalUa/LcXZPSxXGdX21+SlYfcgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f/FSa+3+sZ4uK+QYip0gVhT8a5wKtO/1tVVB/u83d2CIC3f/R7oOfVQfCQGvo384+
         6FGy/fH/XDwxa3b4+oYoa6etZ12s7COOMq8ADNeGhVIWPxHyOwov2IgwjXJndoNExg
         G/7CeLN8BAzIIngrdumr1cMFiQwYTQPdA9kTGy0Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH 5.4 028/203] PCI: amlogic: Fix probed clock names
Date:   Fri, 17 Jan 2020 00:15:45 +0100
Message-Id: <20200116231746.838687863@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

commit eacaf7dcf08eb062a1059c6c115fa3fced3374ae upstream.

Fix the clock names used in the probe function according
to the bindings.

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pci-meson.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -250,15 +250,15 @@ static int meson_pcie_probe_clocks(struc
 	if (IS_ERR(res->port_clk))
 		return PTR_ERR(res->port_clk);
 
-	res->mipi_gate = meson_pcie_probe_clock(dev, "pcie_mipi_en", 0);
+	res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
 	if (IS_ERR(res->mipi_gate))
 		return PTR_ERR(res->mipi_gate);
 
-	res->general_clk = meson_pcie_probe_clock(dev, "pcie_general", 0);
+	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
 	if (IS_ERR(res->general_clk))
 		return PTR_ERR(res->general_clk);
 
-	res->clk = meson_pcie_probe_clock(dev, "pcie", 0);
+	res->clk = meson_pcie_probe_clock(dev, "pclk", 0);
 	if (IS_ERR(res->clk))
 		return PTR_ERR(res->clk);
 


