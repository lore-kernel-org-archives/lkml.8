Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50E2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A6B2184D
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588402161;
	bh=35Oe9XPd06rEpUxvSBp1lVIPWzSKkwBzfY5ro7OpCYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2VagQIhKyXXsvu3L/ND5QuFVz9QEUK0vq4uxY7E3dKE2MBVRMwM6aAfEWHVi+tD7E
	 sqgdi0hgmBQF2m4R5U6LBD34SSPwAMISQWWKcxwE9odseKdufzZR7mzppf1f6QKFRa
	 bATL7fUby7Plwa/lipKm5o+YA0mPc/BRdhCZv+bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgEBGtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 02:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgEBGtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 02:49:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49ECC206F0;
        Sat,  2 May 2020 06:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588402158;
        bh=35Oe9XPd06rEpUxvSBp1lVIPWzSKkwBzfY5ro7OpCYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPB6McU6OBX9v1NzeRECmO0v0hxHW8pEPe4rqCUAVbBEdjNM0YYPNalBhM5nGQQ4k
         AuOD0HbFO0zrE9kfcyneFt7bD9N5AF+NlKURq0bjsGouhDeJembSfd2PJERacNES/C
         kY+y5XTeZO8Hbp5+vlNyrgkuNb364GyfEtFsTZi8=
Date:   Sat, 2 May 2020 08:49:16 +0200
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
Subject: Re: [PATCH 5.4 00/83] 5.4.37-rc1 review
Message-ID: <20200502064916.GA2578714@kroah.com>
References: <20200501131524.004332640@linuxfoundation.org>
 <CA+G9fYtikBkBLyV0_yZua7GDpZCmTooZOCuE9xdkE62J_Gtk2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtikBkBLyV0_yZua7GDpZCmTooZOCuE9xdkE62J_Gtk2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 03:19:40AM +0530, Naresh Kamboju wrote:
> On Fri, 1 May 2020 at 19:08, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.4.37 release.
> > There are 83 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun, 03 May 2020 13:12:02 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.37-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these and letting me know.

greg k-h
