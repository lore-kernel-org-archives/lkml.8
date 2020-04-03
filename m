Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F547C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F0F206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbgDCQ7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:59:01 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44219 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgDCQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:59:01 -0400
Received: by mail-vk1-f195.google.com with SMTP id s194so2161545vkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4DnEM+cAWQKP5FuQpPtv+EXKWtJI0ZZt3lXLyRDV4k=;
        b=QM04RCnhCV8QXlwY5/o9UQixSDcnt1RZh1HIOURMfINqGUy5aBE7HK20K1JOoCvDx6
         ryNqCNsOpgzdUfQJ8ORM2rMHHH7uIXXRh+jEM6Rg5ekXLCISJXs50+jsP5mZ1qqwGSaA
         LTuMj02wF8dW3LJanGkOSf4FHUqJQsKFm0ueyjD9Owj9sk9dDOtp9aWJ8HyhWqV8Ixqb
         ubY9nXXdw/2s+fci+v+GFvy2uTf0GXPKwzGs3IuwwRbAqeoJBuENJfgUg3Ggd/umhSh0
         npWbcIC4aiw1USTHcMKfhU1Y9WCXOeOR1LXQD8nmIqutF3B/ZUveyxayg88bPeDf0C1G
         Vfvw==
X-Gm-Message-State: AGi0PuajJQ4tblvujuXKQ1RniGwSQkxE5khEX5DdNjk89ZK+liRGzn34
        JYaDBMRxAqG3sg1brYMTC3SQrcuoGHopS+dZOl8=
X-Google-Smtp-Source: APiQypItpwWa29o7SbsLrI3WS4YGT3OFKC36zShwOBskr7UR96lF0VYZ7x/274flsv3LeQZjMNGC4VTP2lp2PHCjbSw=
X-Received: by 2002:a1f:60d5:: with SMTP id u204mr7032846vkb.55.1585933139776;
 Fri, 03 Apr 2020 09:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLWMB8rr0x4KKfqruCcTLVq4dH6nZ365auMqA1arZ57J7g@mail.gmail.com>
 <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com>
In-Reply-To: <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Fri, 3 Apr 2020 12:58:48 -0400
Message-ID: <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com>
Subject: Re: acr: failed to load firmware with Kernel 5.6. Kernel 5.5 works
 just fine.
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Zeno Davatz <zdavatz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben -- probably the ACR changes in 5.6 don't fall back nicely anymore
when there's no firmware? The load shouldn't be failed, just GR
disabled...

Zeno -- if you grab linux-firmware, it should be all better. Not sure
if you're missing it on purpose or by accident.

Cheers,

  -ilia

On Fri, Apr 3, 2020 at 11:07 AM Zeno Davatz <zdavatz@gmail.com> wrote:
>
> Hi
>
> After installing Kernel 5.6 I am getting this error:
>
> [ please send a personal CC, thank you! ]
>
> Cannot run in framebuffer mode. Please specify busIDs for all
> framebuffer devices
>
> [ 0.757317] nouveau 0000:05:00.0: NVIDIA GP107 (137000a1)
> [ 0.869775] nouveau 0000:05:00.0: bios: version 86.07.42.00.4a
> [ 0.870157] nouveau 0000:05:00.0: acr: failed to load firmware
> [ 0.870256] nouveau 0000:05:00.0: acr: failed to load firmware
> [ 0.870356] nouveau 0000:05:00.0: acr ctor failed, -2
> [ 0.870455] nouveau: probe of 0000:05:00.0 failed with error -2
>
> This used to work just fine, with Version 5.5, Gentoo/Funtoo Linux.
>
> Very strange.
>
> With Kernel 5.5 everything was fine:
>
> this is what I get with Kernel 5.5
>
> ~/.backup> dmesg | grep nouveau
> [ 0.994622] nouveau 0000:05:00.0: NVIDIA GP107 (137000a1)
> [ 1.107079] nouveau 0000:05:00.0: bios: version 86.07.42.00.4a
> [ 1.107391] nouveau 0000:05:00.0: gr: failed to load firmware "gr/sw_nonctx"
> [ 1.107494] nouveau 0000:05:00.0: gr: failed to load gr/sw_nonctx
> [ 1.107857] nouveau 0000:05:00.0: fb: 4096 MiB GDDR5
> [ 1.124158] nouveau 0000:05:00.0: DRM: VRAM: 4096 MiB
> [ 1.124268] nouveau 0000:05:00.0: DRM: GART: 536870912 MiB
> [ 1.124381] nouveau 0000:05:00.0: DRM: BIT table 'A' not found
> [ 1.124493] nouveau 0000:05:00.0: DRM: BIT table 'L' not found
> [ 1.124604] nouveau 0000:05:00.0: DRM: TMDS table version 2.0
> [ 1.124719] nouveau 0000:05:00.0: DRM: DCB version 4.1
> [ 1.124829] nouveau 0000:05:00.0: DRM: DCB outp 00: 01000f42 04620030
> [ 1.124941] nouveau 0000:05:00.0: DRM: DCB outp 01: 02011f62 00020010
> [ 1.125054] nouveau 0000:05:00.0: DRM: DCB outp 02: 02822f76 04600020
> [ 1.125166] nouveau 0000:05:00.0: DRM: DCB outp 03: 02022f72 00020020
> [ 1.125278] nouveau 0000:05:00.0: DRM: DCB outp 04: 04033f82 00020030
> [ 1.125390] nouveau 0000:05:00.0: DRM: DCB conn 00: 00001031
> [ 1.125501] nouveau 0000:05:00.0: DRM: DCB conn 01: 00010161
> [ 1.125612] nouveau 0000:05:00.0: DRM: DCB conn 02: 00020246
> [ 1.125723] nouveau 0000:05:00.0: DRM: DCB conn 03: 01000331
> [ 1.126100] nouveau 0000:05:00.0: DRM: failed to create kernel channel, -22
> [ 1.126364] nouveau 0000:05:00.0: DRM: MM: using COPY for buffer copies
> [ 1.481589] nouveau 0000:05:00.0: DRM: allocated 1680x1050 fb:
> 0x200000, bo (____ptrval____)
> [ 1.481807] fbcon: nouveaudrmfb (fb0) is primary device
> [ 1.672191] nouveau 0000:05:00.0: fb0: nouveaudrmfb frame buffer device
> [ 1.672362] [drm] Initialized nouveau 1.3.1 20120801 for 0000:05:00.0 on minor 1
>
> Kernel Config is attached.
>
> Looking forward to any help or reply.
>
> I went back to version 5.5 of the Kernel (recompiled after git
> checkout v5.5) and all is fine again.
>
> Best
> Zeno
