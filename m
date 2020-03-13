Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C5B2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJJCKJjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgCMOD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:03:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37045 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCMOD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:03:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id 6so12239359wre.4;
        Fri, 13 Mar 2020 07:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/mwCeCN5j4sHkdzkOsGGfEARJX1vOaTb5UpMNbo2tc=;
        b=EJJCKJjDYov13lHByDWOWGc4KVUJ2OLaFJSBpxzEliqhXwFjnH+JdHHJV05sch9JPV
         K0p6UXI1XBnn74Lgq6DN1x09E2rIcT+0ROYjOLbjXzpHUS5v6aJJcAjYn6P9fiWNaTJQ
         fu/fJ1aB5nME/BHGJB4VjIZACXQ/IPuWX1hfZLtXEgwMJ7Eaht9M0yaNVfQxWfb38CHC
         v8XWcp5k98EKmC+HIzqhc4q1fNbZLgwaHZFKap26jxAIwx/voaSoHYpIErbWWLi091Ph
         uMC0R+1Y3TpRTB331P50enxw7trDa2obPw2gvccF0N+3CQq+SQTE/W5X1S/qNAfCR4Eu
         CgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/mwCeCN5j4sHkdzkOsGGfEARJX1vOaTb5UpMNbo2tc=;
        b=ggCsMLGjjg8z1XRBnXNNDMXmzEhiKO45GUBpv7vyuhAE/KSRZVbo0yKr8hkXmeE8eD
         ZBBs+OU/QiX0HnaFXhUuRE3Y/3BjJYEul8DRbbofn7fpgwrNQ2NSlhjB4uviHj3vJnbG
         fHGJfgB/keA3LK5oGNvJcEWGj85ezwGQ2FHnKvVb8YsszyNEfDSKa7iBMJlCarE9kC3S
         NFLxYHCPy8OfO7QWooC9OF2le6Mxl4NjVaSLwoJHU94vP9vMdRrGyLnWSdRNwoOqoVOM
         ChsCOzTzSCJpaKQIoZxp4tW9dcMWaYvB03u8stxlJoaWTNc6TL5dYvcoAHpdaL7CVSzS
         rO0A==
X-Gm-Message-State: ANhLgQ24uDb1dzRZzq3PCAFKgOb1n0U2LXAHvlWLvTg4cLHYuMvpNEwe
        jchvCp1dvwQswLu4AwzI5h7pwYAf4YbZfurp7v4=
X-Google-Smtp-Source: ADFU+vtEiabhYMCU9TLmkj1psHVHllDAMEJhrEBsiHviseBuVp4EMhF0ZjZ4e6zM5tU855zi/B8DGheUZjAFap3RM3c=
X-Received: by 2002:adf:b35e:: with SMTP id k30mr10721282wrd.362.1584108236285;
 Fri, 13 Mar 2020 07:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200309204326.27403-1-thirtythreeforty@gmail.com>
 <20200309204326.27403-3-thirtythreeforty@gmail.com> <CAGb2v64_cWagG54iMmzmOwtUmv91xJchtzKW25M=y9DbfFDzkQ@mail.gmail.com>
 <CACmrr9hSK1CzDGQ9_v6gNF7TBH65J-QAL_pwQJdKCc4ZxF_-ww@mail.gmail.com> <CAGb2v65RJUVb4fERTi8qM=qWQuhL4QWR5WpBB7kGS4tN67++aw@mail.gmail.com>
In-Reply-To: <CAGb2v65RJUVb4fERTi8qM=qWQuhL4QWR5WpBB7kGS4tN67++aw@mail.gmail.com>
From:   George Hilliard <thirtythreeforty@gmail.com>
Date:   Fri, 13 Mar 2020 09:03:43 -0500
Message-ID: <CACmrr9i-6LSOsabQuNyJn-s-AtBHc3HxX5oDkD=_LM_0em6=yQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/5] phy: sun4i-usb: add support for the USB PHY on
 suniv SoC
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-usb <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020, 11:08 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Thu, Mar 12, 2020 at 8:06 PM George Hilliard
> <thirtythreeforty@gmail.com> wrote:
> >
> > Thanks for the review.
> >
> > On Thu, Mar 12, 2020 at 1:51 AM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Tue, Mar 10, 2020 at 4:43 AM George Hilliard
> > > <thirtythreeforty@gmail.com> wrote:
> > > >
> > > > The suniv SoC has one USB OTG port connected to a MUSB controller.
> > > >
> > > > Add support for its USB PHY.
> > > >
> > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > >
> > > Not sure why Icenowy's SoB is here. If she was the original author, you
> > > are supposed to keep her name as the author.
> >
> > So, I was unclear on the convention here.  This patch is based on her
> > patch, but I've modified it and rebased those modifications back into
> > a single change.  I'm happy to change the author field - does it need
> > a "Co-authored-by: myself" here?
>
> I suppose that really depends on how much you changed it. If it were just
> stylistic changes I'd keep the original author. Also you should list any
> changes you made to the patch by inserting
>
>     [<who>: changed foo and bar]
>
> before your SoB.

Ok, this makes sense. Thanks. I'll send another series. The few that
are stylistic, I believe I retained Icenowy as the author. Where I
modified them, I put myself (so people email me, not her, with
problems).  I'll modify the commit messages like you describe and
double check the authorship.

> As for the Co-authored-by, I haven't really seen it used so I don't really
> know.

Off topic, but I wish Git supported multiple authors natively.

George
