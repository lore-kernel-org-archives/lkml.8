Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B82C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C78C220782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="JFgTz9qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDTUdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:33:02 -0400
Received: from plaes.org ([188.166.43.21]:36274 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTUdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:33:01 -0400
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id 9908240086;
        Mon, 20 Apr 2020 20:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1587414749; bh=d7Hj4YSM+ItexsFnRjVlbilf+LuV59x0yxXoLaqX6Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFgTz9qeJUl4IMms8a8wL9ia7zEMfStVPbGo86s1wI8zOPvSdr8d3OOQkfKBSAKa2
         2cyrCGrrRn18La96SdTgeMAZqOrq4Cm8h7v0CZcLoni8T45VywhEg8K29lcGkgFJRz
         VDVzf5hlkhZyrDEf9NvIz1s7v9EFg+f1U66S+v8m27pLm1AT3OzZ3m0foBRqjtatQ0
         lsYGWr4yFX81V18wzG9BBopi6FfRWZmaUapt/PuABevjh/BaD0UzLsgWMWYTl/ypcW
         fthldSfIuKzT93ot591XlVkUUDKrFD65Z7YSDIWOytaMLrQ16pj8ddeugFDuVU5UsX
         FZU4gbRdhOXTg==
Date:   Mon, 20 Apr 2020 20:32:28 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/4] clk: sunxi-ng: a10/a20: rewrite init code to a
 platform driver
Message-ID: <20200420203228.GA4734@plaes.org>
References: <20200417221730.555954-1-plaes@plaes.org>
 <20200417221730.555954-2-plaes@plaes.org>
 <20200420124935.asfbgv7envb2af55@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420124935.asfbgv7envb2af55@gilmour.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:49:35PM +0200, Maxime Ripard wrote:
> On Sat, Apr 18, 2020 at 01:17:27AM +0300, Priit Laes wrote:
> > In order to register regmap for sun7i CCU, there needs to be
> > a device structure already bound to the CCU device node.
> > 
> > Convert the sun4i/sun7i CCU setup to platform driver to use
> > it later as platform device.
> > 
> > Signed-off-by: Priit Laes <plaes@plaes.org>
> 
> You can't relly do that though. We have timers that need those clocks before the
> device model is initialized.

Ok, I'm somewhat lost now... are these the affected timers on sun7i following:
- allwinner,sun4i-a10-timer (timer@1c20c00)
- allwinner,sun7i-a20-hstimer (hstimer@1c60000)

Any ideas on what approach I could actually use?

Also, similar timer dependency would affect then sun6i-a31 and sun9i-a80
platforms too...

> 
> Maxime
