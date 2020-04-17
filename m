Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D414EC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E3E214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgDQIGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729495AbgDQIGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:06:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA18EC061A0C;
        Fri, 17 Apr 2020 01:06:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 8AD6E2A2164
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-imx@nxp.com
Subject: Re: [PATCH v6 1/8] drm: bridge: dw_mipi_dsi: add initial regmap
 infrastructure
In-Reply-To: <CAFqH_513KB+En_xbpXSBG6Q38kYxWCgw0KO3NVxCb6fqHDaKBA@mail.gmail.com>
References: <20200414151955.311949-1-adrian.ratiu@collabora.com>
 <20200414151955.311949-2-adrian.ratiu@collabora.com>
 <CAFqH_52eKB4jtmn5e4HQubv8ijOPqDqncp1dRGahhU3NOorJMQ@mail.gmail.com>
 <87lfmvjmt5.fsf@collabora.com>
 <CAFqH_513KB+En_xbpXSBG6Q38kYxWCgw0KO3NVxCb6fqHDaKBA@mail.gmail.com>
Date:   Fri, 17 Apr 2020 11:07:37 +0300
Message-ID: <87imhyk01i.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020, Enric Balletbo Serra <eballetbo@gmail.com> 
wrote:
> Hi Adrian, 
> 
> [snip] 
> 
>> >> 
>> >> +static void dw_mipi_dsi_get_hw_version(struct dw_mipi_dsi 
>> >> *dsi) +{ +       regmap_read(dsi->regs, DSI_VERSION, 
>> >> &dsi->hw_version); +       dsi->hw_version &= VERSION; + if 
>> >> (!dsi->hw_version) +               dev_err(dsi->dev, "Failed 
>> >> to read DSI hw version register\n"); 
>> > 
>> > Is this an error that should be ignored? If you can't get the 
>> > HW version, probably, there is something wrong with your 
>> > hardware so, don't you need to return an error? 
>> > 
>> 
>> After thinking a bit more about it, that error should be a 
>> warning. 
>> 
>> I added it because in some cases (for eg. if the peripheral 
>> clock is disabled) the reads can return 0 which is obviously an 
>> invalid version and the bridge will error in the next step when 
>> not finding a layout. 
>> 
> 
> If you'll error anyway, why wait? IIUC at this point the clock 
> *must* be enabled, and if not, something is wrong with the 
> driver, I don't see any advantage on delay the error. do you 
> have a use case where this is called and peripheral clock 
> disabled? 

There should be no real use-case (maybe malfunctioning HW), and we 
could error out here to catch driver bugs ASAP, so I'll go this 
route then :)

Thank you, much appreciated!

>
>> So I'll make this a warning in v7 and explicitely mention that
>> reads version == 0 can be caused by a disabled pclk.
>>
>
> -- Enric
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
