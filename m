Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893B4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F55721D95
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596010886;
	bh=RGd0GtquPwow/H/h1jo+bv6mNBeDVKUjoL5I9qGsWjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j2RGSSRM4mTEWh6XlLw0QEZayTSnthdqQN0MUf0lhGNe/ZkkiLegb1GhkQMEuy0Vy
	 D8FVgiTdWY9XNJySibtJfXY3fpx5f/lzT/ioQ6IGpOYgXna5M2qjpu7qrnWf1an+JL
	 tz39kGMrkkO5JLyoArqe7VERExDtJyXIMkp0EKtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgG2IVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2IVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:21:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97FAC206D4;
        Wed, 29 Jul 2020 08:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596010883;
        bh=RGd0GtquPwow/H/h1jo+bv6mNBeDVKUjoL5I9qGsWjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kvDh4Ivq1qifkU6ugzlMsEwktazzFY51KYAVcubMdNGduqtvZln9+xESPIlnK8yet
         5Dz3UZ1pSulPh1lwIfgwljtstStmgDpJ/IZo0CU5YVx2Dv9Lmdq7KrtLz5MfdP5eYA
         +2KG653m5ohnWRXJ44WWZjlcIeSK2XsLgnSEB6T8=
Date:   Wed, 29 Jul 2020 10:21:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.7 000/179] 5.7.11-rc1 review
Message-ID: <20200729082114.GA529870@kroah.com>
References: <20200727134932.659499757@linuxfoundation.org>
 <63f634e5-e2bb-fea4-90da-774790ced38d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f634e5-e2bb-fea4-90da-774790ced38d@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:31:20PM -0600, Shuah Khan wrote:
> On 7/27/20 8:02 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.7.11 release.
> > There are 179 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 29 Jul 2020 13:48:51 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.11-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.
> 
> Tested-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks for testing all of these and letting me know.

And I've added your tested-by: to the release commit as well, thanks for
that.

greg k-h
