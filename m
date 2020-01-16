Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D9C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928E82073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G12enqTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgAPIoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:44:20 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33544 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAPIoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:44:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id d71so18426603qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gJg5ZRxNcTyn3n/fup2Ib0eaCQR42k4DrKQJxK1gJxw=;
        b=G12enqTe8piIdk84hriOXaCMmvMjuAV+b54nRadwgz9fnOZDPZjMVs6vyaOMZm6BhT
         RoWzO8xuYgT5kkQqno/sAIDSdLvfhCH+2P8/sapey7phZaTUWKVwMp2KtXujHD3w1rlk
         /bO6qrGSD9k/Xs7LsYwOZrmyqSeS95pmTZcsjr/W3hYr+ljqd7jmLyxVOZw/ICWeDoRR
         tYP7OmYgGPokerki2/GaxidmGPM+wINVw42Zw+k45k2T+IF0Wws2xmfXmAYdYnx3ESw5
         xhWlWlBSi5iX65Zd7PIY+HDXryTM2ykiffxi/kmIc6XBhjflgYZg79y+RB2U6uYCzIPM
         b4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gJg5ZRxNcTyn3n/fup2Ib0eaCQR42k4DrKQJxK1gJxw=;
        b=rk0MWsn5JfSQj6yKfA+yFdPvO0jFm2dem2DesKpAHFWSt2KNw4npJjV28t1OUHhL9F
         oqea2d+gLdVjLcuehc8b7FedS78hA914aBCwNQMVDHc1TC8Gt6mi1kH9IaVmshLXJR/7
         HU0XoSF8b/M/n2CWHdUcjtIAZzZfFWpslYyPj9tAa5BwRLUoVTQj0SbDHszIhF2UlRGs
         xZhAkef8zQDLRX4kd9LkDE07ciPQVxzYbYrXlHmR5ZmmMIETIFopgqx2D1lTN0rPMuJG
         z8UJfDjlIUc4Re2Hyu55lw8zxjuRonNgiuvJUaNXhXI9g7YpxjKjtB6voq3eqySp5++2
         H74g==
X-Gm-Message-State: APjAAAVBZI9/YHfT+1b8f27kbH2crI+ar1ij6TD1f3+OlvzXtt9sq99m
        F127cE8kSiZ3jMvMwFNat1jOL+i2ok1j+ztTTvaYUw==
X-Google-Smtp-Source: APXvYqzzVsXY7lf3ajp+EW83v/cLUPrf6701sXXFMVSN6cjNko4p+5PZvF5fmFE9GGnLBb9yOTy+hBPsO70Py44m5do=
X-Received: by 2002:a37:e312:: with SMTP id y18mr32326765qki.250.1579164259120;
 Thu, 16 Jan 2020 00:44:19 -0800 (PST)
MIME-Version: 1.0
References: <20200115182816.33892-1-trishalfonso@google.com>
In-Reply-To: <20200115182816.33892-1-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 09:44:08 +0100
Message-ID: <CACT4Y+bPzRbWw-dPQkLVENPKy_DBdjrbSce0f6XE3=W7RhfhBA@mail.gmail.com>
Subject: Re: [RFC PATCH] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-um@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 7:28 PM Patricia Alfonso
<trishalfonso@google.com> wrote:
> +config KASAN_SHADOW_OFFSET
> +       hex
> +       depends on KASAN
> +       default 0x100000000000
> +       help
> +         This is the offset at which the ~2.25TB of shadow memory is
> +         initialized and used by KASAN for memory debugging. The default
> +         is 0x100000000000.

What are restrictions on this value?
In user-space we use 0x7fff8000 as a base (just below 2GB) and it's
extremely profitable wrt codegen since it fits into immediate of most
instructions.
We can load and add the base with a short instruction:
    2d8c: 48 81 c2 00 80 ff 7f    add    $0x7fff8000,%rdx
Or even add base, load shadow and check it with a single 7-byte instruction:
     1e4: 80 b8 00 80 ff 7f 00    cmpb   $0x0,0x7fff8000(%rax)

While with the large base, it takes 10 bytes just to load the const
into a register (current x86 KASAN codegen):
ffffffff81001571: 48 b8 00 00 00 00 00 fc ff df    movabs
$0xdffffc0000000000,%rax
Most instructions don't have 8-byte immediates, so then we separately
need to add/load/check.
