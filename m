Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02478C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBC120734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgFQLRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:17:34 -0400
Received: from elvis.franken.de ([193.175.24.41]:35896 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbgFQLRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:17:32 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jlW4P-0006Ho-03; Wed, 17 Jun 2020 13:17:29 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id BC0C4C06C3; Wed, 17 Jun 2020 13:14:29 +0200 (CEST)
Date:   Wed, 17 Jun 2020 13:14:29 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     hauke@hauke-m.de, linux-mips@vger.kernel.org, john@phrozen.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: xway: sysctrl: fix the GPHY clock alias
 names
Message-ID: <20200617111429.GD9940@alpha.franken.de>
References: <20200607131023.3136390-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607131023.3136390-1-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 03:10:23PM +0200, Martin Blumenstingl wrote:
> The dt-bindings for the GSWIP describe that the node should be named
> "switch". Use the same name in sysctrl.c so the GSWIP driver can
> actually find the "gphy0" and "gphy1" clocks.
> 
> Fixes: 14fceff4771e51 ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
> Cc: stable@vger.kernel.org
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/mips/lantiq/xway/sysctrl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
