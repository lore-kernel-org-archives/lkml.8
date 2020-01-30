Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BFBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3957214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409739;
	bh=Blafg/gOnUuqwxNep4MqHn1CQ70cWPcCRAZMCdfVyro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=slXnWedrUCFGqgiEYuWTDS2E4fVSTyUpq4jVXiq5QFv6WGvAoKdxMgf0N3keXSd20
	 ckTU1CRQnUnUTtUPyBRFLr77CssWD4tyQQtx5lIynCr8DTYJtYYwvpOcrLAHgh1D5a
	 uHuZ3ujagUq1HqluHqQ6LK5yBLIlmpapkTZxggmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730363AbgA3SmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:42:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbgA3SmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:42:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C685205F4;
        Thu, 30 Jan 2020 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409735;
        bh=Blafg/gOnUuqwxNep4MqHn1CQ70cWPcCRAZMCdfVyro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ydlUfnKVEKcx4iQYiRfAGOqkSLMp7IbK8ptQVeMc0HmNuBXi4ShE7qZoMS8b/MJIl
         J/x3gx9lsp5xDQOHymE8FQMdGy7/bQXcLrpyl3EQz2ONVH0m8dShEhSHSsMrmHHvOO
         6RAKYbw6MbB1BkTIMpWenzo1quJ2YJS3XXSN9hFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.4 005/110] usb: host: xhci-tegra: set MODULE_FIRMWARE for tegra186
Date:   Thu, 30 Jan 2020 19:37:41 +0100
Message-Id: <20200130183614.693315849@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Robinson <pbrobinson@gmail.com>

commit e1f236efd9c579a29d7df75aa052127d0d975267 upstream.

Set the MODULE_FIRMWARE for tegra186, it's registered for 124/210 and
ensures the firmware is available at the appropriate time such as in
the initrd, else if the firmware is unavailable the driver fails with
the following errors:

tegra-xusb 3530000.usb: Direct firmware load for nvidia/tegra186/xusb.bin failed with error -2
tegra-xusb 3530000.usb: failed to request firmware: -2
tegra-xusb 3530000.usb: failed to load firmware: -2
tegra-xusb: probe of 3530000.usb failed with error -2

Fixes: 5f9be5f3f899 ("usb: host: xhci-tegra: Add Tegra186 XUSB support")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200120141910.116097-1-pbrobinson@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-tegra.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1413,6 +1413,7 @@ MODULE_FIRMWARE("nvidia/tegra210/xusb.bi
 
 static const char * const tegra186_supply_names[] = {
 };
+MODULE_FIRMWARE("nvidia/tegra186/xusb.bin");
 
 static const struct tegra_xusb_phy_type tegra186_phy_types[] = {
 	{ .name = "usb3", .num = 3, },


