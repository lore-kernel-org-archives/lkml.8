Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA5C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E3421D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599832911;
	bh=EHkMk8FZTwQ6Tit8Vxcyh+qja6txSu8AoOFPongUJ5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/p6YN/lTSKfe2swDzwvhYfsjurRMV4vXOxhMnqDLfqW30hq2ZoPe12+VjvqfKsxG
	 9lcPALumKYDmIhOsohWtp1LgVhm/Lh4OoHCXrw1dWWrk1Y/fQcXoE9oeqYjyR/uz9V
	 MQtTgmMKkdocQeb9tCXlOniqBcvY9b16LuorYTGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKOAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:00:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgIKN2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:28:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0113122228;
        Fri, 11 Sep 2020 13:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599829220;
        bh=EHkMk8FZTwQ6Tit8Vxcyh+qja6txSu8AoOFPongUJ5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PdFvIy/MNnTZ5WAQ/IEmTKWM2akuIzgKTXwUqohXbX1BJvoaoCCKwXrfWIt8TLiDD
         HCdKw7SbwteTBnTExEcenQvxF75NFNgRC2/owwGthUDhqHPUNKMHkjQ/N7LPeGIbIN
         sh7jlooc7e0zVlL49AtEybiFfxz/6unHAVjPYjLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kamil Lorenc <kamil@re-ws.pl>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 4/8] net: usb: dm9601: Add USB ID of Keenetic Plus DSL
Date:   Fri, 11 Sep 2020 14:54:42 +0200
Message-Id: <20200911125420.794165295@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911125420.580564179@linuxfoundation.org>
References: <20200911125420.580564179@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kamil Lorenc <kamil@re-ws.pl>

[ Upstream commit a609d0259183a841621f252e067f40f8cc25d6f6 ]

Keenetic Plus DSL is a xDSL modem that uses dm9620 as its USB interface.

Signed-off-by: Kamil Lorenc <kamil@re-ws.pl>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/dm9601.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -625,6 +625,10 @@ static const struct usb_device_id produc
 	 USB_DEVICE(0x0a46, 0x1269),	/* DM9621A USB to Fast Ethernet Adapter */
 	 .driver_info = (unsigned long)&dm9601_info,
 	},
+	{
+	 USB_DEVICE(0x0586, 0x3427),	/* ZyXEL Keenetic Plus DSL xDSL modem */
+	 .driver_info = (unsigned long)&dm9601_info,
+	},
 	{},			// END
 };
 


