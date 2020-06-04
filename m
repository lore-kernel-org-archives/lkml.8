Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E83C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC8A2063A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgFDPZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:25:58 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41026 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729396AbgFDPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:25:58 -0400
Received: by mail-vs1-f66.google.com with SMTP id a68so3751384vsd.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:25:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wQu5VmRSYNeWuQ8i5tUUigorDKnoUd980cUZ+cjZTb4=;
        b=S2l3kq1GJTOZsNXcTL+h46kQh1TepglSbipLEj3OV5FTNiepPOCfHOkQr7xO1zo6zU
         kytdKjJrpxjiUXCE1NNQT9OzdBgTL18f2Dii2I0aSmARt7nF1Sm7s1/Kw3r9QJP8O9KR
         9NIfkkvtn7XiNHlSjezos9z7LygRMFl64i7XiLcvpXfMjMHM156OMi9xMU9hfxb8jo4Z
         t4rS09/8JVPtqm7gJjlcGySSQIJhKdIk31++/lygsie6ZVRxhc57VCmHScWIDUIDFGQd
         ThrYUYw0fvHKAVc8Swhqgt1GgoeWI9nnUSdCw9lqqtLfHL8Ou3MLMdI/k58MPfr5tK1v
         l2Ww==
X-Gm-Message-State: AOAM532Dwgz5zzEYi6QH5M7U57CHSKAO4GQBCANpI6bbBbM2xEKQK4fC
        vdHqlAJ7rQvSA/BppDJAOD1oNoa4w2xWY4B3hD4=
X-Google-Smtp-Source: ABdhPJwqO+g81Sm7vWEc4Yket9tjpOnJckjtQCHgAFqLxf9gmX/lI345OEc23j2K4BGT9dlXl7YO1du334sGMfNmZ+A=
X-Received: by 2002:a67:8846:: with SMTP id k67mr3801972vsd.210.1591284355742;
 Thu, 04 Jun 2020 08:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com> <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com>
In-Reply-To: <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 4 Jun 2020 11:25:44 -0400
Message-ID: <CAKb7UvgWMsLSHCayzdY7UYMVTjN3OHbH2WhKd-BP46K=r4Ra8A@mail.gmail.com>
Subject: Re: [Nouveau] NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     Zeno Davatz <zdavatz@gmail.com>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 11:16 AM Zeno Davatz <zdavatz@gmail.com> wrote:
>
> On Thu, Jun 4, 2020 at 4:36 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> >
> > Starting with kernel 5.6, loading nouveau without firmware (for GPUs
> > where it is required, such as yours) got broken.
> >
> > You are loading nouveau without firmware, so it fails.
> >
> > The firmware needs to be available to the kernel at the time of nouveau loading.
>
> Ok, I am now trying this:
>
> /usr/src/linux> grep FIRMWARE /usr/src/linux/.config
> CONFIG_FIRMWARE_MEMMAP=y
> # CONFIG_GOOGLE_FIRMWARE is not set
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> CONFIG_EXTRA_FIRMWARE="nvidia/gp107/gr/sw_nonctx.bin"
> # CONFIG_CYPRESS_FIRMWARE is not set
> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> # CONFIG_FIRMWARE_EDID is not set
> # CONFIG_TEST_FIRMWARE is not set

There's a lot more firmware files than that ... everything in the
gp107 directory. Also this would only be necessary if nouveau is built
into the kernel. The files just have to be available whenever nouveau
is loaded -- if it's built in, that means the firmware has to be baked
into the kernel too. If it's loaded from initrd, that means the
firmware has to be in initrd. If it's loaded after boot, then the
firmware has to be available after boot.

Cheers,

  -ilia
