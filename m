Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA94C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A6421532
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322304;
	bh=yPmakgyZf3oG9P+PmWrdeHlR5ZNMhUmeT1qM0Vy9QHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QPxdFRSU9RVIIroJHeQLydEb5U5Ng3/CJHAeo/yYeGBifNiHB7URAreCsXywNC70E
	 Ob1ggzUtHFiC2DJMimTrAidbsBz+2/PmoW3SnZW2SndpvehufUjUqse+r2DoqSX1fP
	 lIKEoD4+56O3OITxRF+9p+5Subto2Z18fOK3wdDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgFPPpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732014AbgFPPov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:44:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 264FE21475;
        Tue, 16 Jun 2020 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322290;
        bh=yPmakgyZf3oG9P+PmWrdeHlR5ZNMhUmeT1qM0Vy9QHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lg03a356GX8b1LnUKw81lS3ykVMezQQffMU4sbJmaXPgBg0/ucdQyDF78vfuY1aZv
         LzEIZC3YFMS3HBU+fwQ3y8RSLWwCrL+c4byefLvJpdveDlBql+jKaMS5PUYJxFe+ZM
         jCoQj1EBPzq0wnyBFVDNZLLHx2LDZomev0gncyZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.7 074/163] ACPI: GED: add support for _Exx / _Lxx handler methods
Date:   Tue, 16 Jun 2020 17:34:08 +0200
Message-Id: <20200616153110.393704376@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit ea6f3af4c5e63f6981c0b0ab8ebec438e2d5ef40 upstream.

Per the ACPI spec, interrupts in the range [0, 255] may be handled
in AML using individual methods whose naming is based on the format
_Exx or _Lxx, where xx is the hex representation of the interrupt
index.

Add support for this missing feature to our ACPI GED driver.

Cc: v4.9+ <stable@vger.kernel.org> # v4.9+
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/evged.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -79,6 +79,8 @@ static acpi_status acpi_ged_request_inte
 	struct resource r;
 	struct acpi_resource_irq *p = &ares->data.irq;
 	struct acpi_resource_extended_irq *pext = &ares->data.extended_irq;
+	char ev_name[5];
+	u8 trigger;
 
 	if (ares->type == ACPI_RESOURCE_TYPE_END_TAG)
 		return AE_OK;
@@ -87,14 +89,28 @@ static acpi_status acpi_ged_request_inte
 		dev_err(dev, "unable to parse IRQ resource\n");
 		return AE_ERROR;
 	}
-	if (ares->type == ACPI_RESOURCE_TYPE_IRQ)
+	if (ares->type == ACPI_RESOURCE_TYPE_IRQ) {
 		gsi = p->interrupts[0];
-	else
+		trigger = p->triggering;
+	} else {
 		gsi = pext->interrupts[0];
+		trigger = p->triggering;
+	}
 
 	irq = r.start;
 
-	if (ACPI_FAILURE(acpi_get_handle(handle, "_EVT", &evt_handle))) {
+	switch (gsi) {
+	case 0 ... 255:
+		sprintf(ev_name, "_%c%02hhX",
+			trigger == ACPI_EDGE_SENSITIVE ? 'E' : 'L', gsi);
+
+		if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))
+			break;
+		/* fall through */
+	default:
+		if (ACPI_SUCCESS(acpi_get_handle(handle, "_EVT", &evt_handle)))
+			break;
+
 		dev_err(dev, "cannot locate _EVT method\n");
 		return AE_ERROR;
 	}


