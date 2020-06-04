Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0AA4207D8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbgFDQNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:13:48 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:44338 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729718AbgFDQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:13:47 -0400
Received: by mail-vs1-f47.google.com with SMTP id c1so3834696vsc.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OP87Zw/IFo1icTUKy9gN1j2abZ8iJJoEohAgcxBcIRU=;
        b=nFHIGbjXORx2R4ehJxXz13LfNufSyup86CQ7JODWtc1eWLFD9QVT8+jAT8YiVBWTtA
         22/IF9pjTZItj425n/zPANeD3iz5RIDe7XtwsnHHkqQWhpHeMYw+HyirX7pQt+7ljv57
         f0AX/8Yb5DZSTIwqLBJP3mKkPT6k3tDQ1y+t35uFBm1JTeftba6+CAvezi7wJCaGXs1j
         WhXQJcH1PBayD6ILO2Xo8X1Hy/eWN/KiR6ZfM4q0bmPPhGpR1NLIxHryXcpdhVHCH8rJ
         vUjrJNPxqHqPN3KpJXOv+0CpbIx3vUG+aQ+fBVDxFdmDnM2bNFT4BFj6aQQScDXu2DKF
         QTuw==
X-Gm-Message-State: AOAM533ZjTu3qNc6Qwj/Z9fF4lPf6DaRpwp6CAgVt9ZRDtwAi+6A5L+4
        l0VoyrHpXrNkBIpke959zDl+MaDsG4ia1nNmQYg=
X-Google-Smtp-Source: ABdhPJyZmGGDLNY7IQLFjPubFoChqilyzfCrDlHMylGl4TFQjwe3hKLPiVqvAiFOFQvqjwK4eN42b6KxRFZUg2EOyi8=
X-Received: by 2002:a67:df8f:: with SMTP id x15mr4021008vsk.18.1591287226527;
 Thu, 04 Jun 2020 09:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
 <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com>
 <CAKb7UvgWMsLSHCayzdY7UYMVTjN3OHbH2WhKd-BP46K=r4Ra8A@mail.gmail.com> <CAOkhzLXZVNdpgwV=iiO0TEvLp3Hx28Zk8iYzwy5BvJ1pWi4QxQ@mail.gmail.com>
In-Reply-To: <CAOkhzLXZVNdpgwV=iiO0TEvLp3Hx28Zk8iYzwy5BvJ1pWi4QxQ@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 4 Jun 2020 12:13:35 -0400
Message-ID: <CAKb7UviB22HxSJ6j4ts=fU=J24Hh69NCBw4uHC5vsi902Pp6bA@mail.gmail.com>
Subject: Re: [Nouveau] NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 12:04 PM Zeno Davatz <zdavatz@gmail.com> wrote:
>
> Thank you, Ilia
>
> On Thu, Jun 4, 2020 at 5:25 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> > There's a lot more firmware files than that ... everything in the
> > gp107 directory. Also this would only be necessary if nouveau is built
> > into the kernel. The files just have to be available whenever nouveau
> > is loaded -- if it's built in, that means the firmware has to be baked
> > into the kernel too. If it's loaded from initrd, that means the
> > firmware has to be in initrd. If it's loaded after boot, then the
> > firmware has to be available after boot.
>
> For the time being I got it working by removing all nouveau selections
> in "make menuconfig" and by emerging "x11-drivers/nvidia-drivers"
> Version 440.82.
>
> Back on the latest Linux Kernel. Feels great ;).
>
> Linux zenogentoo 5.7.0 #84 SMP Thu Jun 4 17:47:15 CEST 2020 x86_64
> Intel(R) Core(TM) i7 CPU 960 @ 3.20GHz GenuineIntel GNU/Linux

Not sure why you bother asking questions when you're just going to
dump nouveau anyways. This is the second time I've answered your
questions on this very topic, I think it'll be the last too.

Cheers,

  -ilia
