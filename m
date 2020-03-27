Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6376CC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3802020705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WklFs/2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0Ifu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:35:50 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:32822 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbgC0Ift (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:35:49 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DEE89404BF;
        Fri, 27 Mar 2020 08:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585298149; bh=7XXazYeyn/wi9GuA0Vv4y2sHS5WrThISwNq/vLtxKUw=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=WklFs/2vZpJv+CpAw2mpfXrgQ/tYK6zdJrM+4QH4W0ygUVxix3GX1teyj7xwhkDNW
         OfQtYwRGhval8qKDC6LsLLFEBE36y5/LcHfQzb1IItKGHn85mR8Dh9ymbhpbfrluaG
         vF76AU5X7PI+3eqb8SC6KWh8PPFbIYvSa0UpSwypcekxD/mR8EglzthaAdq8g9R0eY
         DFOTAXpnJiKwGqIo5LrEh21Y5b6V+rS3VAtWD0Z9nsV7m05oLFPfBAU7JxLXPc+fzU
         09NgcfL3cej/sx54AQt5u3w3pKBw3VJSfp0CTOBmUPK9uIUPhkxluPron9bzwMadFR
         T0Ht7ob6aA5ag==
Received: from tejas-VirtualBox (joglekar-e7480.internal.synopsys.com [10.146.16.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 868B1A005C;
        Fri, 27 Mar 2020 08:35:45 +0000 (UTC)
Received: by tejas-VirtualBox (sSMTP sendmail emulation); Fri, 27 Mar 2020 14:05:43 +0530
Date:   Fri, 27 Mar 2020 14:05:43 +0530
Message-Id: <77bc6b930db30822a3675cad4fa585a6081516d5.1585297723.git.joglekar@synopsys.com>
In-Reply-To: <cover.1585297723.git.joglekar@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Subject: [RFC PATCH 3/4] usb: dwc3: Add device property consolidate-sgl
To:     Felipe Balbi <balbi@kernel.org>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     John Youn <John.Youn@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the consolidate-sgl property to enable quirk for the
XHCI driver with Synopsys xHC. This property is enabled as initial
property for the dwc3-haps driver.

Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
---
 drivers/usb/dwc3/core.c      | 2 ++
 drivers/usb/dwc3/core.h      | 2 ++
 drivers/usb/dwc3/dwc3-haps.c | 1 +
 drivers/usb/dwc3/host.c      | 5 ++++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index edc17155cb2b..de1747c78cd6 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1296,6 +1296,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,usb3_lpm_capable");
 	dwc->usb2_lpm_disable = device_property_read_bool(dev,
 				"snps,usb2-lpm-disable");
+	dwc->consolidate_sgl  = device_property_read_bool(dev,
+				"snps,consolidate-sgl");
 	device_property_read_u8(dev, "snps,rx-thr-num-pkt-prd",
 				&rx_thr_num_pkt_prd);
 	device_property_read_u8(dev, "snps,rx-max-burst-prd",
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 6846eb0cba13..d6e15f75809e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1007,6 +1007,7 @@ struct dwc3_scratchpad_array {
  *			not needed for DWC_usb31 version 1.70a-ea06 and below
  * @usb3_lpm_capable: set if hadrware supports Link Power Management
  * @usb2_lpm_disable: set to disable usb2 lpm
+ * @consolidate_sgl: set to enable the SG list consolidation
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
@@ -1206,6 +1207,7 @@ struct dwc3 {
 	unsigned		dis_start_transfer_quirk:1;
 	unsigned		usb3_lpm_capable:1;
 	unsigned		usb2_lpm_disable:1;
+	unsigned		consolidate_sgl:1;
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
diff --git a/drivers/usb/dwc3/dwc3-haps.c b/drivers/usb/dwc3/dwc3-haps.c
index 3cecbf169452..495815081576 100644
--- a/drivers/usb/dwc3/dwc3-haps.c
+++ b/drivers/usb/dwc3/dwc3-haps.c
@@ -29,6 +29,7 @@ static const struct property_entry initial_properties[] = {
 	PROPERTY_ENTRY_BOOL("snps,usb3_lpm_capable"),
 	PROPERTY_ENTRY_BOOL("snps,has-lpm-erratum"),
 	PROPERTY_ENTRY_BOOL("snps,dis_enblslpm_quirk"),
+	PROPERTY_ENTRY_BOOL("snps,consolidate-sgl"),
 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 	{ },
 };
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 86dbd012b984..2de8f3f74b93 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -44,7 +44,7 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 
 int dwc3_host_init(struct dwc3 *dwc)
 {
-	struct property_entry	props[4];
+	struct property_entry	props[5];
 	struct platform_device	*xhci;
 	int			ret, irq;
 	struct resource		*res;
@@ -95,6 +95,9 @@ int dwc3_host_init(struct dwc3 *dwc)
 	if (dwc->usb2_lpm_disable)
 		props[prop_idx++] = PROPERTY_ENTRY_BOOL("usb2-lpm-disable");
 
+	if (dwc->consolidate_sgl)
+		props[prop_idx++] = PROPERTY_ENTRY_BOOL("consolidate-sgl");
+
 	/**
 	 * WORKAROUND: dwc3 revisions <=3.00a have a limitation
 	 * where Port Disable command doesn't work.
-- 
2.11.0

