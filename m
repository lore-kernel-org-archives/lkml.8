Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8B3C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B492B2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 11:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJLQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 06:16:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37698 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJLQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 06:16:38 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so8853224oic.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 03:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sHvRjYuAL4q04OfdHJ+J4i9kMPuAT9CKga2TRUxDO4=;
        b=OqgWAXYAyrNiJFF7BzfG808x4roWPdds2nXOkZ7Lk5OzcKdlMV4bog/P4Do/QmYTsJ
         guEJRzqCvz0F8XkU5iffMxSxEx/90xc8+cfin6VtVp9XZQyEzowf6rFMJeB/8R0MDoru
         dAWU+9VcqQgLy0E7vaV17nR5HW0moZ4/GmP7GOhdEn6d2Cvrz1d0O3t4G7ZVQnxJOtNI
         jrEfvEFBv/5Y741DJEZCyiMZD4yNcPeZLcp+7T1D5SdxGwcEfsvGV+8U4TV5ZlB7d3ns
         BqCuOdJbMqxqmUrIli/N/AsPYzuxdhIeazpO92qBnEttp8GBILjL3xtmNBQCPuDwwUhW
         dhWg==
X-Gm-Message-State: APjAAAVhRjJcZAtgHWm4akiiVxMberxp+NVSnQ+E29KqNBKxxlKtY6/e
        TZ/qid443IfI4ClOmtGnACBvo+O+33wrcwkZad0HVw==
X-Google-Smtp-Source: APXvYqxVly9H6sMpaOqTnMW9Bw7Nf5hff740J9szh6Ede/hJKAYSp6/bFoqs00kXUtv+Btr5ojSDw0VkjcRcFVMDmyw=
X-Received: by 2002:aca:b4c3:: with SMTP id d186mr463219oif.131.1581333396784;
 Mon, 10 Feb 2020 03:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20200112164949.20196-1-geert@linux-m68k.org>
In-Reply-To: <20200112164949.20196-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Feb 2020 12:16:25 +0100
Message-ID: <CAMuHMdVJuF=J3L7X6p4YWhMAEuRU5ynwYn2nwzRd+8COWPSGuw@mail.gmail.com>
Subject: Re: [PATCH 0/5] zorro: Miscellaneous cleanups
To:     linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 5:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> This patch series contains miscellaneous cleanups for the Zorro bus
> code.
>
> Geert Uytterhoeven (5):
>   zorro: Make zorro_match_device() static
>   zorro: Fix zorro_bus_match() kerneldoc
>   zorro: Use zorro_match_device() helper in zorro_bus_match()
>   zorro: Remove unused zorro_dev_driver()
>   zorro: Move zorro_bus_type to bus-private header file

Thanks, applied and queued for v5.7.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
