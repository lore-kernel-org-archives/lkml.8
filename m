Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA90C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3758720748
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 16:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePnola2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgHGQaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHGQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:30:17 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAA7C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 09:30:17 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l1so2491770ioh.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 09:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y1VmShTbODQxi97p5yhWcFP1i7Rrvf4UqZFjwZm1PaY=;
        b=ePnola2To6a9y/LKrs8HFSLLRCb/floBdKctMto7uvpYO8RdrkLg/FSl5Vfu4LHEdu
         I3ExqMXZYF62qXvIE0+uZYBUhlZO0wpItQ2O8agf32U9MAzg+ZMO0zDeZ+qZvDb4/G9t
         cQZsdnCsGc0G4H1HRkCVAKUQQnfb7EtDeUX7AWevdK7F8k4frzZdZjQRSNEIPV/Bew2/
         O4UIknznTWXhvKWD5+OR9kMFveG9B93bw6c8qwE2I/jkWDJm+vS+s9a6uNfjFiVFwReM
         1SffnIIpPGPz72lkaVxl4R25+aFoMZrarEUB8zAIKWZsrfJb0+jdoq/t9PQG2qOkz0LN
         trMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y1VmShTbODQxi97p5yhWcFP1i7Rrvf4UqZFjwZm1PaY=;
        b=LMN+WvHfFhVf5F/9aq5ZC2HDscQp8n544SIjvN5VYHw0Y8D37Cno4A7eQO6ySMpnjT
         7wHdgUIF+kkUiqVTCN+hiMLBSoajHIUjRMAZnwCEA+4bKp6wn3MRZCssP7t78bPgtAA/
         Ol6BP13X/kSBGXfa8nmEnGAOhaTT9lni0yI5lh/NWKb4rKFi4iGMRiyYcZVEMxXZAdAl
         SlEoOu9tifOzf8ngangjZSJFf5JZG9CwF4wGbz9glyQAH5utU8h9q8ngeaMcPo7vjWUB
         9RfG2Hzd1DVQCYc9r9pN64yzdPXE5yC5lK/nLssqWj3WO5D0y335FPxVfbTCpdejd1yX
         5U5g==
X-Gm-Message-State: AOAM532KM/yM2ERvLqso23021tqTHVgST6zdGjhWJG3Qv1WWCjb7zfwu
        //sZ9wwcYpRcwJ4DFJlRvotNDm0DdilnvzXEybQ=
X-Google-Smtp-Source: ABdhPJzTbhIXdP3RRjHAE9h7pNMqIoCGqK3uc6aBT7K665Vm4u5cTcQqKvNP77DzylHIruEzzmN8w1q5osXjE7cQpSc=
X-Received: by 2002:a05:6638:2109:: with SMTP id n9mr5880105jaj.16.1596817816475;
 Fri, 07 Aug 2020 09:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200710095409.407087-1-peron.clem@gmail.com> <CAL_JsqLnOGVbO5T92dyzt3K-v4BRNt72yMpYR_wW-z8dpdVSvA@mail.gmail.com>
 <CAJiuCcfezzr7w9=-G6WK0p6YS=6SBAKF8jv=yAOyNFJ59X80qw@mail.gmail.com>
In-Reply-To: <CAJiuCcfezzr7w9=-G6WK0p6YS=6SBAKF8jv=yAOyNFJ59X80qw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 7 Aug 2020 18:30:05 +0200
Message-ID: <CAJiuCceufQko1KWmU0rHSaJiKMKST0L3OADE0O4_7myLtV4Zjg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Add regulator devfreq support to Panfrost
To:     Rob Herring <robh@kernel.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 at 18:28, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>=
 wrote:
>
> Hi Rob,
>
> On Fri, 7 Aug 2020 at 18:13, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jul 10, 2020 at 3:54 AM Cl=C3=A9ment P=C3=A9ron <peron.clem@gma=
il.com> wrote:
> > >
> > > Hi,
> > >
> > > This serie cleans and adds regulator support to Panfrost devfreq.
> > > This is mostly based on comment for the freshly introduced lima
> > > devfreq.
> > >
> > > We need to add regulator support because on Allwinner the GPU OPP
> > > table defines both frequencies and voltages.
> > >
> > > First patches [01-07] should not change the actual behavior
> > > and introduce a proper panfrost_devfreq struct.
> > >
> > > Regards,
> > > Cl=C3=A9ment
> > >
> > > Changes since v4:
> > >  - Fix missed a pfdev to &pfdev->devfreq during rebase
> > >
> > > Changes since v3:
> > >  - Collect Steven Price reviewed-by tags
> > >  - Rebase on next/master (next-20200709)
> > >
> > > Changes since v2:
> > >  - Collect Alyssa Rosenzweig reviewed-by tags
> > >  - Fix opp_set_regulator before adding opp_table (introduce in v2)
> > >  - Call err_fini in case opp_add_table failed
> > >
> > > Changes since v1:
> > >  - Collect Steven Price reviewed-by tags
> > >  - Fix spinlock comment
> > >  - Drop OPP clock-name patch
> > >  - Drop device_property_test patch
> > >  - Add rename error labels patch
> > >
> > > Cl=C3=A9ment P=C3=A9ron (14):
> > >   drm/panfrost: avoid static declaration
> > >   drm/panfrost: clean headers in devfreq
> > >   drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
> > >   drm/panfrost: introduce panfrost_devfreq struct
> > >   drm/panfrost: use spinlock instead of atomic
> > >   drm/panfrost: properly handle error in probe
> > >   drm/panfrost: rename error labels in device_init
> > >   drm/panfrost: move devfreq_init()/fini() in device
> > >   drm/panfrost: dynamically alloc regulators
> > >   drm/panfrost: add regulators to devfreq
> > >   arm64: defconfig: Enable devfreq cooling device
> > >   arm64: dts: allwinner: h6: Add cooling map for GPU
> > >   [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
> > >   [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be alw=
ays
> >
> > Patches 1-10 applied to drm-misc.
>
> This serie has been superseded by v5.
>
> Could you apply the v5 instead.

Oups forget my email

I got an issue with my gmail...

Thanks

>
> Thanks
> Cl=C3=A9ment
>
> >
> > Rob
