Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ED6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D46A21582
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055933;
	bh=cWF3WUe2wPdnGgifyfwwVAofNRCsrR9G7UqKaQgj4Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2dRgAl4ZZYhd9qAuoebng/9AWWmvSiIDBB4BTzLCsHIvaGOaiqqMXuOtG6oj7eq7V
	 1Od5LWEfNsXW6xkuGphdZVJJ6aMZkLoD2wUdcM44NyBxQln1ls+VVOElwtpn+CGXo0
	 khADC2x/wlrcg9qnDkLRaHOh0sNGODHNtR5cKYy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgCXNSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgCXNSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:18:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE6C208E0;
        Tue, 24 Mar 2020 13:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055928;
        bh=cWF3WUe2wPdnGgifyfwwVAofNRCsrR9G7UqKaQgj4Gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYFt6cHe6Epa1CoZqm/GjSqVad//3x5hhTPV892YDNGuy+dJCLLSPFuhyeT01iTyc
         i+5gcVlfzU9ug1iyLXs0b40r6b4iJdi2qdBmXGbgnbIHNecnIZ10J2wukcwi/p90yF
         SPXN6nOrlDBlRtXPM0KTTDzNuI3YNTUW8thur98o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5.4 070/102] staging: rtl8188eu: Add device id for MERCUSYS MW150US v2
Date:   Tue, 24 Mar 2020 14:11:02 +0100
Message-Id: <20200324130813.678444400@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Straube <straube.linux@gmail.com>

commit bb5786b9286c253557a0115bc8d21879e61b7b94 upstream.

This device was added to the stand-alone driver on github.
Add it to the staging driver as well.

Link: https://github.com/lwfinger/rtl8188eu/commit/2141f244c3e7
Signed-off-by: Michael Straube <straube.linux@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200312093652.13918-1-straube.linux@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -38,6 +38,7 @@ static const struct usb_device_id rtw_us
 	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
 	{USB_DEVICE(0x2357, 0x0111)}, /* TP-Link TL-WN727N v5.21 */
+	{USB_DEVICE(0x2C4E, 0x0102)}, /* MERCUSYS MW150US v2 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */
 	{}	/* Terminating entry */


