Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4843F20870
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="Of4+LTMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgGASs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:48:57 -0400
Received: from vps.xff.cz ([195.181.215.36]:55212 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGASs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593629334; bh=8xaksKJGj1kAyua4g1oZLoaGS1nsYn93os3VmQbhpcI=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=Of4+LTMWpjkG2ehoruuK4JmL7d7HB7PhXFTHZ33AW5ALrUk/k1Oh5+Z+UOuyR5T/i
         fXVYS/unoTwEOlZfbsAwP6ihWo19iEZdibHGy6qADnor1mvE9DJF8ZfdNKfV7zR+AE
         +3+GfaRE3Shvu8Kg8V6sSvgFp/SRZ0lnPZU3Kwvw=
Date:   Wed, 1 Jul 2020 20:48:53 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
Subject: Re: [PATCH v7 00/13] Add support for PinePhone LCD panel
Message-ID: <20200701184853.ctrowkdtdsqnlk2f@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-sunxi@googlegroups.com,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>
References: <20200701162928.1638874-1-megous@megous.com>
 <20200701173018.GA1097230@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701173018.GA1097230@ravnborg.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sam,

On Wed, Jul 01, 2020 at 07:30:18PM +0200, Sam Ravnborg wrote:
> Hi Ondrej.
> 
> On Wed, Jul 01, 2020 at 06:29:15PM +0200, Ondrej Jirman wrote:
> > This patchset adds support for the LCD panel of PinePhone.
> > 
> > I've tested this on PinePhone 1.0 and 1.2.
> 
> Thanks for this nive sereis.
> Applied the first 11 patches to drm-misc-next.
> The DTS files needs to go in via another tree.

Thank you very much, too. :)

regards,
	o.

> 	Sam
