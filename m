Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351DAC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C6120838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579887445;
	bh=jVgs4yxvjm/D3IicuAVGJAnb8hZ0lRIStSmtw1Js5nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UiKORV1K5k8rTW86MXVryLlrAXpLo+EuX82oX1izXlvlLXTixiwPdMNfreRxkBUU0
	 dJ3qnm0wbukJtnX+vWoqMChv6ITW5hA7SUZseeUdS8vM3mD+3qOhystZZjnVIv+o1b
	 OhVVDfEXwEPIy+6iEaEccKZghidZpEviHc4heS74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbgAXRhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:56478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390106AbgAXRhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:37:22 -0500
Received: from localhost (unknown [84.241.198.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EBC32087E;
        Fri, 24 Jan 2020 17:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579887441;
        bh=jVgs4yxvjm/D3IicuAVGJAnb8hZ0lRIStSmtw1Js5nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yu4r0j8T4e7ey6QMwRoOMwkRBJ2r0uXaAW/+KTDPPWQ37OyyxFBzLwLBQT02ImjFk
         phdWvbORLjYVh+Xfgwu+4iEGPq6P4HlzxbJsrOJDHwXfAZf8HqVeC0NprLMaj1hJYP
         lFB+R7c1aLZxD7mGNGFsCdzHdKrJzLVxcEqgMetk=
Date:   Fri, 24 Jan 2020 18:33:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/343] 4.14.168-stable review
Message-ID: <20200124173346.GB3166016@kroah.com>
References: <20200124092919.490687572@linuxfoundation.org>
 <6fce449c-e0d4-7660-bee6-578bd5cefeb2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fce449c-e0d4-7660-bee6-578bd5cefeb2@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 06:17:03AM -0800, Guenter Roeck wrote:
> On 1/24/20 1:26 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.168 release.
> > There are 343 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 26 Jan 2020 09:26:30 +0000.
> > Anything received after that time might be too late.
> > 
> 
> powerpc:allmodconfig:
> 
> arch/powerpc/kernel/kgdb.c: In function 'kgdb_arch_set_breakpoint':
> arch/powerpc/kernel/kgdb.c:451:8: error: implicit declaration of function 'probe_kernel_address'

Ah, nice catch, will go push out a -rc2 with this removed and with
Sasha's fixes.

thanks,

greg k-h
