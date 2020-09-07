Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0325C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A502121775
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599495786;
	bh=Y2BCiy3yY3A8EA1BKUV6pwWXEjyt+rKSZq5t8blyh7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WZsjVQJ/MqyYBlf1IvIgaswzxZJiMSNMnS4I5vi9KPx+LwZHsiLtiPj2CaeXm3TtY
	 tWrFvuZ3CqmVvrasxtdYdzFcjol3rAY1TRfihf4xJfy+hQ/UU9yMg04FwaveOSNjD0
	 7do/fjWCRkNexrzYKmN9EVBr4+HvargpWzKgeowA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgIGQWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbgIGQNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:19 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65F42177B;
        Mon,  7 Sep 2020 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495198;
        bh=Y2BCiy3yY3A8EA1BKUV6pwWXEjyt+rKSZq5t8blyh7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDw/uPsjjNA0Nm8ITp0ewceSgTabCRG82GhfX4iODt2TB8ksREiRxLG0Klr+YyT5r
         Tx8yTB23Y1DfHOLMa/6uLxGv8dvX3XlGjriewrClTrSx5s0nfdQlQ7oSVv4iieS7n3
         MtXvWlBkiQ3srsYSH2cUrxvyZGUf1eACwVu5ebak=
Received: by pali.im (Postfix)
        id 670FC814; Mon,  7 Sep 2020 18:13:16 +0200 (CEST)
Date:   Mon, 7 Sep 2020 18:13:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20200907161316.xd5svvahi5xusdlw@pali>
References: <20200907112718.5994-1-pali@kernel.org>
 <20200907144228.GV3112546@lunn.ch>
 <20200907145213.fwlyz4k6scible7x@pali>
 <20200907154353.GW3112546@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907154353.GW3112546@lunn.ch>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 September 2020 17:43:53 Andrew Lunn wrote:
> > I would not say it is a "new feature". But rather that patch in this
> > email fixes issue that Linux kernel did not set correct MAC address for
> > DSA slave ports. I think it is something which could be backported also
> > to stable releases as "ignoring" vendor/factory MAC address is not
> > correct behavior.
> 
> Hi Pali
> 
> The rules for stable are here:
> 
> https://www.kernel.org/doc/html/v5.8/process/stable-kernel-rules.html
> 
> Do you think it fits?
> 
>    Andrew

Hello Andrew! I think it fits into those rules. As I wrote it fixes real
bug that Linux kernel does not use correct MAC address for particular
DSA slaves / ethernet ports. But if you or other people have opposite
opinion I will of course respect it.
