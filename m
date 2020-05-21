Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68210C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F122070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX8b5/50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgEUMYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgEUMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:24:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40FFC061A0E;
        Thu, 21 May 2020 05:24:51 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id e125so4356971lfd.1;
        Thu, 21 May 2020 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDAJOLWg9mKjJNeVSHT8m8/Fhzt9bDgS8eqSCs7Dujc=;
        b=LX8b5/50+9+WTk2veYSl1B0zyuk4I/Z1GdM/3rM5S25W0ryPYoGWL4n2K3MUYaVBNj
         R1NmCkHJjJoWcICePlNevkQvtK/y3MNjvJvNFuW6i6Nrdrrqeo5bMUhT7+ltKY3UdaoM
         uq33UGp0tPTONkG6LTUkpXOeU+ESLmdH8XViwmeucGNNiDpRG1rpdQtQBq4TEPkA7DuW
         TLM4P1Tvi1wHeaugmMWtRxBQs/snHhp3P+sL18IYA6qH2GM15fky7jofEvv6F8XpBpiU
         3sSn6wKmoU7Pl5OojnURTejuqqgcojGeGd7CjKhwzq08+tBwSqOGn+l/J24UlF0rNRBd
         kB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDAJOLWg9mKjJNeVSHT8m8/Fhzt9bDgS8eqSCs7Dujc=;
        b=TvlNrBQ2gTrPHEYoX8fJG2l5TjOuGRILJo+ctGSAE0jLwnC7hxfTvKyClqisEd03sl
         YusWFfY0qxVpJBMM1zpHLOXazoPwMz2zPA9PM5ixmhJa8i7/v4jH/yFnKqeFbWP/Gquf
         SJ2/wzJ+EVahRPa9+Pt80jpb7yuFJzeFwkKZ+XVKcYgp7VzLW5QDNIb0whWN6jvSk1mS
         10JIc+DGx3L+PzAaSqfzYPRiChd8SOJwAOdDG3o7rCFIZ6uiuxMGVULMTVOEflxHBh1/
         nv2hWkXKwo0bzWMImAs+f/GJXHbzK/hj8NUCbI0lASUP1u67cOxc5zYvSCQwMOBaMBxn
         4q0g==
X-Gm-Message-State: AOAM532LNAw+BNuoaCjTEyS3mB+ZSRThbrIGspIEVFqEkG6xYU70EAtn
        bUnHvBoqZP7cU7+7smAFRM55q57u5N2jLXB1IzM=
X-Google-Smtp-Source: ABdhPJwp/R8hnjRcGcej59N3MIfttVemdGNUrGc4anV8BfnRi1gqt5Fn4WKCNYgDEEeAvX3m9xFMKTuz/JumydwFjjQ=
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr4816668lfk.13.1590063890126;
 Thu, 21 May 2020 05:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com>
 <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com>
 <CADBw62rrQ=Po76qpJoUj1za9Hg=T+=eEJf=Yv3UmLFLtRZvwsg@mail.gmail.com>
 <CADBw62oFTV3MPuFQSL0MWyYQWy9MuhL70w5HGHPPV1EXBd3KEQ@mail.gmail.com>
 <CABb+yY1gXxpU=q9xKf14uZtJz51kLJ-k2EeWsjnFRyBzR5bmgA@mail.gmail.com> <CADBw62oFDrruSq+Rm=hXHZYn0qDrr47cNK4Wj0_A-jG1dOT+kw@mail.gmail.com>
In-Reply-To: <CADBw62oFDrruSq+Rm=hXHZYn0qDrr47cNK4Wj0_A-jG1dOT+kw@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 21 May 2020 20:24:36 +0800
Message-ID: <CADBw62rZuhaeSEppy+AhSkv1uNgaj9qrHFf7pz9nwKm8q3OrTA@mail.gmail.com>
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

On Wed, May 13, 2020 at 2:32 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> On Wed, May 13, 2020 at 2:05 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >
> > On Tue, May 12, 2020 at 11:14 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > Hi Jassi,
> > >
> > > On Thu, May 7, 2020 at 11:23 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > >
> > > > Hi Jassi,
> > > >
> > > > On Thu, May 7, 2020 at 7:25 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > > > >
> > > > > On Wed, May 6, 2020 at 8:29 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > >
> > > > > > Hi Jassi,
> > > > > >
> > > > > > On Tue, Apr 28, 2020 at 11:10 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > >
> > > > > > > From: Baolin Wang <baolin.wang@unisoc.com>
> > > > > > >
> > > > > > > The Spreadtrum mailbox controller supports 8 channels to communicate
> > > > > > > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > > > > > > are used to send and receive messages by IRQ mode.
> > > > > > >
> > > > > > > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > > ---
> > > > > > > Changes from v3:
> > > > > > >  - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'
> > > > > > >
> > > > > > > Changes from v2:
> > > > > > >  - None.
> > > > > > >
> > > > > > > Changes from v1:
> > > > > > >  - None
> > > > > >
> > > > > > Gentle ping, do you have any other comments? Thanks.
> > > > > >
> > > > > Yea, I am still not sure about the error returned in send_data().  It
> > > > > will either never hit or there will be no easy recovery from it. The
> > > > > api expects the driver to tell it the last-tx was done only when it
> > > > > can send the next message. (There may be case like sending depend on
> > > > > remote, which can't be ensured before hand).
> > > >
> > > > Actually this is an unusual case, suppose the remote target did not
> > > > fetch the message as soon as possile, which will cause the FIFO
> > > > overflow, so in this case we  can not send messages to the remote
> > > > target any more, otherwise messages will be lost. Thus we can return
> > > > errors to users to indicate that something wrong with the remote
> > > > target need to be checked.
> > > >
> > > > So this validation in send_data() is mostly for debugging for this
> > > > abnormal case and we will not trigger this issue if the remote target
> > > > works well. So I think it is useful to keep this validation in
> > > > send_data(). Thanks.
> > >
> > > Any comments? Thanks.
> > >
> > Same as my last post.
>
> I think I've explained the reason why we need add this validation in
> my previous email, I am not sure how do you think? You still want to
> remove this validation?

Gentle ping.

As I explained in previous email, this validation is for an unusual
case, suppose the remote target did not fetch the message as soon as
possile, which will cause the FIFO overflow, so in this case we  can
not send messages to the remote
target any more, otherwise messages will be lost. Thus we can return
errors to users to indicate that something wrong with the remote
target need to be checked.

So this validation in send_data() is mostly for debugging for this
abnormal case and we will not trigger this issue if the remote target
works well. So I think it is useful to keep this validation in
send_data(). What do you think? Thanks.

-- 
Baolin Wang
