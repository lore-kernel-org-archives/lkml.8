Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C54F2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ikiywTJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgHZPHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgHZPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:07:46 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4671C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:07:45 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id i129so1118990vsi.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCHfqt376JxFgHX9UXwwv2S+UaAdW2ySAIyzZLYkbq8=;
        b=ikiywTJw5XY4hdhfD8BEmtd4hfBBE1CdYMlFhd5fcS4hFo2MVh9XW1+LCdTG5TpE/6
         V4M+Zbb/jdM9ajawXCXmdVa4tey3tcm70KX3uWKYYrVqgSgfLfadNjcSo2pQPYCfTffR
         kjT6ROxXMbcTK8veOuw7mDMspOCnoVuGMQNw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCHfqt376JxFgHX9UXwwv2S+UaAdW2ySAIyzZLYkbq8=;
        b=uVrWNv3Pe1SJ1I7XTsD52pfas4T9gmq2TY8OWkM2CGlrPBWS4fYBIz4Uva1WFas1bN
         6qNs6Bj56A1rtO9mTnLXyU7AN/EwROq2lmwGzj70IgT8epmLo+Azr7gPToMqH6SddlbW
         WXgog9voAyE9s2Das4Y46F+HrLuplCz0Gav4btfLkH2GPnjARujJgCEepaENWqA9qy23
         kTWwkcXT2NW7HsDG3WmFuQi1MD7QoazN/CGUQevpd3cDLjc1NUPh2h/B5envnenYQHZl
         HMAZYnt/CobtLvRyhXNhkf8huKgU761D2wzwa2S0eh0iRswyi84zNaEoPV4Kq2/hyDrm
         k6YQ==
X-Gm-Message-State: AOAM531IP01rHk9y0msDgdezXGTJ5AmSGoJUhm+ZuO/e3kv9kX+yEWoh
        tMVbn2nGKTVkaltWA+/AFh8+QLW2piwCWw==
X-Google-Smtp-Source: ABdhPJzZI78Vz1WDy5j5rMA/V4a1707gwQAPrRZ4jKU1cl0KQn7ZmigmbGv2RNdlP1YJAKgj665qQA==
X-Received: by 2002:a05:6102:1c3:: with SMTP id s3mr8997455vsq.90.1598454464754;
        Wed, 26 Aug 2020 08:07:44 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id c10sm335407vsp.32.2020.08.26.08.07.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 08:07:44 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id q200so501212vke.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:07:43 -0700 (PDT)
X-Received: by 2002:a1f:c10b:: with SMTP id r11mr9195774vkf.70.1598454463470;
 Wed, 26 Aug 2020 08:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
 <e3e4da33-a44f-0a07-9e2e-0f806875ab0b@arm.com> <d9b1f1b614057d87279c26e13cbbb1f5@codeaurora.org>
 <a03ce8f0-cab5-2782-ac50-930cf94b7dcd@arm.com> <f8ac8f57bcf10b2218b4795197efb854@codeaurora.org>
In-Reply-To: <f8ac8f57bcf10b2218b4795197efb854@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Aug 2020 08:07:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFC4ciHanaPe_=9Rb75Sz3Lzosd15ehuovZiNPOtbgYQ@mail.gmail.com>
Message-ID: <CAD=FV=UFC4ciHanaPe_=9Rb75Sz3Lzosd15ehuovZiNPOtbgYQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: Add support to filter non-strict/lazy mode based
 on device names
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 26, 2020 at 8:01 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> On 2020-08-26 19:21, Robin Murphy wrote:
> > On 2020-08-26 13:17, Sai Prakash Ranjan wrote:
> >> On 2020-08-26 17:07, Robin Murphy wrote:
> >>> On 2020-08-25 16:42, Sai Prakash Ranjan wrote:
> >>>> Currently the non-strict or lazy mode of TLB invalidation can only
> >>>> be set
> >>>> for all or no domains. This works well for development platforms
> >>>> where
> >>>> setting to non-strict/lazy mode is fine for performance reasons but
> >>>> on
> >>>> production devices, we need a more fine grained control to allow
> >>>> only
> >>>> certain peripherals to support this mode where we can be sure that
> >>>> it is
> >>>> safe. So add support to filter non-strict/lazy mode based on the
> >>>> device
> >>>> names that are passed via cmdline parameter
> >>>> "iommu.nonstrict_device".
> >>>
> >>> There seems to be considerable overlap here with both the existing
> >>> patches for per-device default domain control [1], and the broader
> >>> ongoing development on how to define, evaluate and handle "trusted"
> >>> vs. "untrusted" devices (e.g. [2],[3]). I'd rather see work done to
> >>> make sure those integrate properly together and work well for
> >>> everyone's purposes, than add more disjoint mechanisms that only
> >>> address small pieces of the overall issue.
> >>>
> >>> Robin.
> >>>
> >>> [1]
> >>> https://lore.kernel.org/linux-iommu/20200824051726.7xaJRTTszJuzdFWGJ8YNsshCtfNR0BNeMrlILAyqt_0@z/
> >>> [2]
> >>> https://lore.kernel.org/linux-iommu/20200630044943.3425049-1-rajatja@google.com/
> >>> [3]
> >>> https://lore.kernel.org/linux-iommu/20200626002710.110200-2-rajatja@google.com/
> >>
> >> Thanks for the links, [1] definitely sounds interesting, I was under
> >> the impression
> >> that changing such via sysfs is late, but seems like other Sai has got
> >> it working
> >> for the default domain type. So we can extend that and add a strict
> >> attribute as well,
> >> we should be definitely OK with system booting with default strict
> >> mode for all
> >> peripherals as long as we have an option to change that later, Doug?
> >
> > Right, IIRC there was initially a proposal of a command line option
> > there too, and it faced the same criticism around not being very
> > generic or scalable. I believe sysfs works as a reasonable compromise
> > since in many cases it can be tweaked relatively early from an initrd,
> > and non-essential devices can effectively be switched at any time by
> > removing and reprobing their driver.
> >
>
> Ah I see, so the catch is that device must not be bound to the driver
> and won't work for the internal devices or builtin drivers probed early.

Hrm, that wouldn't work so well for us for eMMC.  I don't think I'm
going to manage to convince folks that we need an initrd just for
this.  I'm probably being naive and I haven't looked at the code, but
it does seem a little weird that this isn't the kind of thing that
could just be tweaked for transfers going forward...


> > As for a general approach for internal devices where you do believe
> > the hardware is honest but don't necessarily trust whatever firmware
> > it happens to be running, I'm pretty sure that's come up already, but
> > I'll be sure to mention it at Rajat's imminent LPC talk if nobody else
> > does.

I'll at least attend.  We'll see how useful my contributions are
since, as per usual, I'm wandering into an area I'm not an expert in
here.  ;-)

-Doug
