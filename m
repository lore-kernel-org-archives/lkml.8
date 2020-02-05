Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27667C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A0B217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580907751;
	bh=JO0PiD6GAtZW4R/gNGJ7SITTwqtP29t+uZTX1Ax5Gtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G1I8hKlpN+m3y1k978Rq0544Xjmp0FUKHncYYlaFNLHmrJ2if9BajB9IL9lSGuo3W
	 HY/w4L61fCkYN6n5BQxHNPcF49+GyRXvsIp4ugXfdChsg0JziDc/OgYqR8GB2X/yBi
	 E0cN6gJ+yWUIR0anesoKg+EP1rEISp/GHvgCXm6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgBENCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:02:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgBENC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:02:29 -0500
Received: from localhost (unknown [212.187.182.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2F1A218AC;
        Wed,  5 Feb 2020 13:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580907748;
        bh=JO0PiD6GAtZW4R/gNGJ7SITTwqtP29t+uZTX1Ax5Gtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HC04tIk7WLAY+u93dDpB0rQ6/y46U6V8mv0IkUa7eEjKHmRdpw93PhOQyO5ttx8Pf
         EGR+PMk7kETqvVGc9ZR0vg2njXsNVgkD/HsHjKfL384nx3nB5NfbAUT8MNf8T9z00L
         XzzKWEarx9vbjzo5UMrmA3c03ESZwgl3MvQfwBGY=
Date:   Wed, 5 Feb 2020 13:02:25 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/53] 4.4.213-stable review
Message-ID: <20200205130225.GB1199959@kroah.com>
References: <20200203161902.714326084@linuxfoundation.org>
 <3bd0423b-478e-d626-88e7-5d62167ee7e0@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd0423b-478e-d626-88e7-5d62167ee7e0@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 06:43:58AM -0800, Guenter Roeck wrote:
> On 2/3/20 8:18 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.213 release.
> > There are 53 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> > Anything received after that time might be too late.
> > 
> 
> arm:{allmodconfig, omap2plus_defconfig, imx_v6_v7_defconfig}"
> 
> arch/arm/kernel/hyp-stub.S: Assembler messages:
> arch/arm/kernel/hyp-stub.S:147: Error: selected processor does not support `ubfx r7,r7,#16,#4' in ARM mode

Thanks, have now dropped the offending patch.

greg k-h
