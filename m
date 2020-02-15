Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4670DC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 04:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1964022314
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 04:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvFoDcYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBOErk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 23:47:40 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38800 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgBOErk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 23:47:40 -0500
Received: by mail-io1-f65.google.com with SMTP id s24so12852793iog.5;
        Fri, 14 Feb 2020 20:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qq1JsAqiCjHcNPcsxXhmdc0nETQ0QzWBRojx90PLlJU=;
        b=VvFoDcYynIy2stzEw4tKB18BCJsauZ+AfV0YOmIiF9nKGXLTfkLhww+/JkXKopTgkn
         iK4/7NeLk6x4hF6W0aW1opGzM9p+s1IQCJwh8Dcjdm4IVSpiDvZ6akg+m6StChFeAcWF
         Hh2q7Wl33hq52TsWxh7PGARsgmPfqN8RYw+dctlEK/bfJxwafmwbyhfSDgbX4zIlMDqI
         8FVS0kwjUMpV6tJDEAGPT9a0rcMfY1i2E1gLH6feO81+wg9ZKmRCwkI/RSUhq/4WS15U
         g4owFwK23i6eVSdleazq+yPmeHBQtCUe9AcJ4NA67mCMHxrwP9O7nVDREpv0dt4bdLi/
         lZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qq1JsAqiCjHcNPcsxXhmdc0nETQ0QzWBRojx90PLlJU=;
        b=diOd23NX5wH6/KnhTqMC3Byg48NpQIBLKcH50aYZa9JGDU2GhfmFN+uth1awxwZl6i
         2iwkPpPm3uaEcmyN+SN1+lSq/xDwccqau2kdwJZ6lgtjdOO0u66smTTkjEbHzH32STY5
         ufZtWugqVD2PKuUgs0+JJUBzNudnO364V0ngfegNmeeOJCqaCTi1/mehftCmAVVSAJgT
         SBHCx+bSaFQti5GYC+4GrP96BtEjX9drqqFwv5sF6qh1uCgCH6dyjFBwDSvDPf5pVb7L
         DuFCO1iuFDRNpcY4ZKS5QpliOKfGEnGqhvueCfRUrXZMY1/luEMH6IQWB8dW+aTXk6d/
         qSWQ==
X-Gm-Message-State: APjAAAUL9tfCwA5fNPJPPDlhmNgaRm3vqJema4SNwJ2oVf1mjtgpkDoi
        2y5jDkwt2rqcSW1Xgs8sGtb+vFcAAa4Qs7vKQ3M=
X-Google-Smtp-Source: APXvYqzf4RcDZyunuxJs2Ub2RQ8Gq79dlZl5MpqCbLh8XGUvgtMOKI57M3Ctdi0XYVfLmyYogCjU3fCB2/BeMTFx2Nc=
X-Received: by 2002:a05:6602:214f:: with SMTP id y15mr4934405ioy.69.1581742059344;
 Fri, 14 Feb 2020 20:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20200113051852.15996-1-samuel@sholland.org> <20200113051852.15996-3-samuel@sholland.org>
 <CABb+yY2MJ-1i0K7XVkPT3+6ac1XR9-3zf-GDNeswOMp6Zn_Ufw@mail.gmail.com>
 <72dc2074-c06d-4bdf-ca5f-b4007f492407@sholland.org> <89168ba0-a8ac-b433-3f93-412b22a9bc1a@sholland.org>
In-Reply-To: <89168ba0-a8ac-b433-3f93-412b22a9bc1a@sholland.org>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 14 Feb 2020 22:47:28 -0600
Message-ID: <CABb+yY3T1cL+E6Y1tGb5cuKLSY5m_zi=VOx4AJzuX40TMOSQTw@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mailbox: sun6i-msgbox: Add a new mailbox driver
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 9:48 PM Samuel Holland <samuel@sholland.org> wrote:
>
> On 2/12/20 8:18 PM, Samuel Holland wrote:
> > Jassi,
> >
> > On 2/12/20 8:02 PM, Jassi Brar wrote:
> >> On Sun, Jan 12, 2020 at 11:18 PM Samuel Holland <samuel@sholland.org> wrote:
> >>>
> >>> +static int sun6i_msgbox_send_data(struct mbox_chan *chan, void *data)
> >>> +{
> >>> +       struct sun6i_msgbox *mbox = to_sun6i_msgbox(chan);
> >>> +       int n = channel_number(chan);
> >>> +       uint32_t msg = *(uint32_t *)data;
> >>> +
> >>> +       /* Using a channel backwards gets the hardware into a bad state. */
> >>> +       if (WARN_ON_ONCE(!(readl(mbox->regs + CTRL_REG(n)) & CTRL_TX(n))))
> >>> +               return 0;
> >>> +
> >>> +       /* We cannot post a new message if the FIFO is full. */
> >>> +       if (readl(mbox->regs + FIFO_STAT_REG(n)) & FIFO_STAT_MASK) {
> >>> +               mbox_dbg(mbox, "Channel %d busy sending 0x%08x\n", n, msg);
> >>> +               return -EBUSY;
> >>> +       }
> >>> +
> >> This check should go into sun6i_msgbox_last_tx_done().
> >> send_data() assumes all is clear to send next packet.
> >
> > sun6i_msgbox_last_tx_done() already checks that the FIFO is completely empty (as
> > the big comment explains). So this error could only be hit in the knows_txdone
> > == true case, if the client pipelines multiple messages by calling
> > mbox_client_txdone() before the message is actually removed from the FIFO.
> >
> > From the comments in mailbox_controller.h, this kind of usage looks to be
> > unsupported. In that case, I could remove the check entirely. Does that sound right?
>
> After more thought, I would prefer to keep the check. It is fast/simple, and it
> keeps the hardware from getting into an inconsistent state. Silently dropping
> messages sounds like a poor quality of implementation.
>
If the FIFO becomes full after calling send_data(),  then
last_tx_done() should not only check remote's irq status but also
check that the data has been consumed from the FIFO locally (hence the
check becomes redundant in send_data). Otherwise the last_tx_done is
incomplete.  And you actually end up writing more code (error handling
and resubmission instead of the api managing it all transparently)

> send_data() is documented in mailbox_controller.h as returning EBUSY,
>
error is usually returned for s/w check (like mssg too big for fifo),
not h/w events.

> and I see multiple other mailbox controllers implementing the same or a similar check.
>
That it encourages next developer to repeat, is another reason to do
it right this time. Otherwise, I can live with that check in
send_data.

> If
> that is not the way you intend for the API to work, then please update the
> comments in mailbox_controller.h.
>
Mailbox implementations follow no spec. There may be prudent need to
return from send_data, but practically I haven't come across any(?)
platform that can't do without the check in send_data.

Cheers!
