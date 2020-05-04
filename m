Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD66C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A332073E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615380;
	bh=e6ccMfhxtpK7sTocC+QkoGt/nt9t13JWpEXbmbDlFks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ukYWmf/Pgy4nqnrI8r3Yc14up9/BjJpgNvEjWFwUfsCTl60UvT7GKgK89LYRxElwo
	 dMAefkh+UeXj/8yRGywfi/v88Io/kTGsHw6ypB/i/roPa1dxw/rBD+XKNda63/jMV8
	 Cfmai38m9F30M+AbSNwEjw2trC1r764NvdODVh60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgEDSDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbgEDSC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:02:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5039320707;
        Mon,  4 May 2020 18:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615376;
        bh=e6ccMfhxtpK7sTocC+QkoGt/nt9t13JWpEXbmbDlFks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReiSJfoWIXscHLvMnzHxAZmqcuSxWy+QpROoWh4DOWfbn1YzMJafW5cwnR7c7gYdu
         0Vns6qcQSRMyJU7fTG+aZfFxO/coK1MPBJ0DwAqTCmbNyA4ECLYs7SqIX8gkYfe8OQ
         kyz6YJnC8DVulO+vnD6NWWLbUOzn+L2+9eyK+Cvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.4 14/57] mmc: sdhci-pci: Fix eMMC driver strength for BYT-based controllers
Date:   Mon,  4 May 2020 19:57:18 +0200
Message-Id: <20200504165457.666271534@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

commit 1a8eb6b373c2af6533c13d1ea11f504e5010ed9a upstream.

BIOS writers have begun the practice of setting 40 ohm eMMC driver strength
even though the eMMC may not support it, on the assumption that the kernel
will validate the value against the eMMC (Extended CSD DRIVER_STRENGTH
[offset 197]) and revert to the default 50 ohm value if 40 ohm is invalid.

This is done to avoid changing the value for different boards.

Putting aside the merits of this approach, it is clear the eMMC's mask
of supported driver strengths is more reliable than the value provided
by BIOS. Add validation accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 51ced59cc02e ("mmc: sdhci-pci: Use ACPI DSM to get driver strength for some Intel devices")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200422111629.4899-1-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-pci-core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -601,6 +601,9 @@ static int intel_select_drive_strength(s
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct intel_host *intel_host = sdhci_pci_priv(slot);
 
+	if (!(mmc_driver_type_mask(intel_host->drv_strength) & card_drv))
+		return 0;
+
 	return intel_host->drv_strength;
 }
 


