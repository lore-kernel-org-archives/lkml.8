Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427F0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2191720658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbgCPKcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:32:19 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:59407 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbgCPKcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:32:18 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C5B3C240010;
        Mon, 16 Mar 2020 10:31:14 +0000 (UTC)
Date:   Mon, 16 Mar 2020 11:31:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ran Bi <ran.bi@mediatek.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rtc tree
Message-ID: <20200316103114.GO4518@piout.net>
References: <20200316161558.438c7d8b@canb.auug.org.au>
 <1584341922.16860.5.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584341922.16860.5.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/03/2020 14:58:42+0800, Ran Bi wrote:
> > Caused by commit
> > 
> >   00c36d73171b ("rtc: add support for the MediaTek MT2712 RTC")
> > 
> > I have used the version from next-20200313 for today.
> > 
> 
> This build fail only happen if rtc-mt2712 build as module which I
> haven't try. It because ";" was missed after "MODULE_DEVICE_TABLE(of,
> mt2712_rtc_of_match)". Should I send a fix patch for this or resend the
> whole rtc-mt2712 driver?
> 

I fixed it in my tree.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
