Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EDFB208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgE1JIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:08:39 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgE1JIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:08:38 -0400
Received: from mail-qk1-f173.google.com ([209.85.222.173]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MXXZf-1jVZZi0jaJ-00Z3f9; Thu, 28 May 2020 11:08:37 +0200
Received: by mail-qk1-f173.google.com with SMTP id s1so2377183qkf.9;
        Thu, 28 May 2020 02:08:36 -0700 (PDT)
X-Gm-Message-State: AOAM533jSxpUXDpqjMWjpSMuU4LgnWhsd5S1RpfnNQ7hNJEveCQHHVch
        T+XJrMb1jac4a2X+wJ1iQZQoDyE7s9gpZOn/TEU=
X-Google-Smtp-Source: ABdhPJxMRjUKxZH6xpszfE4Dyz28jyf10XmVj16uY61LsBkHJESGSohbLYv+tw2+D7hMoCFfByorAEYf1A5P7jeYv/I=
X-Received: by 2002:a37:bc7:: with SMTP id 190mr1735331qkl.286.1590656915923;
 Thu, 28 May 2020 02:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200527134043.807045-1-arnd@arndb.de> <159062606969.69627.15005677857751012104@swboyd.mtv.corp.google.com>
In-Reply-To: <159062606969.69627.15005677857751012104@swboyd.mtv.corp.google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 28 May 2020 11:08:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0uXyobHKzuEoK1Y8Dmp=x7BOSeZQi-S+_YU6TxnX0s9Q@mail.gmail.com>
Message-ID: <CAK8P3a0uXyobHKzuEoK1Y8Dmp=x7BOSeZQi-S+_YU6TxnX0s9Q@mail.gmail.com>
Subject: Re: [PATCH] clk: versatile: undo some dependency changes
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Iq/tHjUP/PEYdX00FfexK+7OlIFoe10YzrumlPv6tpnSCJITZi+
 h6qksJxldwDxaZLtH8xMcF2IKGKFQRzY+mVeKcv8InIMo7SWy6JWJqgpQYHiAmJuCYlxcOK
 AKm9J0cjq3mdZD6uwGcLzVk3KZoD/i+lS0ek00hFcdGMdV9in6BOXN65fndyrJ1yinGs3eS
 gmuKUhYtJk405iQru0ILw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPKyQcKs6iM=:4OcgBNjhpyOZkKjqvHs8Ys
 DgzJCk1CwJaHinJxF3LsfsGHnxy1Yt7qFRHNwvxBZ40liB9CElZhv+BykU3UcQ6GzdZzJtSaM
 mHzp5cxETja+TyXlOt1Y9wLImUlnB2RSMujdTHcDhIR/KuQ55Hq+yBb45zzShAW73P7BmuqHZ
 RMkm86EUBoMwc5zAnnnsVZhqrC/NrtMaSREzBehBguYuaqifd8OxJJts7PMQX7+Z0o+99ucE9
 TK2VYmkSElqJ0VNrMCCII/CMyLApwKqSeIxB3o4RTjrIxd+MUqyxfYMbsoByWGvPeIwU0tsBw
 0CtzeC3T26E3sk643maMuFi5kFHxMPdubprmtnHWuIQTByAI1QkQQ4DmkxCTjYHbnQjA+tcMM
 MEwQtSG1h/cpoOEDcY7QSPbGYHINHrqWL+EsnJh8jhT1ZdtXt7cai8/WKi4nqSy9lE/d9TH5w
 IH1Yo6ga3vvLuBi/DJjaGAbKrqY9OVO9MTBZ95oElVZx400Ije7UpbenM2yXVZdw2eZJ1CVLW
 jjjuFyq8fcW2x+Ow5uPSHofSpMztBxZcFuytdZNpnw6B9BkjFNwD9h/Gi71y3U4O3XTDdIXwm
 6h3Gn7AO4bu+GAjZxE6jQMxdCWx81u3ZaIlyjfe6ij73tYMdBiqOyfCyYVmhkF3oFBTtoWY1G
 gP3D0Fq7thUwJVKGWs3R9PyE50Qews9UqTH8TjKcwAklQbhBLYSB4wgT+4tnKAW6STr1NAZmO
 MxpcUk67/wZjgX8hEOerIS9XUBEVKcCrjouXHl5UvhhnKcmwhTo9Ntv5C91Qe6HegLQSU6+Zd
 ytAKc+htWk0NvVEVjeXAPcwP8ekP+Kfho7f1em2H/WUQt+VKnE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 2:34 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Arnd Bergmann (2020-05-27 06:40:33)
> > SP810 and ICST are selected by a couple of platforms, most but
> > not all in the versatile family:
> >
> > WARNING: unmet direct dependencies detected for CLK_SP810
> >   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_VERSATILE [=n]
> >   Selected by [y]:
> >   - ARCH_REALVIEW [=y] && (ARCH_MULTI_V5 [=n] || ARCH_MULTI_V6 [=n] ||
> > ARCH_MULTI_V7 [=y])
> >
> > WARNING: unmet direct dependencies detected for ICST
> >   Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_VERSATILE [=n]
> >   Selected by [y]:
> >   - ARCH_REALVIEW [=y] && (ARCH_MULTI_V5 [=n] || ARCH_MULTI_V6 [=n] || ARCH_MULTI_V7 [=y])
> >   - ARCH_VEXPRESS [=y] && ARCH_MULTI_V7 [=y]
> >   - ARCH_ZYNQ [=y] && ARCH_MULTI_V7 [=y]
> >
> > Change back the Kconfig logic to allow these to be selected
> > without the main option.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
>
> Is this similar to
> https://lore.kernel.org/r/20200527181307.2482167-1-robh@kernel.org
> ?

It's similar, but that version still breaks ZYNQ when CONFIG_COMPILE_TEST
is disabled.

      Arnd
