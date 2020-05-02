Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C50C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A1A2080C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 22:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiJDoq4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgEBWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 18:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728530AbgEBWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 18:08:09 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AC3C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 15:08:09 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e8so7725198ilm.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 15:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rSrxmGMEHdAsOxIyHglPoSDFTwvwDOLa96EGkdCDTOk=;
        b=JiJDoq4kTK/JeQtyl5/8r+9eNapC1+8QWpBzpzUcg0pnLcYH+Mul5NvhokEMUU94Wj
         13Empzq7yZ1JiGicsHgxxJymc/FryFT8z6NtrloxEaDJn1oR+xyCYZp/+F2ATqtwnW6K
         Y2tps0ELayvGyeGIOJH9Spy2Wwt7P8OqIYkNqjrggE+mUZbVQxLodcw/6u2u+OXFD1Bb
         ZZNkt3RmnONSIva+efN24JMQDWVvWYDQG0VvAokwid1nf48K9dfCeTNaYd0s89YmA9OO
         LP73uPltfjKW2grljPD/hhqA4S8DBa+nn8sATUWmbdFenxldDM/VrwqTzexsbq6CXPsp
         Mlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rSrxmGMEHdAsOxIyHglPoSDFTwvwDOLa96EGkdCDTOk=;
        b=oBOGRiWPePWOSRKDDNIpGaOc9jM9T8QasvA/AYeousRMAkoBoQhUEQFgDHZULVCBCt
         Hp53oAkp41W1KxotHf36GRQPM9RUhfbfkjvYyARmRr2huJweNO3p/kwEa0VHyrx1/NV3
         zjhsvJ+xbg4zLQa0wnWdf6BwbYc4LM2ysJpw6g8gYcSwfj5UzP7V8mf67BB7Mt/OhhSz
         iDYMweQ+E5vH0+KqOkA/NiZdGk3fa9imhZtoBWWiOmoWetelD+HhaY1eQwrwM1b09SKv
         iHZFGWaq67HPtSyV9rQmzvl/bjM0wsuFDX4YnAHu4jDuycCfCTa0CofUe+hYQn44UyGC
         PA7Q==
X-Gm-Message-State: AGi0PuZ//X4uYB3DqD1Xbxnccz70KdTY//YqPhK9s0hDyLoz38pq9gqG
        9ETebI4far1RNPI6oxbJD+IG5gymaY7lmCW8guY=
X-Google-Smtp-Source: APiQypIglU/rsUA7UkfS0alL/U6tWm1DYn6R8+QV1bjHR4oo53RmWnBw8qz7r5fFurIhZFVGX+PEEjek+rQxTeyD1as=
X-Received: by 2002:a05:6e02:111:: with SMTP id t17mr9258389ilm.59.1588457288614;
 Sat, 02 May 2020 15:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200411200632.4045-1-peron.clem@gmail.com> <20200411200632.4045-2-peron.clem@gmail.com>
 <c96f31a2-6ff4-31aa-aaac-2ce9eafb3bfe@arm.com> <CAJiuCcegkNGQ7j4jcT1rBpSLqG1c-nb8g0wq+Nbvt-dGj7am2Q@mail.gmail.com>
 <CAJiuCceU662o7QGJ=mmT3pzVWK7uJUN=6+NKQnZ=Cfj9c2nw7A@mail.gmail.com>
 <d6465e7e-8e05-8b7d-16bd-f40877969089@arm.com> <CAJiuCccv2XPLY6sjcgvvrG5a8ONYHa_xn9i-YUDKUDK5a0DY=A@mail.gmail.com>
 <CAJiuCcfa9ro1V4nBzfD48cCuHpEsLaNA5P0bb-tQ3hcWUCtpkA@mail.gmail.com> <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com>
In-Reply-To: <000f26f4-3640-797f-c7f6-4b31a5e2669e@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 3 May 2020 00:07:57 +0200
Message-ID: <CAJiuCcfrMhu5Mi7YZTttw2k+hGui0GFAmOhPh_9fv4Te27M0+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panfrost: add devfreq regulator support
To:     Steven Price <steven.price@arm.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Tue, 14 Apr 2020 at 15:10, Steven Price <steven.price@arm.com> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 13/04/2020 18:28, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Steven,
> >

<snip>

> Getting a backtrace from the two occurrences, I see one added from:
>
>    (debugfs_create_dir) from [<c04633f8>] (create_regulator+0xe0/0x220)
>    (create_regulator) from [<c04681d8>] (_regulator_get+0x168/0x204)
>    (_regulator_get) from [<c04682e0>] (regulator_bulk_get+0x64/0xf4)
>    (regulator_bulk_get) from [<c04696f0>]
> (devm_regulator_bulk_get+0x40/0x74)
>    (devm_regulator_bulk_get) from [<bf00af44>]
> (panfrost_device_init+0x1b4/0x48c [panfrost])
>    (panfrost_device_init [panfrost]) from [<bf00a4d4>]
> (panfrost_probe+0x94/0x184 [panfrost])
>    (panfrost_probe [panfrost]) from [<c04ee694>]
> (platform_drv_probe+0x48/0x94)
>
> And the other:
>
>    (debugfs_create_dir) from [<c04633f8>] (create_regulator+0xe0/0x220)
>    (create_regulator) from [<c04681d8>] (_regulator_get+0x168/0x204)
>    (_regulator_get) from [<c05c1280>] (dev_pm_opp_set_regulators+0x6c/0x1=
84)
>    (dev_pm_opp_set_regulators) from [<bf00b4ac>]
> (panfrost_devfreq_init+0x38/0x1ac [panfrost])
>    (panfrost_devfreq_init [panfrost]) from [<bf00a508>]
> (panfrost_probe+0xc8/0x184 [panfrost])
>    (panfrost_probe [panfrost]) from [<c04ee694>]
> (platform_drv_probe+0x48/0x94)
>
> Both are created at /regulator/vdd_gpu

I'm preparing a new version with some clean from lima devfreq.
My working branch :
https://github.com/clementperon/linux/commits/panfrost_devfreq

Two strange things I observe:
 - After 30sec the regulator is released by OPP ???
[   33.757627] vdd-gpu: disabling
Introduce the regulator support in this commit:
https://github.com/clementperon/linux/commit/be310c37b82010e293b7f129ccdcb7=
11a2abb2ce

 - The Cooling map is not probe correctly :
[    2.545756] panfrost 1800000.gpu: [drm:panfrost_devfreq_init
[panfrost]] Failed to register cooling device
Introduce in this commit :
https://github.com/clementperon/linux/commit/0252c38fd55ad78366ac4b1714e285=
c88db34557

Do you have an hint about what I'm missing ?

Thanks for your help,
Clement
