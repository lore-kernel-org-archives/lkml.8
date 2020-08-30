Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F039EC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93A5208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 07:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598772229;
	bh=km28S5CzZd+At7Y+4S9PG+dHmU5CXJCtMAWKdL1fxBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xJe1+NjpKFEnLXIisMlzAdbTGmwOpxQwLrQs51A8XRyN9t2sR9smjG2ZZOaNRy2jy
	 VSgII+ct0O6uDgn6BDpH30gkkc9cGcGa94Mqdr21bUyCNDXZNNQ368NaHGeSE7H6Rw
	 ItJbqIQgVQ8hp43TMZ1mNUT4RgsrYzcBw5jRCi2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgH3HXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 03:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgH3HXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 03:23:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59F3B206FA;
        Sun, 30 Aug 2020 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598772225;
        bh=km28S5CzZd+At7Y+4S9PG+dHmU5CXJCtMAWKdL1fxBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dej4xrrFN62W8cFGVEBlUkZK/4CsbMBrz2dE21RgprMb3qSYwvDEJEBApM4vJ2hhT
         frwLI0HzBLGDLiJvADhAKj3DDpG2teZf1oCjyfae7YJp43pH2iRFeFJmzCpxV+q4fr
         CqXH0NVoUwIreII9lgMcIYY3u7k9FpiupNG8ZKhw=
Date:   Sun, 30 Aug 2020 09:23:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200830072342.GA110796@kroah.com>
References: <20200825024516.16766-1-shuo.a.liu@intel.com>
 <20200825024516.16766-7-shuo.a.liu@intel.com>
 <20200828102738.GC1470435@kroah.com>
 <20200829110436.GF13723@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829110436.GF13723@shuo-intel.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 07:04:36PM +0800, Shuo A Liu wrote:
> Hi Greg,
> 
> On Fri 28.Aug'20 at 12:27:38 +0200, Greg Kroah-Hartman wrote:
> > On Tue, Aug 25, 2020 at 10:45:06AM +0800, shuo.a.liu@intel.com wrote:
> > > +	default:
> > > +		pr_warn("Unknown IOCTL 0x%x!\n", cmd);
> > > +		ret = -EINVAL;
> > 
> > Wrong error value here, right?
> 
> Right, it should be -ENOIOCTLCMD.

It could, but really, just return the correct error for this, to prevent
the core from having to do the conversion.

The reviewers at Intel who should have read this before submitting it,
know the correct value to return for an illegal ioctl, please go ask
them.

> However, i found many instances in kernel drivers return -EINVAL for no
> ioctl command support. :)

Then they too are wrong.  No need to add known bugs before the code is
accepted.

See the comments above the is_unrecognized_ioctl() in block/ioctl.c for
all of the details and why -EINVAL is not the correct thing to do here.

thanks,

greg k-h
