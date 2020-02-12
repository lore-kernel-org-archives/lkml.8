Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6874DC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439C820714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgBLSZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:25:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44059 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLSZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:25:09 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so2874833otj.11;
        Wed, 12 Feb 2020 10:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQSPlBfsEd2wAypjHlcqXA/a/ZUcl1Otw36cJXyEZOY=;
        b=pmYk3F0HWwrc4CCBs+4RIBa93E9wXCNXJroKsuu/kEVu5CD1/N/acgKrHUdpFFwXmv
         VTUY9/+0awnZz/f4yfnYuFFQDToZ1JUZ/m7T9PLvdb0KpKOlC4fUeRRg2z3bNMOvZlBR
         mdytrans2iGS3DPGN/PH9pbZFbmFRTHqQSOil6hzMQOa/u4VGxB+9S/e8c/SojBR0vtP
         zuHsRipUogx9bqjuTLN35qYuDbM6r/xapE4f0OVmuFlWTucuRtQ+nUm2lEmfUUkWIKB3
         vE+LF/ed+SFjEq99+J0Rw53MwRGlhqQGIZK1NcJZWukbAsZ4Tv9QGXYwg70TcAWcXdcs
         bqDA==
X-Gm-Message-State: APjAAAUhYUGJNm52PgjuOt06+KoFIgZkjz8wcaKplmtP7RB6YrGE2NVA
        Yn1QIpB9JJZlQ4gnNvrCfkNDEaosg+ITMff9MIc=
X-Google-Smtp-Source: APXvYqwOCRWQPSAtw26bXb40u6ym1UwgBhm9rv03JRcVMF+mL86f5KFLBEEOsA7KRpS01Cn8ihwfY2VRuJHgRz3w2kI=
X-Received: by 2002:a9d:8f8:: with SMTP id 111mr9820405otf.107.1581531908721;
 Wed, 12 Feb 2020 10:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20200212100047.18642-1-geert+renesas@glider.be> <adba9217-352b-97a0-b1f7-d6895eb0c0d5@synopsys.com>
In-Reply-To: <adba9217-352b-97a0-b1f7-d6895eb0c0d5@synopsys.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Feb 2020 19:24:56 +0100
Message-ID: <CAMuHMdUvtbkTOQEdZ0J52CktOC7Q0gwVYos+VYv_Yet=57DvHg@mail.gmail.com>
Subject: Re: [PATCH] ARC: Replace <linux/clk-provider.h> by <linux/of_clk.h>
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

On Wed, Feb 12, 2020 at 6:30 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> On 2/12/20 2:00 AM, Geert Uytterhoeven wrote:
> > The ARC platform code is not a clock provider, and just needs to call
> > of_clk_init().
> >
> > Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thx for this Geert. Do you want me to pick this up.

Yes please. Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
