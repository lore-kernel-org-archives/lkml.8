Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B1DC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C0A2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPBurWYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgD3Qx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD3Qx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:53:27 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3732BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:53:27 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 72so91914otu.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1yc3aiS2aa72MaQjHCirx/9BP7xAuIw9ECEzmtVIsI=;
        b=ZPBurWYBXORgZDIV17o1am4RGcfdkLOoI+K5fC68nY+u4bbVd/WJBEYIRhMu+fRJge
         L+gspegsNCOmHy6vWRfPmvAibdyVV0j/A44AZCZe/Ho009FgQQPq5QH7l627AnH1WvUB
         hIbSzS4B33PC47tx8og1TQJrQB51fFFKW3NyR+sEtvtc7O2A7Nxg7D6ysQg/veHjw+OD
         v94WHYzlAjd56on25IzjMugBL5gOevb7RY9vdkH0flIX/HrO0CT09fEsCVQGcpcjV+V8
         VrHKiyNbcn7At5DoOIogPUENHdkTZdb+l3v2Z7L4gtw/zNJOIOpjLWvMcCWxhQ7zgink
         C1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1yc3aiS2aa72MaQjHCirx/9BP7xAuIw9ECEzmtVIsI=;
        b=S27sLnrgDU6f3Tsr5DT1PbJC2TKGnE7RJlAa7YoiHlHlIcnBK4LpCISBhfvWS0+yY1
         2uvGgCRpQ1vgJm0UVmaumiS2I46uGBCA6FpNlz0bp6VDxlTv2G+JIuVHWsZSpuJYOYsX
         xk6AiMDRXNb9Fc9QoMNjOo/9gcSTkHchA6RDqShDg6HjXV2cZ6+WZfTvvYGljrdkcwaO
         D/fC86jpwSLKePT39HfpdqhPZmfoJSCiviZcqC4LGanUs/SfJrhcBelf0m6SGRxMP+yu
         8bSdZyKvSEDfd/47IXBnRaU/dLQjYvKzEmrAqxhdeY9VKbvKeXYUFs1xkQF4MNlKK/2P
         z3aw==
X-Gm-Message-State: AGi0PubSWWm1n5wPXgdX9A+z8Id3aR2lrqRxG0xlidtHKn1uqjkmrQ6S
        5yUzINhsUtIRsH4AxChStmPGxVOPHyrC53gh8dA4Jg==
X-Google-Smtp-Source: APiQypJ8t3/XkLVbT5o3BxszJHl5XBeeWLeT/ycZ9X+0ZU0M/P/075GxaYt9V0upGxVcm/4CiJPt/DRDAYJo05RzVmw=
X-Received: by 2002:a05:6830:10da:: with SMTP id z26mr85039oto.139.1588265600483;
 Thu, 30 Apr 2020 09:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
 <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org> <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
 <429da47b-ad51-30eb-ff36-b05780c941ba@linaro.org> <CAGETcx9sc6oWSPK=aWJ+39i9eHAyg6iOf+Xf2oVECO+g1pFjtQ@mail.gmail.com>
 <573b7d9e-fb5d-5c81-a981-6d965db933f3@linaro.org> <20200427221752.GA166576@google.com>
 <7c508403-3b53-8285-5724-c2bca221b77a@linaro.org> <CAGETcx_peaPtmjF4s0iR6ObZ=f76EjaMOokyBYM3a7AX-8_ong@mail.gmail.com>
 <da25dc33-addb-298d-103a-fcf1cf0e6793@linaro.org> <CAPDyKFrDSqnkhCVweaA0D-d+KWN_8=OiXW74tDM1DhnCZAgPww@mail.gmail.com>
In-Reply-To: <CAPDyKFrDSqnkhCVweaA0D-d+KWN_8=OiXW74tDM1DhnCZAgPww@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 30 Apr 2020 09:52:44 -0700
Message-ID: <CAGETcx-TRhRDiWX40n_RJPqWcrjKjabocGhU-wyEzEePv2cP+w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sandeep Patil <sspatil@android.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 5:57 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 28 Apr 2020 at 20:55, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > On 28/04/2020 20:23, Saravana Kannan wrote:
> > > On Tue, Apr 28, 2020 at 12:02 AM Daniel Lezcano
> > > <daniel.lezcano@linaro.org> wrote:
> > >>
> > >>
> > >> Hi Saravana,
> > >
> > > You were replying to Sandeep :)
> >
> > Oh, right :)
> >
> > Sorry Sandeep. Thanks for taking the time to elaborate a clear statement
> > of the GKI.
> >
> > [ ... ]
> >
> > >> That was my understanding of the GKI, thanks for confirming.
> > >>
> > >> Putting apart the non-technical aspect of these changes, the benefit I
> > >> see is the memory usage optimization regarding the single kernel image.
> > >>
> > >> With the ARM64 defconfig, multiple platforms and their corresponding
> > >> drivers are compiled-in. It results in a big kernel image which fails to
> > >> load because of overlapping on DT load address (or something else). When
> > >> that is detected, it is fine to adjust the load addresses, otherwise it
> > >> is painful to narrow down the root cause.
> > >>
> > >> In order to prevent this, we have to customize the defconfig each
> > >> version release.
> > >
> > > Sorry, I'm not sure I understand where you are going with this. Are
> > > you agreeing to pick up this change?
> >
> > Right. I agree with the change but I would like to have Thomas opinion
> > on this before picking the patch.
> >
> > Thomas ?
>
> I am not Thomas :-) But just wanted to provide some feedback from my side.
>
> In general we are careful when deciding to export symbols. And at
> least, I think at least we should require one user of it before
> allowing it to be exported (I assume that is what is happening in
> patch2/2 - I couldn't find it)

I believe it is done in Patch 2/2, but I think you don't see them in
the diff because they are already called from the driver, but the
driver won't compile as a module due to the removal of __init markings
in the driver.
https://lore.kernel.org/lkml/182aae1ed5e5d2b124f1a32686e5566c9a27c980.1585021186.git.baolin.wang7@gmail.com/

-Saravana
