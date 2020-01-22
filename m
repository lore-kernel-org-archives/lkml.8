Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F6DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8162467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686727;
	bh=OgN53ZbZAEKPDXTwQRjmSnvo+k9aCFGxZ6PqMGu4m0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uyT2TdP4K8DCE+wbJHVgOiMys8Nm7xMCfBs0660sxIi9yzfbtvE3t/PJGhZAH2Kx9
	 FWGAvptZvR71A9OTLorpqV3IFDY7Yz40HmHbSo1JZiviWv2CG1pyjQyR+AXehJW1PP
	 hkNOEi2ENo1F42ZRM662xmtNCjWwKFCRBvjr5UP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgAVJwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:52:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbgAVJgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:36:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F132467B;
        Wed, 22 Jan 2020 09:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685801;
        bh=OgN53ZbZAEKPDXTwQRjmSnvo+k9aCFGxZ6PqMGu4m0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tVcicw3ugWqEywA9adMEn0660jOKPlL5EFGNo/IRMF2rwEgxyPVgY+F0nI9Zi9/wd
         HvRABsylM1mOCoom0iuJLi4RR8IR7SgRt+zszyqqtOqbrW1JxlFIz7MUfln+vMBurY
         wqyh0S+yqu6jNXuPYLcX2Xhs/ou18FqeRTUWkl8I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, hayeswang <hayeswang@realtek.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 84/97] r8152: add missing endpoint sanity check
Date:   Wed, 22 Jan 2020 10:29:28 +0100
Message-Id: <20200122092809.824673914@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 86f3f4cd53707ceeec079b83205c8d3c756eca93 ]

Add missing endpoint sanity check to probe in order to prevent a
NULL-pointer dereference (or slab out-of-bounds access) when retrieving
the interrupt-endpoint bInterval on ndo_open() in case a device lacks
the expected endpoints.

Fixes: 40a82917b1d3 ("net/usb/r8152: enable interrupt transfer")
Cc: hayeswang <hayeswang@realtek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/r8152.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -4365,6 +4365,9 @@ static int rtl8152_probe(struct usb_inte
 		return -ENODEV;
 	}
 
+	if (intf->cur_altsetting->desc.bNumEndpoints < 3)
+		return -ENODEV;
+
 	usb_reset_device(udev);
 	netdev = alloc_etherdev(sizeof(struct r8152));
 	if (!netdev) {


