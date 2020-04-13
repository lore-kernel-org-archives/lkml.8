Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EB3C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 430F620732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgDMQJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:09:17 -0400
Received: from mailoutvs43.siol.net ([185.57.226.234]:33552 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731261AbgDMQJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:09:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id BA13F5230DC;
        Mon, 13 Apr 2020 18:09:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6FMkXzO6_pPd; Mon, 13 Apr 2020 18:09:10 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 681F15230DF;
        Mon, 13 Apr 2020 18:09:10 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 2757B5230DC;
        Mon, 13 Apr 2020 18:09:09 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: hdmi ddc clk: Fix size of m divider
Date:   Mon, 13 Apr 2020 18:09:08 +0200
Message-ID: <1742537.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <CAGb2v66LxhqTBeA_Br=kUrTq83hocEcAzYYC6nXpASvkkjn+1g@mail.gmail.com>
References: <20200413095457.1176754-1-jernej.skrabec@siol.net> <CAGb2v65qetxxVX1yoCjyduM4zRTyF3YKX1g9CuaHZkF_Z+AKQg@mail.gmail.com> <CAGb2v66LxhqTBeA_Br=kUrTq83hocEcAzYYC6nXpASvkkjn+1g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 13. april 2020 ob 16:12:39 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Apr 13, 2020 at 6:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > On Mon, Apr 13, 2020 at 5:55 PM Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > > m divider in DDC clock register is 4 bits wide. Fix that.
> > > 
> > > Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Cc stable?

I don't think it's necessary:
1. It doesn't change much (anything?) for me when reading EDID. I don't think 
it's super important to have precise DDC clock in order to properly read EDID.
2. No matter if it has "Cc stable" tag or not, it will be eventually picked 
for stable due to fixes tag.

This was only small observation when I was researching EDID readout issue on 
A20 board, but sadly, I wasn't able to figure out why reading it sometimes 
fails. I noticed similar issue on SoCs with DE2 (most prominently on OrangePi 
PC2 - H5), but there was easy workaround - I just disabled video driver in U-
Boot. However, if A20 display driver gets disabled in U-Boot, it totally 
breaks video output on my TV when Linux boots (no output). I guess there is 
more fundamental problem with clocks than just field size. I think we should 
add more constraints in clock driver, like preset some clock parents and not 
allow to change parents when setting rate, but carefully, so simplefb doesn't 
break. Such constraints should also solve problems with dual head setups.

Best regards,
Jernej



