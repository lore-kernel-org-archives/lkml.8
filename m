Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE001C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC8C20732
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580770276;
	bh=WnMnyvktE5IVTSQXx7/xkKQiDMFaDuYtisTeopfQFkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gI+aWiKT8/Gt9HDJavrMpCIZuTZa+xJqFuYh0ALDO8yn1HeaAj3aSdITwFUVftAyd
	 79pTeydRlXpB84CwWFu7ku1Vq6cIHmGc49xrdwgP+mp9rUGow/g+KtX/z4Ld6dj4g9
	 AGxsv8BS7RP+oRe2c31uiVzwSQKg9G1ewkngZ5Tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBCWvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:60762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgBCWvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:51:15 -0500
Received: from localhost (unknown [167.98.85.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3453020720;
        Mon,  3 Feb 2020 22:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580770273;
        bh=WnMnyvktE5IVTSQXx7/xkKQiDMFaDuYtisTeopfQFkM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mdP89jz3i3RSrWtttLc7Q9Phh/NELRf5ul9nrtBTbS86lH8+/hoUvTCtgm30WLZ3r
         QZYsEvNgU9KiUbvuwHtAaNMNBowAgiB6uDLFP2v+WweIA4l2ZpnA/mUJ7jvCpP4LE3
         HCHhSBW38A5OALVVOponY/uOa00xma8K6wGWol54=
Date:   Mon, 3 Feb 2020 22:51:11 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.5 00/23] 5.5.2-stable review
Message-ID: <20200203225111.GA3925646@kroah.com>
References: <20200203161902.288335885@linuxfoundation.org>
 <10cd3c5f-0a2a-f73c-f071-17d1cc33531b@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10cd3c5f-0a2a-f73c-f071-17d1cc33531b@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 09:40:21PM +0000, Jon Hunter wrote:
> 
> On 03/02/2020 16:20, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.5.2 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.2-rc1.gz
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
> Linux version:	5.5.2-rc1-g8dc0cb8ae177
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra210-p3450-0000,
>                 tegra30-cardhu-a04
> 

Thanks for testing all of these so quickly and letting me know.

greg k-h
