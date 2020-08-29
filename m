Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3439C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C812D207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 07:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgH2HZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 03:25:58 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:40752 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgH2HZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 03:25:55 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 6716720026;
        Sat, 29 Aug 2020 09:25:51 +0200 (CEST)
Date:   Sat, 29 Aug 2020 09:25:49 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        agx@sigxcpu.org, lukas@mntmn.com
Subject: Re: [PATCH v9 0/5] Add support for iMX8MQ Display Controller
 Subsystem
Message-ID: <20200829072549.GA729648@ravnborg.org>
References: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
 <20200828083620.6m5yhcv7rg5tckzh@fsr-ub1864-141>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828083620.6m5yhcv7rg5tckzh@fsr-ub1864-141>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=CaYmGojl c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=FA2L6XnpJxR8pNLPXI4A:9
        a=CjuIK1q_8ugA:10 a=xlwrDsRaDpwA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurentiu.

> As to who is going to do the actual merge, I know we had a brief
> discussion about it some time ago and I was supposed to apply for
> drm-misc rights, however it feels a little awkward to merge my own
> code... :)

You are encouraged to commit your own code, it is anyway you who knows
the state of the code best. The golden rule is that the code must have
been seen by somone else before you merge, are translated there must be
an acked-by or reviewed-by on each of the patches.

If you look at ths page:

    https://people.freedesktop.org/~seanpaul/whomisc.html

You can see that a lot of people commit their own code in drm-misc.
Example:

    Daniel Vetter <daniel.vetter@ffwll.ch>, <daniel@ffwll.ch>
    (authored=159 committed=249 self_committed=153)

There is only a few patches written by Daniel that is committed by
someone else. And all patches committed by Daniel carries an
a-b or -rb by someone else.

> Though, I might not even qualify for drm-misc rights anyway,
> considering I haven't been very active in this area... :/
> 
> On that note, I will probably need help with the merging, provided it's
> still happenning. Will you be able to help me out with this?

If the challenge is only to push the patches to drm-misc-next there
is a lot of people that can help you. I would be happy to do so, but
would need a resend as I have deleted the patches from my inbox.

I could dig the pathces out somewhere else, but a fresh rebase would
be preferred.

	Sam
