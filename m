Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B246FC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760BD2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586291691;
	bh=YRABWMvwvHV0PmDLsBbttXpDhy97LPhtP+IKmrC+GN4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=MN65Dp6+pRwVKIHC1wWhhideBk1AAiMkZywjj7wImg5y8QpJPtYQ4BJJ1Ixb4d4QR
	 9ja8+wklDsfVbe0ff49J5SAXuUa//jzMeyZBMKjZvHIJk9XEFDiFmfa+/XtIHcZi0w
	 UtY1t/eZgZfeYqRh6arOHGhD9qhNNQEhA/lC/Dx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDGUeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGUeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:34:50 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC62C2074B;
        Tue,  7 Apr 2020 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586291689;
        bh=YRABWMvwvHV0PmDLsBbttXpDhy97LPhtP+IKmrC+GN4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=myOh01Dmx+KkdWrwz40Cn7g/n00RxRMho1HYuUNqGKXOcalbV/rv3vk/Ni5UOFIMf
         wjSfQFrDMjiu+Kpe0IwkQFz09Dx/Ah2ANqDryLaB5RDYetyY4DoKURVSBQ5BgWy9ux
         oXBEvtnVgLj4JdHZEFyUDi4buGHDcpmErypEZF5Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAfSe-u1VNDiY0MXGwrUqsNLBiai8zivxoPiyLnkJMZ7hcX+Eg@mail.gmail.com>
References: <20200331104532.12698-1-chunyan.zhang@unisoc.com> <158605608663.158626.7732167785990086489@swboyd.mtv.corp.google.com> <CAAfSe-u1VNDiY0MXGwrUqsNLBiai8zivxoPiyLnkJMZ7hcX+Eg@mail.gmail.com>
Subject: Re: [PATCH] clk: sprd: don't gate uart console clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 07 Apr 2020 13:34:48 -0700
Message-ID: <158629168890.88454.8918367547173437575@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-04-06 19:02:38)
> On Sun, 5 Apr 2020 at 11:08, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Chunyan Zhang (2020-03-31 03:45:32)
> > > Don't gate uart1_eb which provides console clock, gating that clock w=
ould
> > > make serial stop working if serial driver didn't enable that explicit=
ly.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> >
> > Do you have a Fixes: tag?
>=20
> I didn't leave a Fixed tag since that commit [1] will be merged into v5.7=
-rc1
>=20
> [1] https://www.spinics.net/lists/linux-clk/msg46430.html

Please still provide a Fixes tag. It helps track what commit is fixed
regardless.
