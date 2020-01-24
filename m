Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AF2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F081A214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404499AbgAXLct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:32:49 -0500
Received: from foss.arm.com ([217.140.110.172]:50280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404479AbgAXLcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:32:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DCCF31B;
        Fri, 24 Jan 2020 03:32:43 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC53B3F68E;
        Fri, 24 Jan 2020 03:32:41 -0800 (PST)
Date:   Fri, 24 Jan 2020 11:32:39 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jolly Shah <JOLLYS@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Message-ID: <20200124113239.GB40307@bogus>
References: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
 <1578527663-10243-2-git-send-email-jolly.shah@xilinx.com>
 <20200114145257.GA1910108@kroah.com>
 <BYAPR02MB5992FC37E0D2AD9946414417B80F0@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20200124060339.GB2906795@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124060339.GB2906795@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for raising various issues that I have repeatedly asked and
constantly ignored.

On Fri, Jan 24, 2020 at 07:03:39AM +0100, Greg KH wrote:
> On Thu, Jan 23, 2020 at 11:47:57PM +0000, Jolly Shah wrote:
> > Hi Greg,
> >

[...]

> > Firmware driver was changed later to be platform driver but these
> > interfaces were defined earlier and are in use.
>
> Defined and in use where?  Not in the upstream kernel tree, right?  Or
> am I missing them somewhere else?
>

Exactly and they keep saying there partners are using these for 3-4 years
and they want to retain that. I have told them to change several times.

> > > > +	ret = kstrtol(tok, 16, &value);
> > > > +	if (ret) {
> > > > +		ret = -EFAULT;
> > > > +		goto err;
> > > > +	}
> > > > +
> > > > +	ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
> > >
> > > This feels "tricky", if you tie this to the device you have your driver
> > > bound to, will this make it easier instead of having to go through the
> > > ioctl callback?
> > >
> >
> > GGS(general global storage) registers are in PMU space and linux doesn't have access to it
> > Hence ioctl is used.
>
> Why not just a "real" call to the driver to make this type of reading?
> You don't have ioctls within the kernel for other drivers to call,
> that's not needed at all.
>

Oh yes, this is so broken in design. This firmware is designed to abstract
the power and configuration management on their platform, but they decided
to add direct register access to some registers anyway. Weird use case,
don't even ask. But I strongly objected such interface in sysfs even if
they moved under platform device. If they need this at any cost, I have
suggested debugfs.


[...]

> >
> > Agree it will be simpler but to as firmware driver was changed to be
> > platform driver, to keep paths same, we used sysfs.
>
> Keep them same from what?  Use the platform device as that is what it is
> there for, do not go create new apis when they are not needed at all.
>

+1, and please don't add any sysfs that can read/write those GGS registers
directly from userspace. Move them to debugfs if you are desperate to have
something.

--
Regards,
Sudeep
