Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577BFC2BA16
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B63A20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2RTZSrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389858AbgDBR1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:27:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37266 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389166AbgDBR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:27:18 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so1593290plm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gz0f9qZvU+RRQ/9Q8voQs+xALXqzFeKIupVhhXgqIDI=;
        b=L2RTZSrQ7A5ycxsB0TzHG2oAcpIvPJT/LPWiB5atc3DFl38OL9k98TR94lYyhqN4IV
         +lVqrWSoIoJhMJMWUOxJp+t3Rn27ZQbea6iB86DNqNmc3z9+4rKrSu8uAlkZ9xjC7Typ
         bgMl7IoC1f0jJufjDMrL9rG3x7ZzZhG1y256JHyJ7EexJONnqWFvvb/uhvi8YQZCVkzZ
         4gDqG8fzyDvtlmzcWykcCEaP1dUEKWuKpZtFU0BltSc/6zaenJthX2iAYl1Cx0f7mIF7
         QMY1K3I/vLLQsGXRK55TNaSKmFd4LYJJ14QqEKkKlSHZfeV4ygdwXkoGK4vlVPlrfPMc
         kmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gz0f9qZvU+RRQ/9Q8voQs+xALXqzFeKIupVhhXgqIDI=;
        b=rpxokxTIV85vVAiZAX8VqHwQLytRHGG3kadNP5CoAzb0qgrxR6huA2tR4uIfi+mSgC
         iXJ15cbkvrXr2VK2eZLHIHw3boEQqYcwIZDd+5GryEtZuQL3xol1eEgmFolk/eJqTJ1U
         VwOaA+JxsV9XUI8HXx+rHTHSVTprTnlOLuaE8vPtQUJuj4CoBQsg/JOtYXaKHED3CF27
         kF4E6S1j2t2/g/VG6xi3IQfPtF0f5D6brg9wokqFDwS9al/JqxZI4vKImO0u7ketCXLr
         wWAFl7ILBaijGIy+VVFlbih8mhI6CR8+MiWsi97lSuh3TEsu/nGuK34gonEb2N+yawxa
         IBPQ==
X-Gm-Message-State: AGi0PuYzGDDbQiaVXY3ZXfu7DuCjK0BMf5nXmiNLLOU1HRCWdub6YWZN
        ma74LDePS4f6JY3eTMQF5S/mbTyCrN1jtTaiBneaCQ==
X-Google-Smtp-Source: APiQypJHXGs44BWC8WilJ46Avhei19tnaa/YB6ekL4I+Zzra7DGoUGAP21fYvthy3xQNibUnN4QW+Dbx47n7msYUMJE=
X-Received: by 2002:a17:90b:230d:: with SMTP id mt13mr4965537pjb.164.1585848435589;
 Thu, 02 Apr 2020 10:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200401.113627.1377328159361906184.davem@davemloft.net>
 <20200401223500.224253-1-ndesaulniers@google.com> <20200402094239.GA3770@willie-the-truck>
 <adc2aa08-60e2-cdc3-6b5b-6d96f8805c44@ti.com>
In-Reply-To: <adc2aa08-60e2-cdc3-6b5b-6d96f8805c44@ti.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Apr 2020 10:27:04 -0700
Message-ID: <CAKwvOdk4H052Y=t4_XXy=rMV=CUYPNhb5CN6x8-dBTNaTt3aPA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/11] net: ethernet: ti: add networking
 support for k3 am65x/j721e soc
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Will Deacon <will@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        kishon@ti.com, Jakub Kicinski <kuba@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, m-karicheri2@ti.com,
        Network Development <netdev@vger.kernel.org>, nsekhar@ti.com,
        Olof Johansson <olof@lixom.net>, olteanv@gmail.com,
        peter.ujfalusi@ti.com, Rob Herring <robh@kernel.org>,
        rogerq@ti.com, t-kristo@ti.com,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 4:05 AM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
>
>
> On 02/04/2020 12:42, Will Deacon wrote:
> > On Wed, Apr 01, 2020 at 03:35:00PM -0700, Nick Desaulniers wrote:
> >>>> I think the ARM64 build is now also broken on Linus' master branch,
> >>>> after the net-next merge? I am not quite sure if the device tree
> >>>> patches were supposed to land in mainline the way they did.
> >>>
> >>> There's a fix in my net tree and it will go to Linus soon.
> >>>
> >>> There is no clear policy for dt change integration, and honestly
> >>> I try to deal with the situation on a case by case basis.
> >>
> >> Yep, mainline aarch64-linux-gnu- builds are totally hosed.  DTC fails the build
> >> very early on:
> >> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/311246218
> >> https://travis-ci.com/github/ClangBuiltLinux/continuous-integration/jobs/311246270
> >> There was no failure in -next, not sure how we skipped our canary in the coal
> >> mine.
> >
> > Yes, one of the things linux-next does a really good job at catching is
> > build breakage so it would've been nice to have seen this there rather
> > than end up with breakage in Linus' tree :(
> >
> > Was the timing just bad, or are we missing DT coverage or something else?
>
> It seems issue was not caught in -next because the patch that fixes the issue was already in -next
> before this series was pushed.
>
> Sorry for the mess again.

No worries, it's just worthwhile to study failures.  So IIUC, in this case:
mainline was 5.6
the broken patch was merged in 5.7 merge window
a fix was already in -next, but not slated for the new merge window.
(Maybe scheduled for 5.8?)

So it sounds like it can be dangerous to have 2 branches from 1 tree
flow into -next, as the branch meant for a later release can mask
failures in pull requests for the earlier release?

Do we know what and where the fix currently is?
Can we make sure it's sent to Linus for 5.7-rc1? (Or sooner?)
-- 
Thanks,
~Nick Desaulniers
