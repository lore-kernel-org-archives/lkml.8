Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79C420897
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591059773;
	bh=yT6uPPaIXrr08PDkHZ/zzYHOerexZsr8I2IdZgIUlkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aF3paFbobjlyuycyjyLsFYMA5puBzOYuBjFrrALMv6X1wHjZC6IE+mU2eDQcMLPDK
	 ajYcx47iwzzaYUtYoU/cYfy+zTKz5XV+gUvjLmMco+AyXxGrOU484Gc/BLYkNNaDYU
	 nYZXKVe9T0odVWg+tvJq4p8k7ApozBecvLMdNyG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgFBBCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgFBBCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:02:52 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E7320885;
        Tue,  2 Jun 2020 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591059772;
        bh=yT6uPPaIXrr08PDkHZ/zzYHOerexZsr8I2IdZgIUlkg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2W0NCyujKd31R1Y2nzRRE+m4mATws/pY7VyK83RvEzEY4v95k621rIYse7pH0MIBl
         oHr98DBG4TWgOlsBTl92vSMk2rh6UWIt619ELig8Q1uL52rxAEkb35NyzhUv43fffV
         ivnvgoHXAFURrhHhzZv8LXn7CAtxweg5H6zTBzn4=
Date:   Mon, 1 Jun 2020 18:02:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: make a test module with get_count_order/long
Message-Id: <20200601180251.3f905a6e6eea1debc8771479@linux-foundation.org>
In-Reply-To: <20200531124709.c7o7pw7o2rfv4klc@master>
References: <20200530004328.30530-1-richard.weiyang@gmail.com>
        <20200530102531.GA1634618@smile.fi.intel.com>
        <20200530211940.yninqlngnzfvsvki@master>
        <CAHp75Vev_a_VrjoLUxfNo3AZybSteuV28t2EChaqydeFjCq=PQ@mail.gmail.com>
        <20200531124709.c7o7pw7o2rfv4klc@master>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 12:47:09 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> On Sun, May 31, 2020 at 12:56:29AM +0300, Andy Shevchenko wrote:
> >On Sun, May 31, 2020 at 12:23 AM Wei Yang <richard.weiyang@gmail.com> wrote:
> >> On Sat, May 30, 2020 at 01:25:31PM +0300, Andy Shevchenko wrote:
> >> >On Sat, May 30, 2020 at 12:43:28AM +0000, Wei Yang wrote:
> >> >> A test module to make sure get_count_order/long returns the correct result.
> >> >
> >> >>  lib/Kconfig.debug                  | 13 ++++++
> >> >>  lib/Makefile                       |  2 +
> >> >>  lib/test_getorder.c                | 64 ++++++++++++++++++++++++++++++
> >> >
> >> >I didn't get why it's not a part of test_bitops?
> >> >
> >>
> >> I see the document of test_bitops says it does exercise on clear_bit and
> >> set_bit. So not sure it is proper to put them together.
> >
> >It's not a problem to amend a documentation as well :-)
> >
> 
> Sure. I am fine with this.
> 
> Andrew, do you expect me to merge it into test_bitops.c?
> 

Yes please.
