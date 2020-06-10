Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F867C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2AF120691
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591752738;
	bh=dzg/oN10DPBG44cDM1Zt9m1kfbMQP4Z1HCIljURfp1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hcmDVSTYDRmjhqndvmKBtHzRvhP7cQ/AzAu7PnEhA3XymUHuVf0WZwMDoQR06z0LK
	 YSoPM77zHYAIfpf4M110b5iBgLUJCXZt4+oeBRN+Pe9S86WmWAMU8XsdItYqeOom0S
	 zPqHRd0VPj9pKOkiSpfBGbAF7Q4a9TJR84nqmAEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgFJBcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:32:17 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50001 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgFJBcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:32:16 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 05A1VuWh019158;
        Wed, 10 Jun 2020 10:31:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 05A1VuWh019158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591752717;
        bh=S2EWdblSOOwVEN+VucSLtxUOt416JWBmQq0pLM5fxBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QUmAu6Ijp6xJjJBHRbB3X6eM4/YR6/nBW7T4EMNh1c15pA91IuduuWkNMFD+YLLsv
         m+nInATptxjTjWdWF0eaiHm4q6b/y6OjhC1gmCmnKgxp8MkONQ4phjckz7d+sfDnkH
         ERqm6X6kzWaExk5wGQz4KNmBpW5VIz4Mp1z23y+P/3uIDZgq2vQChN+JIgR7d1MGkq
         6T08bLyGHiLPnmBFyJmcgQK8bcwJYIUuiPiuKKMKhmi9HLnmzIl398B9eFzRVG6eK7
         MhhkCDmcyT68dBY7NtZlpJ/KQ+ealeOH6UVrzPT4ODe3LP4SE+F1aGkMXlKp+sBIGA
         6Eo3NEkrpgKBg==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id z47so297710uad.5;
        Tue, 09 Jun 2020 18:31:57 -0700 (PDT)
X-Gm-Message-State: AOAM5323t3ovtrjTrRQ0mEFMWY6J2sfGPv+yOL798obK6mNBIniCJJj1
        t9LkOVaS768fGO7/5sPQrQdbmDBkMfU+N8aiRzc=
X-Google-Smtp-Source: ABdhPJy0bli/7m5Pe+rVE1l+8VJsyjIWmpq1ORdX2I/8/Dj0gWUTUU2kXTV2+4hH7pdmXatt733/zlN2l3k+sWrNv3o=
X-Received: by 2002:ab0:7619:: with SMTP id o25mr811983uap.109.1591752715902;
 Tue, 09 Jun 2020 18:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200608084117.4563-1-jiping.ma2@windriver.com>
 <CAL_JsqKLfSE5tPEPi1=erqBzCF9fceKKDe4qBkywB4O_JhbjGg@mail.gmail.com>
 <acfc88fc-2a7e-19fe-3dc4-37a03ddabcf9@windriver.com> <CAK7LNAS3xOvkUWZzZcb7Mk2YsWo+A6XTjzTZjxjvkYCjWjQvFg@mail.gmail.com>
 <d76f0e39-e22c-7179-955a-981d42b7bc01@windriver.com> <CAK7LNAQkXiw9cV=Qt5VrpDGd5CPAPS-EBs0AeOhSJd5JbXtkZg@mail.gmail.com>
 <6c5b1422-5b8a-03fe-57ea-567767ed75e2@windriver.com>
In-Reply-To: <6c5b1422-5b8a-03fe-57ea-567767ed75e2@windriver.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 10 Jun 2020 10:31:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASj5nABYN0ukE_V3aK_ys7zuAibn4bzy8x5zGHM59gF1g@mail.gmail.com>
Message-ID: <CAK7LNASj5nABYN0ukE_V3aK_ys7zuAibn4bzy8x5zGHM59gF1g@mail.gmail.com>
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

On Wed, Jun 10, 2020 at 10:12 AM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
>
>
>
> On 06/10/2020 08:28 AM, Masahiro Yamada wrote:
> > On Tue, Jun 9, 2020 at 12:08 PM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
> >>
> >>
> >> On 06/09/2020 10:52 AM, Masahiro Yamada wrote:
> >>> On Tue, Jun 9, 2020 at 10:01 AM Jiping Ma <Jiping.Ma2@windriver.com> wrote:
> >>>>
> >>>> On 06/09/2020 03:09 AM, Rob Herring wrote:
> >>>>> On Mon, Jun 8, 2020 at 2:42 AM Jiping Ma <jiping.ma2@windriver.com> wrote:
> >>>>>> yamltree.c includes <yaml.h>, If /usr/include/yaml.h does not exist,
> >>>>>> it fails to build.
> >>>>> Does this patch fix your issue?:
> >>>>>
> >>>>> https://lore.kernel.org/linux-devicetree/20200505100319.741454-1-masahiroy@kernel.org/
> >>>> No, it did not fix the issue.
> >>>>
> >>>> $ pkg-config --cflags yaml-0.1
> >>>>
> >>>> $ pkg-config yaml-0.1 --libs
> >>>> -L/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux/usr/lib64
> >>>> -lyaml
> >> This issue happened in Yocto,  After completing the SDK build and
> >> installing it, use a new shell to source the environment and try to
> >> build the helper scripts.
> >> export
> >> SDKTARGETSYSROOT=/buildarea/jma1/wr-19-0518/19.45/sysroots/aarch64-wrs-linux
> >> export
> >> PKG_CONFIG_PATH=$SDKTARGETSYSROOT/usr/lib64/pkgconfig:$SDKTARGETSYSROOT/usr/share/pkgconfig
> >>>
> >
> > Probably, this commit:
> >
> > https://github.com/yaml/libyaml/commit/3c80be99fb18f3ee18af37221a3b0c4760e8df06
> >
> >
> > Use newer libyaml, and that's fine.
> This commit already was included in our code.


Then, I have no idea,
but this is not a problem in the kernel build.



-- 
Best Regards
Masahiro Yamada
