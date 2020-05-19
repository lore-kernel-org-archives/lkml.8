Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2040C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C45207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589907893;
	bh=njSEaIFh9RXLbuVk3Wkbg0wE3C25mo8/xTDnz+hRj+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGnn3cRPIpVzmw6IfUupQ8gcxZtz+/In54rwZTst6jnzonSPRcatYUwaY7rio79Tv
	 7fvLGMe0gEcjNoimN59nNo9laLWFLsz2tLTNr7rHIzTPZvfyMPAjutHXBHkf1glfNv
	 MFc/mURxF/fI0uk52gm+dKbC3xyG1BxUgOKXpMqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgESREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728778AbgESREw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:04:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0831B20708;
        Tue, 19 May 2020 17:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589907891;
        bh=njSEaIFh9RXLbuVk3Wkbg0wE3C25mo8/xTDnz+hRj+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKwyT2Jk0UBMVvsQTn9cesqoPHXxrQrs5IanXez7s1I76HFXhGAUNttUnKWPJmGNg
         QVV0Z8ETdh6RJY4Obym+GG0Y9MPQQbzWl5xp5gD0liwNgiz5wuJ/xFWx8XRqzWNWeV
         EzsCk+9E5uurfFqYN45ToduDt0RsJkVXjL8/nziE=
Date:   Tue, 19 May 2020 19:04:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.6 000/192] 5.6.14-rc2 review
Message-ID: <20200519170449.GA1085364@kroah.com>
References: <20200519054650.064501564@linuxfoundation.org>
 <CA+G9fYuD66kXa-4kYNFsS+HBmu7qSSpCxSnVVSYzb++X=o=2cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuD66kXa-4kYNFsS+HBmu7qSSpCxSnVVSYzb++X=o=2cg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 06:25:05PM +0530, Naresh Kamboju wrote:
> On Tue, 19 May 2020 at 11:17, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.6.14 release.
> > There are 192 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 21 May 2020 05:45:41 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.14-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
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
