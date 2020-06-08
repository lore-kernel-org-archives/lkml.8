Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2895FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0716A2068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658116;
	bh=Gb4m4Bg7zSFEgsq+BlQuMfZGMwCh1LLMqd3yI6mgJ00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ajcQcMviNmUFDSIeuBUAnVVzavHLUejz7Eilp2gISq7g5GTdYK+5Dnnoy63JMXrT/
	 HC3OQAzM8MyUCdGO8xrze4h8oX9QyaPaXEYNimi5bfjSZbJdFaKO6VaB5yFZ+piNl/
	 yc3yIhkhljDY/ZUh+5n/D6TdFEVzzLZIwicZZgq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgFHXPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgFHXMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:12:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BB3C212CC;
        Mon,  8 Jun 2020 23:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657962;
        bh=Gb4m4Bg7zSFEgsq+BlQuMfZGMwCh1LLMqd3yI6mgJ00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yaOo7wwk+ghb0sVQfevFXDdiHqkcdKc1OWumfWE76vAp3CmH93q3KwuuHQx/eKuB/
         S4yzaPvSsmhuy+ottEq4+OIHyGQP4StyJ1XWntTbUDvueeV85q1NdIBdYcsmayluJs
         G3W6UbaWkOKAdWMWKXU0OdBQ7yDpuitdCCLSvOzI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH AUTOSEL 5.6 026/606] usb: core: hub: limit HUB_QUIRK_DISABLE_AUTOSUSPEND to USB5534B
Date:   Mon,  8 Jun 2020 19:02:31 -0400
Message-Id: <20200608231211.3363633-26-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniu Rosca <erosca@de.adit-jv.com>

commit 76e1ef1d81a4129d7e2fb8c48c83b166d1c8e040 upstream.

On Tue, May 12, 2020 at 09:36:07PM +0800, Kai-Heng Feng wrote [1]:
> This patch prevents my Raven Ridge xHCI from getting runtime suspend.

The problem described in v5.6 commit 1208f9e1d758c9 ("USB: hub: Fix the
broken detection of USB3 device in SMSC hub") applies solely to the
USB5534B hub [2] present on the Kingfisher Infotainment Carrier Board,
manufactured by Shimafuji Electric Inc [3].

Despite that, the aforementioned commit applied the quirk to _all_ hubs
carrying vendor ID 0x424 (i.e. SMSC), of which there are more [4] than
initially expected. Consequently, the quirk is now enabled on platforms
carrying SMSC/Microchip hub models which potentially don't exhibit the
original issue.

To avoid reports like [1], further limit the quirk's scope to
USB5534B [2], by employing both Vendor and Product ID checks.

Tested on H3ULCB + Kingfisher rev. M05.

[1] https://lore.kernel.org/linux-renesas-soc/73933975-6F0E-40F5-9584-D2B8F615C0F3@canonical.com/
[2] https://www.microchip.com/wwwproducts/en/USB5534B
[3] http://www.shimafuji.co.jp/wp/wp-content/uploads/2018/08/SBEV-RCAR-KF-M06Board_HWSpecificationEN_Rev130.pdf
[4] https://devicehunt.com/search/type/usb/vendor/0424/device/any

Fixes: 1208f9e1d758c9 ("USB: hub: Fix the broken detection of USB3 device in SMSC hub")
Cc: stable@vger.kernel.org # v4.14+
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200514220246.13290-1-erosca@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/hub.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 2b6565c06c23..fc748c731832 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -39,6 +39,7 @@
 
 #define USB_VENDOR_GENESYS_LOGIC		0x05e3
 #define USB_VENDOR_SMSC				0x0424
+#define USB_PRODUCT_USB5534B			0x5534
 #define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
 #define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
 
@@ -5621,8 +5622,11 @@ static void hub_event(struct work_struct *work)
 }
 
 static const struct usb_device_id hub_id_table[] = {
-    { .match_flags = USB_DEVICE_ID_MATCH_VENDOR | USB_DEVICE_ID_MATCH_INT_CLASS,
+    { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
+                   | USB_DEVICE_ID_MATCH_PRODUCT
+                   | USB_DEVICE_ID_MATCH_INT_CLASS,
       .idVendor = USB_VENDOR_SMSC,
+      .idProduct = USB_PRODUCT_USB5534B,
       .bInterfaceClass = USB_CLASS_HUB,
       .driver_info = HUB_QUIRK_DISABLE_AUTOSUSPEND},
     { .match_flags = USB_DEVICE_ID_MATCH_VENDOR
-- 
2.25.1

