Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA589C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B503720792
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ja4aLfUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFMNQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgFMNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:16:29 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D1C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CTgyUwh6cSz/c+OXjJ8SE3+Fh1Nd5s6JFCqdOiRWMDc=; b=ja4aLfUrZeDtb/Q+hi9fniI0n
        oDUic4OelYU8+sBynGEk2HzV/Ov9l9/uO5FV6IoNCS3f7i1NHN20jS6OCla7IX1f3zbLTCvXjFunV
        eyqoKi8AgqM/krztw6qZhGDJDwzLqzpn0hFEQhvsqiui8XVEzhR4KHuj9QlmEiw8Z898MGuh+MYzO
        yAC1qt7vE2TLy7JQfPmzmoOhZdsEWNiB4+b1SXN3t+TexgESaR4MwHPpxaTVOTD5tP45yoUWH7WLc
        m/5tNdo5HtvwcjOo+pCYohEuwEpbvpuiMGtwDBZ7cURslG8zRUeKZpukT5nXqjH23RafeSgA2QC0s
        Kov0DeIXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51576)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jk60y-0005SM-Pj; Sat, 13 Jun 2020 14:16:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jk60m-0007LO-M9; Sat, 13 Jun 2020 14:15:52 +0100
Date:   Sat, 13 Jun 2020 14:15:52 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200613131552.GL1551@shell.armlinux.org.uk>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613120432.GA5319@afzalpc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 05:34:32PM +0530, afzal mohammed wrote:
> Hi,
> 
> On Fri, Jun 12, 2020 at 10:07:28PM +0200, Arnd Bergmann wrote:
> 
> > I think a lot
> > of usercopy calls are only for a few bytes, though this is of course
> > highly workload dependent and you might only care about the large
> > ones.
> 
> Observation is that max. pages reaching copy_{from,to}_user() is 2,
> observed maximum of n (number of bytes) being 1 page size. i think C
> library cuts any size read, write to page size (if it exceeds) &
> invokes the system call. Max. pages reaching 2, happens when 'n'
> crosses page boundary, this has been observed w/ small size request
> as well w/ ones of exact page size (but not page aligned).

You can't make that assumption about read(2).  stdio in the C library
may read a page size of data at a time, but programs are allowed to
call read(2) directly, and the C library will pass such a call straight
through to the kernel.  So, if userspace requests a 16k read via
read(2), then read(2) will be invoked covering 16k.

As an extreme case, for example:

$ strace -e read dd if=/dev/zero of=/dev/null bs=1048576 count=1
read(0, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 1048576) = 1048576

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
