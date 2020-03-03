Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B445DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9346F206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgCCLzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:55:10 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42039 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729071AbgCCLzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:55:09 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1j968f-0000I7-0k; Tue, 03 Mar 2020 12:55:05 +0100
Message-ID: <4c61fde86c5e0dced249221dbc0a8d4207d5bffa.camel@pengutronix.de>
Subject: Re: [PATCH 0/5] drm/etnaviv: Ignore MC bit when checking for
 runtime suspend
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 03 Mar 2020 12:55:04 +0100
In-Reply-To: <cover.1583176306.git.agx@sigxcpu.org>
References: <cover.1583176306.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2020-03-02 at 20:13 +0100, Guido Günther wrote:
> At least GC7000 fails to enter runtime suspend for long periods of time since
> the MC becomes busy again even when the FE is idle. The rest of the series
> makes detecting similar issues easier to debug in the future by checking
> all known bits in debugfs and also warning in the EBUSY case.

Thanks, series applied to etnaviv/next.

> Tested on GC7000 with a reduced runtime delay of 50ms. Patches are
> against next-20200226.

I've already wondered if 200ms is too long, 50ms sounds more
reasonable. Do you have any numbers on the power draw on the i.MX8M
with idle GPU, vs. being fully power gated? 

Regards,
Lucas

> Thanks to Lucas Stach for pointing me in the right direction.
> 
> Guido Günther (5):
>   drm/etnaviv: Fix typo in comment
>   drm/etnaviv: Update idle bits
>   drm/etnaviv: Consider all kwnown idle bits in debugfs
>   drm/etnaviv: Ignore MC when checking runtime suspend idleness
>   drm/etnaviv: Warn when GPU doesn't idle fast enough
> 
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 26 ++++++++++++++++++++++----
>  drivers/gpu/drm/etnaviv/state_hi.xml.h |  7 +++++++
>  2 files changed, 29 insertions(+), 4 deletions(-)
> 

