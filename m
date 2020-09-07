Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B6CC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE6B720757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgIGIsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:48:16 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:34670 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbgIGIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:48:14 -0400
Received: by mail-oo1-f66.google.com with SMTP id o20so824419ook.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AtYD4UoRySoM9KhU37kTz8JxnSV4bSKd+NMUzmY7q1s=;
        b=UeDd5jbBFfJC4pTiCmd1STNu8nVM3QRRTPqYREUaD47l+z5XLxUtLkBZkhRh+DFuL/
         d6CToGlyHbrWjR4lPZ2gZ3Rh6h8cIrJ7VryyCDRx5x6Vks9gdGBliAA9LwV72DF6bDcz
         CeyYqQz0A8AYc5phlCP7pJXNrFBoKwQqSn4x5iwu+yyZb64jFJeDlzHymD/n8yh3PY1L
         hC3keVFmprv1+M0gJr6cfy+g3M9UeIDsrgkv49oPisLusZvAd5mF2YWmJ1cmgT/TUth3
         J3NjcXpdC0uKgDe6i8Z99YhlXyFGBMBUCyQ2Uzdt/UI8S++/QBq/BU+EsK2zXCZAnqKh
         TJ6g==
X-Gm-Message-State: AOAM533XOLL9RtiNqhzz8oPCceTwdcuqL5957em8mVcTEkAljox4/diX
        L237BwJdgyMehfrOVJtEZB4Xp8Dt/ARV8e6OywL9eO69
X-Google-Smtp-Source: ABdhPJyQDtQfupQbcI/xUiI2iCvz/yJNxzV9OYTDWPgXBg8ae531TuVzol8RF7CReqYzvdkhvBjgZoHUGvgbNBM523E=
X-Received: by 2002:a4a:5403:: with SMTP id t3mr14453719ooa.11.1599468494094;
 Mon, 07 Sep 2020 01:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200826125259.24069-1-geert@linux-m68k.org>
In-Reply-To: <20200826125259.24069-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Sep 2020 10:48:03 +0200
Message-ID: <CAMuHMdV7AJ+HX=XhRPhZ8OCDi7BhnTC+YN8wGjGo4hbQDZzteA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Sort selects in main Kconfig
To:     linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 2:53 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Sort the list of select statements in the main Kconfig file for the m68k
> architecture, to avoid conflicts when modifying this list.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, queueing in the m68k for-v5.10 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
