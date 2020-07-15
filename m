Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97334C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EAF2065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594799881;
	bh=d+zWYLUlj6gMr9z1u5H7/iRQ1ApMDWHLyq8vpIJWQ/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cWqYfEAyCvgeEt0f0L5TMhXtR4DkoBd09R1kZOWjKUP/PlXsG7/W37f8CQZVGdM/8
	 1XBdPDyjWSepUNxzqw1iKHtDzT0V/gAdXkgRWK2wsWfNuR9DW87dBwV5pORCkGaF1L
	 q/yYbokernkeiRdkIBD8QrdtgDk6moFUNyD4VY4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgGOH6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:58:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgGOH6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:58:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDC92064C;
        Wed, 15 Jul 2020 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594799879;
        bh=d+zWYLUlj6gMr9z1u5H7/iRQ1ApMDWHLyq8vpIJWQ/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YH9KxqV+VW3QrvUFhDbuPJoTpjbrjotyRGdB/yTxYZg86DNucztTjgoVqna4lxZBz
         6JIqapvZEeW9M/LsFc0bOKbp5HcrrH05hKjnkxwMDAOCj9lc8BPvkcrsFbpnEOBFz/
         /mzjsSS422SjoLRxGsG5AqEETtXf6YW+8QnI7pdg=
Date:   Wed, 15 Jul 2020 09:57:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Zhixu Zhao <zhixu001@126.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, rcy@google.com, rspringer@google.com,
        toddpoynor@google.com, dan.carpenter@oracle.com
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
Message-ID: <20200715075755.GA2516028@kroah.com>
References: <20200617161127.32006-1-zhixu001@126.com>
 <20200714234440.27009-1-zhixu001@126.com>
 <20200715071748.GC2305231@kroah.com>
 <23ef3ca9616418b702df891443d0f4864edd58ff.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23ef3ca9616418b702df891443d0f4864edd58ff.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:24:22AM -0700, Joe Perches wrote:
> On Wed, 2020-07-15 at 09:17 +0200, Greg KH wrote:
> > On Wed, Jul 15, 2020 at 07:44:40AM +0800, Zhixu Zhao wrote:
> > > On Thu, Jun 18, 2020 at 12:11:27AM +0800, Zhixu Zhao wrote:
> > > > A coding alignment issue is found by checkpatch.pl.
> > > > Fix it by using a temporary for gasket_dev->bar_data[bar_num].
> > > > 
> > > > Signed-off-by: Zhixu Zhao <zhixu001@126.com>
> > > 
> > > Hi, there~
> > > 
> > > Does anybody have any further comments on this?
> > > Can it be merged?
> > 
> > I never saw the first version of this, are you sure it got sent to the
> > mailing list?  It's not in any archives anywhere.
> 
> I saw it.  It's here:
> https://lore.kernel.org/lkml/20200617161127.32006-1-zhixu001@126.com/

Ah, doh, sorry.

Zhixu, please address the comments given to you on the series and resend
it as a new version.

thanks,

greg k-h
