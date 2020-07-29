Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6877C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A159420672
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 11:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgG2LgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 07:36:02 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60417 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2LgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:36:01 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mth79-1kvAid1FJ1-00vAI7; Wed, 29 Jul 2020 13:36:00 +0200
Received: by mail-qk1-f180.google.com with SMTP id 11so21837735qkn.2;
        Wed, 29 Jul 2020 04:35:59 -0700 (PDT)
X-Gm-Message-State: AOAM5301V01koQiw8Zw6Dp5bdFx6mxV7aSAmfU89DR0H+8bEiS9JLDtU
        sT1tCZYpoEFjft0trMxxHBdMiInA3LLVWs5OJhE=
X-Google-Smtp-Source: ABdhPJxo5fJ/F5KzuBO5kZ+/n0/36DVRpoaDEQranqdtWjA+xCyBnXOZvsxgXoxLXMaovJ3lcU7ByGMB4VEd0o6ogTw=
X-Received: by 2002:a37:b484:: with SMTP id d126mr32582255qkf.394.1596022558928;
 Wed, 29 Jul 2020 04:35:58 -0700 (PDT)
MIME-Version: 1.0
References: <202007291721.W8cazfJX%lkp@intel.com>
In-Reply-To: <202007291721.W8cazfJX%lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Jul 2020 13:35:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1koFEQ6qzok8t+3XKbO5Xi_q29d64Y_QofKXRwL4Dr9g@mail.gmail.com>
Message-ID: <CAK8P3a1koFEQ6qzok8t+3XKbO5Xi_q29d64Y_QofKXRwL4Dr9g@mail.gmail.com>
Subject: Re: drivers/clk/mmp/clk-pxa168.c:68:13: warning: no previous
 prototype for 'pxa168_clk_init'
To:     kernel test robot <lkp@intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PZHV07tB/+bO7U+PL09M5gXjLWJXut9tkC1eAfiRCx5hwYsFP7n
 /TEsCwC8840ezPiY2Sd0A1Y/jDO7fiViC3cxxVYTsHwFw0CXg8GeontfHXn5lVRNGJx/BSH
 Eg4Wf/MjwAsw4gv7dMTwer/CW+zkylvjbsXW74pRxxSeOwsbap5aqpOFbEKPH91rpNtG8vy
 uWOKE5IfBvWETADlYS33A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0shy1hTtKwA=:l+c7txhUebPH1G4Ug3L3jb
 ZvKf1qrTVwqtUCJpCgSovlzsPKKHcje5o3MNOmb2XsTH5LgHqUVyPjKH0MYA+beVfjQLiFLYL
 VvYA+F/08SXpwaM5kmN/s1oXP3uh7y6jl/IZaaPad/JHTPtQhrYD5jvZOeY340BGSSAWVrmlL
 ybQ4HjN3jvhe8S1dCQtKjCuqbtsAlgOxrqGDsalVtPJHJXIgMzSMt69NHxPTL6oKJQd1iS+Kv
 DZ5aOQvYrWo72q/vN4hZKo9bDlimvNm3D9zXPUSYLrQt+NOrORikaCG2tRFWx5fc0eBgMSgzR
 qaNGgCjIx2R/Zdvzo/Wx9y9v5OGuMqHhNv/2Xr+f0Hf38NMHcirylpBhck124dgIWK0/lvDkZ
 clerpevI035mI+jZudtPQOpvp8WhYkA8V+H/heR3mEncB7PbGnAUGg8Nck529JdMnGHeUG2iM
 y9/8KRgj1NIf3PPgZtEGL6S+sB97xT3qUe7gryHBDC3XbT2NAmGFldDw8kQD8x30sDxEBz6wN
 YInWVNEAZjCUo1wbZm2NlETnzfMOMXLw7Nd86xL97FWjJHVgB2ehACv/BKfJXPo/jDYv5Cm7h
 BEmT04TUhRxoHuMRBUUT0z7e59+GHgCHk4QW1zqBTNAXEzIc8qwlVjGSpDe2Js6OhBkfq4W0H
 G9TMz31ieB7GrIh8NoBPFlc6MRbUksXrH0NJ1KwsFq+6cQ09nPp/dvs6K3B/rShlG44dSRkQe
 ti5G+95wswiMTaeKYv/kSyFPHV6uqvXLoGiO7eHqyafp3EWJb1CQcDgajsdcv4oaEAuRK9GYA
 vbI3y40rQhKek5i3iqh7CrLfWdK1Jd4gR4efskRAse94d3QE/bTPmAPRXB4vkb1QmkVT7hM
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 11:23 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Bartosz,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6ba1b005ffc388c2aeaddae20da29e4810dea298
> commit: f962396ce29244d9a64f241481fa73fa370404c3 ARM: davinci: support multiplatform build for ARM v5
> date:   11 months ago
> config: arm-randconfig-r012-20200729 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout f962396ce29244d9a64f241481fa73fa370404c3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm

I don't think this is related to the patch above, but I've sent a fix anyway.

      Arnd
