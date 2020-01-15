Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0865C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843F22467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579075969;
	bh=nk37Yuy3ehqNqReCRqm9scpbx9tu94gE73chRFUUDFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j63SP85VANQa2HDbgH084r8cJNxLsTcwv6SL8UDYLiUULI+F+Z3PXvjnjBzZq8t2c
	 UVhsz1IdCB9lusz2VrEUATNHeFAOJFQG+VXfZFhe4Rc3exiGsxehHMGKT0eFz8TOyl
	 4oyhisdLBLoRZQtWaN2ZbX+gDFNggACjcAXqL3VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAOIMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:12:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgAOIMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:12:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A66324671;
        Wed, 15 Jan 2020 08:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579075968;
        bh=nk37Yuy3ehqNqReCRqm9scpbx9tu94gE73chRFUUDFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QPkM+mcjlqEHMQrqDspRSuC4hK//RkTdmwh5QwN0QtLbwd5a2ARrJ3NwlortMVWFE
         XCZbdZ7TJImM+i0LJ8jOBpXwTciBu1mMiZfTKdZxnSnQfrcAcFSPMksq9/5bvGiGDE
         rEo2DxmgHvWoM1p0FwPlNu1OVXqurh3PBgLIIsRA=
Date:   Wed, 15 Jan 2020 09:12:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 00/78] 5.4.12-stable review
Message-ID: <20200115081245.GA2977551@kroah.com>
References: <20200114094352.428808181@linuxfoundation.org>
 <1d43091c-c7ff-ed26-c3f9-207a291ed157@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d43091c-c7ff-ed26-c3f9-207a291ed157@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 08:09:11PM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 1/14/20 4:00 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.12 release.
> > There are 78 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 16 Jan 2020 09:41:58 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.12-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
