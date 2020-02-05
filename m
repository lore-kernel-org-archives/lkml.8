Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8118AC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE4217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580908031;
	bh=+E3j23x7MS9plaIV652hCATmWkzkTkyEfcfjqZg0OGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tA3YFTyMu5eKnaWcP483oAmIFMaBlfU3r3wQmCeU10hVGEDC7ImoWpILk9QJZs5o0
	 0hBZFqBch9VktbYldykoj4GHGcMXKwIPPyLkYk9kWiVoRxXcKRQGalpVFvgG01XflX
	 nBXpXNl5E5XCIwAxhQRSGndB40xsE+gqZtZ1KBDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBENHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:56400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgBENHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:07:10 -0500
Received: from localhost (unknown [212.187.182.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F379F2082E;
        Wed,  5 Feb 2020 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580908029;
        bh=+E3j23x7MS9plaIV652hCATmWkzkTkyEfcfjqZg0OGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JudLClM59LTYX+R1GeJHJVZAbkYBFo2zixLYxGqIlnIZBrEuS56c/3vFh4qwk8br5
         IL5rYPFAAIxndajvsZLq8pni1L7GNlkMFMaq1Y1tg9+fBFORXzZu7F2/5QRlFXYUBO
         Ij/iQKIJ6op/e3PTGwD9PBFXwmS9du40d36JWLaI=
Date:   Wed, 5 Feb 2020 13:07:06 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 5.5 00/23] 5.5.2-stable review
Message-ID: <20200205130706.GA1208327@kroah.com>
References: <20200203161902.288335885@linuxfoundation.org>
 <CA+G9fYuzYzwqaL6_5=2+KmRHy=BDRS0WgW2dGSL6wi+_FFFhCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuzYzwqaL6_5=2+KmRHy=BDRS0WgW2dGSL6wi+_FFFhCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 09:15:44PM +0530, Naresh Kamboju wrote:
> On Mon, 3 Feb 2020 at 22:08, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.5.2 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 05 Feb 2020 16:17:59 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.2-rc1.gz
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

Thanks for testing all of these and letting me know.

It would be interesting to figure out how all of the different build
errors on this "round" of releases did not trip up your systems...

thanks,

greg k-h
