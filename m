Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B511C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5F720CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580463412;
	bh=kKkl7IIdkI45Xq+BxUMl2TT+5Wgp8VCsHvXb8zf/eV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EaQuJMFkCAJU6Fir+lGrvHNIMLuLOfcXF6tMqrjWprHD6ZVue/h7ypnz5XAdKRZDm
	 KsnRZyjPlSsgw8p07wJ8fnyXhTXPFkoohyL06n8HbVfPdYcIpVd0QXlYeOS3kRm8Xr
	 ggwxEDZMwmjsGDUV2B6T3ENRTOnUUpifGQJvHQm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgAaJgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:36:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728231AbgAaJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:36:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E37E20707;
        Fri, 31 Jan 2020 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580463408;
        bh=kKkl7IIdkI45Xq+BxUMl2TT+5Wgp8VCsHvXb8zf/eV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jI5GJpZLenzLyhKfww2wcwTl8g9WY5wtHDwCm1LOK7DK1rQ11N3u4zgVi7ZJHDm4z
         jgm+p2j6DXzOdQjVmfhv/y5objkwk7vC8ugEwQnINUavbvAtukxYnYL2ENTlUU3xZr
         rfGUApsMb+eRMv3LWV3zKfUMoFyqpuoyJGzvSGEM=
Date:   Fri, 31 Jan 2020 10:36:46 +0100
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     Rajan Vaja <RAJANV@xilinx.com>
Cc:     Jolly Shah <JOLLYS@xilinx.com>,
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
Message-ID: <20200131093646.GA2271937@kroah.com>
References: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
 <1578527663-10243-2-git-send-email-jolly.shah@xilinx.com>
 <20200114145257.GA1910108@kroah.com>
 <BYAPR02MB5992FC37E0D2AD9946414417B80F0@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20200124060339.GB2906795@kroah.com>
 <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
 <20200128062814.GA2097606@kroah.com>
 <4EF659A1-2844-46B9-9ED6-5A6A20401D9D@xilinx.com>
 <20200131061038.GA2180358@kroah.com>
 <BYAPR02MB40559D6B62C4532C0EAD0281B7070@BYAPR02MB4055.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR02MB40559D6B62C4532C0EAD0281B7070@BYAPR02MB4055.namprd02.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 09:05:15AM +0000, Rajan Vaja wrote:
> Hi Greg,
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: 31 January 2020 11:41 AM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; matt@codeblueprint.co.uk;
> > sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> > dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
> > 
> > EXTERNAL EMAIL
> > 
> > On Thu, Jan 30, 2020 at 11:59:03PM +0000, Jolly Shah wrote:
> > > Hi Greg,
> > >
> > > ﻿On 1/27/20, 10:28 PM, "linux-kernel-owner@vger.kernel.org on behalf of Greg
> > KH" <linux-kernel-owner@vger.kernel.org on behalf of
> > gregkh@linuxfoundation.org> wrote:
> > >
> > >     On Mon, Jan 27, 2020 at 11:01:27PM +0000, Jolly Shah wrote:
> > >     >     > > > +     ret = kstrtol(tok, 16, &value);
> > >     >     > > > +     if (ret) {
> > >     >     > > > +             ret = -EFAULT;
> > >     >     > > > +             goto err;
> > >     >     > > > +     }
> > >     >     > > > +
> > >     >     > > > +     ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
> > >     >     > >
> > >     >     > > This feels "tricky", if you tie this to the device you have your driver
> > >     >     > > bound to, will this make it easier instead of having to go through the
> > >     >     > > ioctl callback?
> > >     >     > >
> > >     >     >
> > >     >     > GGS(general global storage) registers are in PMU space and linux
> > doesn't have access to it
> > >     >     > Hence ioctl is used.
> > >     >
> > >     >     Why not just a "real" call to the driver to make this type of reading?
> > >     >     You don't have ioctls within the kernel for other drivers to call,
> > >     >     that's not needed at all.
> > >     >
> > >     > these registers are for users  and for special needs where users wants
> > >     > to retain values over resets. but as they belong to PMU address space,
> > >     > these interface APIs are provided. They don’t allow access to any
> > >     > other registers.
> > >
> > >     That's not the issue here.  The issue is you are using an "internal"
> > >     ioctl, instead just make a "real" call.
> > >
> > > Sorry I am not clear. Do you mean that we should use linux standard
> > > ioctl interface instead of internal ioctl by mentioning "real" ?
> > 
> > No, you should just make a "real" function call to the exact thing you
> > want to do.  Not have an internal multi-plexor ioctl() call that others
> > then call.  This isn't a microkernel :)
> [Rajan] Sorry for multiple back and forth but as I understand, you are suggesting to create a new API for
> Read/write of GGS register instead of using PM_IOCTL API (eemi_ops->ioctl) for multiple purpose. Is my understanding correct?

That is correct.
