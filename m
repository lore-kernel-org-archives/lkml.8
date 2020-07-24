Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2635C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B33206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 18:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgGXS7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 14:59:37 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:60911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXS7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 14:59:37 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MXXZf-1kJ9ho2DDr-00Z0by for <linux-kernel@vger.kernel.org>; Fri, 24 Jul
 2020 20:59:35 +0200
Received: by mail-qk1-f181.google.com with SMTP id b14so7897233qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 11:59:35 -0700 (PDT)
X-Gm-Message-State: AOAM533MvEDOQwXNpnqLoEebrQ7w0NqU9Py+ev7xaqBw7HeolQPfb7XN
        wVPQRJLHegCdkapEt8Uk6y+tduHLNSTY0SVHf3g=
X-Google-Smtp-Source: ABdhPJyKb6Wqd1WSKTFcNMehoKPyqLGClBRz4E2KS6ExDlSdHrxbk5bW4l7mcXFB+ays6GQFXAhuCMSDy5RAEaM58CY=
X-Received: by 2002:a37:b484:: with SMTP id d126mr12004780qkf.394.1595617174418;
 Fri, 24 Jul 2020 11:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200724160314.8543-1-krzk@kernel.org>
In-Reply-To: <20200724160314.8543-1-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jul 2020 20:59:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2v7zB5c4_s=jaO_X_ZMULnp6Mn=0kHBr2pH-wkR06rAg@mail.gmail.com>
Message-ID: <CAK8P3a2v7zB5c4_s=jaO_X_ZMULnp6Mn=0kHBr2pH-wkR06rAg@mail.gmail.com>
Subject: Re: [GIT PULL] memory: Cleanups of memory controller drivers for v5.9
To:     Krzysztof Kozlowski <krzk@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:itd52hWriFcIEcW2GAtntHVq9murbaGq4lbRe1cv1cf1vNY3qWV
 3fJViVgfZroucfOkaz9NcDkFldUzl6wFr8prey3q6Eweb994cyJR1hP8S219JkGimIjGu4a
 zsZlKUNWMoUw73eOnM4g1pPQvRJuUyMXXAlTIyPFJUf1cZ16nCU57Yb5AmIECJSwvcCeJ+i
 Ad5aRxDJjHZLfcQoKi9Dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W4GKn/TvZo0=:LrTKZxvYaEuU3FtGqdEJjA
 y26dvd86AJs7Wa8pPqiG7AjHpIDHnSJ111Sqce21d7YS9oIOW0NjKSBouBL8BOTdQ+nLoRett
 J812aPOFinvbIBVHvC+5NWJ1n5bL29gNJeRtjRYeNZDBoLJ4LyoOeW4JPIP6sEWpK0ryRSUKK
 U74lAiFaRnq/+ajMFIykzi33OTHxvD05+v04+ymzRA7ojosC4qK63H+RNow25g+QuaSxQgw3R
 5xQBHw9a12Qi+i/ckZAAKLrWTYglWiC4YJV3UwehhyFz73y28i5sO2oTQn1E5YVoVQmqKmHHO
 rhwAggwglRHi3YQa8wv0/jhNn5t6BoNeY6cixRVtb5GnXFxmuwelTf2/QREVHtlRCRGgJxhxG
 SU5vQsy8K5eLcObObgY+nFNURseHlfzy3OscSYJShBHaJtVAJf4HXTVhOgUruf/SX/xdizb5k
 jnTW2p2zC6uNB2QEpolruosiBeQ23t0zVejrz/YPo1oYRKgdfRt01OwqXDXV5VG0jaZosRyID
 KAyKiMhF5l2aaZwCGajRtcYS7048ByfDUe/Z+4SQE4vdW8gGbZyQtfSsGjWVhp8VvtzQFjcdq
 nHjWavDl/GDXPX5zHFBcP1ivYr+dMZlAMugsVwYg5pcate5X6oZlfIbEHs8Q8qBXXkA/Nvv1x
 NjmKcRDtutKqzzG8jDEeedtmAxKF5sXE+HlJNvgYaK6Cwm7KgON6GgTWKSFbMpBda2ykP7TS8
 u/84QyC6MxY/a4UkUu2Mh9Xq8f0f7otbfvQRQ+Az3f+4KOzhXEveQzPnV2rGAVDfaccMmBCmN
 XsI5MeHzFjg128wbm/MchNxbtWiVyWS5/fn6BhS3x4Lyg11Kd9xtB8UUsyQWrryg2B9OqYFbS
 ccFOp9hPhOQXCZtDVSigU3yMRj+9S1Bqn8HerqMiINj0XTIOMRAdMIZFKGuE4KhemBDrBQNX+
 I0PKvDnrC8EA/2cFUmMwnb8vOkW/8hpRxMPr91Fy1B9gxidzOS3wA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 6:03 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Hi,
>
> First part of my patchset, with non-intrusive changes + maintainership.
>
> Best regards,
> Krzysztof
>
>
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:
>
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/memory-controller-drv-5.9

Merged into the drivers tree, thanks!

      Arnd
