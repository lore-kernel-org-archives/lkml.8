Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8636EC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286BB20735
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583951308;
	bh=lW4JIv7aa68oSCknjnA/9gvAsIpDfxMJp7nWCIG5B34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JERfGOqFM5vH865jlGPFJ0Gsz/yFAybpcV26eALEZEo9GHk2kWo5XichOFIOmdE6F
	 C9Lid61tc1hTHKjwh8OzxD6XXpnfz+VmY95FeXbji0Co8Jw7rlf7LF7/bep0UahPVa
	 ofiFkg9wW30uv3Iq7El1dn8hU/vHMFWHvloVpnOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730855AbgCKS20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730468AbgCKS20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:28:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C97DF2072F;
        Wed, 11 Mar 2020 18:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583951306;
        bh=lW4JIv7aa68oSCknjnA/9gvAsIpDfxMJp7nWCIG5B34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dBMzRBwStYgZb348uwVYx1xMQStiMomc4gh55B6cktIdpyZKoQbsV8V9SUpoDWYQh
         VkgzVPjy0TplqmFgywaG3pJHIQtEray1b40ahvA0rqlOjkH5gzNzmRwU4jpcosKIaB
         roUif+wLMlMevaEtd5/cEQldD1SLtHIIizRgeFFA=
Date:   Wed, 11 Mar 2020 19:28:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.5 000/189] 5.5.9-stable review
Message-ID: <20200311182823.GB4021147@kroah.com>
References: <20200310123639.608886314@linuxfoundation.org>
 <80505589-baa7-2428-d392-a6ede33bf6fc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80505589-baa7-2428-d392-a6ede33bf6fc@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:15:39PM -0600, shuah wrote:
> On 3/10/20 6:37 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.5.9 release.
> > There are 189 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 12 Mar 2020 12:34:10 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.9-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
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
