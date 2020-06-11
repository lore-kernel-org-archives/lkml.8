Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3123C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915B4207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591859987;
	bh=gMMtTQFVkMf6IKKMKJKbN6xgkfHJXO/dI/WduuxiJBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gnMdiySUt/9aykfINMjrC9+Vzg+9bYQheTQ4sWnOSmbQVU5YemZmrU/F49218rGaI
	 /g0ZqC/sIuh3c5iQSWJTRu8fb4fbAwMs5Rzg9gOW3mKosopugCJ6n8EKBIvPw0xrS6
	 9/kFAIIn81XOvSQPD4DNSDMmqp841YhdqhTR7J8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgFKHTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKHTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:19:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F7822074B;
        Thu, 11 Jun 2020 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591859984;
        bh=gMMtTQFVkMf6IKKMKJKbN6xgkfHJXO/dI/WduuxiJBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N8QwY+MCjDK25bwxpv/ERXM1PmxkV7Hd5cjeowAYkgNjBI9wGf4o2TZ9wT8UWiEOT
         A2G0SdkoFgPwjDsVFsmwisRoFo7n7gR79iiV9b+B5A+2e4KL5Ev80fPDqzxiXuI+34
         x5QUQ7nAcK4s13ZB7VYxcyViVSgS0PuQvukJH3eo=
Date:   Thu, 11 Jun 2020 09:19:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/36] 4.4.227-rc2 review
Message-ID: <20200611071938.GB2637725@kroah.com>
References: <20200609190211.793882726@linuxfoundation.org>
 <d78b5b05-2f40-9152-1752-4a1823d0ab46@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d78b5b05-2f40-9152-1752-4a1823d0ab46@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:37:56PM -0600, Shuah Khan wrote:
> On 6/9/20 1:18 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.227 release.
> > There are 36 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 11 Jun 2020 19:02:00 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.227-rc2.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
