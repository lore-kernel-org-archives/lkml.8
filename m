Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CD5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307AD2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="O4inzXOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgHJMVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgHJMVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:21:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDFC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:21:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 184so8144092wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sK+nPyx5WoMICiJ3Qs4h5WWlLQUIHFIbElrPAgmCLH4=;
        b=O4inzXOeTcwN/B1iTrTGVZDZ48CMY6bIxdUpNgUpB54aHYnPm5UNmHqld+o9Dn55su
         1f9MFeihmiSvkvnjOskV8lOO5vN8gLdM6Pu8OURYyX/G/HHxZqe3vQGO+J6wcTHgYwnY
         n25F85aj0wVRsYpK7Y7SbfMd1YhSgc8mpk1y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=sK+nPyx5WoMICiJ3Qs4h5WWlLQUIHFIbElrPAgmCLH4=;
        b=EOG3kESxilIczS10dYVCXf0cGcUNgAr+7psKk0WajiBHA5nuvi7aKofdY8NkqWLl5p
         +zs6taJiLpQ2eVKCiH61BrOLwjsZa7sbaL7ghAqKrpubeXQCxfC4nU+EYWCoe+T23cjh
         QKF7jjCYZKsabaEvAEk3l5WIelogzxwFoUQcGKJh9b5LotyhnMH99YOgeofhHkCsiwIG
         9UWNqmKxC6VSAV2EYCPMtzNiWc0o/P9OB8mtOPc4lsZ9M6XAHgWHq8ny7PEJDTAZMWuz
         P+6hVeABcRzvYK6218hNW4Qocf+aaKAv678YoDzVeoGBzxIHGyzXSMhY1fS2wzHo0h6k
         E8gg==
X-Gm-Message-State: AOAM533lfnnWCqAxzpLrQEn9GkzYePi05d7ZY19zfWMc58x3L0B9NnPL
        EbY+WpFDd+okbFsZh2nSa+39vA==
X-Google-Smtp-Source: ABdhPJzpZnEAGblsiWEP8Gj51L9OMtozRYzQYwBrfORSTiKSCckdnBIbi5mChPVjIxCeDGb61wXOPw==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr26217576wmg.39.1597062101217;
        Mon, 10 Aug 2020 05:21:41 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l10sm20247630wru.3.2020.08.10.05.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:21:40 -0700 (PDT)
Date:   Mon, 10 Aug 2020 14:21:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Subject: Re: [PATCH v5 00/14] Add regulator devfreq support to Panfrost
Message-ID: <20200810122138.GH2352366@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
References: <20200710095409.407087-1-peron.clem@gmail.com>
 <CAL_JsqLnOGVbO5T92dyzt3K-v4BRNt72yMpYR_wW-z8dpdVSvA@mail.gmail.com>
 <CAJiuCcfezzr7w9=-G6WK0p6YS=6SBAKF8jv=yAOyNFJ59X80qw@mail.gmail.com>
 <CAJiuCceufQko1KWmU0rHSaJiKMKST0L3OADE0O4_7myLtV4Zjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCceufQko1KWmU0rHSaJiKMKST0L3OADE0O4_7myLtV4Zjg@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 06:30:05PM +0200, Clément Péron wrote:
> On Fri, 7 Aug 2020 at 18:28, Clément Péron <peron.clem@gmail.com> wrote:
> >
> > Hi Rob,
> >
> > On Fri, 7 Aug 2020 at 18:13, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Jul 10, 2020 at 3:54 AM Clément Péron <peron.clem@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This serie cleans and adds regulator support to Panfrost devfreq.
> > > > This is mostly based on comment for the freshly introduced lima
> > > > devfreq.
> > > >
> > > > We need to add regulator support because on Allwinner the GPU OPP
> > > > table defines both frequencies and voltages.
> > > >
> > > > First patches [01-07] should not change the actual behavior
> > > > and introduce a proper panfrost_devfreq struct.
> > > >
> > > > Regards,
> > > > Clément
> > > >
> > > > Changes since v4:
> > > >  - Fix missed a pfdev to &pfdev->devfreq during rebase
> > > >
> > > > Changes since v3:
> > > >  - Collect Steven Price reviewed-by tags
> > > >  - Rebase on next/master (next-20200709)
> > > >
> > > > Changes since v2:
> > > >  - Collect Alyssa Rosenzweig reviewed-by tags
> > > >  - Fix opp_set_regulator before adding opp_table (introduce in v2)
> > > >  - Call err_fini in case opp_add_table failed
> > > >
> > > > Changes since v1:
> > > >  - Collect Steven Price reviewed-by tags
> > > >  - Fix spinlock comment
> > > >  - Drop OPP clock-name patch
> > > >  - Drop device_property_test patch
> > > >  - Add rename error labels patch
> > > >
> > > > Clément Péron (14):
> > > >   drm/panfrost: avoid static declaration
> > > >   drm/panfrost: clean headers in devfreq
> > > >   drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
> > > >   drm/panfrost: introduce panfrost_devfreq struct
> > > >   drm/panfrost: use spinlock instead of atomic
> > > >   drm/panfrost: properly handle error in probe
> > > >   drm/panfrost: rename error labels in device_init
> > > >   drm/panfrost: move devfreq_init()/fini() in device
> > > >   drm/panfrost: dynamically alloc regulators
> > > >   drm/panfrost: add regulators to devfreq
> > > >   arm64: defconfig: Enable devfreq cooling device
> > > >   arm64: dts: allwinner: h6: Add cooling map for GPU
> > > >   [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
> > > >   [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
> > >
> > > Patches 1-10 applied to drm-misc.
> >
> > This serie has been superseded by v5.
> >
> > Could you apply the v5 instead.
> 
> Oups forget my email
> 
> I got an issue with my gmail...

drm-misc is a non-rebasing tree (because it's got lots of
maintainers/committers). Which means we need fixup patches now.

Not that currently drm-misc-next isn't in linux-next because of the merge
window, so just rebasing on top of linux-next wont work (at least not
until -rc1 is out). You can get the tree here meanwhile:

https://cgit.freedesktop.org/drm/drm-misc/

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
