Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B53C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF196207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9erukg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgEGDX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgEGDX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:23:28 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BCEC061A0F;
        Wed,  6 May 2020 20:23:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so4644195lja.13;
        Wed, 06 May 2020 20:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvuqFrH0VhqtR/mCwYxGk+dKfAbXLIvqihGgMIQYRpw=;
        b=E9erukg3yo+XivdloEY4rZcygjuAUlPlf+mmqqjQiAlXdcrVUEpO9o9QKTlmBqvlvs
         fPcE/3C9LRx79KXmY6ukyUSkINYWyA9OrAbyTeuE7HuStIqVxyCQn42weCljVzlQP35t
         KRJbRvLSNmQv+BxuQok9Y1g/y+lGNrhKLRDDXC/C5HTqi4pbfXlNTkrzWmFIEM3aWSYk
         aHrLimdsFO8qBT0zliidNOyiki/gDJxE7QLbIrWHS0AaHhS3ogySqya3NyTLF1POLXOS
         JkZBRlSq/LrTpFnSf/lEmQPOuCrRCg/0tjXhk9jDhjpLCN7HocQJuVjJFPEs37pcS7U4
         CzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvuqFrH0VhqtR/mCwYxGk+dKfAbXLIvqihGgMIQYRpw=;
        b=jebaC6zTAJ5H6JBOqxRFsGJHmK6sSLRHb1+Mo5xNlBKjS0kQ5vSxwnReFGEG3OOhSY
         lgMOYkwi8BUjmaiG8DEEz1nBCmEbfoAvw0HoTuiNjSSQc76MycjQKyRoXogqHlsrqRfg
         dy1GuQZJFFSTlN81NBxLztiIVtUwm8fVImt0ze4wo+aqXIPATJT8jyw/RBHwSffE8Z6Q
         XmHEP0sSSVDYYFF44LXbvn/XRTQHCYn+vk4Uy93pIojLZ+Z1iCx3+vDVMOCwVgNI6Elh
         LJz/S8CXXT6mQnovyaOh2BZMxuWi8hHRcE0ugSH+8aP7S6VfQUiUeOVNWl99q/DszIHS
         njCw==
X-Gm-Message-State: AGi0PuaaB7OfKFNQPVNJxfpgkY1TrSGxouT2E9tJLEThxU/w8Yo/p44T
        TdwaYsz4Mfl+TBjPp7kzs1+6fQtZsHfogN+DhEs=
X-Google-Smtp-Source: APiQypKoz1kv+xZgAiqu0t+AS5hS8kmlzW/L9LvHJ6+dt/OqlbNMSdvySl0ffs+MinP7aCdCXqmVkFmrXszfjEYeeuQ=
X-Received: by 2002:a2e:8603:: with SMTP id a3mr7075701lji.153.1588821806738;
 Wed, 06 May 2020 20:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com> <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com>
In-Reply-To: <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 7 May 2020 11:23:15 +0800
Message-ID: <CADBw62rrQ=Po76qpJoUj1za9Hg=T+=eEJf=Yv3UmLFLtRZvwsg@mail.gmail.com>
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

On Thu, May 7, 2020 at 7:25 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Wed, May 6, 2020 at 8:29 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > Hi Jassi,
> >
> > On Tue, Apr 28, 2020 at 11:10 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > >
> > > From: Baolin Wang <baolin.wang@unisoc.com>
> > >
> > > The Spreadtrum mailbox controller supports 8 channels to communicate
> > > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > > are used to send and receive messages by IRQ mode.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > > ---
> > > Changes from v3:
> > >  - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'
> > >
> > > Changes from v2:
> > >  - None.
> > >
> > > Changes from v1:
> > >  - None
> >
> > Gentle ping, do you have any other comments? Thanks.
> >
> Yea, I am still not sure about the error returned in send_data().  It
> will either never hit or there will be no easy recovery from it. The
> api expects the driver to tell it the last-tx was done only when it
> can send the next message. (There may be case like sending depend on
> remote, which can't be ensured before hand).

Actually this is an unusual case, suppose the remote target did not
fetch the message as soon as possile, which will cause the FIFO
overflow, so in this case we  can not send messages to the remote
target any more, otherwise messages will be lost. Thus we can return
errors to users to indicate that something wrong with the remote
target need to be checked.

So this validation in send_data() is mostly for debugging for this
abnormal case and we will not trigger this issue if the remote target
works well. So I think it is useful to keep this validation in
send_data(). Thanks.

-- 
Baolin Wang
