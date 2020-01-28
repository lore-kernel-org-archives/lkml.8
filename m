Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A6C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982A82467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580192900;
	bh=Nror/33/FGHsPj3Lk3bq4hBaWkgAkgSHit0ACqP5MQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zMDVWjzlRObn6R/vhgFMw/Z9kXxMJzOsZummFRKiRw0yD+N8ggKkzUctqkoBisUqN
	 cxg9H7zBZEZEiCPm4Rqi8PNdqgSmYXEQdIwKoLFUz5BPUhlNmOnQoQOuonr/gQDzOK
	 /80tH32Bgn4NAbODyA9Av0KfXz+iBcuisa7QidZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgA1G2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgA1G2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:28:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6C2205F4;
        Tue, 28 Jan 2020 06:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580192898;
        bh=Nror/33/FGHsPj3Lk3bq4hBaWkgAkgSHit0ACqP5MQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Odt/CmZwnxY0FSSxYEi8g01nJTEMq0T60weZ9XLx/Hsot8/uLNqQrsY+FSnrA6Sjk
         LakYOZSNQNtghd4fsZxnu96m/QqzYqWp7d/vJCml8t+qcZe1h1adZPEOCBaDDlmwBW
         uWwapxJiRkKYOn6mLCUuvUPy3AGPks2TVQ5z0RKY=
Date:   Tue, 28 Jan 2020 07:28:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jolly Shah <JOLLYS@xilinx.com>
Cc:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] firmware: xilinx: Add sysfs interface
Message-ID: <20200128062814.GA2097606@kroah.com>
References: <1578527663-10243-1-git-send-email-jolly.shah@xilinx.com>
 <1578527663-10243-2-git-send-email-jolly.shah@xilinx.com>
 <20200114145257.GA1910108@kroah.com>
 <BYAPR02MB5992FC37E0D2AD9946414417B80F0@BYAPR02MB5992.namprd02.prod.outlook.com>
 <20200124060339.GB2906795@kroah.com>
 <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2D4B924A-D10C-4A90-A8E6-507BF6C30654@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:01:27PM +0000, Jolly Shah wrote:
>     > > > +	ret = kstrtol(tok, 16, &value);
>     > > > +	if (ret) {
>     > > > +		ret = -EFAULT;
>     > > > +		goto err;
>     > > > +	}
>     > > > +
>     > > > +	ret = eemi_ops->ioctl(0, read_ioctl, reg, 0, ret_payload);
>     > > 
>     > > This feels "tricky", if you tie this to the device you have your driver
>     > > bound to, will this make it easier instead of having to go through the
>     > > ioctl callback?
>     > > 
>     > 
>     > GGS(general global storage) registers are in PMU space and linux doesn't have access to it 
>     > Hence ioctl is used.
>     
>     Why not just a "real" call to the driver to make this type of reading?
>     You don't have ioctls within the kernel for other drivers to call,
>     that's not needed at all.
> 
> these registers are for users  and for special needs where users wants
> to retain values over resets. but as they belong to PMU address space,
> these interface APIs are provided. They don’t allow access to any
> other registers.

That's not the issue here.  The issue is you are using an "internal"
ioctl, instead just make a "real" call.

>     > > > +int zynqmp_pm_ggs_init(struct kobject *parent_kobj)
>     > > > +{
>     > > > +	return sysfs_create_group(parent_kobj, zynqmp_ggs_groups[0]);
>     > > 
>     > > You might be racing userspace here and loosing :(
>     > 
>     > Prob is called before user space is notified about sysfs so racing shouldn't happen.
>     
>     "shouldn't"?  How do you know this?
> 
> Since firmware driver is always built-in (we don't provide support to
> use as module), user space won't be available before prob is complete.
> Correct if I am wrong.

Userspace starts earlier than you think, and also, use the correct
interfaces for this type of thing, that is why it is there.  Don't
create purposfully-incorrect code :)

>     > > > diff --git a/drivers/firmware/xilinx/zynqmp.c
>     > > b/drivers/firmware/xilinx/zynqmp.c
>     > > > index 75bdfaa..4c1117d 100644
>     > > > --- a/drivers/firmware/xilinx/zynqmp.c
>     > > > +++ b/drivers/firmware/xilinx/zynqmp.c
>     > > > @@ -473,6 +473,10 @@ static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
>     > > >  	case IOCTL_GET_PLL_FRAC_MODE:
>     > > >  	case IOCTL_SET_PLL_FRAC_DATA:
>     > > >  	case IOCTL_GET_PLL_FRAC_DATA:
>     > > > +	case IOCTL_WRITE_GGS:
>     > > > +	case IOCTL_READ_GGS:
>     > > > +	case IOCTL_WRITE_PGGS:
>     > > > +	case IOCTL_READ_PGGS:
>     > > 
>     > > Huh???
>     > 
>     > Sorry not sure about your concern here. These registers are in PMU space and hence
>     > Ioctl is needed to let linux access them.
>     
>     userspace or kernelspace?
>     
>     You seem to be mixing them both here.
> 
> They are in Platform Management Unit register address space so it
> allows only secure access. Hence for linux to access it, interface
> APIs are provided. 

Again, that's fine, but why are you creating an "internal ioctl"?  Just
make a real function call.

thanks,

greg k-h
