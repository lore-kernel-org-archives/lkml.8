Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B438EC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8139D22527
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583932300;
	bh=8l8WIbCR3/RZOnjBsS5vKoi3SDeXiBug5gV1pri3J+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xNkZFtBUMQ0VjBpqCsmJ8ZKsN7lFeMG1bWYgmQXFvUMCrJIpLyfgr/yrX2s9sR+ul
	 pofX5jAk1u34HHd1vHOw/kJOy+8yC0/VXIfWDsN5zN1aZP2k1egJMrdDasMRY4gQp6
	 haX6v82e0rEZnxlB1ia1Sumj0/6T9qKWkYHASUVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgCKNLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:11:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgCKNLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:11:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5504D22464;
        Wed, 11 Mar 2020 13:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583932298;
        bh=8l8WIbCR3/RZOnjBsS5vKoi3SDeXiBug5gV1pri3J+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=np/uxnDnOfaQj05Y5YJvlJ2IZPj+Qqkif88fg9woeCxyLGtjVqTKentb6oBIvNJWn
         IToz72p6d8h4kv1jEMEXFvLlL3XrCW1DpKPOFU0OwGKhqFyCgHGGCP6J/xslBMhSqj
         wihEQCA0AwIK4rAotJOTR0OFmxYw73DqotuNS48k=
Date:   Wed, 11 Mar 2020 14:11:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/126] 4.14.173-stable review
Message-ID: <20200311131135.GA3856613@kroah.com>
References: <20200310124203.704193207@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 01:40:21PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.173 release.
> There are 126 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Mar 2020 12:41:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.173-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.

I have pushed out a -rc2 release to resolve a reported KVM problem now.
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.173-rc2.gz

thanks,

greg k-h
