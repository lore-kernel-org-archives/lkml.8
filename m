Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93F4C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7421B215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580506005;
	bh=wWHXwG6EPfQuosReD4yUbSXQpH38g5vu2/y4wbYryiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bZaK4JPXDNN0/u9mfb4zP60e5nR/OFdp5ydatrLYcfScy8eJoBEvVj8qsHr0RgFXa
	 D7tTWGumMN+hNvOuST0slzdBIG/7lMKgYDUOT0/V3w/j7dTyGskryKd9IS229xB9QP
	 nieuqUhlshQZv5Mc98jfhfSd9i7WL/Va3wAk7D2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgAaV0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 16:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:49576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgAaV0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 16:26:44 -0500
Received: from localhost (unknown [83.216.75.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E53CA20CC7;
        Fri, 31 Jan 2020 21:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580506003;
        bh=wWHXwG6EPfQuosReD4yUbSXQpH38g5vu2/y4wbYryiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdwnnd3hhsrgynPOeYP3Q/99s344QcTOwOnrEDbbhGKx6YpldG1qJE4w599QBvuTV
         eki/If1OtN1oTlbCQRn4/+gylje7tEo4fetYJh4X1nvNEDEiwOdhV+Vzv/olLXQJ/F
         sZ1bkOXe9Hn3ah/3fZFPjs/T9uzPivyV/fNvSiCk=
Date:   Fri, 31 Jan 2020 22:26:40 +0100
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
Subject: Re: [PATCH 5.5 00/56] 5.5.1-stable review
Message-ID: <20200131212640.GD2278356@kroah.com>
References: <20200130183608.849023566@linuxfoundation.org>
 <CA+G9fYsFgp483JYaVj7NZszd_Wh9JOE6t3Tzfikdwsu_xpfaGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYsFgp483JYaVj7NZszd_Wh9JOE6t3Tzfikdwsu_xpfaGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 08:24:39PM +0530, Naresh Kamboju wrote:
> On Fri, 31 Jan 2020 at 00:11, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.5.1 release.
> > There are 56 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 01 Feb 2020 18:35:06 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.1-rc1.gz
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

Thanks for testing all 3 of these and letting me know.

greg k-h
