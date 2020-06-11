Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254932075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591860008;
	bh=bnCLhFb41/ByH7JOGM2QcQBEP4Rn0x1oFtSRYvbto/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fdq04xBb3E49FVmi8qvusnS6m9h7eXZw/Y7N+DZluyhiiCB1PVlcHV4fk19SnucEO
	 9x4TE59U9I1kW0USaI3Lz8y7Be19ofaBAAJVGJs/ttZERLhsj4yZJlx4zlvbfV0dMP
	 I9kJ2fKDhnITX38N9Kt4WqCMsDQihOSxYFd1Xj6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFKHUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbgFKHUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:20:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74522074B;
        Thu, 11 Jun 2020 07:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591860006;
        bh=bnCLhFb41/ByH7JOGM2QcQBEP4Rn0x1oFtSRYvbto/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwK/W9XNxtn9IcxJStz+eCCfhtuqYQK2ouPXvGF3JPKqCNPm0fodZrJaJgfSFdr8k
         /uxxxKr4Xy0n2HoLkkzCNTCFb/SW9x40JlWciNCuIR2caSQyk4EHz4Pfxno0eRcgr1
         M/z0rAGC5iOFbd10BcArVaAzeHg2JS2xtG/Dw5JI=
Date:   Thu, 11 Jun 2020 09:20:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.7 00/24] 5.7.2-rc1 review
Message-ID: <20200611072000.GC2637725@kroah.com>
References: <20200609174149.255223112@linuxfoundation.org>
 <20200610191133.GH232340@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610191133.GH232340@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 12:11:33PM -0700, Guenter Roeck wrote:
> On Tue, Jun 09, 2020 at 07:45:31PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.7.2 release.
> > There are 24 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 11 Jun 2020 17:41:38 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 431 pass: 431 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
