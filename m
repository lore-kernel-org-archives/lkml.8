Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DFEC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE4D2469D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582902758;
	bh=fY6Rmei2EuhvgzIyAwnOSvyfTyjQYRh6rM/zrQJ1n4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SR02LyGNtdn8OEAD6y4RWWYJheJ6gWcqLWdPNJqwJpsH7JocY3yH6xypvC/gaxwyn
	 qjQz3LsZB2y2nguLleWccDJcZn8G/YdtZcTYd6CILlW24voslQZOpupEAFZGm2v8W9
	 EbD3MDyVKARq7P7UIyypkN3s1PxFrnid8s7t25Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgB1PMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:12:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgB1PMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:12:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0270624699;
        Fri, 28 Feb 2020 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582902756;
        bh=fY6Rmei2EuhvgzIyAwnOSvyfTyjQYRh6rM/zrQJ1n4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M9CZE0wxLfCmineUNQdBju90sGGwnWPWKOOWVsmIoPeU5KNlGjppDbJGL+5AMPu94
         RlP9Kl5BSnlPCcBAA6QVhHYvBOBOZqZ3mBuCIu04JyZDXQSIOz2UX8+hm9BfCr81S/
         8uo1TcRttUYygYp1aa7s5BT+V5hzuTeIe9rrRwZI=
Date:   Fri, 28 Feb 2020 16:12:33 +0100
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
Subject: Re: [PATCH 5.5 000/150] 5.5.7-stable review
Message-ID: <20200228151233.GB3136847@kroah.com>
References: <20200227132232.815448360@linuxfoundation.org>
 <CA+G9fYsJyqW95UU-KKNqQOQVSVNaBF9ZyNps+vbxHUtJ1S==gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsJyqW95UU-KKNqQOQVSVNaBF9ZyNps+vbxHUtJ1S==gg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 09:20:18AM +0530, Naresh Kamboju wrote:
> On Thu, 27 Feb 2020 at 19:53, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.5.7 release.
> > There are 150 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.7-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Wonderful, thanks for testing all of these and letting me know.

greg k-h
