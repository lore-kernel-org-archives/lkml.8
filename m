Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03996C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54E220812
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP7bUKOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgEVDsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgEVDst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:48:49 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B116CC061A0E;
        Thu, 21 May 2020 20:48:49 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q129so848780iod.6;
        Thu, 21 May 2020 20:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIP2diEvzhm2AdN/Mxqa8HFPuNr8GL8GdM4WtK2bHt8=;
        b=RP7bUKOja78unJmtL//FaC43ciXZEhEsCeSwFvs4nAHMrjEEGBzp9Q37CHRKKjX5uJ
         I3OYdQjlyHOeLF1/fFBpkCrH7S6p8joOnfozfqfm0fm5KjEAI+spE0kDRf9jXaOviuWA
         UtCICHYp+7kjypw4IWX7dw3steiHeuggnS7j1wKi9OEDrI5d2DkJ7TUZtgNMO3C2l1MG
         aynbN33Icim2XL/IAYnCtX+z4s9TcYksL3N16IZTuYQcKPSiBOgYNaN869be+qloyvEo
         WhUZAAue/metKXimkaOKFUTevbHCojnVwatT5zLvPxxwyW/sfCeH5JVsa0e8WOUlvIjl
         4vUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIP2diEvzhm2AdN/Mxqa8HFPuNr8GL8GdM4WtK2bHt8=;
        b=tNgYCpfcbZsx3/a3tbnr+IK0QbkA1QDyrZ3rC4GJGrna58bcwv60UNmpWf2cUJ2BuL
         22/2gS3MGBlD8aQzFKgb226hy9THBiR+MGg7Ed9eTTcBjGF3URPZDYSykf0m9m9rH0TS
         HQr1c8BGkVivMPZgI6dvpLxfvnxN3G+YV7kSaDaTqihB/GlWMdnfaTUwO/BRSb5RiunZ
         GTqomdS47j4h4yeLEEccRQMJB7pSI33d7UmcKQ2mrXlfe75EARTpNDXjYZ/Pa6QR9SkW
         bCp/QOxBtHkpfB/bNDL+StwwJJdaB5CJVNnCskv48vQsyLNOXEcVMzD9IirQjxT5wxga
         UqJQ==
X-Gm-Message-State: AOAM530on3/zVeySYxIAIxASmp2NYvvl0gkuwESzyzOAxDjj3WVWi/At
        1Vec0QMv83goEYyjXCdQAU6vchckSZSh6mAPRND5PcEB
X-Google-Smtp-Source: ABdhPJx+AFKC3R/jcN/8VoSvvRx56ajr8mq3M4L+d0/fy22KFOOtVQAroBPRqS+PchdcjU/H1D+0L75bduAVSXZdr1M=
X-Received: by 2002:a5e:9807:: with SMTP id s7mr1534629ioj.27.1590119329011;
 Thu, 21 May 2020 20:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com>
 <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com>
 <CADBw62rrQ=Po76qpJoUj1za9Hg=T+=eEJf=Yv3UmLFLtRZvwsg@mail.gmail.com>
 <CADBw62oFTV3MPuFQSL0MWyYQWy9MuhL70w5HGHPPV1EXBd3KEQ@mail.gmail.com>
 <CABb+yY1gXxpU=q9xKf14uZtJz51kLJ-k2EeWsjnFRyBzR5bmgA@mail.gmail.com>
 <CADBw62oFDrruSq+Rm=hXHZYn0qDrr47cNK4Wj0_A-jG1dOT+kw@mail.gmail.com> <CADBw62rZuhaeSEppy+AhSkv1uNgaj9qrHFf7pz9nwKm8q3OrTA@mail.gmail.com>
In-Reply-To: <CADBw62rZuhaeSEppy+AhSkv1uNgaj9qrHFf7pz9nwKm8q3OrTA@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 21 May 2020 22:48:37 -0500
Message-ID: <CABb+yY244ZCOk5kDtOR0oEYajwUVbXoSZdNiid__UuYbU=yB-Q@mail.gmail.com>
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

On Thu, May 21, 2020 at 7:24 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Jassi,
>
> On Wed, May 13, 2020 at 2:32 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > On Wed, May 13, 2020 at 2:05 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > >
> > > On Tue, May 12, 2020 at 11:14 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > Hi Jassi,
> > > >
> > > > On Thu, May 7, 2020 at 11:23 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > >
> > > > > Hi Jassi,
> > > > >
> > > > > On Thu, May 7, 2020 at 7:25 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, May 6, 2020 at 8:29 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Jassi,
> > > > > > >
> > > > > > > On Tue, Apr 28, 2020 at 11:10 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > > >
> > > > > > > > From: Baolin Wang <baolin.wang@unisoc.com>
> > > > > > > >
> > > > > > > > The Spreadtrum mailbox controller supports 8 channels to communicate
> > > > > > > > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > > > > > > > are used to send and receive messages by IRQ mode.
> > > > > > > >
> > > > > > > > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > > > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > > > ---
> > > > > > > > Changes from v3:
> > > > > > > >  - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'
> > > > > > > >
> > > > > > > > Changes from v2:
> > > > > > > >  - None.
> > > > > > > >
> > > > > > > > Changes from v1:
> > > > > > > >  - None
> > > > > > >
> > > > > > > Gentle ping, do you have any other comments? Thanks.
> > > > > > >
> > > > > > Yea, I am still not sure about the error returned in send_data().  It
> > > > > > will either never hit or there will be no easy recovery from it. The
> > > > > > api expects the driver to tell it the last-tx was done only when it
> > > > > > can send the next message. (There may be case like sending depend on
> > > > > > remote, which can't be ensured before hand).
> > > > >
> > > > > Actually this is an unusual case, suppose the remote target did not
> > > > > fetch the message as soon as possile, which will cause the FIFO
> > > > > overflow, so in this case we  can not send messages to the remote
> > > > > target any more, otherwise messages will be lost. Thus we can return
> > > > > errors to users to indicate that something wrong with the remote
> > > > > target need to be checked.
> > > > >
> > > > > So this validation in send_data() is mostly for debugging for this
> > > > > abnormal case and we will not trigger this issue if the remote target
> > > > > works well. So I think it is useful to keep this validation in
> > > > > send_data(). Thanks.
> > > >
> > > > Any comments? Thanks.
> > > >
> > > Same as my last post.
> >
> > I think I've explained the reason why we need add this validation in
> > my previous email, I am not sure how do you think? You still want to
> > remove this validation?
>
> Gentle ping.
>
> As I explained in previous email, this validation is for an unusual
> case, suppose the remote target did not fetch the message as soon as
> possile, which will cause the FIFO overflow, so in this case we  can
> not send messages to the remote
> target any more, otherwise messages will be lost. Thus we can return
> errors to users to indicate that something wrong with the remote
> target need to be checked.
>
> So this validation in send_data() is mostly for debugging for this
> abnormal case and we will not trigger this issue if the remote target
> works well. So I think it is useful to keep this validation in
> send_data(). What do you think? Thanks.
>
I still think the same as before.
You should do this check before you call mbox_chan_txdone() and wait
if busy ... which is exactly the purpose of txdone().
It seems harmless to be paranoid and place a block of code in
practically "if 0", but that sets bad precedence for other drivers. So
please move the check before txdone().

thanks.
