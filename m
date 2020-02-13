Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A395C3B190
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F55D21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 23:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581635141;
	bh=CUZDHl7TVBOCTWU/9IGjTpj26LMuMrCuo/S82CdGO1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xNys1Zev/DfkfINF2HMEcAOO1Wp1SFr9yTlvW+m/kGZrXsgr8eFj0Vuh5TIQ8BFls
	 DDRc/GFBvl6tzcc6xQFb8Hx+av3PMa2wlKZh01WuxDpppNUMA7SF/ZdR6B4N0j7KrP
	 VnOudoAscDlDOackZD50zUNK+ZnHUkA+Ua3l2pyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBMXFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 18:05:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMXFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 18:05:40 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 957CA20675;
        Thu, 13 Feb 2020 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581635139;
        bh=CUZDHl7TVBOCTWU/9IGjTpj26LMuMrCuo/S82CdGO1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xjov0OrjPwJr/Y2IKHNxQ+zrMdFLlQIRADGCm9/slIYttGCDt9DnQJdfp3tDWz/2i
         Z9cnEf/d2B9z8qhwQBBAhY7em4Rh4eH3OLJVPnt9mkKRlu6+I9ZlNWwnQ8fmplo2G+
         sEskCJmC+u0Mt9I66YhPBhnZMFCl+QAPmrgkzLuA=
Date:   Thu, 13 Feb 2020 15:05:39 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 00/96] 5.4.20-stable review
Message-ID: <20200213230539.GC3878275@kroah.com>
References: <20200213151839.156309910@linuxfoundation.org>
 <20200213222732.GA20637@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213222732.GA20637@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:27:32PM -0800, Guenter Roeck wrote:
> On Thu, Feb 13, 2020 at 07:20:07AM -0800, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.20 release.
> > There are 96 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 15 Feb 2020 15:16:40 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build reference: v5.4.19-98-gdfae536f94c2
> gcc version: powerpc64-linux-gcc (GCC) 9.2.0
> 
> Building powerpc:defconfig ... failed
> --------------
> Error log:
> drivers/rtc/rtc-ds1307.c:1570:21: error: variable 'regmap_config' has initializer but incomplete type
>  1570 | static const struct regmap_config regmap_config = {
> 
> Bisect log below. Looks like the the definition of "not needed"
> needs an update.

Nice catch, sorry about that.  I've dropped the offending commit and
will push out -rc2 releases for both 5.5.y and 5.4.y.

thanks,

greg k-h
