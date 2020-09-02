Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53613C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243E820767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n3thLXKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgIBPbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgIBPbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:31:19 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ECFC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 08:31:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a9so5013853wmm.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MRzTXOeTGeZAyaIQ1e/ex4zUgkS94k274JL7swyOwLU=;
        b=n3thLXKYL8UCpmS6P7xcRU/DJXJUDnk8aYygxAO8urgHvALVBB7anUMPuOdfx6L6FL
         DFWTY6fdgsiThCKCKQ9BZhYT7je3gARNBiJl8e16I2zxO4YBTBqJwaW2Dpfd1PVlYlZ2
         4gMUf2BVVo9Hq1PcccnAaoDzNhroAexNnhslqEnjnzMwXtYbtpzSXb7HjeM55GvzZlyB
         eiBKxf4vyYsliXxqPikXFOUpc5Nz88zpnUN3nH9di9BxBEP/9vrFY9ehkHQHhTFRLSlB
         iCwllHPuNAxqIWRZGLbsVg94r+4I8ywcyZbZLnpZdVgC3pCtFBmEETr9TgrIqog9K/AR
         LB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MRzTXOeTGeZAyaIQ1e/ex4zUgkS94k274JL7swyOwLU=;
        b=knUDTGMpZ97Oz/lLAyFnMa9ZFFZETRSjVwNdnXC6t3ytRJtts2c7TcFaeUQYCrYwvi
         QtncsgOZ0errmFjs8L1k+aq5Ul2kG+KZG6wW2xYlPy4oUiNwG7E4ubxaApUvGWUdV4W8
         A6L0PLTFKoI/LYl5Mko+7ejMUaVtCOR11XF/xrgwuuKjevcIBsv5wY8a/cnuuISdB6Z6
         TzlNTBXx77L+bzkWPDk+K47/tokyhvC8ClO06WTyiS3Y5uWVCp753NxMnCk628p73MOb
         dQVs4pIk0R3YCzwrdTdUDxCBcKJKsBuQliN/hPM8rBokEuVVIC6U/6haNoBtjvRIAFSq
         WWQw==
X-Gm-Message-State: AOAM5336V/ozOyFLptw8aCBMHTA/7uPijIpKbTpudu6/8ClgdB9otKvz
        sy5wgJoP5F0p5W0Ck7uCGis=
X-Google-Smtp-Source: ABdhPJygBY0ZfZMgSZivvz2qHn0ore0KK2NLR2pC9rvy2RL8UM3CGtVZXaIYKNHJe8xi9caJogXndQ==
X-Received: by 2002:a1c:b60b:: with SMTP id g11mr1271474wmf.48.1599060676417;
        Wed, 02 Sep 2020 08:31:16 -0700 (PDT)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id z9sm74349wma.4.2020.09.02.08.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 08:31:15 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Wed, 2 Sep 2020 16:31:13 +0100
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nayna Jain <nayna@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] sysfs: add helper macro for showing simple
 integer values
Message-ID: <20200902153113.qxqkpm2o6a6pgoka@medion>
References: <20200829233720.42640-1-alex.dewar90@gmail.com>
 <20200829233720.42640-3-alex.dewar90@gmail.com>
 <20200830091353.GA119062@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830091353.GA119062@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 11:13:53AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 30, 2020 at 12:37:17AM +0100, Alex Dewar wrote:
> > sysfs attributes are supposed to be only single values, which are
> > printed into a buffer of PAGE_SIZE. Accordingly, for many simple
> > attributes, sprintf() can be used like so:
> > 	static ssize_t my_show(..., char *buf)
> > 	{
> > 		...
> > 		return sprintf("%d\n", my_integer);
> > 	}
> > 
> > The problem is that whilst this use of sprintf() is memory safe, other
> > cases where e.g. a possibly unterminated string is passed as input, are
> > not and so use of sprintf() here might make it more difficult to
> > identify these problematic cases.
> > 
> > Define a macro, sysfs_sprinti(), which outputs the value of a single
> > integer to a buffer (with terminating "\n\0") and returns the size written.
> > This way, we can convert over the some of the trivially correct users of
> > sprintf() and decrease its usage in the kernel source tree.
> > 
> > Another advantage of this approach is that we can now statically check
> > the type of the integer so that e.g. an unsigned long long will be
> > formatted as %llu. This will fix cases where the wrong format string has
> > been passed to sprintf().
> > 
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > ---
> >  include/linux/sysfs.h | 31 +++++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> 
> Did you try this out?  Don't you need to return the number of bytes
> written?

I tried it out, but maybe not thoroughly enough ;-)

> 
> I like Joe's patches better, this feels like more work...

Fair enough. As Joe's pointed out, even for single numbers the
formatting is sometimes more complicated, so his approach does seem
best. Thanks for looking though :-)

> 
> thanks,
> 
> greg k-h
