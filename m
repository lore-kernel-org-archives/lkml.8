Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88065C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FCE020772
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgFCOwq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFCOwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:52:46 -0400
Received: from wp148.webpack.hosteurope.de (wp148.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:849b::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F3C08C5C0;
        Wed,  3 Jun 2020 07:52:45 -0700 (PDT)
Received: from ip1f126570.dynamic.kabel-deutschland.de ([31.18.101.112] helo=roelofs-mbp.fritz.box); authenticated
        by wp148.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jgUkr-0002jQ-92; Wed, 03 Jun 2020 16:52:33 +0200
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] lan743x: Added fixed link and RGMII support / BROKEN
 PATCH
From:   Roelof Berg <rberg@berg-solutions.de>
In-Reply-To: <20200601.115136.1314501977250032604.davem@davemloft.net>
Date:   Wed, 3 Jun 2020 16:52:32 +0200
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <D784BC1B-D14C-4FE4-8FD8-76BEBE60A39D@berg-solutions.de>
References: <20200529193003.3717-1-rberg@berg-solutions.de>
 <20200601.115136.1314501977250032604.davem@davemloft.net>
To:     David Miller <davem@davemloft.net>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-bounce-key: webpack.hosteurope.de;rberg@berg-solutions.de;1591195965;eb131c3d;
X-HE-SMSGID: 1jgUkr-0002jQ-92
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TEST REPORT: BROKEN PATCH

Thanks to everyone for working on the fixed link feature of lan743x eth driver.

I received more test hardware today, and one piece of hardware (EVBlan7430) becomes incompatible by the patch. We need to roll back for now. Sorry.

I’ll discuss about options of how to proceed in a second e-mail.

Thank you and best regards,
Roelof


> David Miller <davem@davemloft.net>:
> 
>> Microchip lan7431 is frequently connected to a phy. However, it
>> can also be directly connected to a MII remote peer without
>> any phy in between. For supporting such a phyless hardware setup
>> in Linux we utilized phylib, which supports a fixed-link
>> configuration via the device tree. And we added support for
>> defining the connection type R/GMII in the device tree.
> ...
> 
> Applied, thank you.
> 

