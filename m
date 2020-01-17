Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67A6C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36862083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgAQOy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:54:28 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53599 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgAQOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:54:28 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MqJuN-1jNS6r3Ncx-00nQBt for <linux-kernel@vger.kernel.org>; Fri, 17 Jan
 2020 15:54:27 +0100
Received: by mail-qt1-f175.google.com with SMTP id w8so7535298qts.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:54:26 -0800 (PST)
X-Gm-Message-State: APjAAAUVGe+RbfJki1Sk0nk4RQgV5LNg5fr7Xep6YqX2AchNCdVwRC8d
        iOK36hsrXzI+rPtn1VRduc1y+NkC4O2HklP1usM=
X-Google-Smtp-Source: APXvYqyNbhEoi5YG3bM8Xcwm3wQZqBYt2kSVy1er/HcaWl0jLirbA5wWpGcixz266Cc8Xvwda10KPKBkcfBH32t2J4g=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr7784917qtm.18.1579272865672;
 Fri, 17 Jan 2020 06:54:25 -0800 (PST)
MIME-Version: 1.0
References: <1579259812-27186-1-git-send-email-orson.zhai@unisoc.com> <20200117132807.GL15507@dell>
In-Reply-To: <20200117132807.GL15507@dell>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jan 2020 15:54:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3ApsUTpRYbpCtB-hHcsgtN0yyTOdTYOGUWw4woawH6vQ@mail.gmail.com>
Message-ID: <CAK8P3a3ApsUTpRYbpCtB-hHcsgtN0yyTOdTYOGUWw4woawH6vQ@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon reference
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Orson Zhai <orson.zhai@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        baolin.wang@unisoc.com, Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:SPuSX34aYuNRFJAGEFce2jFOJl6YSOL+wTOjYQ/c/GecMM2JyxY
 NJ22bbtCsSCsZLyEwJmsO7oUfpAWR1DBwHxNcUTVNeQZQypxj7xh6s0yAHhyv1CzDWJtZyO
 os5+zTTuwi4SO4S6RvQ1PoyAxqAI1xwlsBIDVckvtu8YRV8zEXDw0H3QIxwsu/M9JFiEwHH
 EIGFGABd3Zx38NfBkdpMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hv32efBNTtg=:9SA0oSi8Sa/ZsdDkKSA8gJ
 O+X7hM3APtB+8/6f1O6k5KuGNFTxSjQVZNElwWgcFtfjYbWb5Z64y/SxltamDv2fPpMWn7hAL
 F8pBBD72o92rr+RGKAvcfB3fekU0TOLSj4TzVeP/Uo+ZBSP8Vq2PVt7Q5HUkxMmyvVeokVmAD
 BA/Ej9Be+D+N/h9ieAZuZv3eO2JJr+IINKF8OHdTL2RjeEn88mtHhtxz/HH6FjcQW/w2RiWZB
 luyJbAKwDr73Zxd/aRiY1SF4T4rJFjQvqdSh42QbsH2pP8EogUOivo6BpNXc7NlYxO5Pt+9xv
 DncLNsfh3f+gTX+Fd4IVb9Z3JLNGGUO/AVJzCvm5Jxop9Rt/wZZ5hDUCX+uF5NfGmzF1BBeZ6
 zLP0ZLtcw2kEIXHrx9wZLnV42Wa+24d12dXvI09LU1x932zV2N1PXCcuNH/cjbO1oUUbZGnZM
 FLm3ICyKIOBcW7kzVZap+W258EjZC3aDYNZWgHHmR8c7TiIWkWoFDrpbofNWMcaV8TuEKARho
 qEtmYRakYvEvlz50UlJm3pHRdAI4ovSLuo3i3RyXbSZ8Yxx3G9TGIy142M6/Cna+JAYpukglF
 D6G/Oj6HtSvpSvU2QO/97wjpRRVMem5ppIA043W61GvkKdDdY+cAdMacK1YP5DiZjYoEucqWW
 l0oWoCxfY7onro6otuBm7+xFAztZQxhNOPtG8pockR4Wa0ow1/ANxcCszHzU5L7OuousvOIJm
 yjAnKrv01xBf92N5Lv8jqByYHykK57JaGUoAuP1snBMV3d7UhlDQEUNBJihnjdedq1LgLWVmy
 DdM5qw9ABD8g0ytWOl+dvNm1R+yUZn6fJx8jF+x3j802FrWlTMa7Ex+SoUQ3WIoO+0D2M+QS3
 Ygw/seFViktrH5D1zwdg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 2:27 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 17 Jan 2020, Orson Zhai wrote:
>
> > There are a lot of similar global registers being used across multiple SoCs
> > from Unisoc. But most of these registers are assigned with different offset
> > for different SoCs. It is hard to handle all of them in an all-in-one
> > kernel image.
> >
> > Add a helper function to get regmap with arguments where we could put some
> > extra information such as the offset value.
> >
> > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >
> > V3 Change:
> >  Rebase on latest kernel v5.5-rc6 for Lee.
>
> Still not applying.
>
> I think it's a problem with the patch itself.
>
> It looks like all of the tabs have been replaced with spaces also.
>
> How are you sending the patch?
>
> Arnd,
>
>   Are you able to apply this?

No, there appears to be some whitespace damage in the patch.

      Arnd
