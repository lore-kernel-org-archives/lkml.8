Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E420BC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CDE206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgAQOIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:08:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34965 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgAQOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:08:46 -0500
Received: by mail-ot1-f65.google.com with SMTP id i15so22629231oto.2;
        Fri, 17 Jan 2020 06:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+Kvtznk/wQ3RQceXPlbXNebs+cmr/OsrKXgAi73pC8=;
        b=DxcJfHheUQ5tBzDKkzHorgR2gcLXoI0PCm4JF6jNBJ1PuJkeQCpVl3G4IK+c3Cr2+7
         hDwIEIzmoHiZiHJLrYSUQK5PSRyv6igMbeC5Nm6VgMRyTqfyAu6qlvV/XdDjJffzY3S1
         YFhcZYlmx1G4xc9rTVJDxBOmH883izdab+qlcMTTHVjtOZ5SUDDbOkpzfd/ZGG0/V2sT
         R7FNGoRK1iUXzIBoKhrR3T7vD5sUB463qsrqRgv4v/niD6blgjmvNPCCRUkUFhq8NYcn
         0N4DS+Az75mNGyA6LowGE1pE/j+ly5TlFFeEMA2Qx4z9fIJfw4tKdb/QZRlkv0jEFzGK
         s9Cw==
X-Gm-Message-State: APjAAAVScXDUCPVkUvcigxJapPyD9OBce1/z23/Oxvi7yTJDhq8U1FkF
        kWYIj3qVYjjVWm6T3jZBm+XlPzlzq/zdFygFIuE=
X-Google-Smtp-Source: APXvYqwfyMoS4OLZbI0D8YiBzxm1g6GgAYSbLMjZHjS79Rgj58kvMeYupqdn8up0R2mIakaN+MsqQVPiWg9tYoEVsD0=
X-Received: by 2002:a05:6830:2141:: with SMTP id r1mr6202897otd.39.1579270125929;
 Fri, 17 Jan 2020 06:08:45 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200116145157eucas1p2401abc6b00654d767e872edbd0338957@eucas1p2.samsung.com>
 <d98fea18-b72e-6d0f-33ac-1421738bd12b@samsung.com>
In-Reply-To: <d98fea18-b72e-6d0f-33ac-1421738bd12b@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 17 Jan 2020 15:08:34 +0100
Message-ID: <CAMuHMdVxesjdmL7asPwOP2xoS6quLs4-onT80afi7ui2GSZ-tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] video: fbdev: sh_mobile_lcdcfb: add COMPILE_TEST support
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 3:52 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Add COMPILE_TEST support to sh_mobile_lcdcfb driver for better compile
> testing coverage.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
