Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1153FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35D92137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgIGVIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:08:02 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48432 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726458AbgIGVH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:07:59 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kFOMe-00DgGY-Cs; Mon, 07 Sep 2020 23:07:48 +0200
Date:   Mon, 7 Sep 2020 23:07:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ARM: dts: Remove non-existent i2c1 from 98dx3236
Message-ID: <20200907210748.GF3254313@lunn.ch>
References: <20200907024149.20001-1-chris.packham@alliedtelesis.co.nz>
 <20200907024149.20001-3-chris.packham@alliedtelesis.co.nz>
 <20200907154532.GY3112546@lunn.ch>
 <36712d90-6bfe-8965-22b1-6b6dd460116d@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36712d90-6bfe-8965-22b1-6b6dd460116d@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:04:48PM +0000, Chris Packham wrote:
> 
> On 8/09/20 3:45 am, Andrew Lunn wrote:
> > On Mon, Sep 07, 2020 at 02:41:48PM +1200, Chris Packham wrote:
> >> The switches with integrated CPUs have only got a single i2c controller.
> >> The incorrectly gained one when they were split from the Armada-XP.
> Someone pointed out a small grammo instead of "The incorrectly" it 
> should be "They incorrectly". Is it worth me sending a v2 just to fix that?

You are asking somebody who is dyslexic, and often fails to notice
things like this, particularly when written by me :-)

Up to you.

  Andrew
