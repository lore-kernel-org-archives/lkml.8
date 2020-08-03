Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60013C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33E5C204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457939;
	bh=LZWwTvS0tp1gdoXEyc79W/d6yllJPiT86ElTRyUHeQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fQXZsivktVgS/ld9Tke75VOE7d2yU2ClJEzrXtkD17a2HbSf6vmt9iQD5OLnZ9pif
	 uU4CqFu2AxgjvhY5S9TXoRBW1XTpuGd2MSpuN7K1FDXXO3GlQWi41BN4Mwcd33J77M
	 S2u99RmH2B3LrfiHSj+NjMwpYSQeBXEa+b1iXREk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgHCMcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbgHCMcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:32:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABAF12076B;
        Mon,  3 Aug 2020 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457928;
        bh=LZWwTvS0tp1gdoXEyc79W/d6yllJPiT86ElTRyUHeQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUlIB0u4sryH/Y3G4t7boTSEc8XWNe6T1fT3z510RnY5KnGs/JeBEO+xc7PdmWD7C
         +Mj3ECHsqQ1nTP3LZusUYvPkVgT/8fyCsiUBzrRwUOgb36RUWL3vL2EUHPkN6LRmu2
         zKZANGXT7xec81YxAecM+vy+fRMYcf4YhwUCj8pQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 33/56] net: lan78xx: fix transfer-buffer memory leak
Date:   Mon,  3 Aug 2020 14:19:48 +0200
Message-Id: <20200803121851.938595494@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121850.306734207@linuxfoundation.org>
References: <20200803121850.306734207@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 63634aa679ba8b5e306ad0727120309ae6ba8a8e ]

The interrupt URB transfer-buffer was never freed on disconnect or after
probe errors.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Cc: Woojung.Huh@microchip.com <Woojung.Huh@microchip.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/lan78xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 2dff233814ea5..d198f36785a46 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3815,6 +3815,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 			usb_fill_int_urb(dev->urb_intr, dev->udev,
 					 dev->pipe_intr, buf, maxp,
 					 intr_complete, dev, period);
+			dev->urb_intr->transfer_flags |= URB_FREE_BUFFER;
 		}
 	}
 
-- 
2.25.1



