Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDAC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AE72223C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgDQPDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:03:39 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54061 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbgDQPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:03:38 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N332D-1jF7Hp41CX-013N8Z for <linux-kernel@vger.kernel.org>; Fri, 17 Apr
 2020 17:03:37 +0200
Received: by mail-qt1-f178.google.com with SMTP id x2so2200097qtr.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:03:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuYNC+GhqlJWH17b57WhWTE3EeHZlN4QqlAJRGO0fQO93ajDwMDt
        v1974bYnKpf5mkttEbJ9jUEnqcWSFkEuGhOJu5s=
X-Google-Smtp-Source: APiQypK92ISK/zUtOPjeQtP2x+PRyL4eVjU7PNuNXkJFZYgEvbB0WS+Ephg4BOvHEDfhmTcS7Fpamw0rN50aZVdENX4=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr3347694qtb.142.1587135815705;
 Fri, 17 Apr 2020 08:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587088646.git.baolin.wang7@gmail.com> <dad648071fd163140f6534295cfce76562003b5a.1587088646.git.baolin.wang7@gmail.com>
 <CAK8P3a22NMzCQHDoE7Ed0a1_f7yOTO4x4PM6KArXJnaaig4ZTw@mail.gmail.com> <CADBw62q2+nWOFp+BLuNvpztyy-wYJYO=3024eBun4J=grqJhVg@mail.gmail.com>
In-Reply-To: <CADBw62q2+nWOFp+BLuNvpztyy-wYJYO=3024eBun4J=grqJhVg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Apr 2020 17:03:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2-AQx6iuNeWOFfru3H21pv4Gg7Qt00uUghbnPDzwF4_g@mail.gmail.com>
Message-ID: <CAK8P3a2-AQx6iuNeWOFfru3H21pv4Gg7Qt00uUghbnPDzwF4_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: sprd: Add Spreadtrum special bits updating support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vJV0fx4mR6sZwT9pQjXrk3ytuYnTxOWuLnNnvweVuOfS9j9m9zP
 YI0rC4x9AHGlkE9iPAHrCrkKuFyE3ToKkFDMyRFzUAJl5Q2eXEgRL7e7SnCtUCV6hJJhREL
 W0qR8t3E+MPeLeL/GQlx3Zhv9kKxsEbdmi1DSzmnj1zhB/YWx5KEoiBveFmDV34YiJUVwuA
 nL/8X6wBar/M3Trs8CZew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oI/RgdMY/e4=:Z+9lJJwrSSywf+pgDFu5lT
 npHFEEECHTZJbLVDC0E3IuLNKmihPold1o+FH0cI9/Kd/omgyWeqCrxKZpWDi/iLvqIwgQ/js
 BiV14/Eqm5/dB9b/jjCOGfXejMeNx7QEAXs2PTKp5bWz1jOReyuZa1jm3IJy71keSS+A6whIa
 X9HrQ8geytYPG6QBJs2YOiEArJGscpcwLUA/ef9gofcwm0bk45aZY4Mu8ZMPle3jWjY6s5LJw
 QseDbQuRdWYSKz4FHN6OhkMkx2Qmgt9lGo9/tKtW8xhGH6bVq/euoYnOd4w92Xh92xzskK8CF
 90ckIw8pKtue+9zn3W477eXLuGsMDA1MuEXpsZwCSBO6m5QF4pzcX5xxMKkhtgWEf+YhKxMvM
 MlQbi48zCK5LcsHoDPdnrGb8EsBKE77FDUEIMO4wc0QiuoqWgUDRbIcHs8OEyjpQyj9XCRZwU
 eOZn3NNnEO81uqhYau1RXh93V+rvZxLgDT+iYmkGqVQMhhtLNGg7nd1E7L3LCQ0/rhaBoQv1k
 YOQ3MwILqc4vYlAkhut+MLPxNrcuYF1WbdJPbt+WKjfJSeTTrc7h3CNT7+rkBKG0L+KcmvwrB
 GituyiQ/hsgcB22v2YTFv4aZKcBxP6Lwtr6Y1B6UJrJeaeOPv1Be0ibjIFho2i4tvjVQFz0X8
 pAHkWvcfMBhIAQp45ncFnog2WZKveTwTaI/hRERoxuigyvbM86nKa+k1TNHSPVWVwf1Fsq1vd
 0+fadU+EfEWY5Fsp6rIrDmlA8yfdHcmPIHnLqNzKbjA4A7VqQFKtRA0z1uc2BOxCuqDofRlgn
 ZFVX8DQ2as/RbOSU3n6y/EbLipX9QvSgQ6wuWehIl2fUDCZ7JI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 4:10 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> On Fri, Apr 17, 2020 at 9:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Apr 17, 2020 at 4:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > +static int sprd_syscon_init(void)
> > > +{
> > > +       syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
> > > +
> > > +       return 0;
> > > +}
> > > +core_initcall_sync(sprd_syscon_init);
> >
> > This no longer breaks at runtime based on the changes in the other
> > patch, but I still don't like how you have to manually load this module
> > on spreadtrum platforms.
> >
> > What I meant to suggest in my previous reply was to add the regmap_bus
> > instance into drivers/mfd/syscon.c itself.
>
> Sorry, I misunderstood your meaning before, but what you suggested
> will add some vendor-specific things into the common syscon driver, if
> other platforms have different update bits method, we will add another
> vendor-specific regmap bus into the syscon.c, which will make syscon.c
> more complicated.

I think we can always deal with this once it gets too complex, as long
as the DT binding allows it.

> But if you still prefer to add these vendor-specific things into the
> syscon.c, I will follow your suggestion in next version. Thanks.

Yes, please do.

       Arnd
