Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F7C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9581207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578997187;
	bh=DLUMAB8sKpPd5p+SiSltdWxQrt78MGu3CgUvppVNDlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r+P6SE4k2reazon/wQ6HjK3qAQKcyadIiWuW6GrrlA5n8S81YQw6lCcLOitKvC3wD
	 i4TcXrC5nS+Ac70lR2h1ZqJYEkFLfaGrbSjbqu2m/HHxVv13qrLv200Xq+qQmjcuta
	 QYF2dsnTsl5POgtdIZcwg/7DMXEtlstY0QaH6yjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgANKFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:05:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbgANKFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:05:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E7F12467A;
        Tue, 14 Jan 2020 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996309;
        bh=DLUMAB8sKpPd5p+SiSltdWxQrt78MGu3CgUvppVNDlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2J+2WXEQq7pON/uQPZ0TY484thOyNYqTR7jDtzqyZ47Sc5xXkb0o3snolVknMDUUi
         /4ZOleY1uusjl++QmRq7f0W9l6bwug4MuDEdwNyZ/uQN//IUgjpmrw9iv/Ccm6QOIp
         +AdXnEgmCJvn/VyOjykEG7qGLFPCGJ34SpJL0xSM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5.4 52/78] staging: rtl8188eu: Add device code for TP-Link TL-WN727N v5.21
Date:   Tue, 14 Jan 2020 11:01:26 +0100
Message-Id: <20200114094400.464699193@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Straube <straube.linux@gmail.com>

commit 58dcc5bf4030cab548d5c98cd4cd3632a5444d5a upstream.

This device was added to the stand-alone driver on github.
Add it to the staging driver as well.

Link: https://github.com/lwfinger/rtl8188eu/commit/b9b537aa25a8
Signed-off-by: Michael Straube <straube.linux@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191228143725.24455-1-straube.linux@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -37,6 +37,7 @@ static const struct usb_device_id rtw_us
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */
 	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
+	{USB_DEVICE(0x2357, 0x0111)}, /* TP-Link TL-WN727N v5.21 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */
 	{}	/* Terminating entry */


