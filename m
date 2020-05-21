Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FBEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9102072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgEUJbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:31:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:55829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728704AbgEUJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:31:10 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N9cDF-1ixPAH2wTN-015dNM for <linux-kernel@vger.kernel.org>; Thu, 21 May
 2020 11:31:08 +0200
Received: by mail-qk1-f171.google.com with SMTP id y22so6583673qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 02:31:08 -0700 (PDT)
X-Gm-Message-State: AOAM532y3FNcqsntLRaUqXSoNiqDwPKPwbOQju4Osxi9q1xx0BXOx6fb
        kO+6HkQGwy7bCcCCigxInMZh3BaPpP3Uv/z/JbU=
X-Google-Smtp-Source: ABdhPJzbgF8kpiHY8jbqJbvHdKF89SdmVVSXNL4nMi/iekVliG7vUiFck8VHCIJH+/J+6YUDtXi2c8Eovdt4IzQ+dlw=
X-Received: by 2002:a37:434b:: with SMTP id q72mr9455175qka.352.1590053467616;
 Thu, 21 May 2020 02:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200518091222.27467-1-sudeep.holla@arm.com> <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus> <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
 <20200521075755.GA4668@willie-the-truck> <20200521081055.GD1131@bogus>
 <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com> <20200521091736.GA5091@willie-the-truck>
In-Reply-To: <20200521091736.GA5091@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 May 2020 11:30:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3+AjykQpVFcyM9ht9T7FwHGcwSOH3GGo2ziaQ1mpesoA@mail.gmail.com>
Message-ID: <CAK8P3a3+AjykQpVFcyM9ht9T7FwHGcwSOH3GGo2ziaQ1mpesoA@mail.gmail.com>
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
X-Provags-ID: V03:K1:j5rGUQ73rrDexC1lnHcB1RpiEDo35jQL/y8gAGtBCC9Lbxmxv23
 r5eGf2EsLg5w4cXiQDdz7gHVibZJxtz7uKgmUnA8d+GD7/i+piciZGUfbmuaFHuVZ54h8rv
 pAFqkePGbuVSit3Abkaqps8xtVDUiDLUUzI6avSOA6NP8cWLB13XOZXpOwPIm+so6qkM4pT
 4vFV2COVGAhiz72Bt0zxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bRGBE2Z6qFc=:5Rm06osgW0jNoU/v6k9BWf
 s6SUAtcgWJK/Oxn6+jL/lJo3vO7CcyFZTRrfQhNX1be24+tYp6wwIqGC/Ny5AIzBSSKvo29mz
 rUoAFskyYt+hvQR63CjkfyrwkGBQyiGkljRnyRFJAPHfdlvzyboCk8wFpd6tnJf5u7nsaq8jI
 GuHrbwgXPjEItnWXXAYhGjt6mCRowkfykKNpUX8Ha5mHvCYHQrL2FDygjUshqrW33ps1E3VgP
 nDsT3fEn6ggCwCtY2xIRCupA8JgVYOgsS3foJq3QBWmqzhY4TnitjUAF0nICtN05n3SHGXCr/
 +eMY4JDD5fGeNZxPo9eOm21fXh523FlzQ7oPGmjwG/4pTzZ19oaSSy0knN/4wxoesnYxYio8c
 zqOIfzB7QM47aob1/3QWgcoG2TzLQAloAZdkbMZAxC2ITmiKlZkPmT4z1zb0r6m1kes3nZs2B
 48gN6z6B/VQzxEeTaJtwOo6pPMWqQn05s/yL/OYwhrirKycDUzcccDKbM0SOH9MCo1DJsKNYe
 6qobyObkVM2YPbdCJrNIOi2NlwnNB8yhRyTjuCMWWFhse9b4X2IjcMVj+GRT4fnW2UDPMqIjo
 5IP/RdMe5vxrnmr8EkSkLwk7RpHMb/W7zdhlcp8Ah3zTYq798Gaf4fXtjJI7VpZO12G5swmcE
 3McF+KMh9DKhpEeoZ9qynFPiKHdv4YU+Ub0D8aY7Uz97ip6U2WYrbj2USew2BvwxQbNZsaQTK
 XNcqq7mzkbEA8reGTyRC2RLnhs9LtPx7ZEssNxgVmGaL2EFJDOl40NZGEcunW6KkSwFHHwSQZ
 0T/GSHNPB/wnHE4vGhKjX76D154VtpQNo9rttdc2PnkZhPTN0o=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:17 AM Will Deacon <will@kernel.org> wrote:
> On Thu, May 21, 2020 at 11:06:23AM +0200, Arnd Bergmann wrote:
> > On Thu, May 21, 2020 at 10:11 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > Note that the warning should come up for either W=1 or C=1, and I also
> > think that
> > new code should generally be written sparse-clean and have no warnings with
> > 'make C=1' as a rule.
>
> Fair enough. Is anybody working on a tree-wide sweep for this, like we've
> done for other things such as zero-length arrays? If so, I can start
> enforcing this in the arch code as well (I haven't been so far, even though
> I do run sparse on every commit).

I've done some work on that a few years ago, and there are always
some cleanup patches for C=1 and W=1 warnings, most recently
with an increase from Huawei's automated build testing + manual
patching.

I have not looked in a while, but it always seemed to be somewhere
between "too much to do by myself" and "small enough that it should
really be done" as build warnings go.

       Arnd
