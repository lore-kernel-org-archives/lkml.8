Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EEDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8A42068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgFCR7x convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:59:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCR7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:59:52 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M9nAB-1jamNX0RuP-005nAB for <linux-kernel@vger.kernel.org>; Wed, 03 Jun
 2020 19:59:50 +0200
Received: by mail-qk1-f176.google.com with SMTP id s1so3082743qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:59:49 -0700 (PDT)
X-Gm-Message-State: AOAM5321aLxvmfE/DXuID+sHHyLoP+zRHWV0rjYRqvoRAYpu5zuZjGOa
        uvfu/q1cZTKdGOecLrQZByDH+Oivv7ckOWP8oAI=
X-Google-Smtp-Source: ABdhPJzTHGNxXz9Y2OgjZ+AxzjYxutmfQtK6aB/jaKRaqgf61qn7jATyuMAHov4Ykh6j8kV7wzS13i1L0Vrpzi2hers=
X-Received: by 2002:a37:554:: with SMTP id 81mr893516qkf.394.1591207188929;
 Wed, 03 Jun 2020 10:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net> <20200603170357.GG1079@brightrain.aerifal.cx>
In-Reply-To: <20200603170357.GG1079@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 3 Jun 2020 19:59:32 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2QYkZ9StDssxeZ3_zR5OH_P3v-D1iZp7=1E+2EaqoNcQ@mail.gmail.com>
Message-ID: <CAK8P3a2QYkZ9StDssxeZ3_zR5OH_P3v-D1iZp7=1E+2EaqoNcQ@mail.gmail.com>
Subject: Re: headers_install builds break on a lot of targets?
To:     Rich Felker <dalias@libc.org>
Cc:     Rob Landley <rob@landley.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:509lhx/+nAeWqSW3y/p4K0Bzqt8e/x2/Rr7sv00JSE8oGSAF2UC
 pnHr2r8x6LlAIbgrnTysIn6J/jm8ZQj0u+Ng5KJFMoXkSzBehI7cyT7vPeCyUgnL3eGFns8
 p4xFwG3Sbf1p9H9hqZY39AogEHgdRojl0vErbAoFOrPYevVINZ0GCvh2hFE7dwSvplVEB0O
 lHHlQ73rrqGiHNOmydrUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:waplYHj4hMA=:pV9szddLVY2WQRTAt7xvbC
 AMFeSp9KJtahs9mSdRuRZqDXnweJ4ky4MQNfIkcUagekFEgaHpoT5G4LctGlFL0zh41DFrT0l
 LSMgEv7IP6ztwaYBtu3BAEiEE1iwhrLWM0Vb45A7u69hj+vgvkSSm+0ylK1D4F6BMH/5HXDzN
 mjspfdtmwtYXx2c2xALbPBvGVcLSqQ5UbxIrBT0hLrRjBaaiyj5RmO9+YeYLv9cVwC7sc5Fjc
 nMRDuDMiPI78OsCOKFq9JALzVfax0aSkn6MBf2F7XSvxcnU2Czf0dC2IbT87KtQ/TZyPmBUGI
 EQjwIB8IBrq0rHI8I2ynQIp/OhHvLnNJ+4iYtE8yu/49yor/K7fs0chYYiTh371QsCPprB3mO
 JWz4+deIZrTPM3gccBUsqjhx8u/vNFZgFLpWxKtmCGMvlaJPCvg4rycznh4GZvWG8Xg+VItZK
 rerXZD+T5TXjWg7UtORbZNzGKyttUM2IuFUVkQF6/d2ymM2b9oRbyycVSuhd4NVnbvnpHSa0c
 pgxBlekp/ZhMvkUhBuDd7WmzBMW79m1jjvAQUv3lJqh07Dr7fzk/fTiFkznP70EEnNPDcZ3kn
 wsZPkqrsKRu+CYhsvLr+dCOVL4j7Lml4J6sZLT8lvNQw8YrQcR3mftxjjODi7wMmYjf21nuHG
 3Ips1afja4pFSm5++/a3RhiE2QnfSv4X4Qoa7V8zud+UzWmIs2tEglbo9WBGhhG6GTc+tx05e
 5PiV4ROylp1bc8ZLK009weGrxqArhWoYQaoU2wxaU/8dHgoznPgi9zmCIyK9URLjvFD3MOQfM
 v5S20ZGdDt+Hr7rqUV9fSc37utg1KP9GCMawVo31KFNRmRjzW0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 7:04 PM Rich Felker <dalias@libc.org> wrote:
> On Wed, Jun 03, 2020 at 08:49:54AM -0500, Rob Landley wrote:
> >     make ARCH=$i distclean defconfig headers_install \
> >
> > On the bright side, the resulting fruitbasket.tar.xz is 1.5 megabytes. The
> > downside is I have no idea how broken the resulting header files are after this
> > error-fest:
> >
> > alpha
> > arc
> > gcc: error: unrecognized command line option ‘-mmedium-calls’
> > gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean
> > ‘-fno-stats’?
> > gcc: error: unrecognized command line option ‘-mmedium-calls’
> > gcc: error: unrecognized command line option ‘-mno-sdata’; did you mean
> > ‘-fno-stats’?
> > [...]
>
> Uhg. Surely there should be some fix for whatever mistaken dep is
> behind this? Headers shouldn't actually depend on any config/compiler
> output, should they??

The first one of the two comes from "make defconfig", which definitely needs
a working $TARGET compiler, but isn't actually needed before
"make headers_install" as I just checked.

> Or is that machinery somehow involved in
> generating the syscall lists and similar?

The syscall list for ARC is still not generated (that's on my todo list), but
something does call it even for "make headers_install".

What it does is to set Makefile variables such as

CC_VERSION_TEXT = $(shell $(CC) --version 2>/dev/null | head -n 1)
and trying out all kinds of gcc options that may or may not be supported
such as  "$(call cc-option,-fno-tree-loop-im)".

Setting CC=: avoids this, like

make -s CC=: ARCH=$i headers_install  INSTALL_HDR_PATH="$PWD/fruitbasket/$i"

      Arnd
