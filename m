Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27AAC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B118424672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgANLRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:17:47 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:49183 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANLRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:17:47 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1McGtA-1jN6BR3ans-00cdtS for <linux-kernel@vger.kernel.org>; Tue, 14 Jan
 2020 12:17:46 +0100
Received: by mail-qv1-f53.google.com with SMTP id z3so5460700qvn.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 03:17:45 -0800 (PST)
X-Gm-Message-State: APjAAAWXuovQ9UOgj7HTrrPjfne4KrFKCu33o3bunG8/Okej3L0FIIdI
        oxotZn2n14pRpapePg+U5XCuoNJcpBHiAedde6M=
X-Google-Smtp-Source: APXvYqxewBOBWhfpEFWxrE82cB8j/GRSkMj0uZDNDoV/o4MauOIMLjl2H1Czfs8TY0PBzifQFmfdxNh+O2jjxtNVCWw=
X-Received: by 2002:a0c:ead1:: with SMTP id y17mr15513188qvp.210.1579000664506;
 Tue, 14 Jan 2020 03:17:44 -0800 (PST)
MIME-Version: 1.0
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
 <20200113064156.lt3xxpzygattz3he@vireshk-i7> <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
 <20200114092615.nvj6mkwkplub5ul7@vireshk-i7> <CAK8P3a0jXyJArzQFd+u68iRvXNnXb_oHbWF9-abvvFuqhpi-NA@mail.gmail.com>
 <20200114111110.jhkj2y47ncp5233r@vireshk-i7>
In-Reply-To: <20200114111110.jhkj2y47ncp5233r@vireshk-i7>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Jan 2020 12:17:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1cByQrhKV=8gRASNy74p8=WKfi1ZU13S2OpFQRjohUsg@mail.gmail.com>
Message-ID: <CAK8P3a1cByQrhKV=8gRASNy74p8=WKfi1ZU13S2OpFQRjohUsg@mail.gmail.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:++IQvtTspzRE29UBi6vKzQmPn++cVPobveGFppCp1HlcB9IDD9l
 nhWpmZ4fbdhWSuGqx0xQlhEcFGoP49+gzvUF9DxTQQiZ0IzgJFvJIynx1Ey2k7OilWXDfKR
 QI59JnnftB77TzszUjOFuN8OgeqU1vcIxzRN/LwQCQg6ZlqI834rr7dQzr7eDos+8U5TTlj
 Qw61eY0YRNesID+aTIlAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lGCghHztiNE=:WvVOeayv+u0dt/9LImrsQ8
 wjBV48dMe2D5wnKKFs5QV2J1aMny4XeMWKTPFMotxPVre4r5OpANfRlyNIuKqPGhBJXz+RwvF
 tRBGtin0sjINLmw+Id/N+9ffW7DJMYybPcjiKiiPLN1QqvYDGQn6ig80reftWJddNBur4jTy1
 Pm6QyylniGbDGZsOL8S1Z9BeWWc4uHU03IN4dJULCb8jnyqTWb9JQ9DIBznCsR3vz8nK50rzt
 TO9gKXANn1X24g9BlTcDIFkGbsbmAGTj2lRf5xzncAZvADh+Bub1W4BhOD2QbFNeDWpCBNz4z
 7LVygLoQcVWJsnbxxTrZIuk+Df/pztCfUe2SSoRkGrpLxgVRKzkikI+uEkO8p6b6nshvjN6nR
 iddcGucwY+j6c41h8S4htdyTrBaZrDQjTsIBkfosNuMvH/NCIPW0AcjDs2VI0NaYCa7lHoAY6
 iEsM3dqNYYCAHTDZllDvdXykxsYDVUvUyKsYyxFBkCnIMORx5VBAqiVaRmBJB3B3jIjDP8GVW
 yfpL8fbjTl6PZxfzThL5fOW8lT37Pe9vTSADXetk6Qzuxc7w40R5T2c43Y/AeHXUciJc7iWxq
 DtDKQhBxgTIU+ELuMQe7ZnOznTbk6QCbf9q2EfXoA6c8m80QEF3JYDBlLPAnRjXtL1xxY6F5H
 o7ygE/If9/DJEN4uyfK0c4Tz8IFE5U/ACn1Mo4MoSl7Rlw9e01OMRVW4R9PWJbvPsmLw/Vxyi
 cIOsyu83/XZMDJZ+gCDxTr3G+KSwzbdymsyVBt5ptDMemOeglSr0jUn6EoxP8IlT5YtsQUWZh
 MB0MR4XFz8z0qa5tmbwx88msAJ65kreI1Za+RyEqXfHZYXUXpggSa9V2BVdPhPCxWXLV9RKiU
 Du3PAxE4ct22Ym2jt94Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-01-20, 10:56, Arnd Bergmann wrote:
> > My point was that you cannot mix __iomem accesses with pointer
> > accesses. As I understood it, the current version uses a pointer to a
>
> The current version is stupid as I misunderstood the whole __iomem
> thing and just dropped it :)
>
> > hardware mailbox with structured data, so you have to use ioremap()
> > to get a token you can pass into ioread(), but (some of) the new
> > transport types would just be backed by regular RAM, on which this
> > is not a well-defined operation and you have to use memremap()
> > and memcpy() instead.
>
> Okay, I think I understand that a bit now. So here are the things
> which I may need to do now:
>
> - Maybe move payload to struct scmi_mailbox structure, as that is the
>   transport dependent structure..
>
> - Do ioremap, etc in mailbox.c only instead of driver.c
>
> - Provide more ops in struct scmi_transport_ops to provide read/write
>   helpers to the payload and implement the ones based on
>   ioread/iowrite in mailbox.c ..
>
> Am I thinking in the right direction now ?

That sounds about right. What I'm still not sure about is whether the
current kernel code is actually correct and should use iomeap()
in the first place. Can you confirm that all current hardware
implementations actually use MMIO type registers here rather than
just rely on a buffer in RAM?

      Arnd
