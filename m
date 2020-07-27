Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3046C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E0BC21775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859889;
	bh=weRdGSoG9bjwzupYqd5vwcpAZAB7vdEjth1Z4RV9UpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aJVgWBGnvUHCTVfHpc0ZWoAp//TMepXo9MYW7Um3Nlbc6UWY961xPH5OW72ajIOEL
	 f65jryQnvuNAGpLyoi9ou2y+qhgrfmN91NCuhhKRW3KdMpktSU7evrDz8xveHd6Gyz
	 Y9Y/SZMft8OIeYTtPwGO3aE1Czctps47/dX0ruF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgG0OYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:24:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbgG0OYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:24:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29BF208E4;
        Mon, 27 Jul 2020 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859881;
        bh=weRdGSoG9bjwzupYqd5vwcpAZAB7vdEjth1Z4RV9UpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfVvoRerQEYlNEKQ+0xSD09BhPNT5CRk6jiJjQijlkc9hElFnfG/eIq3vmlu75ZvL
         pAXBJEPpgFmMR+4WnxGKVqEHRfpd0YLr5Haq5R8l44ZfAGWzrOpFux+5yokC2Qxl1o
         Dt77h06RJmP6HbPynM0WxewEIzmrhoAjfvhnolYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.7 141/179] usb: tegra: Fix allocation for the FPCI context
Date:   Mon, 27 Jul 2020 16:05:16 +0200
Message-Id: <20200727134939.503608590@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Hunter <jonathanh@nvidia.com>

commit 0b987032f8b58ef51cc8a042f46cc0cf1f277172 upstream.

Commit 5c4e8d3781bc ("usb: host: xhci-tegra: Add support for XUSB
context save/restore") is using the IPFS 'num_offsets' value when
allocating memory for FPCI context instead of the FPCI 'num_offsets'.

After commit cad064f1bd52 ("devres: handle zero size in devm_kmalloc()")
was added system suspend started failing on Tegra186. The kernel log
showed that the Tegra XHCI driver was crashing on entry to suspend when
attempting the save the USB context. On Tegra186, the IPFS context has a
zero length but the FPCI content has a non-zero length, and because of
the bug in the Tegra XHCI driver we are incorrectly allocating a zero
length array for the FPCI context. The crash seen on entering suspend
when we attempt to save the FPCI context and following commit
cad064f1bd52 ("devres: handle zero size in devm_kmalloc()") this now
causes a NULL pointer deference when we access the memory. Fix this by
correcting the amount of memory we are allocating for FPCI contexts.

Cc: stable@vger.kernel.org

Fixes: 5c4e8d3781bc ("usb: host: xhci-tegra: Add support for XUSB context save/restore")

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20200715113842.30680-1-jonathanh@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -856,7 +856,7 @@ static int tegra_xusb_init_context(struc
 	if (!tegra->context.ipfs)
 		return -ENOMEM;
 
-	tegra->context.fpci = devm_kcalloc(tegra->dev, soc->ipfs.num_offsets,
+	tegra->context.fpci = devm_kcalloc(tegra->dev, soc->fpci.num_offsets,
 					   sizeof(u32), GFP_KERNEL);
 	if (!tegra->context.fpci)
 		return -ENOMEM;


