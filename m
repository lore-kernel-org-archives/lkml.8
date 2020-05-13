Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68727C2D11C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F8A2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhDiGu68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgEMGFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728964AbgEMGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:05:20 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61193C061A0C;
        Tue, 12 May 2020 23:05:20 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w18so3803839ilm.13;
        Tue, 12 May 2020 23:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llq+P2xS9hRnxN7VKa+cKSHtEacxqIGOmNa3rWsykFA=;
        b=OhDiGu681l8VKu/cUqlcGkDBshf0USyz3q6TF3HiFLF92uoX2JkY8MX+b91AA0P8jg
         GIXb3UVrxBSWQF5MBDGaVq6I534SKwrh8tO7fDh2xbpy3Ha/uM8MnGDuT4u4NasD0Zqt
         Fzhy7RFHuAe7uFd8Z89J9lCuxvaUMsOjNWLTkgURTTGa0CA4db7KdmDSG/evutJE81cq
         hNfzvTN1DsYwrY0QvdtEIBFkvkP2V035Atdd5CC+oqL4T6auSVXGzXK8cC3XWsrghGf5
         2t3uCsS1PSVAbe4H9fFPUByp1qvj7RspYUSfcsC4Mg08aamZO1fN2dQmspf/rddEVO6F
         sPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llq+P2xS9hRnxN7VKa+cKSHtEacxqIGOmNa3rWsykFA=;
        b=iBVXbVzxA0ffooCay+SfYr6SQlQFT0unMeqTIRO7U8m4/P5fbWwDk9jq+4EhWSPQVH
         kHEWpCtvL//ylize3jwBfeBHc0wR9WWpeerFttzMM93ssAKeAL71ZWiA+pS4nkc4LQvH
         tGMxAwmeDGB/1bs+pz6DrvDtnM7p3u6JFMrh60OdxJlv+sINL+sY0QganAdPaiasZwU3
         UQ9jwSLWW+UoCGK0yk8HlgOh5US6IzujdW2I6LitMuPuNUc0lMykI/Uq72LbyK4628xo
         nwbOPyM4VsdH6QIQ31/bV1sf9kLctj5gXYYuD4U6EehlIO6VGXB25AaZFpnamCZsqn7A
         EX3g==
X-Gm-Message-State: AGi0PuZEVfhUj2nzjjNn23ybJQCJ53GCTSOZYGPPskQMWEdZkd9xjggf
        hV6ZGHvWAs7vIUx6V/Pfdm6HhFr6mcGFtd3ZQHk=
X-Google-Smtp-Source: APiQypJ8LGalrwXglwtoCXMXoWYX/LXkemFz5zDLoFWL2/KGpTe0Vlp4vS4L8XwFx1G8nXVXhXF8bTno/TeKYkepeHQ=
X-Received: by 2002:a92:d40a:: with SMTP id q10mr1858272ilm.87.1589349919748;
 Tue, 12 May 2020 23:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com>
 <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com>
 <CADBw62rrQ=Po76qpJoUj1za9Hg=T+=eEJf=Yv3UmLFLtRZvwsg@mail.gmail.com> <CADBw62oFTV3MPuFQSL0MWyYQWy9MuhL70w5HGHPPV1EXBd3KEQ@mail.gmail.com>
In-Reply-To: <CADBw62oFTV3MPuFQSL0MWyYQWy9MuhL70w5HGHPPV1EXBd3KEQ@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 13 May 2020 01:05:08 -0500
Message-ID: <CABb+yY1gXxpU=q9xKf14uZtJz51kLJ-k2EeWsjnFRyBzR5bmgA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mailbox: sprd: Add Spreadtrum mailbox driver
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:14 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Jassi,
>
> On Thu, May 7, 2020 at 11:23 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi Jassi,
> >
> > On Thu, May 7, 2020 at 7:25 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > >
> > > On Wed, May 6, 2020 at 8:29 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > Hi Jassi,
> > > >
> > > > On Tue, Apr 28, 2020 at 11:10 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > >
> > > > > From: Baolin Wang <baolin.wang@unisoc.com>
> > > > >
> > > > > The Spreadtrum mailbox controller supports 8 channels to communicate
> > > > > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > > > > are used to send and receive messages by IRQ mode.
> > > > >
> > > > > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > ---
> > > > > Changes from v3:
> > > > >  - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'
> > > > >
> > > > > Changes from v2:
> > > > >  - None.
> > > > >
> > > > > Changes from v1:
> > > > >  - None
> > > >
> > > > Gentle ping, do you have any other comments? Thanks.
> > > >
> > > Yea, I am still not sure about the error returned in send_data().  It
> > > will either never hit or there will be no easy recovery from it. The
> > > api expects the driver to tell it the last-tx was done only when it
> > > can send the next message. (There may be case like sending depend on
> > > remote, which can't be ensured before hand).
> >
> > Actually this is an unusual case, suppose the remote target did not
> > fetch the message as soon as possile, which will cause the FIFO
> > overflow, so in this case we  can not send messages to the remote
> > target any more, otherwise messages will be lost. Thus we can return
> > errors to users to indicate that something wrong with the remote
> > target need to be checked.
> >
> > So this validation in send_data() is mostly for debugging for this
> > abnormal case and we will not trigger this issue if the remote target
> > works well. So I think it is useful to keep this validation in
> > send_data(). Thanks.
>
> Any comments? Thanks.
>
Same as my last post.

thnx
