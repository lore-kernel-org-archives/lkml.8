Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5E0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E9022314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgATSsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:48:10 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:40784 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgATSsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:48:10 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 726E220023;
        Mon, 20 Jan 2020 19:48:06 +0100 (CET)
Date:   Mon, 20 Jan 2020 19:48:04 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     Noralf T <noralf@tronnes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v1 2/5] pardata: new bus for parallel data access
Message-ID: <20200120184804.GA7630@ravnborg.org>
References: <20180802193909.GA11443@ravnborg.org>
 <20180802194536.10820-2-sam@ravnborg.org>
 <CAMuHMdVP4UwGYuNcOphPO9F2pSCaHS1j-ODxYrv_LNOoo_4coA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVP4UwGYuNcOphPO9F2pSCaHS1j-ODxYrv_LNOoo_4coA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=WVoohQUBmtK7-yx5X7kA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert.

On Mon, Jan 20, 2020 at 11:10:37AM +0100, Geert Uytterhoeven wrote:
> Hi Sam,
> 
> (stumbled on this accidentally)
> 
> On Thu, Aug 2, 2018 at 9:46 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > The pardata supports implement a simple bus for devices
> > that are connected using a parallel bus driven by GPIOs.
> > The is often used in combination with simple displays
> > that is often seen in older embedded designs.
> > There is a demand for this support also in the linux
> > kernel for HW designs that uses these kind of displays.
> >
> > The pardata bus uses a platfrom_driver that when probed
> > creates devices for all child nodes in the DT,
> > which are then supposed to be handled by pardata_drivers.
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> > --- /dev/null
> > +++ b/Documentation/driver-api/pardata.rst
> > @@ -0,0 +1,60 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=========================
> > +Parallel Data Bus/Drivers
> > +=========================
> > +
> > +Displays may be connected using a simple parallel bus.
> > +This is often seen in embedded systems with a simple MCU, but is also
> > +used in Linux based systems to a small extent.
> > +
> > +The bus looks like this:
> > +
> > +.. code-block:: none
> > +
> > +       ----+
> > +           |  DB0-DB7 or DB4-DB7      +----
> > +           ===/========================
> > +           |  E - enable              |  D
> > +           ----------------------------  I
> > +        C  |  Reset                   |  S
> > +        P  ----------------------------  P
> > +        U  |  Read/Write (one or two) |  L
> > +           ----------------------------  A
> > +           |  RS - instruction/data   |  Y
> > +           ----------------------------
> > +           |                          +----
> > +       ----+
> 
> Oh, cool!  Looks like this can be used by the hd44780 driver.
> 
>     Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt
>     drivers/auxdisplay/hd44780.c

This patchset was from a time when I knew next to nothing about DRM.
Now I am just confused on a different level :-)

It is on my TODO list to make a mipi-dbi driver that in the future
replaces the auxdisplay driver for hd44780.
But that TODO list have a growing tendency.
It seems that pretending to be co-maintainer on panel/ stuff
alone can take up most of my DRM time.

I hope Paul will contribute the i8080 support to drm_mipi_dbi,
at least he mentioned he planned to work on this.

	Sam
