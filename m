Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D06C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC53206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeI4ofqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgEVNHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgEVNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:07:22 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A01AC061A0E;
        Fri, 22 May 2020 06:07:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 82so6497624lfh.2;
        Fri, 22 May 2020 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3YLmShsXHzYS+SwxvGmWk40fJ/Ku1cYbc0CTeNJEyY=;
        b=SeI4ofqcvKBWBQLeol3QjOhY8LDNHEE3pUkAVpZFjLvvKGYDLuroE4XLupIWS568qv
         D+jDVeq50I/hTYnKWdzqoflote3stbpFnMUcvJxgTpB7jNRb6utRBGuY5RZZRSD0L/4Q
         5pRFMD1h/2Yv3NYjThbgZRJZgjCtqrpdWg/foPsXULhPXvxfR8+wDSfF9RDNOjRRLuiC
         jgRiPc/92Iu6YkOc/SvA0XK3z9GQDwJkYfc2mwXvy4xEc3ht/ZNdw60JZh3BvB4LDTK5
         Qk8q6eJBMkXQMzC/KqTf6vB67GRN5ZtoOiqgHoekgcdn3C914wt9rqH8VqdiV/dta+gP
         Zo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3YLmShsXHzYS+SwxvGmWk40fJ/Ku1cYbc0CTeNJEyY=;
        b=R1oQ5AWcfNfaTRn4nd+wax4o2/RZSbcMiAy0e8ZfZJJfGa54dJnPt8UKA46q5CdGaf
         JE1ubKhEisEeA80Xe11ymDD/VmbD32hS5proQYgEQBs6gq6XKgv/qHV6FvVt0BrA1xHr
         15qdtnT9T/MTj+568rH4Jp7XhuYNoeRENRYyqaLqfKkQ77OCBPKohmBl24kODwXBi3cp
         58jHUiltI9cmKze0DINHlRqSokSnxKituge82gsATr3i0O1SplTaws5k9fFilopa18yx
         khdpS5NDsr43zxYNFbqvkHLv2YH5lMcYoXpQmcyLG0W0Otk4D39LEZMmlMhCDS6wpO1F
         zGeA==
X-Gm-Message-State: AOAM532Vv3aDmaFqECL9q/EbYYcNJK+CpPVG7dfaoYFljqgxE2U+o91v
        zSgJwc/uL4vI95DC6P2GRW4+Sp3URiPIku2Ho4/Ogw==
X-Google-Smtp-Source: ABdhPJygiVyf31phO5FaXHWu7V1/HU83xSM42R6UMC74ptWXQTYVhkNLA5OcsYN4QeCh2XAvhcbeVPsBqUgqMbfmDfc=
X-Received: by 2002:a05:6512:10cd:: with SMTP id k13mr7529609lfg.153.1590152841031;
 Fri, 22 May 2020 06:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com>
 <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com>
 <CADBw62rrQ=Po76qpJoUj1za9Hg=T+=eEJf=Yv3UmLFLtRZvwsg@mail.gmail.com>
 <CADBw62oFTV3MPuFQSL0MWyYQWy9MuhL70w5HGHPPV1EXBd3KEQ@mail.gmail.com>
 <CABb+yY1gXxpU=q9xKf14uZtJz51kLJ-k2EeWsjnFRyBzR5bmgA@mail.gmail.com>
 <CADBw62oFDrruSq+Rm=hXHZYn0qDrr47cNK4Wj0_A-jG1dOT+kw@mail.gmail.com>
 <CADBw62rZuhaeSEppy+AhSkv1uNgaj9qrHFf7pz9nwKm8q3OrTA@mail.gmail.com> <CABb+yY244ZCOk5kDtOR0oEYajwUVbXoSZdNiid__UuYbU=yB-Q@mail.gmail.com>
In-Reply-To: <CABb+yY244ZCOk5kDtOR0oEYajwUVbXoSZdNiid__UuYbU=yB-Q@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 22 May 2020 21:07:04 +0800
Message-ID: <CADBw62p_tB1izMnwQgLHcN-uwQCDDyigQ=pcA3+43C6uww2NsA@mail.gmail.com>
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

On Fri, May 22, 2020 at 11:48 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Thu, May 21, 2020 at 7:24 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi Jassi,
> >
> > On Wed, May 13, 2020 at 2:32 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > On Wed, May 13, 2020 at 2:05 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > > >
> > > > On Tue, May 12, 2020 at 11:14 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > >
> > > > > Hi Jassi,
> > > > >
> > > > > On Thu, May 7, 2020 at 11:23 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > >
> > > > > > Hi Jassi,
> > > > > >
> > > > > > On Thu, May 7, 2020 at 7:25 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, May 6, 2020 at 8:29 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Jassi,
> > > > > > > >
> > > > > > > > On Tue, Apr 28, 2020 at 11:10 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Baolin Wang <baolin.wang@unisoc.com>
> > > > > > > > >
> > > > > > > > > The Spreadtrum mailbox controller supports 8 channels to communicate
> > > > > > > > > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > > > > > > > > are used to send and receive messages by IRQ mode.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > > > > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > > > > ---
> > > > > > > > > Changes from v3:
> > > > > > > > >  - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'
> > > > > > > > >
> > > > > > > > > Changes from v2:
> > > > > > > > >  - None.
> > > > > > > > >
> > > > > > > > > Changes from v1:
> > > > > > > > >  - None
> > > > > > > >
> > > > > > > > Gentle ping, do you have any other comments? Thanks.
> > > > > > > >
> > > > > > > Yea, I am still not sure about the error returned in send_data().  It
> > > > > > > will either never hit or there will be no easy recovery from it. The
> > > > > > > api expects the driver to tell it the last-tx was done only when it
> > > > > > > can send the next message. (There may be case like sending depend on
> > > > > > > remote, which can't be ensured before hand).
> > > > > >
> > > > > > Actually this is an unusual case, suppose the remote target did not
> > > > > > fetch the message as soon as possile, which will cause the FIFO
> > > > > > overflow, so in this case we  can not send messages to the remote
> > > > > > target any more, otherwise messages will be lost. Thus we can return
> > > > > > errors to users to indicate that something wrong with the remote
> > > > > > target need to be checked.
> > > > > >
> > > > > > So this validation in send_data() is mostly for debugging for this
> > > > > > abnormal case and we will not trigger this issue if the remote target
> > > > > > works well. So I think it is useful to keep this validation in
> > > > > > send_data(). Thanks.
> > > > >
> > > > > Any comments? Thanks.
> > > > >
> > > > Same as my last post.
> > >
> > > I think I've explained the reason why we need add this validation in
> > > my previous email, I am not sure how do you think? You still want to
> > > remove this validation?
> >
> > Gentle ping.
> >
> > As I explained in previous email, this validation is for an unusual
> > case, suppose the remote target did not fetch the message as soon as
> > possile, which will cause the FIFO overflow, so in this case we  can
> > not send messages to the remote
> > target any more, otherwise messages will be lost. Thus we can return
> > errors to users to indicate that something wrong with the remote
> > target need to be checked.
> >
> > So this validation in send_data() is mostly for debugging for this
> > abnormal case and we will not trigger this issue if the remote target
> > works well. So I think it is useful to keep this validation in
> > send_data(). What do you think? Thanks.
> >
> I still think the same as before.
> You should do this check before you call mbox_chan_txdone() and wait
> if busy ... which is exactly the purpose of txdone().
> It seems harmless to be paranoid and place a block of code in
> practically "if 0", but that sets bad precedence for other drivers. So
> please move the check before txdone().

OK. I realized I can implement the flush() to make sure the
transmission has been completed. Thanks.

--
Baolin Wang
