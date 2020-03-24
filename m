Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A02C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF8020775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056277;
	bh=Td0VTEA4giKMKVzXp4NT3S64O2tEPqFcHTgV4ped+YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TehrlYKMYCjaCJg83F2FaI2GWXfgussTqBVYRmQjj7brv+nSqTRoBcvpe5itDcgOt
	 mskXnZuq4qmHFqnicCW1EV46d/wgRV+aBpaHSVR7mOqStX6eIcEMwEQDYpAkOI+XvX
	 hrJmeeLvi95TVyubgFEniV6BhaFKDtFAJhIvK/aI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgCXNYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbgCXNY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:24:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF80208D6;
        Tue, 24 Mar 2020 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056269;
        bh=Td0VTEA4giKMKVzXp4NT3S64O2tEPqFcHTgV4ped+YU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wrbtfv8MLGKSr08jv7+mRDrPmpE6XEgJus88k3xw7W0wO6ry/aWm4bsv8dJ3veN+o
         s/Raulko5zNHeaparurbiY3Zmv53nl1bmw6+v+/0p91PtFEIbiMeN9ZeGCaA7rsfJD
         G7AnZCMOMFuw+K1XVOAC7OVRCjr0mM5BoV6RA8QA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.5 075/119] mmc: sdhci-acpi: Disable write protect detection on Acer Aspire Switch 10 (SW5-012)
Date:   Tue, 24 Mar 2020 14:11:00 +0100
Message-Id: <20200324130815.953085001@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 3397b251ea02003f47f0b1667f3fe30bb4f9ce90 upstream.

On the Acer Aspire Switch 10 (SW5-012) microSD slot always reports the card
being write-protected even though microSD cards do not have a write-protect
switch at all.

Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk which when set sets
the MMC_CAP2_NO_WRITE_PROTECT flag on the controller for the external SD
slot; and add a DMI quirk table entry which selects this quirk for the
Acer SW5-012.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200316184753.393458-2-hdegoede@redhat.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-acpi.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -80,6 +80,7 @@ struct sdhci_acpi_host {
 
 enum {
 	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			= BIT(0),
+	DMI_QUIRK_SD_NO_WRITE_PROTECT				= BIT(1),
 };
 
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
@@ -671,6 +672,18 @@ static const struct dmi_system_id sdhci_
 		},
 		.driver_data = (void *)DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP,
 	},
+	{
+		/*
+		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
+		 * reports the card being write-protected even though microSD
+		 * cards do not have a write-protect switch at all.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{} /* Terminating entry */
 };
 
@@ -795,6 +808,9 @@ static int sdhci_acpi_probe(struct platf
 
 		if (quirks & DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP)
 			c->reset_signal_volt_on_suspend = true;
+
+		if (quirks & DMI_QUIRK_SD_NO_WRITE_PROTECT)
+			host->mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
 	}
 
 	err = sdhci_setup_host(host);


