Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF6CC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56CE320719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCZHvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:51:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43763 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZHvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:51:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id a6so4853097otb.10;
        Thu, 26 Mar 2020 00:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jdaus+I+p+fd20KZKudGZdW7EHNZwepZ5DDTslcmkYs=;
        b=Z70i6hwaOX9093gvMXKpdXfh6GoK9zyzm7XScawWlE94rBHfUJNubiknHgSnUh2z3m
         Z9cl2+7wKKlXFMDKZq+VEunYyScVwzLogd24F1cNjJyP5M+bb3CNavqMW39DKtn7RTUV
         KAvGjB/5F50l0yzJSVihYKaY7FfVkI+o/6JwBHIcu5aMH54Bo3XUrUwVtnFcKLQ/6Z0r
         Pr5BD9+Y+riai5mXyh3XGmr9KsDprmvElqfdarllt/jm1R0b2GyV12PWYotYFmlB8XLg
         El5bJrd82TD0octJYE/sLCuyNw36OQvn5LqvKqZos/s88p/NsJZlXwq78qKpemoOjvyy
         QCqQ==
X-Gm-Message-State: ANhLgQ3DbmSbZo4CEhNtNSrW2+3fYdpHTBqafBNu41N8CIj+JiQB8cJv
        TB9gPEiZ25tcYDknUzYkWLoOFGjP09vZ8h/ckJ9Ikg==
X-Google-Smtp-Source: ADFU+vtDZo+YnMnT18ODyK5Oq6s2sQaBsKvFfPPWch0sOUep6jOGER/17j5s1m7RkJyjpLHhvVR4oAQTZZPL/Q4o0kY=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr5285156otk.250.1585209106891;
 Thu, 26 Mar 2020 00:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <1585187131-21642-1-git-send-email-frowand.list@gmail.com> <1585187131-21642-2-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1585187131-21642-2-git-send-email-frowand.list@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Mar 2020 08:51:35 +0100
Message-ID: <CAMuHMdWQmOWQJcJ8j2akXoD1nkrq5EwWazGccoihvbQ9StU+bw@mail.gmail.com>
Subject: Re: [PATCH 1/2] of: gpio unittest kfree() wrong object
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 2:47 AM <frowand.list@gmail.com> wrote:
> From: Frank Rowand <frank.rowand@sony.com>
>
> kernel test robot reported "WARNING: held lock freed!" triggered by
> unittest_gpio_remove().  unittest_gpio_remove() was unexpectedly
> called due to an error in overlay tracking.  The remove had not
> been tested because the gpio overlay removal tests have not been
> implemented.
>
> kfree() gdev instead of pdev.
>
> Fixes: f4056e705b2e ("of: unittest: add overlay gpio test to catch gpio hog problem")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
