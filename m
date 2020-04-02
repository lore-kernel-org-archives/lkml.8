Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3689C2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9AC20784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585833052;
	bh=Pekhp02iC7923qClheAUkrevoj7oWf/H5z9VPQT/Xc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z78mhCSSwznedsxoZDxwMBsdkrWBf6omUUYM4welqtI+Jr0Ott5bgA95Jm5W/jQET
	 jvR7M+GjsPZzNmQItHmzvzRH2uXvAYT7nMkaRHlyd0Ce6JTOyhhCHxU8kOZfkOwRjb
	 ASid92KPu57ecSKKNj79ynv9xH6elKXeGNbnB9II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbgDBNKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388280AbgDBNKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:10:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45EB206E9;
        Thu,  2 Apr 2020 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585833051;
        bh=Pekhp02iC7923qClheAUkrevoj7oWf/H5z9VPQT/Xc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NHwFUmG/9A7h9b+VzT2aOCAyewFslD41siju3sKhMP9OgS7GMbkRGcaV3L1mrNXhg
         dpSaPkfZq187Xe6Xzk8D2EuBl3DhB0Xjs+4o3CuQagR+G69Y17ClKAl/iQrTYWhDnQ
         kyIrsSxAFzER/QThIiB4PGTcGSQ1Dh2TY31qQYz8=
Date:   Thu, 2 Apr 2020 15:10:48 +0200
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
Subject: Re: [PATCH 5.6 00/10] 5.6.2-rc1 review
Message-ID: <20200402131048.GA2891655@kroah.com>
References: <20200401161413.974936041@linuxfoundation.org>
 <CA+G9fYv=2KC+Gx7wv2iDtsNBcKG2PaXndtLuT+FRmqyk7bEX3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYv=2KC+Gx7wv2iDtsNBcKG2PaXndtLuT+FRmqyk7bEX3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 04:01:54PM +0530, Naresh Kamboju wrote:
> On Wed, 1 Apr 2020 at 21:50, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.6.2 release.
> > There are 10 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 03 Apr 2020 16:09:36 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.2-rc1.gz
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

Great, thanks for testing all of tehse and letting me know.

greg k-h
