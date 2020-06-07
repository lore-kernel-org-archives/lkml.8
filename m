Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD179C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 11:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B10920723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 11:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591528770;
	bh=53gxRq5Z1RxBMufkh7Ra9d+t2aZTO0FwRsxwlOvy99M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ebtmDymxd0gpLWd+A95GHSMLGVFU7F/Wa13SeNZrUDTYC7ozHz4K76RY6UytFuj0c
	 bGvWlOhCEmyO1wskGs1grot8lc4jD4Nzuzjf9OVLPY37ObnJelXVcWvQx8fyULpPa/
	 JJ6jL/Qakr5Livl7WJ9uzM/CvmFnNWN2MsAQKA+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgFGLTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 07:19:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgFGLT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 07:19:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7E620663;
        Sun,  7 Jun 2020 11:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591528769;
        bh=53gxRq5Z1RxBMufkh7Ra9d+t2aZTO0FwRsxwlOvy99M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bVXhibNYvg203iNlAdTjDmBFrnd0aBWDg+CLLvfSGljPzpzec41KVyROMEYWuSOZ5
         8OGgFhdXrlP0KIQ3agfCJH6ENUUVD+obWbuOqawtyLqy6THc9P5g0UWtv7dZ9mi3LE
         gXeEQGaeFI4n9F27uhR9HR3g/Filo0MJndw1n07A=
Date:   Sun, 7 Jun 2020 13:19:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.7 00/14] 5.7.1-rc1 review
Message-ID: <20200607111927.GC47740@kroah.com>
References: <20200605135951.018731965@linuxfoundation.org>
 <77f30512-ff14-47a4-9350-9fd4151657a9@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f30512-ff14-47a4-9350-9fd4151657a9@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 06, 2020 at 06:34:48AM -0700, Guenter Roeck wrote:
> On 6/5/20 7:14 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.7.1 release.
> > There are 14 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 07 Jun 2020 13:54:56 +0000.
> > Anything received after that time might be too late.
> > 
> 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 431 pass: 431 fail: 0

Great, thanks for testing all of these and letting me know.

greg k-h
