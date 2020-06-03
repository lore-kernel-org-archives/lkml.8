Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57839C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5EC2068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgFCQgg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgFCQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:36:36 -0400
Received: from wp148.webpack.hosteurope.de (wp148.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:849b::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1C5C08C5C0;
        Wed,  3 Jun 2020 09:36:35 -0700 (PDT)
Received: from ip1f126570.dynamic.kabel-deutschland.de ([31.18.101.112] helo=roelofs-mbp.fritz.box); authenticated
        by wp148.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jgWNR-0003Jg-IX; Wed, 03 Jun 2020 18:36:29 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] lan743x: Added fixed link and RGMII support / debugging
From:   Roelof Berg <rberg@berg-solutions.de>
In-Reply-To: <20200603155927.GC869823@lunn.ch>
Date:   Wed, 3 Jun 2020 18:36:28 +0200
Cc:     David Miller <davem@davemloft.net>,
        Bryan Whitehead <bryan.whitehead@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9D950C93-921D-4D50-84C5-A566726B7AA5@berg-solutions.de>
References: <20200529193003.3717-1-rberg@berg-solutions.de>
 <20200601.115136.1314501977250032604.davem@davemloft.net>
 <D784BC1B-D14C-4FE4-8FD8-76BEBE60A39D@berg-solutions.de>
 <20200603155927.GC869823@lunn.ch>
To:     Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-bounce-key: webpack.hosteurope.de;rberg@berg-solutions.de;1591202195;2365ddb7;
X-HE-SMSGID: 1jgWNR-0003Jg-IX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If I find a fix, would I need to submit a delta patch (to our last one) or a full patch ?

Thanks.

> So lets try to fix it.
> 
>    Thanks
> 	Andrew
> 

