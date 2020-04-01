Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CD5C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA1921655
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758627;
	bh=fTRyOl1Orx7e2ysLkp6Ucx/ayhAxV6Tul2irmgEtuWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MTTjOcXEEogsfiId5OBj7JBOWG7BUHyN/IPjejG6s5Jf0cGV//iZ4FxH0DlfTPP85
	 bNv1OKbENCt55cAL3DcfJHU+yS0/aAntUWI3h/cdCvJtZibCUUGbx+75RW5aBts08v
	 M0hcJGUb6QypDJxsg28ywmRQ21Ae/IM95Kqb2JdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbgDAQa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732683AbgDAQaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:30:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451472137B;
        Wed,  1 Apr 2020 16:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758622;
        bh=fTRyOl1Orx7e2ysLkp6Ucx/ayhAxV6Tul2irmgEtuWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYGFDV3Peo4FE8F9agiEir3RbYJoUwoeBf7O+lePMVi2Ch3bl/uFHg+Ihswo3n9AD
         eQ+qGWflWnZFfeHHBjTK8W0VzxltRaP1oZNkXogmMA39my+ARfgfPtjBYokGXyrJDZ
         gVN84XX4gTY2livea4OvnFo9ZfQV1dM7oSUmWUag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4.4 18/91] staging: rtl8188eu: Add device id for MERCUSYS MW150US v2
Date:   Wed,  1 Apr 2020 18:17:14 +0200
Message-Id: <20200401161519.229022998@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
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
@@ -50,6 +50,7 @@ static struct usb_device_id rtw_usb_id_t
 	{USB_DEVICE(0x2001, 0x331B)}, /* D-Link DWA-121 rev B1 */
 	{USB_DEVICE(0x2357, 0x010c)}, /* TP-Link TL-WN722N v2 */
 	{USB_DEVICE(0x2357, 0x0111)}, /* TP-Link TL-WN727N v5.21 */
+	{USB_DEVICE(0x2C4E, 0x0102)}, /* MERCUSYS MW150US v2 */
 	{USB_DEVICE(0x0df6, 0x0076)}, /* Sitecom N150 v2 */
 	{USB_DEVICE(USB_VENDER_ID_REALTEK, 0xffef)}, /* Rosewill RNX-N150NUB */
 	{}	/* Terminating entry */


