Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35597C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0551E206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578955049;
	bh=+Vwx7gkSAe5ZKuyDwReisBuyr1j6476uD+cB0xRNHyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iqqVNLYNncZAWcW9QNGPsuN7qHJWM3FMRj+wNz+X17etpquy2zeIYxnrLWyXgFi1p
	 FVFgrHxYJwWdx0z6ZhEzLyDWE9S4mgkMJnWVEIOj1tXGcLo4EpqEgHofILRAdvxHlx
	 KRzXECI6uZT5Th1f3hW5kq4rbJsCPX2nla2VyqrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAMWh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:37:28 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40779 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgAMWh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:37:27 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so10599292otj.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zw6iSRepM4LG+d/YXuCQ8oJD6o1KO8WeOLqBNcecU20=;
        b=NioT3SkxcotQ6F7GfcDF37tVh/XiWm6ixwn3/rVV9RtCR2t4AxqIKWiG9a1TJBVulS
         NLbSYCVLA1pW72DM/XACFc4k3Q9qnQDKHlrPucFjUS4ZffZgfmAi0UccSPlGiNcv/KDl
         uVRTwJO0y6NFNBHOqdKBosynoJq/K162j85AsmCN/wnjwbipZihls497GgkwGYlHC25P
         YhqL6Ddmq0YvxFPDo6yPjJDXWArWySs+aYJnCtpQhoKGv847AF9JFRzrTlED2/fudSMu
         JjVgkc8dh+eXQxFT8CWwK7Zf/Io+2G26MsdDUW/Q0Y2pu8QamX53Qm8N1C+7ETYFvnC8
         8mPw==
X-Gm-Message-State: APjAAAXoq4TqjLqeNpfX4+zoNytH4jBMRZWBqzXF9TOh1Ljw18BgS4G0
        7bVwDUV1jK0/P1RxJhxd7mkTxtA=
X-Google-Smtp-Source: APXvYqzZkqMNa99/23sCgqMdXHUgm5gw0Sk2aoKl2kampaqRevyTbF4OL+Vrvg4Votj29MOr/8Tovg==
X-Received: by 2002:a9d:24e8:: with SMTP id z95mr14889734ota.5.1578955046644;
        Mon, 13 Jan 2020 14:37:26 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z12sm4648059oti.22.2020.01.13.14.37.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:37:25 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:37:25 -0600
Date:   Mon, 13 Jan 2020 16:37:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     guillaume La Roque <glaroque@baylibre.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: Re: [PATCH v6 1/2] dt-bindings: net: bluetooth: add interrupts
 properties
Message-ID: <20200113223725.GA22169@bogus>
References: <20200109104257.6942-1-glaroque@baylibre.com>
 <20200109104257.6942-2-glaroque@baylibre.com>
 <20200109105305.GL30908@localhost>
 <a33f9c30-03a8-ea12-e9d3-5e050e41318e@baylibre.com>
 <20200109132917.GM30908@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109132917.GM30908@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:29:17PM +0100, Johan Hovold wrote:
> On Thu, Jan 09, 2020 at 02:13:23PM +0100, guillaume La Roque wrote:
> > 
> > On 1/9/20 11:53 AM, Johan Hovold wrote:
> > > On Thu, Jan 09, 2020 at 11:42:56AM +0100, Guillaume La Roque wrote:
> > >> add interrupts and interrupt-names as optional properties
> > >> to support host-wakeup by interrupt properties instead of
> > >> host-wakeup-gpios.
> > >>
> > >> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> > >> ---
> > >>  Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 +++-
> > >>  1 file changed, 3 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > >> index c44a30dbe43d..d33bbc998687 100644
> > >> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > >> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> > >> @@ -37,7 +37,9 @@ Optional properties:
> > >>      - pcm-frame-type: short, long
> > >>      - pcm-sync-mode: slave, master
> > >>      - pcm-clock-mode: slave, master
> > >> -
> > >> + - interrupts: must be one, used to wakeup the host processor if
> > >> +   gpiod_to_irq function not supported
> > >> + - interrupt-names: must be "host-wakeup"
> > > Looks like you forgot to address Rob's comment. If I understood him
> > > correctly you either need to stick with "host-wakeup-gpios" (and fix
> > > your platform) or deprecate it in favour of "interrupts":
> > >
> > > 	https://lkml.kernel.org/r/20191218203818.GA8009@bogus
> > 
> > not forgot marcel ask me a v6
> 
> Not much point in sending v6 before addressing feedback on v5.
> Especially as Marcel asked for a v6 with acks. ;)
> 
> > for rob comment ok but it's not possible to support gpiod_to_irq on my
> > platform.
> > 
> > if i deprecated it i need to update all DT with good interrupt number
> > right?
> 
> Not sure. Perhaps just updating the binding is enough. Rob?

Correct. Just need to reflect in the binding which way is preferred. If 
it's a case of update all the dts files, then we often just don't 
document the old way.

Rob
