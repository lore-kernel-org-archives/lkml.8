Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F9C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824F52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587475355;
	bh=A5iNwUnYfVcplxMAFs2F56euY/pwlC7lC0GbKQZVvGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UNez9CjsIaLLm92VcJisv93pZ94RHQgLjHQkdi1RorxR1xP7lGsoaqE6m7zbOzOG0
	 zY0FLy79Oze/bQNTsLa0+RgYtU0A2Qy3TNkHoojwZxG3D44ua3bxtSDm+FcIeWGocH
	 UbN4qodOYfj4nt/4zvPjUFLg1YdHKDS0DXPsAplE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgDUNWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgDUNWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:22:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F14620753;
        Tue, 21 Apr 2020 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587475353;
        bh=A5iNwUnYfVcplxMAFs2F56euY/pwlC7lC0GbKQZVvGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pp5NWDguCXrpaftsHaRgdBBYUC8Bs91EQS8DkM+9b+ldZybRMm3xHxA5DyoKb/hCl
         P2RYil9mCB9yc66DSt8bRwxHF7mdr67NeNhzhtd45FcbNFk7Zrrep+HVRNdvSLEUsO
         Lv2MZJBmW6fdHMbqbYQqGM/f8wX2gpemjRMXRxA0=
Date:   Tue, 21 Apr 2020 15:22:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.6 00/71] 5.6.6-rc1 review
Message-ID: <20200421132231.GB794782@kroah.com>
References: <20200420121508.491252919@linuxfoundation.org>
 <59a68f6a-d37d-6a74-14e4-648861637185@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59a68f6a-d37d-6a74-14e4-648861637185@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 10:55:36AM +0100, Jon Hunter wrote:
> 
> On 20/04/2020 13:38, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.6.6 release.
> > There are 71 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 22 Apr 2020 12:10:36 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.6-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> All tests are passing for Tegra ...
> 
> Test results for stable-v5.6:
>     13 builds:	13 pass, 0 fail
>     24 boots:	24 pass, 0 fail
>     40 tests:	40 pass, 0 fail
> 
> Linux version:	5.6.6-rc1-g906ecc0031ed
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra210-p3450-0000,
>                 tegra30-cardhu-a04
> 

Thanks for testing all of these and letting me know.

greg k-h
