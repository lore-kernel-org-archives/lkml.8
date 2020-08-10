Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E631EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB102204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597076799;
	bh=fkfI6OJtgRo63f+y4uLQRkaVeFikdXuomFKqwErsDWM=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=WaOXMdO5Tn9C7sCP5w44vjpvFYMoX9eMDPCcEkT4oBguFFgh5WLLafLUQlXproLI1
	 k5RjhT8vcF+kNndCymUGz0RUj4YpLwgxd9VTDE+jaZGlrB9PB07EvXASckvD5CnwF/
	 OAUhu2vrZ3dY4JPsQ8PE5d1Eqq5AvKgyCVZ4Cg2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgHJQ0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgHJQ0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:26:37 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EADF5208E4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597076797;
        bh=fkfI6OJtgRo63f+y4uLQRkaVeFikdXuomFKqwErsDWM=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=1A5HlNsY9sbYwrjvpsPbvfcoC+3uJ2wFSkcaCgV5gctYlI0tCGW2kNhN7x3u3KMEu
         g2wsrb68w5s7kaMhv0F/FC22kvkpUE76ufHo/gqF4QCgUxKk9X1hdf4GvIhsQT8CLI
         Ot9GZqV/1QdC6DWU204fTJPIaob1llqcXCgfm+DY=
Received: by mail-ot1-f52.google.com with SMTP id v21so7729859otj.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 09:26:36 -0700 (PDT)
X-Gm-Message-State: AOAM5325yDiGBpF52yelbvQFMVwiYMgbSkobdFQv9Ywos3uCNQcCQv4C
        lfpTTO+oXnVpRmXQfrHi92l419gfSYtRExbG5A==
X-Google-Smtp-Source: ABdhPJx//bZialdTk8cnPDttxIrd8vs1afDiBKqW0iV/L7RcHfJcceW7i1t04GrgEEOd00euxQ57zyuVIfAKbHfZbYM=
X-Received: by 2002:a05:6830:1d8e:: with SMTP id y14mr1457483oti.129.1597076796182;
 Mon, 10 Aug 2020 09:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200710095409.407087-1-peron.clem@gmail.com> <CAL_JsqLnOGVbO5T92dyzt3K-v4BRNt72yMpYR_wW-z8dpdVSvA@mail.gmail.com>
 <CAJiuCcfezzr7w9=-G6WK0p6YS=6SBAKF8jv=yAOyNFJ59X80qw@mail.gmail.com>
 <CAJiuCceufQko1KWmU0rHSaJiKMKST0L3OADE0O4_7myLtV4Zjg@mail.gmail.com> <20200810122138.GH2352366@phenom.ffwll.local>
In-Reply-To: <20200810122138.GH2352366@phenom.ffwll.local>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Aug 2020 10:26:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJGXVgP3AyViocmzqGAf3jep-M-9rCyqhzW9HOx-+m6CA@mail.gmail.com>
Message-ID: <CAL_JsqJGXVgP3AyViocmzqGAf3jep-M-9rCyqhzW9HOx-+m6CA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] Add regulator devfreq support to Panfrost
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 6:21 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, Aug 07, 2020 at 06:30:05PM +0200, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Fri, 7 Aug 2020 at 18:28, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.=
com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Fri, 7 Aug 2020 at 18:13, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Fri, Jul 10, 2020 at 3:54 AM Cl=C3=A9ment P=C3=A9ron <peron.clem=
@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > This serie cleans and adds regulator support to Panfrost devfreq.
> > > > > This is mostly based on comment for the freshly introduced lima
> > > > > devfreq.
> > > > >
> > > > > We need to add regulator support because on Allwinner the GPU OPP
> > > > > table defines both frequencies and voltages.
> > > > >
> > > > > First patches [01-07] should not change the actual behavior
> > > > > and introduce a proper panfrost_devfreq struct.
> > > > >
> > > > > Regards,
> > > > > Cl=C3=A9ment
> > > > >
> > > > > Changes since v4:
> > > > >  - Fix missed a pfdev to &pfdev->devfreq during rebase
> > > > >
> > > > > Changes since v3:
> > > > >  - Collect Steven Price reviewed-by tags
> > > > >  - Rebase on next/master (next-20200709)
> > > > >
> > > > > Changes since v2:
> > > > >  - Collect Alyssa Rosenzweig reviewed-by tags
> > > > >  - Fix opp_set_regulator before adding opp_table (introduce in v2=
)
> > > > >  - Call err_fini in case opp_add_table failed
> > > > >
> > > > > Changes since v1:
> > > > >  - Collect Steven Price reviewed-by tags
> > > > >  - Fix spinlock comment
> > > > >  - Drop OPP clock-name patch
> > > > >  - Drop device_property_test patch
> > > > >  - Add rename error labels patch
> > > > >
> > > > > Cl=C3=A9ment P=C3=A9ron (14):
> > > > >   drm/panfrost: avoid static declaration
> > > > >   drm/panfrost: clean headers in devfreq
> > > > >   drm/panfrost: don't use pfdevfreq.busy_count to know if hw is i=
dle
> > > > >   drm/panfrost: introduce panfrost_devfreq struct
> > > > >   drm/panfrost: use spinlock instead of atomic
> > > > >   drm/panfrost: properly handle error in probe
> > > > >   drm/panfrost: rename error labels in device_init
> > > > >   drm/panfrost: move devfreq_init()/fini() in device
> > > > >   drm/panfrost: dynamically alloc regulators
> > > > >   drm/panfrost: add regulators to devfreq
> > > > >   arm64: defconfig: Enable devfreq cooling device
> > > > >   arm64: dts: allwinner: h6: Add cooling map for GPU
> > > > >   [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
> > > > >   [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be=
 always
> > > >
> > > > Patches 1-10 applied to drm-misc.
> > >
> > > This serie has been superseded by v5.
> > >
> > > Could you apply the v5 instead.
> >
> > Oups forget my email
> >
> > I got an issue with my gmail...
>
> drm-misc is a non-rebasing tree (because it's got lots of
> maintainers/committers). Which means we need fixup patches now.
>
> Not that currently drm-misc-next isn't in linux-next because of the merge
> window, so just rebasing on top of linux-next wont work (at least not
> until -rc1 is out). You can get the tree here meanwhile:
>
> https://cgit.freedesktop.org/drm/drm-misc/

I applied v5 so there's nothing to do. The gmail issue was gmail put
v4 and v5 in the same conversion (under v4) which it likes to do
somewhat randomly and with no regard to actual threading. :(

Rob
