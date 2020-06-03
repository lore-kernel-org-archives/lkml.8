Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A7EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568E520679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFCOFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:05:46 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43349 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:05:45 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MOzfO-1jLeqa1ICq-00POF2 for <linux-kernel@vger.kernel.org>; Wed, 03 Jun
 2020 16:05:44 +0200
Received: by mail-lj1-f172.google.com with SMTP id n24so2852961lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 07:05:44 -0700 (PDT)
X-Gm-Message-State: AOAM531PNcYiJTYS4EqmmRmU93oIV0/jiWZ9uTu++4QBaxG7YYQlw4yg
        xsY7YxWJkFKk+00XUI57v076ffivkw0CpzEeYbQ=
X-Google-Smtp-Source: ABdhPJw9qs12iRvzkgPmHY8aOZeCRrpbIbW1QfyJC7R+9YgSABJCJMnrNREoyL5SNjuejmVOGOhvU5KnoORQoAGCH20=
X-Received: by 2002:a2e:9192:: with SMTP id f18mr2334489ljg.383.1591193143649;
 Wed, 03 Jun 2020 07:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net>
In-Reply-To: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jun 2020 16:05:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2o-_JcLBsF-8JozRv_i3n18r7ZEBBBmzvTVaXpt8HQpg@mail.gmail.com>
Message-ID: <CAK8P3a2o-_JcLBsF-8JozRv_i3n18r7ZEBBBmzvTVaXpt8HQpg@mail.gmail.com>
Subject: Re: headers_install builds break on a lot of targets?
To:     Rob Landley <rob@landley.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cBpTzGMX1rOvmCkWLXRufYfRZAPBR1sOg0pyxD1MorXfBbuV9rj
 J/AwrENwWJdiCZxGyhaJq0QF+zBYH11rLJgv0t8vf5mpPkqN8B4CuRJLAUxGR/6aEfIMI1t
 ZBBOJyDDmqAOCss4SwBbbmTx9wTHoIFBw56+7bgsvHl0W3OY34i+G8v+55aqGlWZIYwJzOb
 MKcyLzekSVtW8E3M4Np1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fzlHmOYXcs8=:1YxdYCNiin9tN3gK7Y1Xac
 gH+1G/F9nB1wNL/EzWN+1LArEQMW5mcwYroqqXzjQkeb7tDJ/GurYrfyZiYFUUCLxeiwurlvq
 3KGsk2lOwiBM7v8B+6GPIkMhJvCuzjOcrt8N7j5tek86fMK629Ucokd7I2jAHFyE7IPJNU69b
 aT3I12OhMl8xLUc/ulg3hXd20KDJKfndrvphlhCcREipjZ0s5WkdzxC7w1xW/i4FfigRvEszP
 feCosFzbyEm2Y+V+MdhUnlFhjPeCZUh5Jum4PlUpv6+J/SM21vNws/XGydv7aSdHuJ+7lAZBS
 mZeNdwcOMlYcWt3YBIJpbrTHYhS1vrKfqP73EOpmEWxAfEtwc7K0qP0IMagP2FomzU9B4sDRI
 bd0YWCGVIE7Abj6DJw29UAksRUCOArMqBiaCXkRiHqBC53wHPQgMUUiJs5Qg/Tmd5R+gxO9sq
 eUAo8sWulLhpbb3keYtAvc1Q8xqUJu7g0I0Z/rXx4IKbk1eOIHSow9UKebdts7lSe1Jbr7kiq
 6zrz4zO07euAz8Kk6t+yJ3HK0cfQRl03p6SseaQiftgJsFj5w+ctEKLLxdD+cw1pjGRe8nkhx
 Qhq/kqloWWmQcq5OFWR2wB+dYGHm4uvn0CCT2qK0h4j+7evy/2ZBww1/1OdlGs3dPEzRhfTd3
 VMH7fYU+hezoj8PYUMDjcg7ckQNPfL42IO6o7+Agps6k6lJNct4IKZBdjZGV4DyQPOgZvLmvB
 XiHwwjlB9AWpvMc6Omk3NfARIJhpgpp8nrHUbOjwTTnlvxRf0C49shzWNtPIeMGovV1Z4hMOz
 e6eXChaSaQ55xs4JlIWxRW1+fAj87TwuxiPJGpM+DerIbIQo5M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 3:49 PM Rob Landley <rob@landley.net> wrote:
>
> The headers_install_all target got removed last year (commit f3c8d4c7a728 and
> would someone like to update Documentation/kbuild/headers_install.txt which
> still describes it?)
>
> The musl-libc maintainer is using a forked hand-hacked kernel header package in
> his toolchain build project (https://github.com/richfelker/musl-cross-make), and
> he said the reason for it is:
>
>   http://lists.landley.net/pipermail/toybox-landley.net/2020-March/011536.html
>
>   Because downloading 100 MB of kernel source and extracting it to a far
>   larger tree just to get the headers isn't really fun.
>
> And I thought "that's why headers_install_all existed", and noticed the target
> being removed, so I tried my hand at a small shell script vesion:
>
>   for i in $(echo arch/*/ | sed 's@arch/\([^/]*\)/@\1@g')
>   do
>     echo $i
>     X="$PWD/fruitbasket/$i"
>     mkdir -p "$X"
>     make ARCH=$i distclean defconfig headers_install \
>       INSTALL_HDR_PATH="$PWD/fruitbasket/$i" > /dev/null
>   done
>
> On the bright side, the resulting fruitbasket.tar.xz is 1.5 megabytes. The
> downside is I have no idea how broken the resulting header files are after this
> error-fest:

I think the problem is that you can no longer run 'make defconfig ARCH=foo'
without passing  a CROSS_COMPILE=${ARCH}-linux-gnu- argument pointing
to a valid toolchain target triple.

You can use the cross-compilers from
https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/10.1.0/
to do this if you need kernel headers for an architecture that you have no
cross-compilers for, but they are build against glibc and won't run on
a musl based host, or anything other than x86-64, arm64 or ppc64le
that I built for.

I don't know if you can just run 'make headers_install' without configuring
first, or if that is something that can be easily changed if it doesn't already
work.

       Arnd
