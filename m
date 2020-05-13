Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58100C2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 04:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E99206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 04:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCY38xRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgEMEOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 00:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725943AbgEMEOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 00:14:10 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BBBC061A0C;
        Tue, 12 May 2020 21:14:10 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v5so8314803lfp.13;
        Tue, 12 May 2020 21:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ahCDXQiMHnFAjGQZFWa3EU/WYE096uPwzw+1hypJRg=;
        b=OCY38xRSWj2F1o83KA4utovE82g3hXfBvZAV42sOUT2WA9xFgZgT+NHWcV49WqQcKH
         aAhUgSfdSoVmS1/uje+15mzUU3blIvZbNaYXNoayRZoR03Pmv17xa3vxfcwv/O0ON+24
         O3L9o1FSlVXf8kSxrulqgNiC657j2A9Lm3880Bap+Zofwf8xkMygJcYrZxz645uLkGEP
         tqXoZ9EFyda421p5B/871cFHjm2HqyOEJVRO41Ibm1iOrenw6t68uAtxqilGiE2HiesN
         9Qg4bAqV3VbqIoQyHLO1vBcE59+WLKUKX+UH/YVQVd93VCvgo9Fzq0n5b09yIXyABtfh
         nYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ahCDXQiMHnFAjGQZFWa3EU/WYE096uPwzw+1hypJRg=;
        b=lRQ+RbzB/LW4S2X4TOqDaDbVvHzbXcz7UDmNc7Tl+5MbJTamtFg8poIjoeNd6SuHTB
         9tsfVTMPMSBZ5EqlZnHBpAjy7HfBa75/v/zxf8NTlfT8k1uvIsHunoY3SmD0boqv/+TW
         qKboSz5kjSCPav4TLnsxE6TJ2Xe9wnqCN8V/fpyorRhl/X/XXc+kcNWfpdXGqRtmF+D7
         yQgNG6WEHvls9TWsuNI4L6b7VtgcO7/UpFDkQuutwiOMaBMIKEezguKX2VHC28/506aW
         WwcYGxGaP9OhRjrcw40XLOE4pKJq6yv/SRsHBcrr5GkjMdu37Q58C/i3dE6xkS9JEJUE
         Ss/A==
X-Gm-Message-State: AOAM5319DxMzwdKJ4AhUUtAoMwxmxVXw0saRvitOLuOhI4SkmmN+665W
        DsYSHZEcM0NYZNSdSvhrFoI5ZB3bs+N6vhaXSzs=
X-Google-Smtp-Source: ABdhPJzXujhsuFrsFdx13RF+OZEnFT8Qs+NbvyPaselPPhn4Som0iftFJsRh0vz3+lb6f01KB6OMTXk1AsIs1PEYCHk=
X-Received: by 2002:ac2:5293:: with SMTP id q19mr16863434lfm.90.1589343248887;
 Tue, 12 May 2020 21:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com>
 <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com> <CADBw62rrQ=Po76qpJoUj1za9Hg=T+=eEJf=Yv3UmLFLtRZvwsg@mail.gmail.com>
In-Reply-To: <CADBw62rrQ=Po76qpJoUj1za9Hg=T+=eEJf=Yv3UmLFLtRZvwsg@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 13 May 2020 12:13:54 +0800
Message-ID: <CADBw62oFTV3MPuFQSL0MWyYQWy9MuhL70w5HGHPPV1EXBd3KEQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mailbox: sprd: Add Spreadtrum mailbox driver
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jassi,

On Thu, May 7, 2020 at 11:23 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Jassi,
>
> On Thu, May 7, 2020 at 7:25 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >
> > On Wed, May 6, 2020 at 8:29 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > Hi Jassi,
> > >
> > > On Tue, Apr 28, 2020 at 11:10 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > From: Baolin Wang <baolin.wang@unisoc.com>
> > > >
> > > > The Spreadtrum mailbox controller supports 8 channels to communicate
> > > > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > > > are used to send and receive messages by IRQ mode.
> > > >
> > > > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > ---
> > > > Changes from v3:
> > > >  - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'
> > > >
> > > > Changes from v2:
> > > >  - None.
> > > >
> > > > Changes from v1:
> > > >  - None
> > >
> > > Gentle ping, do you have any other comments? Thanks.
> > >
> > Yea, I am still not sure about the error returned in send_data().  It
> > will either never hit or there will be no easy recovery from it. The
> > api expects the driver to tell it the last-tx was done only when it
> > can send the next message. (There may be case like sending depend on
> > remote, which can't be ensured before hand).
>
> Actually this is an unusual case, suppose the remote target did not
> fetch the message as soon as possile, which will cause the FIFO
> overflow, so in this case we  can not send messages to the remote
> target any more, otherwise messages will be lost. Thus we can return
> errors to users to indicate that something wrong with the remote
> target need to be checked.
>
> So this validation in send_data() is mostly for debugging for this
> abnormal case and we will not trigger this issue if the remote target
> works well. So I think it is useful to keep this validation in
> send_data(). Thanks.

Any comments? Thanks.

-- 
Baolin Wang
