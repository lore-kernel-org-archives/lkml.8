Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2BEC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA13E2070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583570838;
	bh=kj/tz8uKDDAeZwkPo7mMFm2l9KjE7wjG93hY1K6V3nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H63tO750KoD1YxrgUOzzBCKQ024g35cs7F5+L70RpG6NEPmzkK/2nZkcsBWXlWI/z
	 2gU8Tcz5H3It1ts3NcfHaN0I62ri4yKxTd4mv9TPrXINrM1e7Uag8NvM5cjgfQ0SVI
	 NM73T9WwpERomswhfKtC1iePqKUvvCD08n44nwLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgCGIrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:47:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgCGIrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:47:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FAD2070A;
        Sat,  7 Mar 2020 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583570833;
        bh=kj/tz8uKDDAeZwkPo7mMFm2l9KjE7wjG93hY1K6V3nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsQNFpEObKzYDo79u4Ass2VY8Ixe4DZQB8f5a255DpEv5b4vgAh022s+uQ3hWvFiS
         7bmkbPzO12ePSrDSCDkftCfwjO+WdB5Me6UPXoKKRId5MOkGO/P/KEkyfvOa5EU7gF
         fPVcEdE+mqifUE+y6kgJVcMAHYQDyLpBDBsqmDio=
Date:   Sat, 7 Mar 2020 09:47:11 +0100
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     Rajan Vaja <RAJANV@xilinx.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Message-ID: <20200307084711.GA3877697@kroah.com>
References: <20200128062814.GA2097606@kroah.com>
 <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
 <20200131061038.GA2180358@kroah.com>
 <BYAPR02MB40559D6B62C4532C0EAD0281B7070@BYAPR02MB4055.namprd02.prod.outlook.com>
 <20200131093646.GA2271937@kroah.com>
 <3ef20e9d-052f-665c-7fc8-69a1f8bc9bd2@xilinx.com>
 <20200214171005.GB4034785@kroah.com>
 <c2914eae-bf95-ad51-79a4-07f199f37e27@xilinx.com>
 <20200215005235.GA32359@kroah.com>
 <23a785fd-3874-b71a-c0f5-d117a9058abf@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a785fd-3874-b71a-c0f5-d117a9058abf@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:55:46PM -0800, Jolly Shah wrote:
> Hi Greg,
> 
> > ------Original Message------
> > From: 'Greg Kh' <gregkh@linuxfoundation.org>
> > Sent:  Friday, February 14, 2020 4:52PM
> > To: Jolly Shah <jolly.shah@xilinx.com>
> > Cc: Rajan Vaja <RAJANV@xilinx.com>, Ard.biesheuvel@linaro.org
> <ard.biesheuvel@linaro.org>, Mingo@kernel.org <mingo@kernel.org>,
> Matt@codeblueprint.co.uk <matt@codeblueprint.co.uk>, Sudeep.holla@arm.com
> <sudeep.holla@arm.com>, Hkallweit1@gmail.com <hkallweit1@gmail.com>,
> Keescook@chromium.org <keescook@chromium.org>, Dmitry.torokhov@gmail.com
> <dmitry.torokhov@gmail.com>, Michal Simek <michals@xilinx.com>,
> Linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.org>,
> Linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
> >
> > On Fri, Feb 14, 2020 at 04:37:16PM -0800, Jolly Shah wrote:
> > > > Just make the direct call to the firmware driver, no need to muck around
> > > > with tables of function pointers.  In fact, with the spectre changes,
> > > > you just made things slower than needed, and you can get back a bunch of
> > > > throughput by removing that whole middle layer.
> > > > 
> > > 
> > > arm,scpi is doing the same way and we thought this approach will be more
> > > acceptable than direct function calls but happy to change as suggested.
> > 
> > Just because one random tiny thing does it the wrong way does not mean
> > to focus on that design pattern and ignore the thousands of other
> > apis/interfaces in the kernel that do not do it that way :)
> > 
> > > > So go do that first please, before adding any new stuff.
> > > > 
> > > > Now for the ioctl, yeah, that's not a "normal" pattern either.  But
> > > > right now you only have 2 "different" ioctls that you call.  So why not
> > > > just turn those 2 into real function calls as well that then makes the
> > > > "ioctl" call to the hardware?  That makes things a lot more obvious on
> > > > the kernel driver side exactly what is going on.
> > > > 
> > > 
> > > Sure as i understand firmware driver will provide real function calls to be
> > > used by user drivers and underneath it will call ioctl for desired
> > > operation. Please correct if I misunderstood.
> > 
> > You do not misunderstand.
> 
> Submitted v3 with required changes. Please review.

Will do, when I get to it, relax :)
