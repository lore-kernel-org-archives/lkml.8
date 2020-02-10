Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AE2C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC8320838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgBJLQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:16:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34811 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgBJLQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:16:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so5958028otf.1;
        Mon, 10 Feb 2020 03:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKVhR2mFwQgeH/9Gxx4fnwbgR6TAEIa6JPWCDLORAb4=;
        b=BnceRyGxptGWGs0kUlnDOXP8zwRvmqKOu+KiObK4u4Bl8xpJk5zP+OPccNOV0cpCyi
         ipOloNsdRDo3dsvcWbzJuLYuGeL/XVr0kM5Rt5Q1pyJNWT8O1jpRP0BEDl2OlpH1/Vjx
         rkO1pm47NU958WrtxrU//iw7mvhn8FcAVFZp9PQ3sj9XNMiXfHRgISwzpI6GGcFz2v+7
         RmuEBGSC0J3P6G6ZjfMx4nzNx9Amj++ijtDdcFxjGDLoW7PT/v3ILc4Jf60/pbp/onAP
         aNfHBu+d0OfcJGQvLPv6YMqpjEFwFFb9m9BGLphBHvv+ZC8y3OZLlm8w9vCHTgnby6ZD
         WM8Q==
X-Gm-Message-State: APjAAAVuBlWRp8GJ+q3baTS+zfk2CTrrp1vSiAxRek+1Thme3tGfzl49
        vany5/HME2W9Jmh0WjGEG9cD9pW8kEQsheO8X/TfYg==
X-Google-Smtp-Source: APXvYqy50qEuo7H8b9HJRYda1PYKNff3sjS4hdtlwXuFNfX/CyEbejUP7FIORnAyZUGVYMwdH4wvME0i9Ciix7WNfjg=
X-Received: by 2002:a9d:8f8:: with SMTP id 111mr619212otf.107.1581333401855;
 Mon, 10 Feb 2020 03:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20200112165613.20960-1-geert@linux-m68k.org>
In-Reply-To: <20200112165613.20960-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Feb 2020 12:16:30 +0100
Message-ID: <CAMuHMdVzW_6J-gUWG44JDAKMxCos84XrvaNU3+6Qd5ZCT9U8gw@mail.gmail.com>
Subject: Re: [PATCH 0/3] dio: Miscellaneous cleanups
To:     Philip Blundell <philb@gnu.org>
Cc:     "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 5:56 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> This patch series contains miscellaneous cleanups for the Zorro bus
> code.
>
> Geert Uytterhoeven (3):
>   dio: Make dio_match_device() static
>   dio: Fix dio_bus_match() kerneldoc
>   dio: Remove unused dio_dev_driver()

Thanks, applied and queued for v5.7.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
