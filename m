Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F48C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682EF208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645818;
	bh=ZmACsDQQqEmFzphVKiN3V7EO4QhkgJNKRbxPkL6TpN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xGsoVcEYaM7q8rs4vY2CJj2QSpaG+UdhCyNvaA1NHTsGlafMvAUhkFUFp/rg548Z9
	 NpQU4nCO0vhdoiPD/tsI7Y6iHDuKCKVQFTgYVLD9rt3B4HF9jcJNx5LNnxQ/YOO06C
	 xVSQV1TDMnya2Mkzhk4eevBeyXiJsetqIhFt1Spk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgCaJKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731169AbgCaJKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:10:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B50208E0;
        Tue, 31 Mar 2020 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645815;
        bh=ZmACsDQQqEmFzphVKiN3V7EO4QhkgJNKRbxPkL6TpN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4LA9FxPOhsoF9Yhdz8i5rGtydZa6dxgH8ojnsmantqlG/s9rAUakhO0C/DtBro9d
         5emX7oDw5A2k9LFXhIRZuW2U1KRz/TopGQOEMxm4lBrJvg1oZFpeP18q/mdDESE3Hw
         b2tXqyW4T/Ad1I/t5N1OdySbgDmvlgOsP+8V/7mk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        kovi <zraetn@gmail.com>
Subject: [PATCH 5.5 158/170] staging: rtl8188eu: Add ASUS USB-N10 Nano B1 to device table
Date:   Tue, 31 Mar 2020 10:59:32 +0200
Message-Id: <20200331085439.707728115@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 38ef48f7d4b7342f145a1b4f96023bde99aeb245 upstream.

The ASUS USB-N10 Nano B1 has been reported as a new RTL8188EU device.
Add it to the device tables.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Reported-by: kovi <zraetn@gmail.com>
Cc: Stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200321180011.26153-1-Larry.Finger@lwfinger.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -32,6 +32,7 @@ static const struct usb_device_id rtw_us
 	/****** 8188EUS ********/
 	{USB_DEVICE(0x056e, 0x4008)}, /* Elecom WDC-150SU2M */
 	{USB_DEVICE(0x07b8, 0x8179)}, /* Abocom - Abocom */
+	{USB_DEVICE(0x0B05, 0x18F0)}, /* ASUS USB-N10 Nano B1 */
 	{USB_DEVICE(0x2001, 0x330F)}, /* DLink DWA-125 REV D1 */
 	{USB_DEVICE(0x2001, 0x3310)}, /* Dlink DWA-123 REV D1 */
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */


