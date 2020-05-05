Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F98C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4FE206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588702336;
	bh=eBlTRvSIheu5WMv7ZBONMrWpfIs5brxkxoq6Xueq2Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NXKPVzwqbPw33YMRMSvr/n2SS7wcctaiHgBWl4jsTWDdhw17QwKGbW5B35Qpasj0p
	 u0QJnHQYhX2jHlE2UKz+tZQIQmXu6ry+l1LIxSMqdXD4tln+CAp5BZsW8HnXJptno3
	 S/A+Faowps4tkLjJLiL2WrUrQ5/QTXQ965ysbPLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgEESMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbgEESMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:12:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD56206B8;
        Tue,  5 May 2020 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588702334;
        bh=eBlTRvSIheu5WMv7ZBONMrWpfIs5brxkxoq6Xueq2Us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=av1zvveOjaij6HEQ3RqRlAiz7eBex5suaICM6QytRT9ECSu3K9Hk9YO1/tJQiT5YZ
         6DH33eZEq8c3/aj1AmkfHSR2SAWWywRvANIEwLc8m9yLr3jGR608IuCNQx3Txw3PU7
         CF5BvIaNtZbaAuw14CMclQLFmOdkVWwT7cRxVsxk=
Date:   Tue, 5 May 2020 20:12:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.6 00/73] 5.6.11-rc1 review
Message-ID: <20200505181212.GA1210667@kroah.com>
References: <20200504165501.781878940@linuxfoundation.org>
 <2c85f997-cf6a-3013-09fc-a56417cc56d3@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c85f997-cf6a-3013-09fc-a56417cc56d3@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 08:45:59AM -0700, Guenter Roeck wrote:
> On 5/4/20 10:57 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.6.11 release.
> > There are 73 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 06 May 2020 16:52:55 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 427 pass: 427 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
