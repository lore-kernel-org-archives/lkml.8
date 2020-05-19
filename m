Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34FBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8E9207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+43DCJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgEST5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgEST5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:57:48 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C11C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:57:46 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id c187so235841ooc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iNeQP5ee6psuw10GRS3UP54RfEa+IGu/iBWGhrLxKw=;
        b=N+43DCJQN8eRl4QR709SgnvQJDPivxRNw908Qr+hkSugZJHzk/eCoGdncp5dkhCKM2
         iSFGue4ic/IGMTuIaptNEzw8jROo2A6izzos64C+mUufZLyjPQDW1mIEHj71ky5+QwyA
         oAfI+5edsFHUxJfdmN9shXYeKyYNPMwdvmFfnu4g3TwVm2URiBp6DQetqEffDHPmACQu
         G8NlrDXE0/gWk7R+nYgf4bpC+Hzb2MtCWaQdCAJzZ11mxtqRFTZg9ZNs2v950dYR7NoC
         8D1Rfg/+C23GfTOnQAaz7cD08zjRs68dmKrkfJ4sa9YzLiV5gvghZNNVLHATF4s/oB/o
         RszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iNeQP5ee6psuw10GRS3UP54RfEa+IGu/iBWGhrLxKw=;
        b=e/ca7qrBQaRd+WGR6otSbFc9Fh73XV7fFY1Kt3xOYMhigE1gSo+ji+1Dvnbar+5M2E
         ArRuJgTsJ9XHkgsxAFoJDBBtmioEBNG/aKIZ9AfU9ZlXckD/R/ZAv34kaXAiK8mJHIkj
         aWIufe7YApDyXL/nKH7Z9HO81VCIfSQL/f9x9zpRULHI31nNoOCl8GHEsk8upq25tbOK
         uj5zqFCM/sx+kH81aPaMJVlBsj6jRXn95cBm4OY+KYDuqVtaaDyl9ppYQ+Xp5JN9t6qk
         Wc+hqRynL8wXDdkCd+3KjkKAHkbrrAIg2xbwOA7aOftmMg3/L+jXrs/C2I95lGeaTO0T
         X8NA==
X-Gm-Message-State: AOAM531Ar8HNQIeFTyAr4aV3g53JFGgIN1LUjzb4Pr8q8KbUUJf0UDdV
        0OavVFhlNA69k/FNJqrpVwFnnL9NUYCB3ifaS2bQ+g==
X-Google-Smtp-Source: ABdhPJzjHSQQr1SlJ5IQ6LUFgUIMFmZsvjjUAG5WFib50tVK5ijRaPJrWzmIkn2S4Imd7hxzqW7QZ0STrMI3Ehc5DLQ=
X-Received: by 2002:a4a:615d:: with SMTP id u29mr668618ooe.15.1589918265798;
 Tue, 19 May 2020 12:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200512125327.1868-10-georgi.djakov@linaro.org> <20200519185836.GA469006@bogus>
In-Reply-To: <20200519185836.GA469006@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 19 May 2020 12:57:09 -0700
Message-ID: <CAGETcx8+NZYT863ySLf6XvgLBm8PM_4euue2=zbDscgmDFh+7g@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] dt-bindings: interconnect: Add interconnect-tags bindings
To:     Rob Herring <robh@kernel.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:58 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, May 12, 2020 at 03:53:26PM +0300, Georgi Djakov wrote:
> > From: Sibi Sankar <sibis@codeaurora.org>
> >
> > Add interconnect-tags bindings to enable passing of optional
> > tag information to the interconnect framework.
> >
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> > ---
> > v8:
> > * New patch, picked from here:
> >   https://lore.kernel.org/r/20200504202243.5476-10-sibis@codeaurora.org
> >
> >  .../devicetree/bindings/interconnect/interconnect.txt        | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > index 6f5d23a605b7..c1a226a934e5 100644
> > --- a/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > +++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
> > @@ -55,6 +55,11 @@ interconnect-names : List of interconnect path name strings sorted in the same
> >                        * dma-mem: Path from the device to the main memory of
> >                                   the system
> >
> > +interconnect-tags : List of interconnect path tags sorted in the same order as the
> > +                 interconnects property. Consumers can append a specific tag to
> > +                 the path and pass this information to the interconnect framework
> > +                 to do aggregation based on the attached tag.
>
> Why isn't this information in the 'interconnect' arg cells?
>
> We have 'interconnect-names' because strings don't mix with cells. An
> expanding list of 'interconnect-.*' is not a good pattern IMO.

Also, is there an example for interconnect-tags that I missed? Is it a
list of strings, numbers, etc?

-Saravana
