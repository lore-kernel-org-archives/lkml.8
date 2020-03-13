Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74263C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4044320746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCMEIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:08:06 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37622 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCMEIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:08:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id b23so10267712edx.4;
        Thu, 12 Mar 2020 21:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDox/6vLEM6w6LLKrtTgN8Ke1yzgs6JPxhSC2EqD6Jg=;
        b=UrspklO559xZkVJiyzSChTOUwCj520pc0OfO9Wqb9HMTNk3wJDHxUYgzmULCnatLE+
         m5GHQjyBzD5ggU362THPVni45o1y1TuCOZRzLHP4z7ZkLf+PUw1iT7PyrP759fanDkzP
         vmdLBoa8njn+TK+W91QY3R9IicvfIjuoP+5X3/APbvGAKWbT0uOepTl6DQzjDqWqzpgH
         v5mdxel9gIuKKouio6Fw+wO2jaqciV//QRI6/SdzUcWcxpqyeljYIMNkRHISKOe0CGvx
         PMZO6aVO21uYDIz8NH1hcM6Z+VoxbGeJL3S37VNHF2AXpbKDj/MCws6RLey+DDsHLvfd
         BGSA==
X-Gm-Message-State: ANhLgQ1y3egz5WAWw6zriZEajEOrGfuny+D8/fU8Y2e1tGOEYc6PQB6s
        p2NCAJvtGQ6TJtDeuROHhG9XygcTj2c=
X-Google-Smtp-Source: ADFU+vuk4ttAN2oQwh1V8Pu3jzXTECde1dUCdklUdLjpdNo0D5VcaL7eP+zGescKRE6mAWCYUswdeQ==
X-Received: by 2002:aa7:c2cc:: with SMTP id m12mr11316407edp.11.1584072481138;
        Thu, 12 Mar 2020 21:08:01 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id cx3sm3700926edb.75.2020.03.12.21.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 21:08:01 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id n8so8435987wmc.4;
        Thu, 12 Mar 2020 21:08:00 -0700 (PDT)
X-Received: by 2002:a1c:9816:: with SMTP id a22mr8906345wme.16.1584072480383;
 Thu, 12 Mar 2020 21:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200309204326.27403-1-thirtythreeforty@gmail.com>
 <20200309204326.27403-3-thirtythreeforty@gmail.com> <CAGb2v64_cWagG54iMmzmOwtUmv91xJchtzKW25M=y9DbfFDzkQ@mail.gmail.com>
 <CACmrr9hSK1CzDGQ9_v6gNF7TBH65J-QAL_pwQJdKCc4ZxF_-ww@mail.gmail.com>
In-Reply-To: <CACmrr9hSK1CzDGQ9_v6gNF7TBH65J-QAL_pwQJdKCc4ZxF_-ww@mail.gmail.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 13 Mar 2020 12:07:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v65RJUVb4fERTi8qM=qWQuhL4QWR5WpBB7kGS4tN67++aw@mail.gmail.com>
Message-ID: <CAGb2v65RJUVb4fERTi8qM=qWQuhL4QWR5WpBB7kGS4tN67++aw@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/5] phy: sun4i-usb: add support for the USB PHY on
 suniv SoC
To:     George Hilliard <thirtythreeforty@gmail.com>
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

On Thu, Mar 12, 2020 at 8:06 PM George Hilliard
<thirtythreeforty@gmail.com> wrote:
>
> Thanks for the review.
>
> On Thu, Mar 12, 2020 at 1:51 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Tue, Mar 10, 2020 at 4:43 AM George Hilliard
> > <thirtythreeforty@gmail.com> wrote:
> > >
> > > The suniv SoC has one USB OTG port connected to a MUSB controller.
> > >
> > > Add support for its USB PHY.
> > >
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >
> > Not sure why Icenowy's SoB is here. If she was the original author, you
> > are supposed to keep her name as the author.
>
> So, I was unclear on the convention here.  This patch is based on her
> patch, but I've modified it and rebased those modifications back into
> a single change.  I'm happy to change the author field - does it need
> a "Co-authored-by: myself" here?

I suppose that really depends on how much you changed it. If it were just
stylistic changes I'd keep the original author. Also you should list any
changes you made to the patch by inserting

    [<who>: changed foo and bar]

before your SoB.

As for the Co-authored-by, I haven't really seen it used so I don't really
know.

ChenYu

> > >
> > >  static const struct of_device_id sun4i_usb_phy_of_match[] = {
> > > +       { .compatible = "allwinner,suniv-f1c100s-usb-phy",
> > > +         .data = &suniv_f1c100s_cfg },
> > >         { .compatible = "allwinner,sun4i-a10-usb-phy", .data = &sun4i_a10_cfg },
> >
> > Please use the same style (and ignore checkpatch.pl on this one).
>
> Very happy to change this, it was bugging me!
>
> George
