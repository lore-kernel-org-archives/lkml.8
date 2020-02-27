Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5935EC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FBF222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgB0Ic6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:32:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32881 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgB0Ic6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:32:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id w6so2186515otk.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 00:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OeGtTXktVcqacz7cYnWdrEZYsOucMfq/ZWYQMhH1UAI=;
        b=Vg1yt3ftDzobeDLlbheHZBnRkwGlD2gpWJjHqM5Qs/TKNaPBqhYgNGOk1o7bzXZbnO
         jU4db5dj9/7aZ1GMtUKq/1ah3stww9AFEOzIpAuhkljZ5vR9pdaFqHi8nGf4gwbiUw2g
         vHvZEpAp4PVjWmyQ9dCmM2XPhd5VMYiLUeqFYUSSE4/Pt/mfiW3u8H+EpPmjt/dzR8pa
         dMUbRYT/hVH9WuwJFUA/2W4KKNDAjCOG/TfNT4TMb/D8JKJy3khRJZyr3gJDvW7piv7B
         kebLbrzyCEQqPQFqkCKC5Oqct/b+qZVl8MPJbXPZC+/+2PTgy+aQEMhZcN8cuSN9YAXi
         b24Q==
X-Gm-Message-State: APjAAAXwzB4vu8rZTLmSYIxEBZvrNkgv7crtPdDpQTYyEdlJaJn+CSSi
        7pUD8RNFsokxGJrMFBdY9cHdV3zXHWUcHJgd4nM=
X-Google-Smtp-Source: APXvYqzdoCVOtrlrzUXT8HEP1lYZ4KzJVPdQN1Q3Woonf40gMgnK+NC4wo5cm8aEXvQipTsQHhdVLVpRzTFU+2KkZBw=
X-Received: by 2002:a05:6830:10e:: with SMTP id i14mr2360889otp.39.1582792377824;
 Thu, 27 Feb 2020 00:32:57 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LNX.2.22.394.2002270908380.8@nippy.intranet>
 <a682c89d-baf2-3d3c-647f-a07b2a146c9f@linux-m68k.org> <alpine.LNX.2.22.394.2002261637400.8@nippy.intranet>
 <caa5686a-5be3-5848-fdee-36f54237ccb6@linux-m68k.org> <alpine.LNX.2.22.394.2002261151220.9@nippy.intranet>
 <73c3ad08-963d-fea2-91d7-b06e4ef8d3ef@linux-m68k.org> <20200227081805.GA5746@afzalpc>
In-Reply-To: <20200227081805.GA5746@afzalpc>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 09:32:46 +0100
Message-ID: <CAMuHMdWVVWaoHA1Tie5APYBq3Pa3s4BAoWN1jAACAZZS65UA7w@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] m68k: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Afzal,

On Thu, Feb 27, 2020 at 9:18 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> On Wed, Feb 26, 2020 at 10:42:00AM +1000, Greg Ungerer wrote:
> > > -   setup_irq(TMR_IRQ_NUM, &m68328_timer_irq);
> > > +   if (request_irq(TMR_IRQ_NUM, hw_tick, IRQF_TIMER, "timer", NULL))
> > > +           pr_err("%s: request_irq() failed\n", "timer");
> >
> > Why not just:
> >
> >                 pr_err("timer: request_irq() failed\n");
>
> The reason to use %s was that it could be automated by cocci script &
> the o/p didn't look bad. Second arg to pr_err is what cocci
> presents me & there is wide variation in the name across the tree as
> Finn noted.
>
> Excerpts from v1 cover letter [1],
>
> - setup_irq(E1,&act);
> + if (request_irq(E1,f_handler,f_flags,f_name,f_dev_id))
> +       pr_err("request_irq() on %s failed\n", f_name);
>
> [ don't get mislead by string contents used, this was for v1, just to
>  show how the result was obtained. To take care of Finn's suggesstion,
>  instead of modifying cocci & then making changes other changes over
>  that (i could not fully automate w/ cocci, and Julia said my script
>  is fine as is), it was easier to run sed over the v1  patches ]
>
> > And maybe would it be useful to print out the error return code from a
> > failed request_irq()?
>
> Since most of the existing setup_irq() didn't even check & handle
> error return, my first thought was just s/setup_irq/request_irq, it
> was easier from scripting pointing of view. i felt uncomfortable doing
> nothing in case of error. Also noted that request_irq() definition has
> a "__much_check", so decided to add it.

Most (all?) of the code calling setup_irq() is very old, and most of the calls
happen very early, so any such failures are hard failures that prevent the
system from booting at all.  Hence printing a message may be futile, as it
may happen before the console has been initialized (modulo early-printk).

Just my 2 €c.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
