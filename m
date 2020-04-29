Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B03C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28EE72085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588146437;
	bh=jvpm32KYqadCq9EEE4zcmVzzPq1eo9+YysP3iBvNrQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cgy1aHs718SsjxWE7CzoS5Gpd5bIFownKY5Le1KCPMQrgeqdHSnXzkRvk/GGbvRZ8
	 63cglwiJL/RBb3cLMFhIWPBMhcYHjON1PbpBJBLbPVHOwcpGwzhfE3bUFdxs+UTtxq
	 ra/RfitqoiZl3iN+83VG4xbRgF3NGZ/d4SVd//dU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgD2HrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgD2HrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:47:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3979320787;
        Wed, 29 Apr 2020 07:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588146435;
        bh=jvpm32KYqadCq9EEE4zcmVzzPq1eo9+YysP3iBvNrQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eavxv+ikLybmX6KTIMyzwrk78pooqsrD+xKWhJcvw9TqeRYQO9DnmbyxM3YopwjIP
         zW01nhJp3MtiODkb7CPFC2hVYEgk5z6hH+S20pyItQeYX899IhoqWaXJSDRJzdJmIY
         LHx6YVn8CZJXpLnCgAqp5HDlIs2Pwo9r3LCZgYZE=
Date:   Wed, 29 Apr 2020 09:47:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drivers: base: Fix NULL pointer exception in
 __platform_driver_probe()
Message-ID: <20200429074713.GA2073394@kroah.com>
References: <20200408214003.3356-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20200428190337.GA1719585@kroah.com>
 <2c0c2e54-a385-c4ce-da29-0f84454cce55@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c0c2e54-a385-c4ce-da29-0f84454cce55@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 12:24:05PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Hi Greg,
> 
> On 4/28/20 12:03 PM, Greg KH wrote:
> > On Wed, Apr 08, 2020 at 02:40:03PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > 
> > > If platform bus driver registration is failed then,
> > 
> > How is your platform driver registration failing?  What caused that, is
> > it an in-kernel problem with something?  How can it be triggered?
> In my case I triggered it intentionally. For one of our internal
> project we want to strictly control the number of drivers/devices
> allowed in kernel. To verify the feasibility of adding above support,
> I intentionally failed few bus drivers and checked the behavior. In
> one of those tests I hence came across the mentioned issue.
> 
> In any case, platform bus driver registration failure is a valid case
> right ? Any issue we notice when this happens needs to be handled right?

That's fine, I just need to know if this is something that someone can
actually trigger today, and needs to be fixed up, or if this is just a
"hardening for when a driver author does something foolish" type of a
case.

It seems to be the "don't do foolish things" to me, so it's a much lower
priority as we can always fix foolish drivers because we have the source
to them :)

thanks,

greg k-h
