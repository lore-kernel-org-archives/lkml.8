Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6949AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F084208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598001239;
	bh=BstpKq0K+UB9fK7IvcmMudc9rC7PhRprOeU+BJfrk8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E2YqEGI+thdM8W7AAlI9Nj2LcGGuPnJsXuGXLvyTHuLuz1cW3xHLc2zYAgcU91T3E
	 02IUZkUGHtLOVDXDaNUlrYMihQBm5SxTMQUfEcZaJ1BL1J3Qh7QaD9T3QAlzT9GkC6
	 nTkIR8EqdT+7vVd2NUAVipg3I/H5GCTmMCrHnAR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgHUJN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgHUJN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:13:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD892087D;
        Fri, 21 Aug 2020 09:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598001237;
        bh=BstpKq0K+UB9fK7IvcmMudc9rC7PhRprOeU+BJfrk8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmD2/2ktTLm+Jp/JqAGW03t9itqYnmFBJuri36WegciTaTnFnn/kSwy5cus76iNDz
         U7DU7REMGheXUWUiQ+zCg8xd0oNGwwYwEIG1+6FsHsf5Z8LE77B68VivWx1XNzgGC4
         yOLsulfO8OzhH4hWYyzFKcKx2VL2bIQQqZUn71kE=
Date:   Fri, 21 Aug 2020 11:14:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 83/92] mfd: dln2: Run event handler loop under
 spinlock
Message-ID: <20200821091416.GA1894114@kroah.com>
References: <20200820091537.490965042@linuxfoundation.org>
 <20200820091541.964627271@linuxfoundation.org>
 <20200821072123.GC23823@amd>
 <CAHp75Vcbmc-PV-gQxuj9i8sAcFCzhJKe_qzEfrkUTZbnf3Vupg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vcbmc-PV-gQxuj9i8sAcFCzhJKe_qzEfrkUTZbnf3Vupg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:06:45PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 21, 2020 at 10:26 AM Pavel Machek <pavel@denx.de> wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > [ Upstream commit 3d858942250820b9adc35f963a257481d6d4c81d ]
> > >
> > > The event handler loop must be run with interrupts disabled.
> > > Otherwise we will have a warning:
> > ...
> > > Recently xHCI driver switched to tasklets in the commit 36dc01657b49
> > > ("usb: host: xhci: Support running urb giveback in tasklet
> > > context").
> >
> > AFAICT, 36dc01657b49 is not included in 4.19.141, so this commit
> > should not be needed, either.
> 
> I'm wondering if there are any other USB host controller drivers that
> use URB giveback in interrupt enabled context.

Almost all do.
