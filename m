Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F24C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CD82072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgAQTc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:32:28 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:38214 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgAQTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:32:27 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D152F803F0;
        Fri, 17 Jan 2020 20:32:24 +0100 (CET)
Date:   Fri, 17 Jan 2020 20:32:23 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] video: fbdev: controlfb: small cleanup
Message-ID: <20200117193223.GD24812@ravnborg.org>
References: <CGME20200116140914eucas1p1a62794ad40589e818614176ea8e817ff@eucas1p1.samsung.com>
 <20200116140900.26363-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116140900.26363-1-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=e5mUnYsNAAAA:8 a=52nNHdF23vC62uqb84gA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej

On Thu, Jan 16, 2020 at 03:08:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> Small cleanup for controlfb driver:
> 
> - fix sparse warnings
> - remove not working module support
> - add COMPILE_TEST support
> - remove redundant function prototypes

Nice cleanup - with a few comments.
The last three patches are the good ones.

With my comments considered - and then up to you if you cahnge anything
- then all patches are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (6):
>   video: fbdev: controlfb: fix sparse warning about using incorrect type
>   video: fbdev: controlfb: remove obsolete module support
>   video: fbdev: controlfb: add COMPILE_TEST support
>   video: fbdev: controlfb: remove function prototypes part #1
>   video: fbdev: controlfb: remove function prototypes part #2
>   video: fbdev: controlfb: remove function prototypes part #3
> 
>  drivers/video/fbdev/Kconfig     |   2 +-
>  drivers/video/fbdev/controlfb.c | 810 +++++++++++++++-----------------
>  2 files changed, 383 insertions(+), 429 deletions(-)
> 
> -- 
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
