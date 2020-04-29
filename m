Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F47AC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D4420B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgD2VG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:06:59 -0400
Received: from elvis.franken.de ([193.175.24.41]:60831 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgD2VG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:06:56 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jTtuv-0005Q3-04; Wed, 29 Apr 2020 23:06:53 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id CACD3C0355; Wed, 29 Apr 2020 23:05:24 +0200 (CEST)
Date:   Wed, 29 Apr 2020 23:05:24 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>, od@zcrc.me,
        =?utf-8?B?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] MIPS: ingenic: DTS: Update GCW0 support
Message-ID: <20200429210524.GE24583@alpha.franken.de>
References: <20200413152633.198301-1-paul@crapouillou.net>
 <20200413152633.198301-10-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413152633.198301-10-paul@crapouillou.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 05:26:30PM +0200, Paul Cercueil wrote:
> Add support for the face buttons, the ACT8600 PMUC, the LCD panel
> with backlight, the rumble, internal/external SD readers, and other
> things.
> 
> Note that the otg-phy node was dropped in the process as it was neither
> useful nor used, and was inside a non-compliant board "bus".
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/dts/ingenic/gcw0.dts | 499 +++++++++++++++++++++++++++-
>  1 file changed, 484 insertions(+), 15 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
