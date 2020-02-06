Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45850C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0352020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R1bZ8y8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBFTRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:17:41 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52520 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFTRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:17:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 016JHanZ000581;
        Thu, 6 Feb 2020 13:17:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581016656;
        bh=tpXKeiUAFwwUs4rTkFC126Vv3lLQyaS+9i9VFe2hufY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=R1bZ8y8zrv6TCaBc0g6cebmjaSU4lvlFAN2HNlgD4A2DsByTihNtUVmn7i1X10TPN
         F0m7MSBGqIkL8OxlU+AtPKUOAn/SioSwntVSB5J+0+SExo9Q0O5+WwiBmbhxiymuKt
         Jpxg4iZx5WnAqWMMoiibNqxknOpvnVQf9Y4vbC1I=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 016JHaUl099666
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Feb 2020 13:17:36 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 6 Feb
 2020 13:17:36 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 6 Feb 2020 13:17:36 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 016JHaAv059722;
        Thu, 6 Feb 2020 13:17:36 -0600
Date:   Thu, 6 Feb 2020 13:17:35 -0600
From:   Bin Liu <b-liu@ti.com>
To:     SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <saurav.girepunje@hotmail.com>
Subject: Re: [PATCH] usb: musb: Fix external abort on non-linefetch
Message-ID: <20200206191735.GA11124@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        SAURAV GIREPUNJE <saurav.girepunje@gmail.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
References: <20191211190953.GH16429@iaqt7>
 <20200119060404.GA104504@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200119060404.GA104504@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saurav,

On Sun, Jan 19, 2020 at 11:34:04AM +0530, SAURAV GIREPUNJE wrote:
> Hi Bin,
> 
> Yes, I really got this kernel dump for mode_show() and vbus_store(),
> While accessing show/store for mode and vbus through sysfs .

Please provide the kernel dump for mode_show() and vbus_store(). The log
below is for mode_store().

> I have submitted earlier also three patches for same bug, In reply to
> one of those patches you
> asked me to merge another two patches and just sent in one.

I don't have issue to merge all the fixes into one patch, since they fix
the same bug. But I need the dump log to see how the dump is triggered
in mode_show() and vbus_store() as I don't see the how it could happen
and I cannot reproduce it. These two function do not access any musb
register.

By the way, please don't top-posting, and reply to my message to
preserve the context.

-Bin.

> 
> Regards,
> Saurav Girepunje
> 
> On 27/10/19 14:06 +0530, Saurav Girepunje wrote:
> > While setting the usb mode from sysfs. Below error came on kernel
> > version 4.19.
> > 
> > On latest kernel vserion api name changed. Therefore API
> > name and backtrace API name are different.
> > 
> >    [  821.908066] Backtrace:
> >    [  821.910695] [<bf078fc0>] (musb_default_readl [musb_hdrc]) from [<bf0af738>] (dsps_musb_set_mode+0x38/0x12c [musb_dsps])
> >    [  821.922059] [<bf0af700>] (dsps_musb_set_mode [musb_dsps]) from [<bf07899c>] (musb_mode_store+0xc8/0x12c [musb_hdrc])
> >    [  821.933105]  r7:a0010013 r6:0000000b r5:cd79d200 r4:cb634010
> >    [  821.939096] [<bf0788d4>] (musb_mode_store [musb_hdrc]) from [<c0425184>] (dev_attr_store+0x20/0x2c)
> >    [  821.948593]  r7:cd79d200 r6:c5abbf78 r5:00000000 r4:bf0788d4
> >    [  821.954549] [<c0425164>] (dev_attr_store) from [<c0285b08>] (sysfs_kf_write+0x48/0x4c)
> >    [  821.962859]  r5:00000000 r4:c0425164
> >    [  821.966620] [<c0285ac0>] (sysfs_kf_write) from [<c0285274>] (kernfs_fop_write+0xfc/0x1fc)
> >    [  821.975200]  r5:00000000 r4:cd79d080
> >    [  821.978966] [<c0285178>] (kernfs_fop_write) from [<c020ec00>] (__vfs_write+0x34/0x120)
> >    [  821.987280]  r10:00000000 r9:0000000b r8:00000000 r7:0000000b r6:c5abbf78 r5:c0285178
> >    [  821.995493]  r4:cb67a3c0
> >    [  821.998160] [<c020ebcc>] (__vfs_write) from [<c020fae8>] (vfs_write+0xa8/0x170)
> >    [  822.005835]  r9:0000000b r8:00000000 r7:c5abbf78 r6:000def80 r5:cb67a3c0 r4:0000000b
> >    [  822.013969] [<c020fa40>] (vfs_write) from [<c02108d0>] (SyS_write+0x44/0x98)
> >    [  822.021371]  r9:0000000b r8:000def80 r7:00000000 r6:00000000 r5:cb67a3c0 r4:cb67a3c0
> >    [  822.029517] [<c021088c>] (SyS_write) from [<c010d8a0>] (ret_fast_syscall+0x0/0x3c)
> >    [  822.037467]  r9:c5aba000 r8:c010daa8 r7:00000004 r6:b6f0ad58 r5:000def80 r4:0000000b
> >    [  822.045599] Code: e1a0c00d e92dd800 e24cb004 e0801001 (e5910000)
> > 
> >    Without pm_runtime_{get,put}_sync calls in place,
> >    Similar issue come on "mode_show" and "vbus_store" also.
> > 
> >    fix- call pm_runtime_{get,put}_sync before reading/writing
> >    usb mode/vbus from sysfs.
> > 
> >    As sugguested on commit '2d15f69ed5c1c33f283e77ec161578badde33eaf'
> >    Merged all the fix which reslove same bug in the same file.
> >    "
> >      commit '2d15f69ed5c1c33f283e77ec161578badde33eaf'
> >      Author: Saurav Girepunje <saurav.girepunje@gmail.com>
> >      Date:   Thu Aug 8 00:05:03 2019 +0530
> > 
> >      usb: musb: Fix external abort on non-linefetch for vbus_store
> > 
> >      Without pm_runtime_{get,put}_sync calls in place, writing
> >      vbus value via /sys causes the error
> > 
> >      "Unhandled fault external abort on non-linefetch"
> > 
> >        On Thu, Aug 08, 2019 at 12:11:46AM +0530, Saurav Girepunje wrote:
> > 	> Without pm_runtime_{get,put}_sync calls in place, writing
> > 	> vbus value via /sys causes the error
> > 	>
> > 	> "Unhandled fault external abort on non-linefetch"
> > 	>
> > 	> Signed-off-by: Saurav Girepunje <saurav.girepunje@xxxxxxxxx>
> > 
> > 	Thanks for the patch. Can you please merge another two similar patches
> > 	you just sent with this one? They all fix the same bug in the same file
> > 	so could be just in one patch.
> > 
> > 	-Bin.
> >    "
> > 
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
> > drivers/usb/musb/musb_core.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index bd63450af76a..dc7d786feb58 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -1723,9 +1723,11 @@ mode_show(struct device *dev, struct device_attribute *attr, char *buf)
> > 	unsigned long flags;
> > 	int ret;
> > 
> > +	pm_runtime_get_sync(dev);
> > 	spin_lock_irqsave(&musb->lock, flags);
> > 	ret = sprintf(buf, "%s\n", usb_otg_state_string(musb->xceiv->otg->state));
> > 	spin_unlock_irqrestore(&musb->lock, flags);
> > +	pm_runtime_put_sync(dev);
> > 
> > 	return ret;
> > }
> > @@ -1738,6 +1740,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
> > 	unsigned long	flags;
> > 	int		status;
> > 
> > +	pm_runtime_get_sync(dev);
> > 	spin_lock_irqsave(&musb->lock, flags);
> > 	if (sysfs_streq(buf, "host"))
> > 		status = musb_platform_set_mode(musb, MUSB_HOST);
> > @@ -1748,6 +1751,7 @@ mode_store(struct device *dev, struct device_attribute *attr,
> > 	else
> > 		status = -EINVAL;
> > 	spin_unlock_irqrestore(&musb->lock, flags);
> > +	pm_runtime_put_sync(dev);
> > 
> > 	return (status == 0) ? n : status;
> > }
> > @@ -1766,6 +1770,7 @@ vbus_store(struct device *dev, struct device_attribute *attr,
> > 		return -EINVAL;
> > 	}
> > 
> > +	pm_runtime_get_sync(dev);
> > 	spin_lock_irqsave(&musb->lock, flags);
> > 	/* force T(a_wait_bcon) to be zero/unlimited *OR* valid */
> > 	musb->a_wait_bcon = val ? max_t(int, val, OTG_TIME_A_WAIT_BCON) : 0 ;
> > @@ -1773,6 +1778,7 @@ vbus_store(struct device *dev, struct device_attribute *attr,
> > 		musb->is_active = 0;
> > 	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
> > 	spin_unlock_irqrestore(&musb->lock, flags);
> > +	pm_runtime_put_sync(dev);
> > 
> > 	return n;
> > }
> > -- 
> > 2.20.1
> > 
