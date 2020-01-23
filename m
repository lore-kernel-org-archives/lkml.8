Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69571C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D33D24125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAWSTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:19:11 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:46934 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAWSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:19:10 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id CFE8220051;
        Thu, 23 Jan 2020 19:19:05 +0100 (CET)
Date:   Thu, 23 Jan 2020 19:19:04 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, David Lechner <david@lechnology.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] dt-bindings: restrict properties for sitronix,st7735r
Message-ID: <20200123181904.GC17233@ravnborg.org>
References: <20200115124548.3951-1-geert+renesas@glider.be>
 <20200115124548.3951-2-geert+renesas@glider.be>
 <ba21d2c8-ccc6-2704-fa1f-d28239700547@lechnology.com>
 <20200120190249.GA9619@ravnborg.org>
 <CAMuHMdV4QtKTBvM+8U=BgDV7zzQfO50Z_pnwpNWLhh6Gioe+=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV4QtKTBvM+8U=BgDV7zzQfO50Z_pnwpNWLhh6Gioe+=A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=WZHNqt2aAAAA:8 a=J6VubnrAGtYNr-PBG9AA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22 a=PrHl9onO2p7xFKlKy1af:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert & Rob.

On Thu, Jan 23, 2020 at 08:43:39AM +0100, Geert Uytterhoeven wrote:
> Hi Sam,
> 
> On Mon, Jan 20, 2020 at 8:02 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > From 6b54fb0a071c0732cd4bd5b88f456b5a85bcf4f2 Mon Sep 17 00:00:00 2001
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Mon, 20 Jan 2020 19:55:04 +0100
> > Subject: [PATCH] dt-bindings: restrict properties for sitronix,st7735r
> >
> > David Lechner noticed (paraphrased):
> > - not all properties from panel-common are applicable.
> > - missing optional rotation and backlight properties
> >
> > Fix this by listing all allowed properties, and do not allow other properties.
> >
> > Fixes: abdd9e3705c8 ("dt-bindings: display: sitronix,st7735r: Convert to DT schema")
> > Reported-by: David Lechner <david@lechnology.com>
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I'm far from a DT yaml expert, but LGTM, so:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, now pushed to drm-misc-next.

	Sam
