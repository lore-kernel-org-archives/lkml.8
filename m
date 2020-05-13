Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBACBC2D0FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7C38206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frhhnar7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbgEMGcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbgEMGck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:32:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D05C061A0C;
        Tue, 12 May 2020 23:32:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r17so9579005lff.9;
        Tue, 12 May 2020 23:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krXK6kZ32e/DR3mFxC2FGM2vIFqONMy2uV/TIX0FVDM=;
        b=frhhnar7CKQR2XF4Gs7FLnJvOeAo/JsvYEUzT8TLjEVb6kqd31MBao6wcIFeBL3qg+
         KwkF1Amy5O8k2ZXdiMmlmf+LSJt3xL8s9ss5Az4ue5CXlNw9OcCvTSnEeI+VrUu3K1vo
         K3Jerui34Obxv4lspAwcu5qRexjClFphoMQYY5QtDLC0E2zXn0Obo9qMJEiXcq4YRXIw
         ThGRjP6sspwo39HZICoCCR3J7IHG7IqQeuGf+qWW20WRpkcXxsYfOJYrpCtRxLbNp3lu
         aABlwegv63RSx26E+0g8aUtS0nx6o1Af6kWXyjnyySpLjVnlw+SNmO8W+Jc3wzYOozDl
         g7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krXK6kZ32e/DR3mFxC2FGM2vIFqONMy2uV/TIX0FVDM=;
        b=JBsEP5UNvJo3LpJnTeKjp3srq1ulcBRzmF4LM/DVVAVv0iVD9wkZrOsRka3y68fakK
         BYpPPpqFeCMEbJ/MBIKsOwR0BKYZj0LVSW3ViTeP20d9c425i/oQWkzdroR/5CVoCEL5
         Vx8qqKvSZRzLuTe0nrC5EAO5v/NWVm9cnVl8oNJndy3CJOkH5zdz56tkPHVP29gflQTN
         IlY05ia4zjk8CBiWB1Y6M41dyLPoG18JT58Q1ae1PMzTPftFBbtyP0mui7PQWsCKAW3D
         J8HvkP/d/Aq4ewaYHZklGA4Di5rHNM3g/S/RCvk4eBvJkcHSZud4HeA0/HLLA/bl7HP5
         wfeA==
X-Gm-Message-State: AOAM533NHvFhjKIQj4pemkArpi3GG7RTp6RNCq95kpi4fdQnqXQS67mO
        p3f/ACsvcsxaWTC4T1KmGU6WQzOQjRAYgn2/6KnS1g==
X-Google-Smtp-Source: ABdhPJxbvqZkkJXjowqHDv7L9rLpGIRvDYTGXyAqz9zNiTVOkPexOuZDGWJb752gZC4Hfjw1q8/fZ3ILE93Jt83mUJ8=
X-Received: by 2002:a05:6512:10cd:: with SMTP id k13mr16946641lfg.153.1589351558460;
 Tue, 12 May 2020 23:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com>
 <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com>
 <CADBw62rrQ=Po76qpJoUj1za9Hg=T+=eEJf=Yv3UmLFLtRZvwsg@mail.gmail.com>
 <CADBw62oFTV3MPuFQSL0MWyYQWy9MuhL70w5HGHPPV1EXBd3KEQ@mail.gmail.com> <CABb+yY1gXxpU=q9xKf14uZtJz51kLJ-k2EeWsjnFRyBzR5bmgA@mail.gmail.com>
In-Reply-To: <CABb+yY1gXxpU=q9xKf14uZtJz51kLJ-k2EeWsjnFRyBzR5bmgA@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 13 May 2020 14:32:23 +0800
Message-ID: <CADBw62oFDrruSq+Rm=hXHZYn0qDrr47cNK4Wj0_A-jG1dOT+kw@mail.gmail.com>
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

On Wed, May 13, 2020 at 2:05 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Tue, May 12, 2020 at 11:14 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi Jassi,
> >
> > On Thu, May 7, 2020 at 11:23 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > Hi Jassi,
> > >
> > > On Thu, May 7, 2020 at 7:25 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> > > >
> > > > On Wed, May 6, 2020 at 8:29 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > >
> > > > > Hi Jassi,
> > > > >
> > > > > On Tue, Apr 28, 2020 at 11:10 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > > > > >
> > > > > > From: Baolin Wang <baolin.wang@unisoc.com>
> > > > > >
> > > > > > The Spreadtrum mailbox controller supports 8 channels to communicate
> > > > > > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > > > > > are used to send and receive messages by IRQ mode.
> > > > > >
> > > > > > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > > > > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > > > > ---
> > > > > > Changes from v3:
> > > > > >  - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'
> > > > > >
> > > > > > Changes from v2:
> > > > > >  - None.
> > > > > >
> > > > > > Changes from v1:
> > > > > >  - None
> > > > >
> > > > > Gentle ping, do you have any other comments? Thanks.
> > > > >
> > > > Yea, I am still not sure about the error returned in send_data().  It
> > > > will either never hit or there will be no easy recovery from it. The
> > > > api expects the driver to tell it the last-tx was done only when it
> > > > can send the next message. (There may be case like sending depend on
> > > > remote, which can't be ensured before hand).
> > >
> > > Actually this is an unusual case, suppose the remote target did not
> > > fetch the message as soon as possile, which will cause the FIFO
> > > overflow, so in this case we  can not send messages to the remote
> > > target any more, otherwise messages will be lost. Thus we can return
> > > errors to users to indicate that something wrong with the remote
> > > target need to be checked.
> > >
> > > So this validation in send_data() is mostly for debugging for this
> > > abnormal case and we will not trigger this issue if the remote target
> > > works well. So I think it is useful to keep this validation in
> > > send_data(). Thanks.
> >
> > Any comments? Thanks.
> >
> Same as my last post.

I think I've explained the reason why we need add this validation in
my previous email, I am not sure how do you think? You still want to
remove this validation?

-- 
Baolin Wang
