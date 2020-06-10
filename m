Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 00:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4033B206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 00:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591748996;
	bh=pSlBcS9kFU9bDgzfsMFBUwoYpu5ZiWs7SSCafDpj32o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dHGjry86Bs+VLxEr2Ouf8QKcXVS6DtogG4oAXGSgAFCQ7AjTCm2csrqy3pJywtBw2
	 cPJqM468GALxybYtblDOSKNZvqboNm7LF8jyIYgygEgDLgAr91rWI0dehIFxVDV0Yf
	 /vWfG3rHVmGrqcuIY18HrBsTpnkmydXVistIleGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgFJA3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 20:29:48 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35709 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFJA3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 20:29:46 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 05A0T8DU019689;
        Wed, 10 Jun 2020 09:29:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 05A0T8DU019689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591748949;
        bh=VM70ps23UXtp9wyqfDLB4Qqq6BEuxOAlmWAVhnS3iis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gVYbEca9FeUnZVXU49Hrf4d0EOcfGyfKIWjsR4VvgeuDC3q8WOHT0+YSePNhbwwpy
         F5OFC4TOFdd5HTRN65MYMyRJuuCSVoomWFJmgA+uRPO2El8RC1M/rTYfbt8gGp8LLq
         ASHqHzwKi/tSS9vK3SG3Ji+q+k57uuk/sJORTK9/iqv93Epo4qGA1oRsf1vCqZj7yf
         Po7ZTLQd4v2ZeB8erBxFcmwIEkuVR8ajM+oTIQL+k/ELkLgR/JUaM7SN7mF97zV62Z
         pL/tvRDuS11re3Vr2PDmjstxgxIZNtOj7fufIHbX0k9IZ9IRrrsKM5G4mFw0CQefRK
         iG4fPTSiDZOhg==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id r1so255540uam.6;
        Tue, 09 Jun 2020 17:29:09 -0700 (PDT)
X-Gm-Message-State: AOAM531vY6yfc2Z7rIw0H3gGPJgP07mkD5gcdReHf4s43ftdpVj9LapG
        NWg6s+NjcNp5I1t+nqR9nrUk4A/LstMTt0WppUg=
X-Google-Smtp-Source: ABdhPJyigR5ge5vveQoPK8ELBVmZtF5xMk71Nnyk0ogmFqEypSJ0hJgpKPOS6JHMNFvjIHwp6Qva/2XYP9bfL1z6Toc=
X-Received: by 2002:ab0:156d:: with SMTP id p42mr751675uae.121.1591748947924;
 Tue, 09 Jun 2020 17:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200608084117.4563-1-jiping.ma2@windriver.com>
 <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com>
 <acfc88fc-2a7e-19fe-3dc4-37a03ddabcf9@windriver.com> <CAK7LNAS3xOvkUWZzZcb7Mk2YsWo+A6XTjzTZjxjvkYCjWjQvFg@mail.gmail.com>
 <d76f0e39-e22c-7179-955a-981d42b7bc01@windriver.com>
In-Reply-To: <d76f0e39-e22c-7179-955a-981d42b7bc01@windriver.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 10 Jun 2020 09:28:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkXiw9cV=Qt5VrpDGd5CPAPS-EBs0AeOhSJd5JbXtkZg@mail.gmail.com>
Message-ID: <CAK7LNAQkXiw9cV=Qt5VrpDGd5CPAPS-EBs0AeOhSJd5JbXtkZg@mail.gmail.com>
Subject: Re: [PATCH] dtc: also check <yaml.h> for libyaml
To:     Jiping Ma <Jiping.Ma2@windriver.com>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 12:08 PM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
>
>
>
> On 06/09/2020 10:52 AM, Masahiro Yamada wrote:
> > On Tue, Jun 9, 2020 at 10:01 AM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
> >>
> >>
> >> On 06/09/2020 03:09 AM, Rob Herring wrote:
> >>> On Mon, Jun 8, 2020 at 2:42 AM Jiping Ma <jiping.ma2@windriver.com> wrote:
> >>>> yamltree.c includes <yaml.h>, If /usr/include/yaml.h does not exist,
> >>>> it fails to build.
> >>> Does this patch fix your issue?:
> >>>
> >>> https://lore.kernel.org/linux-devicetree/20200505100319.741454-1-masahiroy@kernel.org/
> >> No, it did not fix the issue.
> >>
> >> $ pkg-config --cflags yaml-0.1
> >>
> >> $ pkg-config yaml-0.1 --libs
> >> -L/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux/usr/lib64
> >> -lyaml
> This issue happened in Yocto,  After completing the SDK build and
> installing it, use a new shell to source the environment and try to
> build the helper scripts.
> export
> SDKTARGETSYSROOT=/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux
> export
> PKG_CONFIG_PATH=$SDKTARGETSYSROOT/usr/lib64/pkgconfig:$SDKTARGETSYSROOT/usr/share/pkgconfig
> >
> >


Probably, this commit:

https://github.com/yaml/libyaml/commit/3c80be99fb18f3ee18af37221a3b0c4760e8df06


Use newer libyaml, and that's fine.


-- 
Best Regards
Masahiro Yamada
