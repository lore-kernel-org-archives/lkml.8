Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB1FC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8E7207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580283100;
	bh=gwfKxRFodf8q2QiJ7MSmoFa07bd7ZseuAdVSv7DBo7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xv4WCW9IPLWwqbxbMx5eJdQPqvHh1D8SwiPrTpMoy9mxA8sXWq3XTzLKh4PqjJ3UU
	 +vo2IkICNMBdGcbmOOq3Diy+wamy5+NJvDH31e9PkHG1sNzt6FSaodea1x6lD0BbIZ
	 IFOM+1OODDNimRU7U1zZlLd7QmYaiju+neh0moMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgA2Hbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 02:31:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgA2Hbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 02:31:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E1E20708;
        Wed, 29 Jan 2020 07:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580283099;
        bh=gwfKxRFodf8q2QiJ7MSmoFa07bd7ZseuAdVSv7DBo7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2cGBdHpENqO2Y5mo1KCCswcGrub9aySmK3y1TGuOmpHZB/9WCYhLZrtT8jk+TWyqo
         1OYYlzAM9z2lXJM5V7WPAr3xOXlG1AA1L0+s7CYl7nnmxQrR6Ftt6PNjfTSWVidp8f
         fWSQbGMBdhvOArfNg41GgB2jJQxWsLXYPCh3eb3A=
Date:   Wed, 29 Jan 2020 08:31:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/271] 4.9.212-stable review
Message-ID: <20200129073136.GA3772981@kroah.com>
References: <20200128135852.449088278@linuxfoundation.org>
 <20200128204221.GB16941@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128204221.GB16941@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 12:42:21PM -0800, Guenter Roeck wrote:
> On Tue, Jan 28, 2020 at 03:02:29PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.212 release.
> > There are 271 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 30 Jan 2020 13:57:09 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For v4.9.211-272-g91ff8226a074:
> 
> Build results:
> 	total: 172 pass: 172 fail: 0
> Qemu test results:
> 	total: 357 pass: 357 fail: 0

Thanks for testing these two so quickly and letting me know they worked.

greg k-h
