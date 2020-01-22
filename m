Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3C9C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FC624686
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686170;
	bh=qQTligRoMn1rcwW1M0BXrXltC+2WE7lvseXzLYSYWGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=luswjgqMICzN+OKRJ599jyiJU2b4QL3QrGGJeEejrkUpUhdwZMCfnUa1G1aYo/Wsq
	 Vbxw1jUp6zL8k9SnA3I8FMJOvZN3A6fgKUK5omh+k8D0MG56Gd7z8FmPIwCr4GRmlz
	 gtSRcmkuXw9edu5hzt7jXrRq380pjbLkwr44Q5G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgAVJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:42:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbgAVJmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:42:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA2ED2467B;
        Wed, 22 Jan 2020 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686165;
        bh=qQTligRoMn1rcwW1M0BXrXltC+2WE7lvseXzLYSYWGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wn+NkSyv7c+6vfJhsyokSJThThUqlmG/SEerQAhM/60INh07jBg8j9O1aI6cWFgBR
         /f5Q7i2ZRUWQnYHFVnxSk9o+z9T5EAlkj2RaHvOH/xhGTXtm1106h4WjgeuBZN18K5
         xuW3J3qAGYctoMHI7Y0MdiZ3sODRFTvSe/1RAKps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        RENARD Pierre-Francois <pfrenard@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 071/103] net: usb: lan78xx: limit size of local TSO packets
Date:   Wed, 22 Jan 2020 10:29:27 +0100
Message-Id: <20200122092814.032899084@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f8d7408a4d7f60f8b2df0f81decdc882dd9c20dc ]

lan78xx_tx_bh() makes sure to not exceed MAX_SINGLE_PACKET_SIZE
bytes in the aggregated packets it builds, but does
nothing to prevent large GSO packets being submitted.

Pierre-Francois reported various hangs when/if TSO is enabled.

For localy generated packets, we can use netif_set_gso_max_size()
to limit the size of TSO packets.

Note that forwarded packets could still hit the issue,
so a complete fix might require implementing .ndo_features_check
for this driver, forcing a software segmentation if the size
of the TSO packet exceeds MAX_SINGLE_PACKET_SIZE.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: RENARD Pierre-Francois <pfrenard@gmail.com>
Tested-by: RENARD Pierre-Francois <pfrenard@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3769,6 +3769,7 @@ static int lan78xx_probe(struct usb_inte
 
 	/* MTU range: 68 - 9000 */
 	netdev->max_mtu = MAX_SINGLE_PACKET_SIZE;
+	netif_set_gso_max_size(netdev, MAX_SINGLE_PACKET_SIZE - MAX_HEADER);
 
 	dev->ep_blkin = (intf->cur_altsetting)->endpoint + 0;
 	dev->ep_blkout = (intf->cur_altsetting)->endpoint + 1;


