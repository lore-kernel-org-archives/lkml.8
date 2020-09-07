Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBECAC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B3BD206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599462079;
	bh=jtl3ocdz4s7eCeaWwzmlgjsKUt1fZOXz5Rqn8hjmcMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b5zM9maRsUfC0lJs41AFTupZCfKeZWEKITSg8kqs7Nbug4cq3aaOb8qjxA/jhWGnK
	 8tDFwFBG2QKPzK8pA06We6JY+4yLyos92BciwQKqRVqoHDzT71C0hvO5VClgdRgDgo
	 aNb86ng4mRTNvkqk3TP0TUpwipptSICFzomr+lak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIGHA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgIGHAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:00:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1933206D4;
        Mon,  7 Sep 2020 07:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599462031;
        bh=jtl3ocdz4s7eCeaWwzmlgjsKUt1fZOXz5Rqn8hjmcMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=heU+0xPXwFMEP2dwdlDaqtYnliLSx1XhyOmFFboJ8ulYl86YNJ9ulUD6BKZb4X1Sd
         QNHhsxAyHAOMZp6rpQ0as8zPvN7fmdr0BEN3onb0RkDK+DxvEF56St9AhxkBZ5Ow/X
         EpMXnshKTzrkKvEsTE312pA0tffqyEtwiEB9Vbjs=
Date:   Mon, 7 Sep 2020 09:00:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v7] binder: transaction latency tracking for user build
Message-ID: <20200907070045.GA605692@kroah.com>
References: <1596509145.5207.21.camel@mtkswgap22>
 <1596549552-5466-1-git-send-email-Frankie.Chang@mediatek.com>
 <20200903162105.GA371057@kroah.com>
 <1599461369.16905.19.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599461369.16905.19.camel@mtkswgap22>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 02:49:29PM +0800, Frankie Chang wrote:
> On Thu, 2020-09-03 at 18:21 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 04, 2020 at 09:59:09PM +0800, Frankie Chang wrote:
> > > 
> > > Frankie.Chang (3):
> > >   binder: move structs from core file to header file
> > >   binder: add trace at free transaction.
> > >   binder: add transaction latency tracer
> > > 
> > >  drivers/android/Kconfig                 |    8 +
> > >  drivers/android/Makefile                |    1 +
> > >  drivers/android/binder.c                |  425 ++-----------------------------
> > >  drivers/android/binder_internal.h       |  417 ++++++++++++++++++++++++++++++
> > >  drivers/android/binder_latency_tracer.c |  112 ++++++++
> > >  drivers/android/binder_trace.h          |   49 ++++
> > >  6 files changed, 607 insertions(+), 405 deletions(-)  create mode 100644 drivers/android/binder_latency_tracer.c
> > 
> > This series blows up the build into lots of tiny pieces, how was it
> > tested?
> > 
> 
> I am sorry that I had built pass.on the too older kernel, and some of
> api had been deprecated.
> I have fixed these errors in local, and I add the
> EXPORT_TRACEPOINT_SYMBOL for binder_latency_tracer to be ko needed.
> 
> Do I need to push a patch V8 or I provide the fixed code here ?

I need a whole new patch series, I dropped yours when it would not
compile properly.

thanks,

greg k-h
