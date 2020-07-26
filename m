Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3887C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB76E206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgGZIcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:32:23 -0400
Received: from elvis.franken.de ([193.175.24.41]:49109 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGZIcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:32:22 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jzc4y-0004Hg-01; Sun, 26 Jul 2020 10:32:20 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 216F4C0A2D; Sun, 26 Jul 2020 10:22:43 +0200 (CEST)
Date:   Sun, 26 Jul 2020 10:22:43 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me
Subject: Re: [PATCH] MIPS: ingenic: JZ4725B: Add IPU node
Message-ID: <20200726082243.GB5032@alpha.franken.de>
References: <20200725174307.99327-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725174307.99327-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 07:43:07PM +0200, Paul Cercueil wrote:
> Add a devicetree node for the Image Processing Unit (IPU) found in the
> JZ4725B. Connect it with graph nodes to the LCD node. The LCD driver
> will expect the IPU node to be accessed through graph port #8, as stated
> in the bindings documentation.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     Binding documentation was merged in the DRM tree (drm-misc-next branch).
>     See https://cgit.freedesktop.org/drm/drm-misc/plain/Documentation/devicetree/bindings/display/ingenic,ipu.yaml
> 
>  arch/mips/boot/dts/ingenic/jz4725b.dtsi | 30 +++++++++++++++++++++++++
>  arch/mips/boot/dts/ingenic/rs90.dts     |  6 ++++-
>  2 files changed, 35 insertions(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
