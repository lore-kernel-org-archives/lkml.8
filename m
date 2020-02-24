Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33822C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE0B21744
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582575504;
	bh=nuaV4XO5eiIT/H0dgAWv3yFG5BIK96mVK8IsPOHBisM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=brzAU6KMqCiU2AycA3Z3KhOqDqT4Cl4nAQKouyGOoDW9xzK3mwa4CpUMTeFpT7NPf
	 /eoSW30shdyPlp42pDBKWMIlDyIoUaTDQt9KI1MherSqe26zQeYaTbcEjTAUnfZB5V
	 RM+7fJGIWuauxfrKH/d8ORDCNgIScu/S65QRoXO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBXUSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:18:23 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40431 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:18:22 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so11562575ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ton2dy5GNqJyLPJEEIDedKcsvitgM4YKPz9ezK/FmE0=;
        b=bc1jk6Z6X5J0gkzdttLCx6ihvZcpztqqdW5l9vvmxaZPW3vSAmMBFMQW8ztbsx2qQf
         enD1xQhjmUaaapmJ4YS+GQJxZDWSwnCjw16rQN4BIbIqI5pcEcoyRlwS4BBNoa+UuF7M
         8Yp8BcvIpPQz6RMk4VAm8jOL8DI1gTL1lm728=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ton2dy5GNqJyLPJEEIDedKcsvitgM4YKPz9ezK/FmE0=;
        b=lHarbtJBYVxJDFSDHcTz1PR1rOGzpELHM+c5WL0/qC2Pr5KaSUHtIK9MPgDNLKnUQD
         JdePrWPFUVpj7WkB6zgeJ2UZOkNvknHXGIBQcO3Yz0TA5WxT5PWzFyRGZDyvqWlBxErG
         2M9N8cSx0oiGsWxOEWekvMR9tbi5qOwd97DbI7vjvkR5aZcdfNGE0fdwka+S6UiU4AwT
         JzjJqzuXwt+zXgMU8l4LuCOBuzhq9FQdgaV+BQTudvkPujL9vG1V5K3uRom6TXHHXyjG
         30q2YGy6I252KDqJhTnmto5PUV7fOtShChJ1shlk6hXrqZm3hQsmTRsNApaUwvhP0hkZ
         G09g==
X-Gm-Message-State: APjAAAUqDxtBA57WbswdJFutiY8DKxeMGJ9D7Cifkabm9aonIM4fzRnw
        R/Cxy+hm/zXSHWRlWfjIUssBmY6Q3g0=
X-Google-Smtp-Source: APXvYqzWad1kcQKrVvBQ5MmNzkGOjsHQ1xAS8h4Kxqxkp/wmeztDPwDjjJcNBpBZk7S37tnxpduYjw==
X-Received: by 2002:a2e:9b05:: with SMTP id u5mr31661858lji.59.1582575500249;
        Mon, 24 Feb 2020 12:18:20 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a25sm3815985lfi.53.2020.02.24.12.18.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 12:18:19 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id x7so11580634ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:18:19 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr31671680ljb.150.1582575498886;
 Mon, 24 Feb 2020 12:18:18 -0800 (PST)
MIME-Version: 1.0
References: <CADDKRnBq6oFFfVzqDRwwx2Eoc74M7f_9Z7UCdSVmS_xGMD1wdQ@mail.gmail.com>
In-Reply-To: <CADDKRnBq6oFFfVzqDRwwx2Eoc74M7f_9Z7UCdSVmS_xGMD1wdQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Feb 2020 12:18:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh101Kcdby3UwzGWcCVELdGJoyduQ7Hwp2B6tavzx8ULw@mail.gmail.com>
Message-ID: <CAHk-=wh101Kcdby3UwzGWcCVELdGJoyduQ7Hwp2B6tavzx8ULw@mail.gmail.com>
Subject: Re: i915 GPU-hang regression in v5.6-rcx
To:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add in some of the i915 people and list.

Everything quoted below for the new participants.

              Linus

On Mon, Feb 24, 2020 at 2:52 AM J=C3=B6rg Otte <jrg.otte@gmail.com> wrote:
>
> In v5.6-rcx I sporadically see a hanging GPU.
>
> [  640.919302] i915 0000:00:02.0: Resetting chip for stopped heartbeat on=
 rcs0
> [  641.021808] i915 0000:00:02.0: Xorg[722] context reset due to GPU hang
>
> [ 2229.764709] i915 0000:00:02.0: Resetting chip for stopped heartbeat on=
 rcs0
> [ 2229.867534] i915 0000:00:02.0: kwin_x11[1005] context reset due to GPU=
 hang
>
> To recover Xorg must be killed and restarted or reboot is required.
> I've never seen this before v5.6-rcx.
>
> Best way to reproduce seem to be "heavily scrolling with the mouse wheel"
> in graphic applications. I also saw this once while video streaming in
> a browser.
>
>
> System:  Host: fichte Kernel: 5.6.0-rc1 x86_64 bits: 64 Console: tty 3
> Distro: Ubuntu 18.04.3 LTS
> Machine: Device: Notebook System: FUJITSU product: LIFEBOOK A544
> serial: <filter>
>          Mobo: FUJITSU model: FJNBB35 serial: <filter>
>          BIOS: FUJITSU // Phoenix v: Version 1.17 rv 1.17 date: 05/09/201=
4
> CPU:     Dual core Intel Core i5-4200M (-MT-MCP-) cache: 3072 KB
>          clock speeds: max: 3100 MHz 1: 1127 MHz 2: 964 MHz 3: 1034
> MHz 4: 984 MHz
> Graphics:Card: Intel 4th Gen Core Processor Integrated Graphics Controlle=
r
>          Display Server: X.Org 1.19.6 drivers: modesetting (unloaded:
> fbdev,vesa) Resolution: 1366x768@60.00hz
>          OpenGL: renderer: Mesa DRI Intel Haswell Mobile version: 4.5
> Mesa 19.2.8
>
>
> Thanks, J=C3=B6rg
