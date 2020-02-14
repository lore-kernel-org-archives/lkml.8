Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8949FC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42126206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581710553;
	bh=vbhL7nPtuRrInzreAM2knLkJjeK5ZKQCxhIVz3erTy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xch4eEVUJNg+mgnyt+FSTAO9zmxXheu+Xm3VxyTm+ZsFdUY7rxIXZtq5m4vyEdawE
	 2+pjz7IiL05i22o4F1hXiRK0ncKDaeQnrGfkijYN4GSn3S6d8vEwgTDJ+RI179CKje
	 MgGJ/4pXs33KmRt0kXM7eQKSccWYAaxbZDqkW5/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbgBNUCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:02:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:33474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389136AbgBNUCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:04 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81E46206D7;
        Fri, 14 Feb 2020 20:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710523;
        bh=vbhL7nPtuRrInzreAM2knLkJjeK5ZKQCxhIVz3erTy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0N3BZgRQajZ5/7xssEtpfAh86fEI2ifpd2hPVGfNE23RtL3mMqy0xAIfDCkCtolFI
         bPGOVG2ssAlCqQBy6+iHyMii5QV/8Oqi270r+OUjLvVqUZuFGLDrhvjRR1hGINEkEw
         X3Oe34GaWOTEJHjDNAhJ0+VG2nC8ThICEMuQXRig=
Date:   Fri, 14 Feb 2020 07:22:02 -0800
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
Subject: Re: [PATCH 5.5 000/120] 5.5.4-stable review
Message-ID: <20200214152202.GD3959278@kroah.com>
References: <20200213151901.039700531@linuxfoundation.org>
 <CA+G9fYudhnZ9dmSk_ujQa4A8MA6N_HWjEyJV3CLDcBTceN-nLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYudhnZ9dmSk_ujQa4A8MA6N_HWjEyJV3CLDcBTceN-nLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 03:50:33PM +0530, Naresh Kamboju wrote:
> On Thu, 13 Feb 2020 at 21:00, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.5.4 release.
> > There are 120 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 15 Feb 2020 15:16:41 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.4-rc1.gz
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

Thanks for testing all of tehse and letting me know.

greg k-h
