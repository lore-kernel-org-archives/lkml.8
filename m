Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9995EC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A20206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PjsNQ/VG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbgIKIei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:34:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1611C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:34:25 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so10620810wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M0S4mP0yQ288Ht2IB3N+dbHxuqNNpIHZMkWTvJtXhOc=;
        b=PjsNQ/VGfWEB/Je9D2ogZjHZiDGDyOpS4ISuRBopjuEgW6j2F2opOiYWud3Q5U5GI3
         AQeU9UOKGJv01qSSw1DB1PVTcy3ESKJYkbxgo7Nm08xdMV5HNfX1FK0KYi9N4L21ES1k
         9U/1QUSJes6b4cEvGOcHiC1J0281ylA2mrnajr+Zz06h9OKNDuFugNOqajsZ3QumU0eZ
         /x0BHg7x2ioMEalsdP8EQcU998V8ejjZs40169D0Dc4vOzndI7VIzlVpcC+FzfcBXsqq
         fajcI4JOzvFDntYJ6wFTqoNnvj2yJUr57Lu0jh/M/UeE7LpGNCcTIUhnov7H9XqHLXwX
         G8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M0S4mP0yQ288Ht2IB3N+dbHxuqNNpIHZMkWTvJtXhOc=;
        b=jvBxwCgmE7sNmCb2L1Urz1poE/NJYhcT3Yr3Bjyp1vbTkjxqhOveUU2rJ0Pcx9Tfuy
         NhBdEacl477EtogGObcbaith8ppvMxppd978lTVnGb7UVgAXQwCQdw2JD4OVdQzyci0L
         +VcYnlqAyIW9mbxs93erCJ7IaumGLpdaDRCxBdOcKk3xcUSqBtvbYfPIo4N8BSA428ic
         llz2U4ADcxCVoHzVTFAVCGuFj7ZEM0kF35mJWYnLHyvaZbsAvZi0rqHbkWR1tJQLpdCJ
         yQmJKxDvdgmiZM91FK599JK48kF8yPnGIslrNAeR14gcuGyyB4FhPlzebwzMp1kyYZ4z
         u/uQ==
X-Gm-Message-State: AOAM532Fmy/Lcg6Vr3JaZ9aZ6pWWSv5wiBhFL5ngYQL+T//lNP07NOtZ
        LkKTeU1rDfaeXYT1dssj+wpDMQ==
X-Google-Smtp-Source: ABdhPJz+kgniz8iKUb4blQrRirzDIa4lhBqRbiiOpeC5E8r1DBQFs2ka64TSwdoiUTGozKH7QGOAjw==
X-Received: by 2002:adf:f290:: with SMTP id k16mr982616wro.124.1599813263810;
        Fri, 11 Sep 2020 01:34:23 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q186sm2803894wma.45.2020.09.11.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 01:34:23 -0700 (PDT)
Date:   Fri, 11 Sep 2020 09:34:21 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
Message-ID: <20200911083421.g5cidlnwfiksggvk@holly.lan>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
 <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
 <20200910131212.wm7zskxvcesl652c@holly.lan>
 <1599791601.24609.5.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599791601.24609.5.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 10:33:21AM +0800, Chunfeng Yun wrote:
> On Thu, 2020-09-10 at 14:12 +0100, Daniel Thompson wrote:
> > On Thu, Sep 10, 2020 at 04:21:45PM +0800, Chunfeng Yun wrote:
> > > Use readl_poll_timeout_atomic() to simplify code
> > > 
> > > Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > ---
> > > v2~v3: no changes
> > > ---
> > >  drivers/usb/host/xhci-rcar.c | 43 ++++++++++++-------------------------------
> > >  1 file changed, 12 insertions(+), 31 deletions(-)
> > > 
> > > diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> > > index c1025d3..74f836f 100644
> > > --- a/drivers/usb/host/xhci-rcar.c
> > > +++ b/drivers/usb/host/xhci-rcar.c
> > > @@ -6,6 +6,7 @@
> > >   */
> > >  
> > >  #include <linux/firmware.h>
> > > +#include <linux/iopoll.h>
> > >  #include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/of.h>
> > > @@ -127,8 +128,7 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
> > >  	void __iomem *regs = hcd->regs;
> > >  	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
> > >  	const struct firmware *fw;
> > > -	int retval, index, j, time;
> > > -	int timeout = 10000;
> > > +	int retval, index, j;
> > >  	u32 data, val, temp;
> > >  	u32 quirks = 0;
> > >  	const struct soc_device_attribute *attr;
> > > @@ -166,32 +166,19 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
> > >  		temp |= RCAR_USB3_DL_CTRL_FW_SET_DATA0;
> > >  		writel(temp, regs + RCAR_USB3_DL_CTRL);
> > >  
> > > -		for (time = 0; time < timeout; time++) {
> > > -			val = readl(regs + RCAR_USB3_DL_CTRL);
> > > -			if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) == 0)
> > > -				break;
> > > -			udelay(1);
> > > -		}
> > > -		if (time == timeout) {
> > > -			retval = -ETIMEDOUT;
> > > +		retval = readl_poll_timeout_atomic(regs + RCAR_USB3_DL_CTRL,
> > > +				val, !(val & RCAR_USB3_DL_CTRL_FW_SET_DATA0),
> > > +				1, 10000);
> > > +		if (retval < 0)
> > >  			break;
> > > -		}
> > >  	}
> > >  
> > >  	temp = readl(regs + RCAR_USB3_DL_CTRL);
> > >  	temp &= ~RCAR_USB3_DL_CTRL_ENABLE;
> > >  	writel(temp, regs + RCAR_USB3_DL_CTRL);
> > >  
> > > -	for (time = 0; time < timeout; time++) {
> > > -		val = readl(regs + RCAR_USB3_DL_CTRL);
> > > -		if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) {
> > > -			retval = 0;
> > > -			break;
> > > -		}
> > > -		udelay(1);
> > > -	}
> > > -	if (time == timeout)
> > > -		retval = -ETIMEDOUT;
> > > +	retval = readl_poll_timeout_atomic((regs + RCAR_USB3_DL_CTRL),
> > > +			val, (val & RCAR_USB3_DL_CTRL_FW_SUCCESS), 1, 10000);
> > 
> > Directly assigning to retval at this point will clobber a previous
> > -ETIMEDOUT error.
> > 
> > In other words if there is a timeout waiting for FW_SET_DATA0, but not for
> > DW_SUCCESS, then we will return the wrong return value.
>
> Yes, agree with you, but seems I keep its original logic unchanged.

I disagree.

Your patch does not preserve the original logic. Your patch explicitly
sets retval to zero if the second loop succeeds. The original code does
not do this. As a result there is a change of return code for one of the
error paths.


Daniel.
