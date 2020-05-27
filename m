Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A40CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273AB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590593866;
	bh=jAkMEUHBqdEO/QszEQaHMrmSFZfYvlTNLoTI/ewiBbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BeeePMSJW070sZcmqe4JqLg6ONexLuLxrQPu0vJI7gjIMjN8/TNLOGtQyh2VUCd+U
	 x+7hO8ObNpAQsKmqwQGq/4B877QVVB8k3b24Tth4pWzCp1ZEKyk8o6lub2dC0a2ZsT
	 UHx76ge0S3jkyRxGWhANggPUo0e4Hi1vbg9/vagc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgE0Php (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:46864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgE0Php (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:37:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9B020776;
        Wed, 27 May 2020 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590593864;
        bh=jAkMEUHBqdEO/QszEQaHMrmSFZfYvlTNLoTI/ewiBbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJsdueIkTxkhujGy8F7+ZyRYofmEVlcyWjp5QPEirpbUJExxaMWAJbPsY0KBdTLtd
         Ea5F8NxXoz+ohsz1GBI5tCVWdl1wD/t4fk5chRVo3645DCOGcf7qCKvtziDmvN6voL
         TU9ggbO0pUoEiQKyHeAH4nP7xm7lSjj3Zh6bC8vA=
Date:   Wed, 27 May 2020 17:37:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.6 000/126] 5.6.15-rc1 review
Message-ID: <20200527153742.GB524990@kroah.com>
References: <20200526183937.471379031@linuxfoundation.org>
 <ed76968d-55b5-79c5-61d1-40e8d2842421@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed76968d-55b5-79c5-61d1-40e8d2842421@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 06:54:27AM -0700, Guenter Roeck wrote:
> On 5/26/20 11:52 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.6.15 release.
> > There are 126 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 28 May 2020 18:36:22 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 431 pass: 431 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
