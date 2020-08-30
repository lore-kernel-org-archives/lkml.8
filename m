Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD7AC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E62B4207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598778841;
	bh=xQzXOcqDtmUYQq7g3pMECZEmtAKxdxMbgh4yLXmTE70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nOs+NoYSYc/lFJ/IMuP/cs3qOp3+iCyJWyWuazo8MpOD3UvtLhlkUFoTGREVqGJF6
	 NuxUQ7zza2tpZMDjIo9tpkrr/FPkuxYqbTJa+cWbr42CFv8sAPzorESOpqlSBhBsKU
	 8R0DdVaavtn4UmwDQ2Fl+ZGDHoed3CwCJRl8nXr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgH3JN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 05:13:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgH3JN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 05:13:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06EB207BB;
        Sun, 30 Aug 2020 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598778836;
        bh=xQzXOcqDtmUYQq7g3pMECZEmtAKxdxMbgh4yLXmTE70=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vt3ZG0nCWhS8rihVO00dchU6iwISPLq1crtaRf26NVt8zoKFc+n4ey8kMT9cDRKSL
         13qmHL/JJYtwn71WWmZqQJODP24wz+yz45+atDy5VHYlzSmZdf5dRbB16fIZFeT34i
         iS2B5y5cFTSWuNWBwhCHM3JeVmfj65GLRlAYvAA0=
Date:   Sun, 30 Aug 2020 11:13:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nayna Jain <nayna@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] sysfs: add helper macro for showing simple
 integer values
Message-ID: <20200830091353.GA119062@kroah.com>
References: <20200829233720.42640-1-alex.dewar90@gmail.com>
 <20200829233720.42640-3-alex.dewar90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829233720.42640-3-alex.dewar90@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 12:37:17AM +0100, Alex Dewar wrote:
> sysfs attributes are supposed to be only single values, which are
> printed into a buffer of PAGE_SIZE. Accordingly, for many simple
> attributes, sprintf() can be used like so:
> 	static ssize_t my_show(..., char *buf)
> 	{
> 		...
> 		return sprintf("%d\n", my_integer);
> 	}
> 
> The problem is that whilst this use of sprintf() is memory safe, other
> cases where e.g. a possibly unterminated string is passed as input, are
> not and so use of sprintf() here might make it more difficult to
> identify these problematic cases.
> 
> Define a macro, sysfs_sprinti(), which outputs the value of a single
> integer to a buffer (with terminating "\n\0") and returns the size written.
> This way, we can convert over the some of the trivially correct users of
> sprintf() and decrease its usage in the kernel source tree.
> 
> Another advantage of this approach is that we can now statically check
> the type of the integer so that e.g. an unsigned long long will be
> formatted as %llu. This will fix cases where the wrong format string has
> been passed to sprintf().
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  include/linux/sysfs.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Did you try this out?  Don't you need to return the number of bytes
written?

I like Joe's patches better, this feels like more work...

thanks,

greg k-h
