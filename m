Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E308C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33AF0206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgFZSij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:38:39 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFZSii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:38:38 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MjjGX-1j906h3rrP-00lAps for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 20:38:37 +0200
Received: by mail-qk1-f170.google.com with SMTP id j80so9711800qke.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 11:38:36 -0700 (PDT)
X-Gm-Message-State: AOAM531RW2l60g66nOHwpdj8/oCcGM6dO5bWX5KvZdjO8G/L5w/32xG3
        hiTVvh97BLvbue2WitZdSkbZQ5wSoLWdGhSHDtI=
X-Google-Smtp-Source: ABdhPJyNQfXE0ruJoQ05uf8LqIW97WW2kUX2cNf9ib85ESLuPO2ZW8kSwf5CGuEtUuAzBjEMbkNjuKHwJyc+D9Q5Vtc=
X-Received: by 2002:a37:4ed2:: with SMTP id c201mr4102478qkb.138.1593196715831;
 Fri, 26 Jun 2020 11:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-8-lee.jones@linaro.org>
 <CAK8P3a38P1PGHkvTDqSQC6sBoDrfipbZzxUaJeV4q4At92g_bw@mail.gmail.com> <20200626152923.GB177734@dell>
In-Reply-To: <20200626152923.GB177734@dell>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 20:38:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0paVJoQmqOB95mp1gQJKZTg-X8jK9b5ZnCqnnSKeCCQw@mail.gmail.com>
Message-ID: <CAK8P3a0paVJoQmqOB95mp1gQJKZTg-X8jK9b5ZnCqnnSKeCCQw@mail.gmail.com>
Subject: Re: [PATCH 07/10] misc: mic: vop: vop_main: Remove set but unused
 variable 'ret'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:hZRcRcvEfEYlm10qGT7ZSxJqZGkz+vXIDWi9+z5cpSDC9+NhNQ4
 Np3FLrwEr8YnhnTjh53/d7GVSJoii2Jy6/m3ZE0xW1q0/Ul0IamqxDCYncc+Nc0VgQ4XTIT
 AMFLXKppXo6ObePR42fjVVayHgRP6yz6dpJ/vTxO/DumP2L8aXvRZbnDotUso5kap/T+eqp
 h3Su4K4pzOP//yrIpCWKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wo/zRie9ZbU=:/MFnA9ossBRL66oA+OVrwR
 6PyIArypKceFUj5QpTEeg7Q5kUK5nk1lED7hfhhMK8vzLkFhBeffPMpvtC6vDFJNL9rLi55Xu
 GcjcjAXPH9JVuiJiwA9/sGFMeLrCm2K9i1+9+Eln2R7QJLWutkgJVvOE/Pw8SuH7DseGZJXoZ
 CO6WM5Z41VfLC44tJxrknebiToO14LWndHknQQAQIa326NcqvpWAsaCGD67XefyDodRWxyaQs
 n1NrobH0lmLj0cSysfUofiVD8wphgP9NiYl3VD2Zyf6Nhv7UPW0YdZ+R2dmibykzkgR/hchwO
 xhFMOrfAfAWMG59u/boXSQTJLhDO0D8RnyMJW9a4172epS5tfMaVyUjIetnd2quGVAE+onTTU
 IWRsKCReyAtLUQKjlwZX4AAh/vDko7vSIx4rFqEyM+p5lXxtlq0S8VqKhVe7o9LRSFMyfSbwr
 a7yI6WCnaYuyFm0krOzqNt9Rg1XfeXozBME/ZUmpOLvo1eAsx5JBY9htWHSM6bN1xfpw0GHo/
 saZCvGt6AMMZD+YoeGqNbnjl/1MSzL2jY/H7QPSlLl3amclxyG00Zqt6TJkkd/vi2JaT/s2fV
 iLiwf2TZjDcnJbE/Hcq0kKkJPIa2k/5hZlhE6hIBKfAv6yMXoKLX6nRCrVnJp6BidVVQhV7fR
 cobZ9Cu6UIz6AMLQPnXB0IgEBrse5uv4Htwrv8lLv+9EtW63V6Cv31TURrg4Zdgi/80Tdjdul
 KI+IyWyyct8kKPnuEVLs0DoSxjZHN19Elk/Rkixw7ACGGRgDj143TEEgCeCFy/WMcYMkY/R7J
 u44NjB3t58ZevsDO9/7h5QgASYfYGq58GnqZqWCnTmrsd5SzQI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 5:29 PM Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 26 Jun 2020, Arnd Bergmann wrote:
> > On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
> > This is a correct change, but I'd take it one step further and make the
> > _vop_remove_device() function return 'void' if you don't mind
> > respinning the patch.
> >
> > Either way
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Do you mind if I handle your request as a subsequent patch?

That also works for me, thanks!

      Arnd
