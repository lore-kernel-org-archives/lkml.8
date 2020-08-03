Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3932CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3F4207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457738;
	bh=jL9S8E1aRsFyMZRNQR4wIAVSmZSOi4xsEA0kdU+usTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NoEy0zdQHSXrqsyQKDcUgYTdGvFJfCg7pvi70SG8TfkPW9ZDznFd+9duB6qB5D/y9
	 ZXjK78n3EotSHbOmrbd1X8YIhao5ukhWLhLeBexrfZ4o7SpBkaAZLwARDJYq8nb8p6
	 tQs2+7b7ajh1Js0PmTpipH3kOw8cYdLeX4mf2YgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgHCM26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgHCM2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:28:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FD3208E4;
        Mon,  3 Aug 2020 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457730;
        bh=jL9S8E1aRsFyMZRNQR4wIAVSmZSOi4xsEA0kdU+usTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8dR4XBqc/vukeTsWMoh20nJWVHFWND5ymz7+AlENCI+UAtS0pz/ACLBPqNJs2O3P
         6WQq+lZ9Yh2hj00CvYliaQcRMth9EjwdwvkLr0DXJ+O3k3yhDhCrx3h9xgNNb0gtiv
         RA7eOqLiZtRwUrn1LlI8kJXVEBJxZbTAxGmygbck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Woojung.Huh@microchip.com" <Woojung.Huh@microchip.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 53/90] net: lan78xx: fix transfer-buffer memory leak
Date:   Mon,  3 Aug 2020 14:19:15 +0200
Message-Id: <20200803121900.193714519@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
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
index 54ce1ed1ea379..1da99abc6ed15 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3796,6 +3796,7 @@ static int lan78xx_probe(struct usb_interface *intf,
 			usb_fill_int_urb(dev->urb_intr, dev->udev,
 					 dev->pipe_intr, buf, maxp,
 					 intr_complete, dev, period);
+			dev->urb_intr->transfer_flags |= URB_FREE_BUFFER;
 		}
 	}
 
-- 
2.25.1



