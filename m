Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB03DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0ED2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597162821;
	bh=560RLAr2CC8DsyQDfdrVgGa0PUW6VVnYsSWEajK45vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ED6CWxrjeLp8rACwZ3sRz67f6W4r9nf7vCI8XBV/sFb9IWhO+F0F6HBzXQYKGlYuy
	 UVsfM34RpBHp2M/Uek2rWyaOwMEG6FM8X/pSw7l0wxjnK1StvfTeLjHKiR81mHUriR
	 O3hqRj0LNnRsN0CUUEsOUT8uM5jixI/y3MJ7zL98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgHKQUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgHKQUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:20:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A242206B5;
        Tue, 11 Aug 2020 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597162820;
        bh=560RLAr2CC8DsyQDfdrVgGa0PUW6VVnYsSWEajK45vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSDmjBIjA4lPu1MEPURG0xdd/3LlJnySfQPGzQHenDweMnBzT9CRaS+zCO0QlKSOI
         6+evWblw1atF+KQvK/lRrqaAGpH5sviH7J2MJwwzh3U+GLqlIEO489l18Y7MSNgSYj
         Ma129BJVHgzY9mpiVuj7P40hCFtpivHsH7gfL2Kk=
Date:   Tue, 11 Aug 2020 18:20:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.8 00/38] 5.8.1-rc1 review
Message-ID: <20200811162029.GD440280@kroah.com>
References: <20200810151803.920113428@linuxfoundation.org>
 <20200811142417.GD195702@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811142417.GD195702@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:24:17AM -0700, Guenter Roeck wrote:
> On Mon, Aug 10, 2020 at 05:18:50PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.8.1 release.
> > There are 38 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 12 Aug 2020 15:17:47 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 151 pass: 151 fail: 0
> Qemu test results:
> 	total: 430 pass: 430 fail: 0

Great, thanks for testing all of them and letting me know.

greg k-h
