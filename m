Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF030C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 07:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1D502080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599377825;
	bh=OIz8h/6QwPMWXdHna/eW6akmH0aWYub1doBQ699tMNA=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=zKF3/lKWRMwDH04HIdjl6hnhiwQJ3h/UP9/18OdtFEbw0us3fXDTPCxzldfkx0io+
	 TYuFDoAtSUcJ3N4I2MlIDlX26U8gdgdqsaR1GO2C4rJAyJx3C7MH7l/aHDfD7m4X5B
	 Zdu8pLcXKfbsURLUV3BkNhAfHtAvZ5I3wuMxDEHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgIFHhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 03:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgIFHhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 03:37:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13A220759;
        Sun,  6 Sep 2020 07:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599377823;
        bh=OIz8h/6QwPMWXdHna/eW6akmH0aWYub1doBQ699tMNA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=TkRFfgSNEQIpxJHCHwKRJ9S55Y5LL+y7CcC5JDOVSND7tZiegDhnkXieURk8rXlVa
         izoWTZQoYsji9xcCcsAyTLpxsQzIiuf8+ecRFl6lyZ8egi/ULaLBjOFQvjhkA3yeI4
         4lVp80fsjWHhmpge0mC8x2R6ruoYSR0ks45ARFlk=
Date:   Sun, 6 Sep 2020 09:37:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 5.4 00/16] 5.4.63-rc1 review
Message-ID: <20200906073700.GA209646@kroah.com>
References: <20200904120257.203708503@linuxfoundation.org>
 <20200905153458.hdamqfp6eq4oyeq6@nuc.therub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905153458.hdamqfp6eq4oyeq6@nuc.therub.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 10:34:58AM -0500, Dan Rue wrote:
> On Fri, Sep 04, 2020 at 03:29:53PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.63 release.
> > There are 16 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> 
> Sorry for the delay - we are short handed this weekend and I got
> confused looking at results yesterday and thought we had a systems
> problem. In fact, the problem was that tags/releases weren't pushed to
> stable-rc which split-brains our results and I just forgot about that
> possibility. Is it possible on your side to automate updating the
> stable-rc repo when you publish a stable release?

Yes, I need to do that, sorry.  Will work on that this week...

> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

THanks for testing both of these, and sorry it crossed a weekend.

greg k-h
