Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8641C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D1F20705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588616042;
	bh=u1eRWLzcSsHvN8fzxr/uCnaS7bnXn9sRpbs/0zvLWHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JPM5kr6BojFfvhoFK21VMK1FVhtnQ2qg2ULwbKL/prc7h/n2J04xWnGTDGDZ2eczK
	 oC/LwPwhjKZr+Vj28zgkWPjfPOKX1c+wp9tZ7wjgstgInyvxL9k7XUEK9mz1awZckK
	 WIg968saAVh6Er+MYXGVdh0F9Aa55f01rp485/PI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgEDSOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731084AbgEDSA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:00:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7183E2073B;
        Mon,  4 May 2020 18:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615255;
        bh=u1eRWLzcSsHvN8fzxr/uCnaS7bnXn9sRpbs/0zvLWHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zWCZUQ1m/edPpmXWt6tee3yajjLc7I2aPfl335/fY0pv/QY2lO50Y41WV2knBjKu2
         U7olG2VwaSr4mLju00SbymHliqM9v5GqHhGEc+oPvJuaNRf5t4lZ7PFqquu0fO/YX5
         XNGVACKJyCAen7v1hvSvQbVop21o7JqPXwdlYTpg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 09/26] mmc: sdhci-pci: Fix eMMC driver strength for BYT-based controllers
Date:   Mon,  4 May 2020 19:57:23 +0200
Message-Id: <20200504165444.899552282@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165442.494398840@linuxfoundation.org>
References: <20200504165442.494398840@linuxfoundation.org>
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
@@ -490,6 +490,9 @@ static int intel_select_drive_strength(s
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct intel_host *intel_host = sdhci_pci_priv(slot);
 
+	if (!(mmc_driver_type_mask(intel_host->drv_strength) & card_drv))
+		return 0;
+
 	return intel_host->drv_strength;
 }
 


