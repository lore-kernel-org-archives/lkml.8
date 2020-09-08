Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B24206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599587452;
	bh=cdTtW9ossjS0lKVMh9rDyZz8jLKbd4RxXqjxQeq8iO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ixBZJao6td4RCQIga6mzcTGZxj5tvtuL2h3pTPnbxzYYdo3FZQTOzJEVa5mcB2Yoh
	 r8KCmQH9u+AEqKoPwwiyOFEX+l5hqhjK7BMSg15y+PiVZEyjQEkRssMtxJ/Pex6R55
	 Ct4IIkRLhXHa/UjmQdlArlagIRBi1oGfzyBpq2VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbgIHRut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731621AbgIHQN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:13:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E253248E7;
        Tue,  8 Sep 2020 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580381;
        bh=cdTtW9ossjS0lKVMh9rDyZz8jLKbd4RxXqjxQeq8iO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVNReHhCtlEqn9nbpCc1XKvlNN+hOIxjOzZxN0YPhDWRNpr7UzxnwDQv5lI92H1Yy
         WSjhffhIZWOyNhdpnL2calbZXjQoknUJ00+vdlRRpawJ8DXwVkD+S0L7N9RUlQ8c4n
         aVcdWj4PYS2KQXkxI0vRBYeX1xbSfsv8lJPhL4uc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rogan Dawes <rogan@dawes.za.net>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 46/65] usb: qmi_wwan: add D-Link DWM-222 A2 device ID
Date:   Tue,  8 Sep 2020 17:26:31 +0200
Message-Id: <20200908152219.417082248@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rogan Dawes <rogan@dawes.za.net>

[ Upstream commit 7d6053097311643545a8118100175a39bd6fa637 ]

Signed-off-by: Rogan Dawes <rogan@dawes.za.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 03f84bf4b6ee4..3e3dca59b7a69 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1216,6 +1216,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x19d2, 0x2002, 4)},	/* ZTE (Vodafone) K3765-Z */
 	{QMI_FIXED_INTF(0x2001, 0x7e19, 4)},	/* D-Link DWM-221 B1 */
 	{QMI_FIXED_INTF(0x2001, 0x7e35, 4)},	/* D-Link DWM-222 */
+	{QMI_FIXED_INTF(0x2001, 0x7e3d, 4)},	/* D-Link DWM-222 A2 */
 	{QMI_FIXED_INTF(0x2020, 0x2031, 4)},	/* Olicard 600 */
 	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
 	{QMI_FIXED_INTF(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
-- 
2.25.1



