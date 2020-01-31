Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C091C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A722173E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580505896;
	bh=oP0QDkNpgO99NHwEI5Z+l29jb55HfLJWvghf9WDu2S0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GGCeOmLA3npy0923mH7s7Mz5wvD02vLSKcAPVjEAowr6QalkS1ZjZ5y34ooVNOsN5
	 /ijKBvh5K8mnF5tT1LQoZFGz5Ch78Yqz5oCO/uYo+k8rRxttYP5JtDX0wmOWqcUzqo
	 +zFv1g5pWTCkiNB0fqa+bqUmhlQBaa370l7CTEKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgAaVYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:24:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:49320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgAaVYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:24:55 -0500
Received: from localhost (unknown [83.216.75.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0959720CC7;
        Fri, 31 Jan 2020 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580505894;
        bh=oP0QDkNpgO99NHwEI5Z+l29jb55HfLJWvghf9WDu2S0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sz88run3o93+OWa1zNAMicqs1we6wv0rs4+6Lw5Ik5wEjVm6bbcOFiKOQBJM8Aawd
         fwa/onRAFWMPpym4yyRC3ya35tnLeEttFqcm9mCBLzoD+8iOYyK42U0Nv1PNkz4rd+
         dk7g2HBnTzqWOWdSAEscHD1JpF5diNROkUvygZag=
Date:   Fri, 31 Jan 2020 22:24:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.5 00/56] 5.5.1-stable review
Message-ID: <20200131212452.GB2278356@kroah.com>
References: <20200130183608.849023566@linuxfoundation.org>
 <69db1365-4b9a-0e58-4998-c9275bbc8f83@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69db1365-4b9a-0e58-4998-c9275bbc8f83@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 11:04:11AM +0000, Jon Hunter wrote:
> 
> On 30/01/2020 18:38, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.5.1 release.
> > There are 56 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 01 Feb 2020 18:35:06 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.1-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> All tests are passing for Tegra ...
> 
> Test results for stable-v5.5:
>     13 builds:	13 pass, 0 fail
>     22 boots:	22 pass, 0 fail
>     40 tests:	40 pass, 0 fail
> 
> Linux version:	5.5.1-rc1-gad64b54689dd
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra210-p3450-0000,
>                 tegra30-cardhu-a04

Thanks for testing all of these and letting me know.

greg k-h
