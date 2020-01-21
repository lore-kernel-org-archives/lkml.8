Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C878C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520EC2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579627120;
	bh=7grS1WGckL5jGKfqLWFd/uj2zIg9RehptV2ErsyqeR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C6+xVQDX+s9C9Peo07eBUxFUKGGfqMplRNtSBGhEWg9xvP6wjUmogqJKqQ73aP0lj
	 GsOnoh4RVs49jSXQr8os8/a/6FaXFZa95LeQI1C76oJqdjxWHFDf1SIH5tScZXQ0Fs
	 BOZzmkrza4YPViw96BMcuOYWDBw3m6e4hNm9yDts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgAURSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:18:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgAURSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:18:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF1E20882;
        Tue, 21 Jan 2020 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579627118;
        bh=7grS1WGckL5jGKfqLWFd/uj2zIg9RehptV2ErsyqeR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TT05N1567N9r55and97a9dZdKvmGqEb1nxH+XpHR18Pg1I9tCq53t9kblIVKW1oje
         GK99riUo+t8scXc/t1ul3xXolcdTjgE7P7FI00KR2spa5h8smwpuSYUFkpoyeheHqL
         xBTuVXdt6ubLLeSqUrJ1G4Az1/hkPxzgei6hTmrE=
Date:   Tue, 21 Jan 2020 18:18:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: optee: Fix compilation issue.
Message-ID: <20200121171836.GA674326@kroah.com>
References: <20200110122807.49617-1-vincenzo.frascino@arm.com>
 <8fa0e5b3-6e88-3fa2-9e16-046350cc752b@arm.com>
 <20200121152031.GA572414@kroah.com>
 <f4134c26-231f-968a-7fc3-0427af9a886e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4134c26-231f-968a-7fc3-0427af9a886e@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 03:27:47PM +0000, Vincenzo Frascino wrote:
> Hi Greg,
> 
> On 21/01/2020 15:20, Greg Kroah-Hartman wrote:
> > On Tue, Jan 21, 2020 at 02:23:02PM +0000, Vincenzo Frascino wrote:
> >> Hi Greg,
> >>
> >> I sent the fix below few days ago to the optee maintaners but I did not get any
> >> answer. Could you please pick it up?
> > 
> > 	 $ ./scripts/get_maintainer.pl --file drivers/tee/optee/Kconfig
> > 	Jens Wiklander <jens.wiklander@linaro.org> (maintainer:OP-TEE DRIVER)
> > 	tee-dev@lists.linaro.org (open list:OP-TEE DRIVER)
> > 	linux-kernel@vger.kernel.org (open list)
> > 
> > This should go through Jens, why me?
> > 
> 
> I added Jens and tee-dev list in copy already but as I was mentioning in my
> previous email I did not get any answer. I thought that since it is a small fix
> you could help. Sorry if I made a mistake.

Give people time to catch up on email, especially for obscure issues
like this.

thanks,

greg k-h
