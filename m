Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0B7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875E320B80
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590573687;
	bh=9wa7osKVq8G8KRV4UBClAM7K0DIQxJQ1DAeZp+MGtP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PYbraM7exrLz0Nguisg4bedS3tf1Wb0xz4kX4nf3B7/KTDZKucaFGZ282IXbhFLfD
	 IoLgeJI4m3hMLenMp4A563UOYaTwUxAnNM/bx/Ppz75FP8MFCcXAZeZiaO6+S3j47G
	 lFaYZv3uQZRWxJLqfJpF5iNJ2M1Tsd53/tnVKv1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbgE0KBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:01:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgE0KBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:01:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 993F92084C;
        Wed, 27 May 2020 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590573682;
        bh=9wa7osKVq8G8KRV4UBClAM7K0DIQxJQ1DAeZp+MGtP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzPzZQw0Lu6ffUH+LzQ8WlnVeUShSkRaMiu1fnr9uTH86FvrFNodRcI3Dhr3+ciO2
         DENjVdi1xDG9fYfKb/kQT/m0GCr+lhy0HwjpIAnnDXb2R3xMUmW2kMklAOWesQVi/m
         NGBFEYsV/dHVLTD5gK0Lo5tzzpoLZtacGCllZE90=
Date:   Wed, 27 May 2020 12:01:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.6 000/126] 5.6.15-rc1 review
Message-ID: <20200527100119.GC277684@kroah.com>
References: <20200526183937.471379031@linuxfoundation.org>
 <CA+G9fYtbi+qgdu9ZeHPxKZyqON18WUdK1i=f9YpFQ2t58JCO-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtbi+qgdu9ZeHPxKZyqON18WUdK1i=f9YpFQ2t58JCO-g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 01:47:41PM +0530, Naresh Kamboju wrote:
> On Wed, 27 May 2020 at 00:46, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.6.15 release.
> > There are 126 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 28 May 2020 18:36:22 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.15-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Great!  That was fast, thanks for testing them all and letting me know.

greg k-h
