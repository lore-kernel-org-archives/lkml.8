Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1F7C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89FF221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587112739;
	bh=QOHiMxRFGEgVWn9nG00kwqQ0MK10y04DtBJYV1Gtnns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l00+ZMtuxGbIQbZRr6ZY1H4nJv42hfCzcmTfmN2Rt9xHhnn9WUqIUnIt4aq9CUgMT
	 fLWnbtu3/nkyr4b9n8RTLAwTz2WuVr/f1rmWwMUemadfdcM7W2wapiG4mTOMPY0Weh
	 +b5aMTEosJejFBir9ww3+AqbPXAuB4R1q4rQqqx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgDQIi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 04:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729650AbgDQIi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:38:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7DC22137B;
        Fri, 17 Apr 2020 08:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587112737;
        bh=QOHiMxRFGEgVWn9nG00kwqQ0MK10y04DtBJYV1Gtnns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3N93+suml7yPvTnfmsMBk1KpYz4pg2br56Jaz0amqQbss17ly2R1og/L3WAld6m+
         mTe07ipLXdomEfqEs3t/lOmvNIGTQhQbuJvxVUbzzOLLMOpLBa9/WavB5RNrmXORI8
         CGBI+F2aAQyTs3V9tesWffQ7II2X5azdJbA6Rvpw=
Date:   Fri, 17 Apr 2020 10:38:55 +0200
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
Subject: Re: [PATCH 5.6 000/254] 5.6.5-rc1 review
Message-ID: <20200417083855.GG141762@kroah.com>
References: <20200416131325.804095985@linuxfoundation.org>
 <CA+G9fYtm0vpovNM5exU69WnQxpa3LHaumogCE9V8BCHgdcFr2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtm0vpovNM5exU69WnQxpa3LHaumogCE9V8BCHgdcFr2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:37:47PM +0530, Naresh Kamboju wrote:
> On Thu, 16 Apr 2020 at 19:26, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.6.5 release.
> > There are 254 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 18 Apr 2020 13:11:20 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.5-rc1.gz
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

Great!  Thanks for testing and letting me know.

greg k-h
