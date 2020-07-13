Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA9CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B69207BC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="k+yaceJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgGMPzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbgGMPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:55:14 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663AEC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:55:14 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n2so14101674edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvFP8C9ElhA+9J4NHbp88icoVdD/LwjeDZ0MuCFKeSs=;
        b=k+yaceJBmAwAdUCCyLHeNdv0mZPyEZbdhlT8pDEeDX6/g/ec0BIgzMl9fL3Lw/BqhS
         U71Pzd9vUppH1ups2mJxxE/r6i/5zwspEzYxTDFn6EsIOjvHm51oI1doIU++tVmZgI27
         BdPB8DMiSWkDIO32gxyEcTiv24z2GypgsanuioeCYCCddPWp3l+gSVV7tETNrNWs0Hk3
         OslOKsF3Nyzu9BRxm6XVDq8yO19LQSOTt+v1oiSw5RP5SbZ55kbkc9drcEVBDv/ly7re
         RJIvU2CS5xZD9bSLFj8kZgqtl8/akOZNwNo8J0GWdIdnCo0JHoUECwa9tFEhidKHsRLp
         YbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvFP8C9ElhA+9J4NHbp88icoVdD/LwjeDZ0MuCFKeSs=;
        b=aI/y2Bp/UUWgW0e3EQ+LUDBrhOYltIAuL7ITKlbziTwm2MMgyuu/l2xH9TQxulVmwu
         /d+zqtzNYm/8qT04VjxVJWUZKu+/Hx1sRh2mXAjhMjTyYQUaiKh5Pm72wdjL/cs3i1ng
         IUyA+m8ugYsv/Mg/XuuqVJW5c9fajRsV3X69CVUIjo4OtqnMa9KU/JWh4OzD8m85xX/w
         CWWSlsx4pwHqUKAWfAmkRdT/kKJpIoFjaC+k5xuoShcieQaqCLAE/MLJRDrRaLamSx2z
         WuEmsX5i+jfG+UU8VPScL+x8FTYQAcVyy5NoulwiTG2NuYuy1JZYiFkcHojSPx1OCCLX
         CA5Q==
X-Gm-Message-State: AOAM530HBDxaLIQTsTwGbwMzX422M6SwaPrY2Sk22J5Mgi/BbcwhayTD
        Fv2oNPqmKDIKESLWLUbOwbH90HDWmwetfso3f5VlGA==
X-Google-Smtp-Source: ABdhPJxM5zWHCQaAimbCxxaf2ae+gWBz1Jqgn91MrvD+o+/On1BzJQ/4ijhdDBCqPvzUO6bFSmg/E+5V1W51fg7nUZU=
X-Received: by 2002:a50:d9cb:: with SMTP id x11mr50150edj.93.1594655713140;
 Mon, 13 Jul 2020 08:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
 <87h7ul15le.fsf@notabene.neil.brown.name> <20200706072221.GA1947246@kroah.com>
 <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
 <CAFhKne9vswg3Q4mTOz4WP6QWJ8tDH+SNx1Pu7LotLagoNURKgw@mail.gmail.com>
 <d6f56f5f5e0790ee9c7579eb05c7d92e071ee15a.camel@perches.com>
 <CAFhKne_p_rKN4adhsuyUyBfrS0YwCtoNFNn-x4aFajPmnkR6iQ@mail.gmail.com>
 <10eeae911ab653036554f5599ba34406572acaa9.camel@perches.com>
 <20200709131133.1bbb9c63@coco.lan> <20200713042547.GO34333@vkoul-mobl>
In-Reply-To: <20200713042547.GO34333@vkoul-mobl>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Jul 2020 08:55:02 -0700
Message-ID: <CAPcyv4iPWXRQxGQOXO-eCmRn7HeDp0NvSUq-o3eQjFPRkA1eoQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 9:26 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> Hi Mauro,
>
> On 09-07-20, 13:11, Mauro Carvalho Chehab wrote:
> > Em Mon, 06 Jul 2020 06:30:01 -0700
> > Joe Perches <joe@perches.com> escreveu:
> > >
> > > $ git grep -i -w -P '\w*slave\w*' drivers | \
> > >   cut -f1,2 -d/ | uniq -c | sort -rn | head -20 | cat -n
> > >      1         5683 drivers/net
> > >      2         2118 drivers/gpu
> > >      3         1807 drivers/dma
> > >      4         1389 drivers/i2c
> > >      5          866 drivers/interconnect
> > >      6          835 drivers/soundwire
> > >      7          821 drivers/spi
> > >      8          698 drivers/w1
> > >      9          508 drivers/media
> > >     10          481 drivers/infiniband
> > >     11          440 drivers/ata
> > >     12          317 drivers/scsi
> > >     13          267 drivers/fsi
> > >     14          240 drivers/tty
> > >     15          225 drivers/vme
> > >     16          223 drivers/staging
> > >     17          157 drivers/mmc
> > >     18          155 drivers/usb
> > >     19          141 drivers/video
> > >     20          140 drivers/char
> >
> > It sounds that, as soon after this patch gets merged, the mailing lists
> > will be flooded by lots of patches replacing such terms with something
> > else :-(
> >
> > Doing a quick look at the media subsystem, it sounds that most terms
> > come from I2C master/slave and DiSEqC terminology, as defined by their
> > specs (and the others seem to be derived from some hardware vendor
> > specific terminology).
> >
> > As they're all supported by the current specs, if one would want
> > to replace them, it should first ensure that the supporting specs
> > should be using a different terminology, as otherwise replacing
> > them would just make harder for anyone trying to understand the
> > code.
>
> I think waiting for specs may result in long delays, we all know how
> 'fast' spec bodies work!
>
> Putting my soundwire maintainer hat, I see more than 1K uses of 'slave'
> in the subsystem due to MIPI defined terms of SoundWire Master/Slave, so
> I am planning to replace that and not wait for MIPI to update the spec.

Sounds good.

> A similar approach where we discuss with relevant stakeholder and arrive
> at replacement terms and swap them would be great

Right, just like any other coding-style cleanup, stage it the way that
makes the most sense for the subsystem you maintain.
