Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9160AC2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:22:06 +0000 (UTC)
Received: from vger.kernel.org (unknown [23.128.96.19])
	by mail.kernel.org (Postfix) with ESMTP id 5D2D420737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 08:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLL70XPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2D420737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgDMIWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgDMIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:22:04 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353FDC014CDB;
        Mon, 13 Apr 2020 01:22:04 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7784520692;
        Mon, 13 Apr 2020 08:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586766123;
        bh=myCwX7QCUQ1jF+vQX9y7N4B7bRpg4u9sExHyAT0PwI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MLL70XPoduJaJyvsD6kgwZyNb0YMq1Vs/8JKD/02q8F63Zz5kqWhUbSBJyao6AVbB
         E7ufNDOY1luG5RR1jWKGpTMm2IhYdyztgpBeUgv2tOcjnPwT9h+H3cBDfZOIVPUGTT
         clibTJq5Ht3fdEkPgpEPKhDAOKo3IUEj/YPn+Bl0=
Date:   Mon, 13 Apr 2020 10:22:01 +0200
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
Subject: Re: [PATCH 5.6 00/38] 5.6.4-rc1 review
Message-ID: <20200413082201.GC2792388@kroah.com>
References: <20200411115459.324496182@linuxfoundation.org>
 <CA+G9fYuC0s59WRDmBzy7gx62snosjDAX6EigYSGmvX+46cRASw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuC0s59WRDmBzy7gx62snosjDAX6EigYSGmvX+46cRASw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 11:08:18AM +0530, Naresh Kamboju wrote:
> On Sat, 11 Apr 2020 at 17:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.6.4 release.
> > There are 38 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Mon, 13 Apr 2020 11:51:28 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.4-rc1.gz
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
