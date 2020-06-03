Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4C9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8511E206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgFCAUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:20:25 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51420 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgFCAUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:20:24 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 68E8629AF2;
        Tue,  2 Jun 2020 20:20:22 -0400 (EDT)
Date:   Wed, 3 Jun 2020 10:20:21 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v2 1/2] video: fbdev: amifb: add FIXME about dead APUS
 support
In-Reply-To: <20200602161225.GJ23230@ZenIV.linux.org.uk>
Message-ID: <alpine.LNX.2.22.394.2006031002550.8@nippy.intranet>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com> <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com> <767d36ff-22ec-8136-7ebc-1d9d0d3ac98d@samsung.com> <CAMuHMdWac+YE3qr0CTepn5K24tGZq0VHuQDGg-yUOHW1rJDbbg@mail.gmail.com>
 <20200602161225.GJ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020, Al Viro wrote:

> I have done that on aranym (which is how I'd been doing all testing for 
> e.g. signal-related m68k patches) and I've seen references to some 
> out-of-tree qemu variant doing quadra, but nothing for amiga 
> emulators...
> 

Laurent Vivier's Quadra 800 emulation is no longer out of tree. It 
appeared in QEMU v4.2.0 and ethernet support was stabilized in QEMU 
v5.0.0.
