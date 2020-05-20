Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1B4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D3FA20823
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgETVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:54:36 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbgETVyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:54:36 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N336L-1iuFr23Vld-013KlW for <linux-kernel@vger.kernel.org>; Wed, 20 May
 2020 23:54:34 +0200
Received: by mail-qv1-f52.google.com with SMTP id er16so2169665qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:54:33 -0700 (PDT)
X-Gm-Message-State: AOAM531NNFNz7UfsVPFBNccsTJ1y2riIxOaacDM0PqdLmwqidlvGhTTV
        lHWMh3H3T3kQ1W7+Hw5TXMh5PNp2N1TMQNXuFDg=
X-Google-Smtp-Source: ABdhPJxhlqBF6F6xcths8T69XvlyK8bJ9zrIzMxBBqdK7jmppg8Ks49xtrdIsFA0/8gwq5p9lAz9h8OG/cU+A8ZjutQ=
X-Received: by 2002:a05:6214:905:: with SMTP id dj5mr7068725qvb.222.1590011672567;
 Wed, 20 May 2020 14:54:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200518091222.27467-1-sudeep.holla@arm.com> <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
In-Reply-To: <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 May 2020 23:54:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
Message-ID: <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
To:     Will Deacon <will@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:SkYbFRr+qFpj6OoA3d+MgIf4tuiCcYPyCWSgCAGXSsH9l1SOT/y
 nLw+g4gLqCOt6r8Ss/6rMLINQHDUIwxcOA9JuYnEByAyZ5y5kBjMALvq6OkNJF5K7WTMwR6
 yQwMHkDJqxyCtltFmpmeOPrq7Oiz56NMXqKAuH2GeaRT7/9ecBd+SbQrkAdytmla+lwhYMe
 kBGXdA4P9P3T0sTtWqlJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lRkoBFP6kck=:iAloHf01fLf57RNkxYCI/H
 klP+OAJ4Ka9QeRoatLAq+465Z9T7rhyafal9/vzkFXAsgealBFgo43OOHRUo2YYzNmWjtRfn7
 Yuf2lIEd6PKev+pl7tujAem04C7ckKIllBmRAbvnvE/iZGHXBvt6sSTTfoH3HvdDoW3NiKmcA
 byIRUtyTArUBFMxpszSicM1v7oYHShoffR+5vKemeE/2sxaAtn1HJDijvFWN+7ie7PiwX855E
 txsn+KhkM1E3POZnAMDrvY+FQxdkhnrr9M7ZgPgljv/oqsLBEYoqMM3617KS0jRI+g1y3pIvH
 S3ffRxErwQpwtCsylqiF/9HoBDtEDmEN7Q+eTeudYjZgd8TGgb9qBLUQx5bTPMGD+cHFE2Abb
 q4hWs4URF1Y6xKZq6rt80Az9rTLUGGWnI2fzYKrUNweZ6VPT+tD0+KEWyCIf+KuPB705PQL1a
 qwRelvCh9caQ+OrBHhXcZXer4IhQi2gwZaWyd/oL8ag2IbS6U3gOVB1u0bKlnDztREDwn44vB
 8bsjapEbHKloSnfXsUh/VolxifgUwU2576MPJv+GmkU0RukbewFKiHWddtRXtMjk2MVcsYZ2S
 6is6xWzO00EuCwiMwV0qukh/iaRl4dfFdC/VmRd4DjDRRcHgbng5DbuvdDYT1jzZxK9tA4BGl
 cbf8mIQ1wqcVJ4Qw4YNmjhjgMUajOzLKyTPua1Y0Q8ADvBbitEhjr1BLoUkoictJhqUuZ2WGP
 FT5p57X9r5lgh5Sb+w7bSDJzQDcmL12Rkpqaeh1M47Gf9Q091CGD17zsula+/VMGinkmAxhQE
 fU/PjRb+teSn4AWFKjt4pPpeBfUtBxUsz2VI+hZeg6qpBKiJeA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 11:29 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, 18 May 2020 10:12:15 +0100, Sudeep Holla wrote:
> > This patch series adds support for SMCCCv1.2 ARCH_SOC_ID.
> > This doesn't add other changes added in SMCCC v1.2 yet. They will
> > follow these soon along with its first user SPCI/PSA-FF.
> >
> > This is tested using upstream TF-A + the patch[3] fixing the original
> > implementation there.
> >
> > [...]
>
> Applied to arm64 (for-next/smccc), thanks!
>
> [1/7] firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to identify SMCCC v1.1 and above
>       https://git.kernel.org/arm64/c/e5bfb21d98b6
> [2/7] firmware: smccc: Update link to latest SMCCC specification
>       https://git.kernel.org/arm64/c/15c704ab6244
> [3/7] firmware: smccc: Add the definition for SMCCCv1.2 version/error codes
>       https://git.kernel.org/arm64/c/0441bfe7f00a
> [4/7] firmware: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
>       https://git.kernel.org/arm64/c/ad5a57dfe434
> [5/7] firmware: smccc: Refactor SMCCC specific bits into separate file
>       https://git.kernel.org/arm64/c/f2ae97062a48
> [6/7] firmware: smccc: Add function to fetch SMCCC version
>       https://git.kernel.org/arm64/c/a4fb17465182
> [7/7] firmware: smccc: Add ARCH_SOC_ID support
>       https://git.kernel.org/arm64/c/ce6488f0ce09
>
> Arnd -- Sudeep's reply to you about the sysfs groups seemed reasonable to me,
> but please shout if you'd rather I dropped this in order to pursue an
> alternative approach.

I missed the reply earlier, thanks for pointing me to it again.

I'm not entirely convinced, but don't revert it for now because of that,
I assume we can find a solution.

However, please have a look at the build failure report for patch 5
and fix it if you can see what went wrong.

        Arnd
