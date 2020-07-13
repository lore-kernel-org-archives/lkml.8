Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E348BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B76CD20702
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594626797;
	bh=6i5rQzqBSmQsIzpuHkcSXG2b1AFyblLUzKfTF3wG9k0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SHfrOGK2r/k4lR4wDCso6S/ZbPtszcG0LhPvgEm32GVbfy/b/4Tfl8eJ1FP4mD4UQ
	 v0lCGmgw6lkV2vsldz1Ujxd7QgKnjBLQ3N+p2IVb7j9lsRor4NRDv6dN4zYbtpUoyZ
	 hkmoHXcW63WD7CwC603cki0CkXagX3a6DBlZa46o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgGMHxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:53:16 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:34990 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMHxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:53:16 -0400
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 06D7qprL021691;
        Mon, 13 Jul 2020 16:52:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 06D7qprL021691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594626772;
        bh=QRmgCLz55pGAiYJ6IPSUrsAwdIpDl1h9v5capnjYD6s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RzaEuixqZ4VGYkgY0LqBtba7nieyXeP+KM51Dnu4vjg9EOttoUbJ1NbRZmy5CP/OT
         4AgXqeMG8mlXGn0NWZ7/TBJslwWX0D/oKfZ0qvxxDYR4zoc7PnCyWpuXzXXAOXhpEk
         uckL3Ve2i5lFKHo2Hxjw3m1KOQQeYKiLpgQvSWkHHeHnBd6tN5+FJxLiDTp7WFMHN0
         hd/HSHVm9dNlH4at3hPynk/hFP6caP5xquaZvDfxqV9xzqU65+BQ4XzI9Fd70w9VPg
         aBhBHL3MejLkkSbjCdkUoKfZbI1/LoxDioq/n0FJliGHN/vNYITtg419qb7xyIZUwd
         8yjlvNN9myZlA==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id g22so2578169vke.9;
        Mon, 13 Jul 2020 00:52:51 -0700 (PDT)
X-Gm-Message-State: AOAM531ExoYbhuDxJtQN0X8isVhC98ymp/voz111OH2jt1P9waowaAkP
        IErvuoJiN2ylhWlOksmu72t+gE0YGolENF8Yuro=
X-Google-Smtp-Source: ABdhPJxNFyJ8q8WNzZnAYfoUMz6NpZVD2Cwf3rJ/k4h8+eaFQ7YUe7R9b9rSUc8J692BZ2OVzipzRSlmQIBQotaT270=
X-Received: by 2002:a1f:a616:: with SMTP id p22mr41700565vke.96.1594626770912;
 Mon, 13 Jul 2020 00:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200707170720.55be721f@canb.auug.org.au> <20200713115618.5e07a783@canb.auug.org.au>
In-Reply-To: <20200713115618.5e07a783@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 13 Jul 2020 16:52:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARoPNi-QbT=4Odap9LtP9dpMUh9TExtD5gOaaktwdY3Aw@mail.gmail.com>
Message-ID: <CAK7LNARoPNi-QbT=4Odap9LtP9dpMUh9TExtD5gOaaktwdY3Aw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Jul 13, 2020 at 10:56 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Tue, 7 Jul 2020 17:07:20 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the kbuild tree, today's linux-next build (powerpc
> > ppc44x_defconfig) failed like this:
> >
> > cc1: fatal error: opening output file arch/powerpc/boot/dts/.ebony.dtb.dts.tmp: No such file or directory
> >
> > and directory arch/powerpc/boot/dts/ does, indeed, not exist in the
> > separate object directory.
> >
> > Caused by commit
> >
> >   ea4679253288 ("kbuild: always create directories of targets")
> >
> > at least, reverting that commit makes the build work again.
>
> I am still reverting that commit.


Sorry, I missed the previous email.
I will fix it soon.


-- 
Best Regards
Masahiro Yamada
