Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB2C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3694222204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599842075;
	bh=JoQXBX4d16xcTyZAQCuJdMeWdYPKguExKHrFWB6Z2zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ZfVRckQoezz3EZ9PcajL4mikJPPoeNheQQqFQYh5jmBajL8CZThI19TlHw5ANXhW
	 EW/UxU5yJc74YwoV5ODAN6mv/2PRSOqrUTQoW2k0ybQqIHyy9xeStLetha2qr3YVsv
	 NOyZtheXAijBwC0tgV5D/OoorKVb1TfuoK4fBGW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgIKQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgIKPPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:15:37 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 196AE22246;
        Fri, 11 Sep 2020 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829132;
        bh=JoQXBX4d16xcTyZAQCuJdMeWdYPKguExKHrFWB6Z2zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XzTJR4v0rUY/uxTtXFKb3UHM7xrHYI9eOL8r0U+MZjrT1xdet3EquAqzi8d4mE9wX
         kaKohkEBYKaXI0+dXwgPzDoiqTigZGdA59gqgSRcyUJIWdjUSkTfXT/4D+JE28ZBKQ
         MC8Tj8DK0gH1vv//+zkBXmoc3ObnY/+7hUOuwhLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Himadri Pandya <himadrispandya@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 62/71] net: usb: Fix uninit-was-stored issue in asix_read_phy_addr()
Date:   Fri, 11 Sep 2020 14:46:46 +0200
Message-Id: <20200911122508.003816840@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911122504.928931589@linuxfoundation.org>
References: <20200911122504.928931589@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Himadri Pandya <himadrispandya@gmail.com>

commit a092b7233f0e000cc6f2c71a49e2ecc6f917a5fc upstream.

The buffer size is 2 Bytes and we expect to receive the same amount of
data. But sometimes we receive less data and run into uninit-was-stored
issue upon read. Hence modify the error check on the return value to match
with the buffer size as a prevention.

Reported-and-tested by: syzbot+a7e220df5a81d1ab400e@syzkaller.appspotmail.com
Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/usb/asix_common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -277,7 +277,7 @@ int asix_read_phy_addr(struct usbnet *de
 
 	netdev_dbg(dev->net, "asix_get_phy_addr()\n");
 
-	if (ret < 0) {
+	if (ret < 2) {
 		netdev_err(dev->net, "Error reading PHYID register: %02x\n", ret);
 		goto out;
 	}


