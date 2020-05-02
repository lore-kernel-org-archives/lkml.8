Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D9AC47247
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 05:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022CA24959
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 05:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588399087;
	bh=opgmUo41HjFfWtFggOSI+R8DGipbb/58MVzKPh8fOQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xaJuppTlox/8BhpT0ZIuJMcS7GJLZ065xmtBv0E0Ev/WYU0jDEvIcBH9tcN88vNCO
	 FywgMxHmsKWWQYjT17O7ksSSbM9D5023ZE6ZZLicutD4M2aGC9xi31ZlLM+1zzxz/7
	 EjMKrf7t+a7YnhJrVZ7FhrEf2bDUYwJRU0QGdK/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEBF6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 01:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgEBF6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 01:58:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02D03208DB;
        Sat,  2 May 2020 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588399084;
        bh=opgmUo41HjFfWtFggOSI+R8DGipbb/58MVzKPh8fOQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fn08yGVJ2g+2s9xjJPlq/TsRj8C1Gsr/tXPDuuJy9Hb5DYNCUHrBIeOUXhH1HFplA
         RXCsTgRexDggfAmFKjdNPZJs24AAZZK2Et9Ax/0p3gNNNyEphPZhgw9W07RBz67tys
         Qh7p3R+TWP2N5FQim/bO3G4IqjsebMSMt+rX7Dfo=
Date:   Sat, 2 May 2020 07:58:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5.6 000/106] 5.6.9-rc1 review
Message-ID: <20200502055802.GC2516731@kroah.com>
References: <20200501131543.421333643@linuxfoundation.org>
 <0d85912b-9bea-91c1-0eaf-f029d82166a1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d85912b-9bea-91c1-0eaf-f029d82166a1@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:17:41PM +0100, Jon Hunter wrote:
> 
> On 01/05/2020 14:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.6.9 release.
> > There are 106 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 03 May 2020 13:12:02 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.9-rc1.gz
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
> Linux version:	5.6.9-rc1-g96c73ff08986
> Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra194-p2972-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra210-p3450-0000,
>                 tegra30-cardhu-a04

Thanks for testing all of these and letting me know.

greg k-h
