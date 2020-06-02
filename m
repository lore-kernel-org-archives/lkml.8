Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD724C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9039420663
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFBUAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:00:44 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:51685 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:00:43 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MyK9U-1im34I00Bo-00ygd9 for <linux-kernel@vger.kernel.org>; Tue, 02 Jun
 2020 22:00:42 +0200
Received: by mail-qk1-f179.google.com with SMTP id v79so13778407qkb.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:00:41 -0700 (PDT)
X-Gm-Message-State: AOAM530R0sKYhwt8iK+GL5I+ub2ulvT69OVSSe0f5QhFPrS0Qk7zjvSj
        Kj6gH5BrSiJKNRwO15Bf06gD/DeCJkMOHHQXiV4=
X-Google-Smtp-Source: ABdhPJyB5+r7g3bHdXBxRdOOYP+7Rw0T2HuVg/Rbf+3oEj8ADNCBgrexKnNOpu+oGkSnzC4SnXDxD46Jw/blC+iUP8E=
X-Received: by 2002:ae9:c10d:: with SMTP id z13mr24759360qki.3.1591128040882;
 Tue, 02 Jun 2020 13:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <1583603819-9651-1-git-send-email-santosh.shilimkar@oracle.com> <8750635a-37de-f4d0-08b1-16e904be2de7@oracle.com>
In-Reply-To: <8750635a-37de-f4d0-08b1-16e904be2de7@oracle.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Jun 2020 22:00:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1v7V=980HasrQ8t96mLG3wHWW1SXwbXDL5o=F1oFd-Fg@mail.gmail.com>
Message-ID: <CAK8P3a1v7V=980HasrQ8t96mLG3wHWW1SXwbXDL5o=F1oFd-Fg@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: Keystone DTS updates for 5.7
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Kevin Hilman <khilman@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mEoBN5p95MB5V5bZp+wNqn2bN/3zZceietOTAhqGMW9qPJdvVL3
 MR5/wL9wGso6tSG2I/22LPWGTM3IoPdaBpQyYH+XDVYwD1RxMf0A/KZPLwKKllTIMTW8cyQ
 lC6E37UL8DpHUl/eNDudwtpZL5HWi6vpFmxogjyqvjunxFpUHLl8k7kxZoIuxOkQwnWOEu6
 v9YalmmEheAqzvLnlc6xw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VPDAF7SBqC8=:FRxcJDAru4WEcgx0NSJlkK
 umDi9WI73G+W5y41YlXis+AfaxPWWVoB06iWBC/J4tCOp4frgvaNyIpX6Y/q/x2sqL8s8qQ/+
 jy0TuGK0xQ9zOZD5GzoY2ajnWenEahLb8OTbTgpEo5OnPWJ4oEJFaSDN1Fji9vVaoirUMjl+M
 eBrfmLEgoJe3ylVHyCrkeOMSfbK50HXol5cMA5BX775r8iM3F7n3n2vq9476LdY4O9iwICQjE
 AUY/caQjvku/cqP2duOcWAKW07PrGrQPZMvLeEJlK2bqy57FjN/GHGMqayK6Goav1UJbRlrQo
 3EBC5UBdZEpfcIwFM+vhNlY+S5AsB9lBu+feQ2jFdVmSLtjhFcw1JXx9FiKfSycTkHJGpR+/+
 +KQyqMbDoECinfZ48OpVD/8eaEqwIXMMAYPqlFNFJx2xDTnaRbarXRmpgKbhIIzTJaJgbQdMV
 PB4EvHY/emTO3ev8YS6B/KHPBEk8jAPWysvBWFwItAyXdsYhTzux9gaTSn/nFMQdAv4Cjpag9
 XRo4Ihno1bCEHGq5b5mtnXM3v4IVel36I7aAJW1B96ePyj77bmeogq6vcI/5k2xleRqp6CYix
 AYuTt+l3xgZJ5+Ekyi/Upkm5yk7cJxzpjV7sAkndgn+2j7VA1HEUtgYsMokqJUTu+V50rK4h+
 FCdTpOB6LuiTThClqXgtSHcw/UWca+2gYnLVGaobgYNWMaoPw5dL0Pm9t5B889sTxypqZWWAL
 a0cesNw9igKo8b0Yip2L51p7Y4k0LT6JJBWu2esn5Lw/vv2Uz0DfH91fYvl4tmqL2Son5ctWO
 /WdWECh6N+X47E7wjqVpg+daqqN+UEP+P7yIMv0AcPKRpspJOo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 5:14 PM <santosh.shilimkar@oracle.com> wrote:
>
> Hi Arnd, Olof,
>
> On 3/7/20 9:56 AM, Santosh Shilimkar wrote:
> > The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> >
> >    Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> >
> > are available in the git repository at:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_5.7
> >
> > for you to fetch changes up to 7856488bd83b0182548a84d05c07326321ae6138:
> >
> >    ARM: dts: keystone-k2g-evm: add HDMI video support (2020-03-07 09:47:24 -0800)
> >
> > ----------------------------------------------------------------
> > ARM: Keystone DTS updates for 5.7
> >
> > Add display support for K2G EVM Board
> >
> > ----------------------------------------------------------------
> > Jyri Sarha (2):
> >        ARM: dts: keystone-k2g: Add DSS node
> >        ARM: dts: keystone-k2g-evm: add HDMI video support
> >
> >   arch/arm/boot/dts/keystone-k2g-evm.dts | 101 +++++++++++++++++++++++++++++++++
> >   arch/arm/boot/dts/keystone-k2g.dtsi    |  22 +++++++
> >   2 files changed, 123 insertions(+)
> >
> Looks like this pull request wasn't picked. Can you please check
> in case am missing something.

I pulled it now, thanks for double-checking!

The problem here was that the soc@kernel.org address was not on Cc, so
the pull request did not end up in patchwork. I try to also look for other
pull requests sent to the arm@kernel.org address, but it's much less reliable.

       Arnd
