Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B0C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CDE20857
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N4XJyGIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgDVTuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725961AbgDVTuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:50:13 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287DC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:50:11 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g10so3141134uae.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SOZ/kuYPJyFAJV3DkFh+WewThK39UItCMPkriQP28k=;
        b=N4XJyGIORMnB7t4xAh0V4FafNe7aQpOGecPfMWtYdZA1QWheksB21HqlyRprFqBNlx
         1WFMRq7wGfLDwgMeBX/p5CovR+swvRXlk7Z/YeQtBbrhcReV/vZ47nhBDqDGNPC3GPPh
         VWul0+ZhqslDhGi2ur2rAQ33vUyHb0HULuIHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SOZ/kuYPJyFAJV3DkFh+WewThK39UItCMPkriQP28k=;
        b=SpcQpPPsWMfxdaoEprH/3qsDNJ+N6ez7mRkQqMszePovWPjA+RYaKW210pWlw3SazU
         AvK9MkLBhkJPzW+YorZKNjVPSYZM1sZEKS8cZX2YgZuDV6kr2rlVx9yV9BBYSdDVxEXu
         2L++LJp+lKCw1DXqgtPmn8q1704o4cp6VCso99DIunjFpGx4GGI0Sg/qOxCGE7GM+4n4
         TIK316ywp8PE8x79eZgZB4G6ymMVAlQgV8PyqSLXlOoVA+EwrgfOzBs99+vkDf5zvByi
         rbTl9xsC6DTPFgu/qKxJMBFLlO5sUQAVuCNKPQEWoz8rAGPT6vuKgnWktmHJs4+v/sOq
         oalQ==
X-Gm-Message-State: AGi0Pub2JIStlqXmVio2TaJKjAWCUBhECq0H0aRFkuLlBGJSIYF8t4vR
        x4KDdtbk79qfd5MFsSsYN9406rOeksk=
X-Google-Smtp-Source: APiQypL2YOUO4QJ7T8cWXH9lJtE0124NuiCH4rifFm+3f+hkpW0ki1eDg+skswVAwXydvIqNYsIHjQ==
X-Received: by 2002:a67:fad7:: with SMTP id g23mr416605vsq.240.1587585010626;
        Wed, 22 Apr 2020 12:50:10 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id v26sm107664vsi.3.2020.04.22.12.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 12:50:09 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id s5so3146331uad.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:50:09 -0700 (PDT)
X-Received: by 2002:a67:fc46:: with SMTP id p6mr410935vsq.169.1587585008976;
 Wed, 22 Apr 2020 12:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200327132852.10352-1-saiprakash.ranjan@codeaurora.org>
 <0023bc68-45fb-4e80-00c8-01fd0369243f@arm.com> <37db9a4d524aa4d7529ae47a8065c9e0@codeaurora.org>
 <5858bdac-b7f9-ac26-0c0d-c9653cef841d@arm.com> <d60196b548e1241b8334fadd0e8c2fb5@codeaurora.org>
 <CAD=FV=WXTN6xxqtL6d6MHxG8Epuo6FSQERRPfnoSCskhjh1KeQ@mail.gmail.com>
 <890456524e2df548ba5d44752513a62c@codeaurora.org> <20200331074400.GB25612@willie-the-truck>
 <1bf04938249bcd5b2111c1921facfd25@codeaurora.org>
In-Reply-To: <1bf04938249bcd5b2111c1921facfd25@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Apr 2020 12:49:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VBM6cS1UmWTUJ2vrt0a2zn7xV3C53tpthBx58M2=1JPg@mail.gmail.com>
Message-ID: <CAD=FV=VBM6cS1UmWTUJ2vrt0a2zn7xV3C53tpthBx58M2=1JPg@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Demote error messages to debug in
 shutdown callback
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>," 
        <iommu@lists.linux-foundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 31, 2020 at 12:53 AM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Hi Will,
>
> On 2020-03-31 13:14, Will Deacon wrote:
> > On Tue, Mar 31, 2020 at 01:06:11PM +0530, Sai Prakash Ranjan wrote:
> >> On 2020-03-30 23:54, Doug Anderson wrote:
> >> > On Sat, Mar 28, 2020 at 12:35 AM Sai Prakash Ranjan
> >> > <saiprakash.ranjan@codeaurora.org> wrote:
> >> > >
> >> > > > Of course the fact that in practice we'll *always* see the warning
> >> > > > because there's no way to tear down the default DMA domains, and even
> >> > > > if all devices *have* been nicely quiesced there's no way to tell, is
> >> > > > certainly less than ideal. Like I say, it's not entirely clear-cut
> >> > > > either way...
> >> > > >
> >> > >
> >> > > Thanks for these examples, good to know these scenarios in case we
> >> > > come
> >> > > across these.
> >> > > However, if we see these error/warning messages appear everytime then
> >> > > what will be
> >> > > the credibility of these messages? We will just ignore these messages
> >> > > when
> >> > > these issues you mention actually appears because we see them
> >> > > everytime
> >> > > on
> >> > > reboot or shutdown.
> >> >
> >> > I would agree that if these messages are expected to be seen every
> >> > time, there's no way to fix them, and they're not indicative of any
> >> > problem then something should be done.  Seeing something printed at
> >> > "dev_error" level with an exclamation point (!) at the end makes me
> >> > feel like this is something that needs immediate action on my part.
> >> >
> >> > If we really can't do better but feel that the messages need to be
> >> > there, at least make them dev_info and less scary like:
> >> >
> >> >   arm-smmu 15000000.iommu: turning off; DMA should be quiesced before
> >> > now
> >> >
> >> > ...that would still give you a hint in the logs that if you saw a DMA
> >> > transaction after the message that it was a bug but also wouldn't
> >> > sound scary to someone who wasn't seeing any other problems.
> >> >
> >>
> >> We can do this if Robin is OK?
> >
> > It would be nice if you could figure out which domains are still live
> > when
> > the SMMU is being shut down in your case and verify that it *is* infact
> > benign before we start making the message more friendly. As Robin said
> > earlier, rogue DMA is a real nightmare to debug.
> >
>
> I could see this error message for all the clients of apps_smmu.
> I checked manually enabling bypass and removing iommus dt property
> for each client of apps_smmu.

Any update on the status here?  If I'm reading the conversation above,
Robin said: "we'll *always* see the warning because there's no way to
tear down the default DMA domains, and even if all devices *have* been
nicely quiesced there's no way to tell".  Did I understand that
properly?  If so, it seems like it's fully expected to see this
message on every reboot and it doesn't necessarily signify anything
bad.

-Doug
