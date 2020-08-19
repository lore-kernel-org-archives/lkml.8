Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7604C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A299E2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597806809;
	bh=3HYKC4lph4BSGjKk7QnGJ/iNJRQMO5s9oVBYH6NYs40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PFNbdIyfp/QapbfltJWoww1EE9aTEZzDbalgktIEGAbKn8mg0pg59ohlKobZVcQR4
	 e8HC9pk23UHPWjfgeFW74f4QXd8oboRMXmpg1JDHfJxvaz9Ec3uR0XMhjWalfmqhbx
	 H7880ioH+pB0rEqYyQ2zxpJ7ojolpj8/N0ojm9B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHSDN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgHSDN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:13:27 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D1B2065F;
        Wed, 19 Aug 2020 03:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597806807;
        bh=3HYKC4lph4BSGjKk7QnGJ/iNJRQMO5s9oVBYH6NYs40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y6chg8ZcukcmnDpajVBgevZppgQK1mINo+4sdKBBmU91pVR5RZUrU1kDSZzsW/Naq
         XduQkg9vC+UKUFEf8NV5iXGoTzaSpdgWfG2jkF2grngC5emeQOmZcEWrUL/k2OOEv9
         HfjGIy6x28gKzIn78NCWMYN/gp9gFup7TNQjt6hM=
Date:   Tue, 18 Aug 2020 20:13:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Philippe Liard <pliard@google.com>, hch@lst.de,
        adrien+dev@schischi.me, Guenter Roeck <groeck@chromium.org>,
        Daniel Rosenberg <drosen@google.com>,
        Nicolas Prochazka <nicolas.prochazka@gmail.com>,
        Tomoatsu Shimada <shimada@walbrix.com>
Subject: Re: [PATCH] squashfs: avoid bio_alloc() failure with 1Mbyte blocks
Message-Id: <20200818201326.2b9eab480ab4228ccd250ffa@linux-foundation.org>
In-Reply-To: <CABXOdTcJDub=ffmwn4_Xn0chxdwwu4jNFrh9o3HVVH1Mzt4iSA@mail.gmail.com>
References: <20200815035637.15319-1-phillip@squashfs.org.uk>
        <CABXOdTcJDub=ffmwn4_Xn0chxdwwu4jNFrh9o3HVVH1Mzt4iSA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 21:30:33 -0700 Guenter Roeck <groeck@google.com> wrote:

> On Fri, Aug 14, 2020 at 8:57 PM Phillip Lougher <phillip@squashfs.org.uk> wrote:
> >
> > This is a regression introduced by the "migrate from ll_rw_block usage
> > to BIO" patch.
> >
> > Bio_alloc() is limited to 256 pages (1 Mbyte).   This can cause a
> > failure when reading 1 Mbyte block filesystems.  The problem is
> > a datablock can be fully (or almost uncompressed), requiring 256
> > pages, but, because blocks are not aligned to page boundaries, it
> > may require 257 pages to read.
> >
> > Bio_kmalloc() can handle 1024 pages, and so use this for the
> > edge condition.
> >
> > Reported-by: Nicolas Prochazka <nicolas.prochazka@gmail.com>
> > Reported-by: Tomoatsu Shimada <shimada@walbrix.com>
> > Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
> 
> Fixes: 93e72b3c612a ("squashfs: migrate from ll_rw_block usage to BIO")
> Reviewed-by: Guenter Roeck <groeck@chromium.org>

Thanks.  I added cc:stable also.
