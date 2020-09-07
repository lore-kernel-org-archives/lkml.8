Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE11C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B9321481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599486798;
	bh=PWtmn+Z9RrLCbibZwYxdj5VdBnfGeAWKO2SOBBWHdOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XTXURHCyaijACHE5tUgHdUhORwvVME4bURF0RV5XiiSiB2uznhn2vGKVfKXKAmifM
	 BYUQf/OneqY1STP1twzR3b+hD9HFsM/khdbgzb8ktGJ+ZozfAK8Y2ab2jcR3ne1Dpo
	 wn9U2GLC4RJYCTi+muRhTY5x0jo+DZB2X1yEoNWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgIGNu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgIGNp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:45:29 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F7920757;
        Mon,  7 Sep 2020 13:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599485750;
        bh=PWtmn+Z9RrLCbibZwYxdj5VdBnfGeAWKO2SOBBWHdOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UARSrkQBalFJiyuplZd86WZgcGkPGkHh4W5UB3z6sPDs/iucB9oO+xQADt4eocjHx
         a/hL0/+MUz5WolqcV42GXojvatVRW78Ddr5uHibtCwV4KY+/0ANcxtSt5i675YoajP
         kCiipNsHVLex8nVpM+VaHz/nDMFGtmygwkSiWfkA=
Date:   Mon, 7 Sep 2020 15:36:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] sysfs: Add sysfs_emit and sysfs_emit_at to format
 sysfs output
Message-ID: <20200907133604.GA2779041@kroah.com>
References: <a9054fb521e65f2809671fa9c18e2453061e9d91.1598744610.git.joe@perches.com>
 <c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c22b7006813b1776467a72e716a5970e9277b4b7.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 05:43:58PM -0700, Joe Perches wrote:
> On Sat, 2020-08-29 at 16:48 -0700, Joe Perches wrote:
> > Output defects can exist in sysfs content using sprintf and snprintf.
> > 
> > sprintf does not know the PAGE_SIZE maximum of the temporary buffer
> > used for outputting sysfs content and it's possible to overrun the
> > PAGE_SIZE buffer length.
> > 
> > Add a generic sysfs_emit function that knows that the size of the
> > temporary buffer and ensures that no overrun is done.
> > 
> > Add a generic sysfs_emit_at function that can be used in multiple
> > call situations that also ensures that no overrun is done.
> 
> This preliminary coccinelle script converts ~5000 instances treewide.
> There are still many remaining instances that could be converted.
> 
> $ git grep -w sysfs_emit -- '*.[ch]'|wc -l
> 4702
> $ git grep -w sysfs_emit_at -- '*.[ch]'|wc -l
> 229

Can you send a patch that would at least convert the driver core code
(drivers/base/*) to use these new helpers so we have an in-tree user
when applying the first patch?

thanks,

greg k-h
