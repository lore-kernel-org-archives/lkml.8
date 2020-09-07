Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD1C2065E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgIGPbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:31:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47332 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730080AbgIGPNP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 11:13:15 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kFILk-00Dcsi-Ey; Mon, 07 Sep 2020 16:42:28 +0200
Date:   Mon, 7 Sep 2020 16:42:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andre Heider <a.heider@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch
 aliases
Message-ID: <20200907144228.GV3112546@lunn.ch>
References: <20200907112718.5994-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200907112718.5994-1-pali@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:27:17PM +0200, Pali Rohár wrote:
> Espressobin boards have 3 ethernet ports and some of them got assigned more
> then one MAC address. MAC addresses are stored in U-Boot environment.
> 
> Since commit a2c7023f7075c ("net: dsa: read mac address from DT for slave
> device") kernel can use MAC addresses from DT for particular DSA port.
> 
> Currently Espressobin DTS file contains alias just for ethernet0.
> 
> This patch defines additional ethernet aliases in Espressobin DTS files, so
> bootloader can fill correct MAC address for DSA switch ports if more MAC
> addresses were specified.
> 
> DT alias ethernet1 is used for wan port, DT aliases ethernet2 and ethernet3
> are used for lan ports for both Espressobin revisions (V5 and V7).
> 
> Fixes: 5253cb8c00a6f ("arm64: dts: marvell: espressobin: add ethernet alias")
> Signed-off-by: Pali Rohár <pali@kernel.org>

I'm not sure a Fixes: is appropriate here. What is actually broken?
This just seems like a new feature.

    Andrew
