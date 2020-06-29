Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C24C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9C9206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390359AbgF2VPC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:15:02 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55692 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgF2S4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:56:47 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 23289CECDA;
        Mon, 29 Jun 2020 21:06:40 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] dt-bindings: net: bluetooth: realtek: Fix uart-has-rtscts
 example
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200629180545.2879272-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 29 Jun 2020 20:56:45 +0200
Cc:     devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Alistair Francis <alistair@alistair23.me>, anarsoul@gmail.com,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <8BBD6F0B-DE92-4241-999E-ED26040E891B@holtmann.org>
References: <20200629180545.2879272-1-martin.blumenstingl@googlemail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

> uart-has-rtscts is a boolean property. These are defined as present
> (which means that this property evaluates to "true") or absent (which
> means that this property evaluates to "false"). Remove the numeric value
> from the example to make it comply with the boolean property bindings.
> 
> Fixes: 1cc2d0e021f867 ("dt-bindings: net: bluetooth: Add rtl8723bs-bluetooth")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> Documentation/devicetree/bindings/net/realtek-bluetooth.yaml | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

