Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C36C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9271207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996519;
	bh=XQLkSruPo+o5PUSErv4u/zaJfbC1EOrkYq7lBk8SaLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+LBJu9NgVOTa3tk0JKsq3qON/XOI5DoJcw8FchsAZPSFgS6dqNnLMlT9dx0wPz/Z
	 /2DAETScuU6PKpmRTdaYCLZksIUq3X77J6DekQoykKF5sQ0QDVRsBJn2GJ5FulMvTK
	 oTlX6LydS8ybQUklayIYEhzF16Efmey1YbpX04Ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgANKIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgANKIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:08:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89247207FF;
        Tue, 14 Jan 2020 10:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996514;
        bh=XQLkSruPo+o5PUSErv4u/zaJfbC1EOrkYq7lBk8SaLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Opt09eAgz/DaGEyCv+VwY/HmC9Wvz91gDVRHBiFX2aBypdO/7beOf9QDmVaRt+Sz4
         8Y+VseF1RI2F2W+TYoqKd6/J7haTb0L6RIC2ScyVlwQS45RPlsaOTUZSkJslCWvqkF
         MhByH/yfkcTsYnuHNRmBzWYHHjUMJyrKEocuLDrw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4.19 43/46] phy: cpcap-usb: Fix flakey host idling and enumerating of devices
Date:   Tue, 14 Jan 2020 11:02:00 +0100
Message-Id: <20200114094348.528047360@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit 049226b9fd7442149dcbcf55f15408f5973cceda upstream.

We must let the USB host idle things properly before we switch to debug
UART mode. Otherwise the USB host may never idle after disconnecting
devices, and that causes the next enumeration to be flakey.

Cc: Jacopo Mondi <jacopo@jmondi.org>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Michael Scott <hashcode0f@gmail.com>
Cc: NeKit <nekit1000@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Fixes: 6d6ce40f63af ("phy: cpcap-usb: Add CPCAP PMIC USB support")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/motorola/phy-cpcap-usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/phy/motorola/phy-cpcap-usb.c
+++ b/drivers/phy/motorola/phy-cpcap-usb.c
@@ -281,13 +281,13 @@ static void cpcap_usb_detect(struct work
 		return;
 	}
 
+	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
+
 	/* Default to debug UART mode */
 	error = cpcap_usb_set_uart_mode(ddata);
 	if (error)
 		goto out_err;
 
-	cpcap_usb_try_musb_mailbox(ddata, MUSB_VBUS_OFF);
-
 	dev_dbg(ddata->dev, "set UART mode\n");
 
 	return;


