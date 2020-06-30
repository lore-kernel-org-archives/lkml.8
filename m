Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F50EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7060D207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593506331;
	bh=CJ+C8ZdKsvhVaVIQGe4TZRTwKW7+G3J0siGkh8wZTdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O8hCNazm9UFebhPcPy8JGFyOwqhdW0X75CFkf75HtGTsPkLlV7d7Qqa5F3k2sh8bu
	 lodA7izpJehjftxj7e7tFWY9L/AdFlonF+Uu3LWf1eylQlGDE885ReJgpv7hPBzYdp
	 7u9d41OpKkMzYWNeiW9f02AcPxg+pvw2WvYtw0Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgF3Iiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbgF3Iit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:38:49 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FFDF206BE;
        Tue, 30 Jun 2020 08:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593506328;
        bh=CJ+C8ZdKsvhVaVIQGe4TZRTwKW7+G3J0siGkh8wZTdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZahWUwe6PFeTP3M0qu7LY5NLQwEnX83/pGSmNb08y/7YYeIPPogEea0UrvqCOqOxK
         4mbZ01TEfqtiKeMvpLoz4cu26UR3wnPzKZUlo2EL57EZ7rGoehaideIYfbJ9/VBFgc
         dZ3ALWv6NKFaygERtyLtGnJTNnKeWFbX5LzpvGMA=
Date:   Tue, 30 Jun 2020 10:38:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org
Subject: Re: [PATCH 5.7 000/265] 5.7.7-rc1 review
Message-ID: <20200630083845.GA637154@kroah.com>
References: <20200629151818.2493727-1-sashal@kernel.org>
 <42dadde8-04c0-863b-651a-1959a3d85494@linuxfoundation.org>
 <20200629231826.GT1931@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629231826.GT1931@sasha-vm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 07:18:26PM -0400, Sasha Levin wrote:
> On Mon, Jun 29, 2020 at 02:37:53PM -0600, Shuah Khan wrote:
> > Hi Sasha,
> > 
> > On 6/29/20 9:13 AM, Sasha Levin wrote:
> > > 
> > > This is the start of the stable review cycle for the 5.7.7 release.
> > > There are 265 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed 01 Jul 2020 03:14:48 PM UTC.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > > 	https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.7.y&id2=v5.7.6
> > > 
> > 
> > Looks like patch naming convention has changed. My scripts look
> > for the following convention Greg uses. Are you planning to use
> > the above going forward? My scripts failed looking for the usual
> > naming convention.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.6-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.7.y
> > and the diffstat can be found below.
> 
> Sorry for that. I was hoping to avoid using the signed upload mechanism
> Greg was using by simply pointing the links to automatically generated
> patches on cgit (the git.kernel.org interface).
> 
> Would it be ok to change the pattern matching here? Something like this
> should work for both Greg's format and my own (and whatever may come
> next):
> 
> 	grep -A1 "The whole patch series can be found in one patch at:" | tail -n1 | sed 's/\t//'

If those don't work, I can still push out -rc1 patches.

It might be best given that the above -rc.git tree is unstable and can,
and will, change, and patches stored on kernel.org will not.

thanks,

greg k-h
