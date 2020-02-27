Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41386C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EE5246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="eTHOlOzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbgB0PxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:53:02 -0500
Received: from vps.xff.cz ([195.181.215.36]:58882 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgB0PxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582818779; bh=9G3TKy4/xrc5jr6Pbe73EGsbZNccDkBuSnkf4goeC3U=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=eTHOlOzGPHThofA8iMxQuXOb2N5X7CpRxbNqFJZEva2/buP1hGUN/LmNZnoHvPhLn
         2YSbqShNGKPK9awd5EUJCxdt2BN23vzvtJnaKywBYx05g4t9nkZEY8xeLxrmE79tCE
         hASUbASg529At8OVXJSTqZIL+jNTQNvzl0Cow9aI=
Date:   Thu, 27 Feb 2020 16:52:59 +0100
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add support for Pine64 PinePhone Linux Smartphone
Message-ID: <20200227155259.2gvtmeiismceh7ca@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-sunxi@googlegroups.com,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200227012650.1179151-1-megous@megous.com>
 <20200227130427.s6dckhlxxpwmekch@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227130427.s6dckhlxxpwmekch@gilmour.lan>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:04:27PM +0100, Maxime Ripard wrote:
> On Thu, Feb 27, 2020 at 02:26:47AM +0100, Ondrej Jirman wrote:
> > This series adds an initial support for Pine64 PinePhone.
> >
> > Please take a look.
> >
> > thank you and regards,
> >   Ondrej Jirman
> 
> Applied all three, thanks

Thank you too! :)

regards,
	o.

> Maxime


