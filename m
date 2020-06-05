Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED12C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798C320663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591366851;
	bh=GVHnm3hh3L2GRK/NDb/CACB4DM4slcHUXJjsoaWORg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D39EEB3CkHJAy7XHXalXFOpX0Id5FILoE4Oe8tu0/J6O9ku1E1DNXOwwVUFz871u4
	 pPXmfyKNRNUNASqSHrK/1nFUHmPAY/VU4ViIF2vtPzbPpdRAwU9k9IjEVgZgg4Nhf1
	 uQ75dF6ckSB2sbUkS14LYABr/XMxeAYcGogm91Hk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgFEOUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728950AbgFEOUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:20:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 973D120663;
        Fri,  5 Jun 2020 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591366822;
        bh=GVHnm3hh3L2GRK/NDb/CACB4DM4slcHUXJjsoaWORg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0LSwgbpdGoFI07VHi260pG8KGhhFCqHYvIpTwLTYGLBDxPtxsJ5tbLab3AKoyBHp
         AQj+5Od5akD78sFeTppHQ3qc9pFSDSNxamMoJsELXOtz38UvyavWdVeueaAN8+vehp
         j9KTGc3XJQ9LwIE6HU99qYiv0rTGrKVBDEzGhpSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Giuseppe Marco Randazzo <gmrandazzo@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Christian Lamparter <chunkeey@gmail.com>
Subject: [PATCH 4.19 06/28] p54usb: add AirVasT USB stick device-id
Date:   Fri,  5 Jun 2020 16:15:08 +0200
Message-Id: <20200605140252.700944477@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200605140252.338635395@linuxfoundation.org>
References: <20200605140252.338635395@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giuseppe Marco Randazzo <gmrandazzo@gmail.com>

commit 63e49a9fdac1b4e97ac26cb3fe953f210d83bc53 upstream.

This patch adds the AirVasT USB wireless devices 124a:4026
to the list of supported devices. It's using the ISL3886
usb firmware. Without this modification, the wiki adapter
is not recognized.

Cc: <stable@vger.kernel.org>
Signed-off-by: Giuseppe Marco Randazzo <gmrandazzo@gmail.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com> [formatted, reworded]
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200405220659.45621-1-chunkeey@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intersil/p54/p54usb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/intersil/p54/p54usb.c
+++ b/drivers/net/wireless/intersil/p54/p54usb.c
@@ -64,6 +64,7 @@ static const struct usb_device_id p54u_t
 	{USB_DEVICE(0x0db0, 0x6826)},	/* MSI UB54G (MS-6826) */
 	{USB_DEVICE(0x107b, 0x55f2)},	/* Gateway WGU-210 (Gemtek) */
 	{USB_DEVICE(0x124a, 0x4023)},	/* Shuttle PN15, Airvast WM168g, IOGear GWU513 */
+	{USB_DEVICE(0x124a, 0x4026)},	/* AirVasT USB wireless device */
 	{USB_DEVICE(0x1435, 0x0210)},	/* Inventel UR054G */
 	{USB_DEVICE(0x15a9, 0x0002)},	/* Gemtek WUBI-100GW 802.11g */
 	{USB_DEVICE(0x1630, 0x0005)},	/* 2Wire 802.11g USB (v1) / Z-Com */


