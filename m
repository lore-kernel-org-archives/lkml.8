Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7A9320791
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="z1PsoTYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHUVTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHUVTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:19:06 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6EC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:19:05 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id 4so3086415ion.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w6WSyptBPwYRWrRHSx80kX+6iYfBT46ZbcjP/fES6I0=;
        b=z1PsoTYFXOE10VkEP/YBXXnEqvzL0FLW0zsORDK3mGdTS056B9sZUHLxfdcAokqe76
         +NBXP2h7tOsJR1Gg6zdz/JAoigWvm5WTafkriXiKzdgGW6/TIon0eXjuJj8JtqLc+sAS
         qwxWrVDfLsG4P72r5o6XgsW7tauJAx+QL/FvKbF/5HiXrJ2kZojxLaSExBOx3BbHjU6H
         QI12IvY5MEzGt2CCUyhgMcB/Zw1F8pOFouKs7vs0NMBtcYEWdUk4EO3vymhMh22o/b/E
         DZ3BhPStI4Ku2Q90M+CIP3rbaDLDrvHfXtvIwb3p7YLWCnYQCNCmx3PpQotUkCy4noLn
         +2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6WSyptBPwYRWrRHSx80kX+6iYfBT46ZbcjP/fES6I0=;
        b=a6KUDtw6Xqq1is2enN8ToxKQHy4+VQOiYOs1Df4L6COw3075d1ATaDQ2cQyB7khzAY
         5kX7MvsIhx+rcnlo512VEE7WY/xOpkLDuv8gJXNeAiG/h2H/fXPETK1ercewz9po2ryb
         S53DQI56Mh37JP0/gu4T3RTyDa4ueMABB4ehXcqTtsaXpIVVNoLmLqqEuZODU/vhQQi9
         Alk9/GlT9YJQVRgYfukt9Qur0U+Dg9fBop+1V606HXtFxbZTqiHsMjOHyvDq+54YJZOY
         ESdmQPSQPj3OwyDH5/1g6ckPvR1wTJDh6AAZw4NNXyPz5D8IDwqnub+F9JF/zVRFsvRY
         9Kpg==
X-Gm-Message-State: AOAM530v2lp00lgbsGLN4YgVeApqsVXr98Lu0UkWFd+DHiN2gxisBdVW
        hHHB3qioGs9CEquZPL3UvvP1fK0rN0T01nNCz3lGIbfNFPFkzA==
X-Google-Smtp-Source: ABdhPJxrq5ZpSkKoECQJj0CKZYCSsWq01GluOPGYWz9T8G6DbYDmlD70WHyOubgtihq8Exlxshq74/0dxtpi0ndEygg=
X-Received: by 2002:a6b:bfc1:: with SMTP id p184mr3734387iof.193.1598044744987;
 Fri, 21 Aug 2020 14:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200526131259.GA97001@jade> <20200821184910.GB3407@lx2k> <f7c8bb6e-e732-2565-8b50-20f5504701c9@nvidia.com>
In-Reply-To: <f7c8bb6e-e732-2565-8b50-20f5504701c9@nvidia.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Fri, 21 Aug 2020 14:18:53 -0700
Message-ID: <CAOesGMjKq3ECJuaMANq=AyDMLXYvorafMYS3LDr9YMH6M9VdYA@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsystem pin_user_pages for v5.8
To:     John Hubbard <jhubbard@nvidia.com>
List-Id: <soc.lore.kernel.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:58 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/21/20 11:49 AM, Olof Johansson wrote:
> > On Tue, May 26, 2020 at 03:12:59PM +0200, Jens Wiklander wrote:
> >> Hello arm-soc maintainers,
> >>
> >> Please pull this small patch converting the tee subsystem to use
> >> pin_user_pages() instead of get_user_pages().
> >>
> >> Thanks,
> >> Jens
> >>
> >> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> >>
> >>    Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> >>
> >> are available in the Git repository at:
> >>
> >>    git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-pin-user-pages-for-5.8
> >>
> >> for you to fetch changes up to 37f6b4d5f47b600ec4ab6682c005a44a1bfca530:
> >>
> >>    tee: convert get_user_pages() --> pin_user_pages() (2020-05-26 10:42:41 +0200)
> >
> > Hi, I noticed this never got merged, but I don't see any follow-up here that
> > retracts it. Is it still pending merge such that I should queue it for v5.10?
> >
>
> I think so. I had marked it in my notes as "accepted, and the maintainer will
> eventually merge it", and I left it at that. It's still desirable.
>

Looks like it conflicts with some of the later work. Jens, given the
timelines here it's probably easiest all around if you rebase/respin
and send a fresh pull request. I could fix it up but you'd still need
to review that so the amount of work is probably less if you do it
directly.


-Olof
