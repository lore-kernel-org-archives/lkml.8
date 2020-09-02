Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026B2C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFF820826
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599032218;
	bh=UDYaPWY1oS3KWoU/8ARko6bgUSNf6ai7JxlKBzaoMlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dTJQ31Mpp5HHnyqvcaOSDyh6to/sHWcpm1AU+LDWFTkAhHs7XCR4+KxwXHKHfHfGa
	 8kvFq4khSbT+fHQ4ZgEQZZiL2rc59cZEO00RB3Nmw0i4Wgd902fC9Crsr5zim6YS92
	 cnocua4OKNhd/h9E9qvGXm4REZdyMdSZ46yx+xmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgIBHg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBHg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:36:57 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDF3207EA;
        Wed,  2 Sep 2020 07:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599032216;
        bh=UDYaPWY1oS3KWoU/8ARko6bgUSNf6ai7JxlKBzaoMlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5R/Ho1E6MREUe5fjYWmIoFjRcgGtDcdecaBREcVjCqXcBsJ1lLHkzAYcNutGZ4SD
         dTls0LY/Tne61QllzoY5Or+ugKESsyQzi7WtbtQbwW5jNN3AEIiQRbKg/Tq0R6gaiB
         jut2t1ndFZISC8r7+oQi+BUpTyfW1XhkLJzWpEOY=
Date:   Wed, 2 Sep 2020 09:37:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/62] 4.4.235-rc1 review
Message-ID: <20200902073722.GD1610179@kroah.com>
References: <20200901150920.697676718@linuxfoundation.org>
 <76622586-3742-692a-c9de-994ac21c5257@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76622586-3742-692a-c9de-994ac21c5257@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:58:21AM -0700, Guenter Roeck wrote:
> On 9/1/20 8:09 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.235 release.
> > There are 62 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Building powerpc:defconfig ... failed
> --------------
> Error log:
> arch/powerpc/perf/core-book3s.c: In function ‘record_and_restart’:
> arch/powerpc/perf/core-book3s.c:2045:7: error: implicit declaration of function ‘perf_event_account_interrupt’; did you mean ‘perf_event_interrupt’? [-Werror=implicit-function-declaration]
>    if (perf_event_account_interrupt(event))
> 
> Caused by commit 91d6f90ac6d5 ("powerpc/perf: Fix soft lockups due
> to missed interrupt accounting"). perf_event_account_interrupt()
> does not exist in v4.4.y.

Ah, good catch.  Sasha, I thought your builder would have got this one?

Anyway, now dropped, I'll push out a -rc2 for this as well soon.

thanks,

greg k-h
