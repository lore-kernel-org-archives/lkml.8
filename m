Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE51C47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6862B20746
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKbBOLIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgEFXZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgEFXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:25:50 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D549C061A0F;
        Wed,  6 May 2020 16:25:50 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b18so146319ilf.2;
        Wed, 06 May 2020 16:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+CNkpvoV+7/WGRtPvOLP3NxAkiDmtlvxq7O9LqthmvE=;
        b=tKbBOLIPghXV1x039iYZ7x+Y1RJC0Q3+9P9/zbjar9hhlkyIVZaNWCRtt+5bpdtpj2
         2PH3iRDmzDTcwt3YUNleGOprd4FzeRfsZvdTmfV76IQCNfCbkJaCRmwrbWyVqsCJ/kUy
         5ubqTOshBUAdF9S8YvBtxyr4NbdlkP9poH6og27SiiH3yhaYDIuJQGy4tgJrXbzVUnQQ
         y+cluAVE3JIOEWAC69AKY0sggp05g9O21cLCxFYCnzkdAIyPsXRLCj+qirmeH1z/5PG0
         kq0zdTIPkFfiyfHPsDe2PPCh6YNleXoXgTSSmDr36SUGy9d2EjjUEvkl/v8kum+99b0K
         d7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+CNkpvoV+7/WGRtPvOLP3NxAkiDmtlvxq7O9LqthmvE=;
        b=cxYqSYqmVw9k5vjdXRs/uTPB+D39ckn29GXoC/tE+s242z5D1QlJAI5EePS94i1MbL
         kAeC0Sn3QPbE7HT5g+hJuW37O93c8wlh8SFo9lNNQPhABuaFuKA6oA1q2c6DJG3S4TES
         ZDOYq0yhNMzVBx1K8KDyBQOwRSZ58hqpFpVOtgGaF1dbdthId+LiFGSIH701I0ZLTLJH
         98WsVAoV2ImMvuYY0FqbsNZxVB2i9MdmqUFY4/4++DsEnxj0B6S0aEvNCy+LPIGKllGt
         byG4tqd6OlqQWPOp/yC4DWWLSQC1lF19m8IL+YMPEduQSTjz62PKtgKtPijiUHeve5+3
         vbWA==
X-Gm-Message-State: AGi0PuYRbEqaJAiL5FXr/1BeUAv3oPTiQv95eIECd3eJbRWkrAPE9Zrl
        Xx3L3EOve71GEAJpTlai1e7v/7pAxXT0H6v680k=
X-Google-Smtp-Source: APiQypJd1bvaAZ6xswFa4gdRaiKe8L9dkI6mmjVGE7LVH0QLX2wsxeD9NAWt/rEvRTMYwN6igmGfQNkcIt0aPeN/008=
X-Received: by 2002:a05:6e02:8ea:: with SMTP id n10mr11858252ilt.87.1588807549127;
 Wed, 06 May 2020 16:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
 <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com>
In-Reply-To: <CADBw62pDp4NByqNJ+ryUdBUi7GsW3tD8_vSN7iRGekThw0Xo+Q@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 6 May 2020 18:25:38 -0500
Message-ID: <CABb+yY2Pph4EeQtg9xSaCWHqcXr0mVNkrrFYm-E3x3f5xaxygg@mail.gmail.com>
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

On Wed, May 6, 2020 at 8:29 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Jassi,
>
> On Tue, Apr 28, 2020 at 11:10 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >
> > From: Baolin Wang <baolin.wang@unisoc.com>
> >
> > The Spreadtrum mailbox controller supports 8 channels to communicate
> > with MCUs, and it contains 2 different parts: inbox and outbox, which
> > are used to send and receive messages by IRQ mode.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> > Changes from v3:
> >  - Save the id in mbox_chan.con_priv and remove the 'sprd_mbox_chan'
> >
> > Changes from v2:
> >  - None.
> >
> > Changes from v1:
> >  - None
>
> Gentle ping, do you have any other comments? Thanks.
>
Yea, I am still not sure about the error returned in send_data().  It
will either never hit or there will be no easy recovery from it. The
api expects the driver to tell it the last-tx was done only when it
can send the next message. (There may be case like sending depend on
remote, which can't be ensured before hand).

thnx
