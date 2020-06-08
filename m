Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5624C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0AD2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiDQkzO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgFHHwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgFHHwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:52:37 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8837C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:52:37 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id z2so15816590ilq.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WV7BGV6+mEZwraMDjdp2nR5SYEH9cq5Koj6bSPDzdFg=;
        b=iiDQkzO51Ud8doQx/Fvh2frErrXLmcQWVjwu4YrZ9CdsCem3uJBtlf0qS6ZgGxg6il
         hpclaZv49UZ7Pmh1g/QoVFpBj1RwKms62u9Jam9CCMfYI4Ioo4T1qjzFYaTzuVuR3Kq3
         2YQglGzdTR1gFim4n2GLGNuhF30EPKuTm7dD76Ner6RGMNYPfv0PaMhm6X0tN88Cn8RN
         O1E8Jts4ICVCMSq86MRU942h2PwipxwDNA6tAwGs5y0243Z6YfSpavFKT/jOmeerlrEZ
         DoxzTu25LqTY6rSjPuB66MA3GM5MdbaaMkK8xcUta4aBv89kNNnUgvugET8DbmzsImT0
         QHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WV7BGV6+mEZwraMDjdp2nR5SYEH9cq5Koj6bSPDzdFg=;
        b=srQ86pJR+yKmeAuVFbubkDRDw+5CZ+64G5KVD9sHZTtEbAy8WtLlHe3OuXy+qhHYaL
         rd0PJV2JECZckXJWe2YpE/aUzBDn3jUYub2f2YSk566lpcdzJzqTHX32YZG1kqXshbAI
         VFTYw9Xkv/Bn2ozxfifBjp1vxsALOkyzvE6qQPfq0AyD8B39o4LOQYGoNGMm+1t1QILN
         WE7ydvIILHTg3nNCXRC+Wn+NW29jtvEgQb7/wApTHltuPgAZW1zROk/7Acmg8zJurFb3
         l1dvYHP9E57Evt0jn0VQ5Y5RTYaN+u1484O+Gw5QO2Irdfm/XcC7BgGaqiDWWgEy0ay+
         1s/Q==
X-Gm-Message-State: AOAM531xvo8i1B/kTW+9q+6CORWoC29KkWweZEtjgprk4D3nAlKGZoDz
        oQmwW+jg3kLjmvO4fvglLKeW7OC5u1fDRlCrNHI=
X-Google-Smtp-Source: ABdhPJz6HjW2AjMShnUHb5sUGouse+q5w4H3QF05k31/UU5NL88h0qkyrEVgMXxUvTa1t/7MDpYLI7cZU0Ra8tqVWrs=
X-Received: by 2002:a92:af44:: with SMTP id n65mr19226418ili.61.1591602757110;
 Mon, 08 Jun 2020 00:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
 <CAKb7Uvg0W_1qUjf3G4JrCb2oJgkwz4G5T6PwkyeL-rZEp4UnTw@mail.gmail.com>
 <CAOkhzLV+suVNAoyiaHKOkbwP-KKgTLEa7S8kp8+GSTLm_-wWFw@mail.gmail.com>
 <CAKb7UvgWMsLSHCayzdY7UYMVTjN3OHbH2WhKd-BP46K=r4Ra8A@mail.gmail.com>
 <CAOkhzLXZVNdpgwV=iiO0TEvLp3Hx28Zk8iYzwy5BvJ1pWi4QxQ@mail.gmail.com> <CAKb7UviB22HxSJ6j4ts=fU=J24Hh69NCBw4uHC5vsi902Pp6bA@mail.gmail.com>
In-Reply-To: <CAKb7UviB22HxSJ6j4ts=fU=J24Hh69NCBw4uHC5vsi902Pp6bA@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Mon, 8 Jun 2020 09:52:25 +0200
Message-ID: <CAOkhzLUQXAB1-=2VasSeJC9-LDgsd0Sk-pJY2LBbHaLqpcBeLg@mail.gmail.com>
Subject: xrandr: Failed to get size of gamma for output default
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Ilia

On Thu, Jun 4, 2020 at 6:13 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:

> Not sure why you bother asking questions when you're just going to
> dump nouveau anyways. This is the second time I've answered your
> questions on this very topic, I think it'll be the last too.

I tried again and removed the Nvidia-Drivers with

sudo emerge -C x11-drivers/nvidia-drivers

and installed

sudo emerge x11-drivers/xf86-video-nouveau

this works with Kernel 5.7.0!

~> inxi -G
Graphics:  Device-1: NVIDIA GP107 driver: N/A
           Display: server: X.Org 1.20.5 driver: nouveau,vesa
unloaded: modesetting resolution: 1680x1050~N/A
           OpenGL: renderer: Rasterizer v: 2.1 Mesa 19.1.4

but now xrandr no longer works.

~> xrandr -q

Screen 0: minimum 1680 x 1050, current 1680 x 1050, maximum 1680 x 1050
default connected 1680x1050+0+0 0mm x 0mm
   1680x1050      0.00*

Best
Zeno
