Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BD7C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6C5206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MmJgrSMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgIKJtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgIKJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:49:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBECC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:49:03 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so4145379wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9A++ewy8sVp6thBcPOOtbsKFvGPTO2SoiU/BMG02wq8=;
        b=MmJgrSMYoiVBokXHZc4aTskAuomxprJ7MaYaG+sU2biRH5WdQ5hvCNYeEhwh1mllhV
         POSHe3VvNWfA2At3j0JoC4OcALmT8yfhnYyfrnUPJzd9qb74FpW84zZwx10r3yl117BZ
         UpdklLK+p44ymorq/xa/2T2/tcdO71IFq4aeTagml7xomDou/T84yJ8lFYkebPG+x2BK
         1Avo0G+iAFcqbV807/eW41JANHtVCbJ0W5BUmo1XWkVV8VmOIrKmLMU2SYU2LichxXjU
         +LvrMQuteq2ezkJQxv4SmFZyCQzgAEbmdm3AkF1aIGXI+9BNcxq+wUfzoLKb1mwSs9Q0
         mCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9A++ewy8sVp6thBcPOOtbsKFvGPTO2SoiU/BMG02wq8=;
        b=rceRFYKXi8zZnVh0QUablx65suVtiJ0iIYc3WsiY9tCMt9wrAGYqzX/5Gpio/9ffjT
         zBoS/S+uYOuSRkCciGRb0Rr0mJ3nG5yOu8EbtbJ7mbs7GG1AG7LyNfMbj0/BOT6rzU7c
         TMZ5uRqjKmYhYueZErl/U9P3KsZdSvFBudfCmHozfOMpb85okU2Ze7UikrTE+i4qQt3z
         2BDvY4owl+8BlVO0GFTIMVT6Z+2jIcFgPsaoecfCCCdOHDTpk5A1N+dy7cVsqWsYmwCH
         q7bVHdRnh4PgYodk+yAZgT//UROp3xxDJwunl0nDn336Zf3ix5kPE9gq+vCQgZ6LWGpa
         l10w==
X-Gm-Message-State: AOAM530eQG288iqywsSkLQ44Za+JqARaieYmtvGt/l1KKmFsnFxkmkLN
        qHIarCGkaCrWW5BPureTixbSSg==
X-Google-Smtp-Source: ABdhPJyFqCl0VUl+g10iEXvosWPQJqdSR+Yit/3/I+53mTW4FRef+/DbhGVSRBxXqQdFvFZhfLapeg==
X-Received: by 2002:a1c:6187:: with SMTP id v129mr1330703wmb.35.1599817742032;
        Fri, 11 Sep 2020 02:49:02 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id b18sm3644841wrn.21.2020.09.11.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 02:49:01 -0700 (PDT)
Date:   Fri, 11 Sep 2020 10:48:59 +0100
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
Message-ID: <20200911094859.tk2jlcjbolsrkeeh@holly.lan>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
 <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
 <20200910131212.wm7zskxvcesl652c@holly.lan>
 <1599791601.24609.5.camel@mhfsdcap03>
 <20200911083421.g5cidlnwfiksggvk@holly.lan>
 <1599816442.29909.10.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599816442.29909.10.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 05:27:22PM +0800, Chunfeng Yun wrote:
> On Fri, 2020-09-11 at 09:34 +0100, Daniel Thompson wrote:
> > On Fri, Sep 11, 2020 at 10:33:21AM +0800, Chunfeng Yun wrote:
> > > On Thu, 2020-09-10 at 14:12 +0100, Daniel Thompson wrote:
> > > > On Thu, Sep 10, 2020 at 04:21:45PM +0800, Chunfeng Yun wrote:
> > > > > Use readl_poll_timeout_atomic() to simplify code
> > > > > 
> > > > > Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> > > > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > > ---
> > > > > v2~v3: no changes
> > > > > ---
> > > > >  drivers/usb/host/xhci-rcar.c | 43 ++++++++++++-------------------------------
> > > > >  1 file changed, 12 insertions(+), 31 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> > > > > index c1025d3..74f836f 100644
> > > > > --- a/drivers/usb/host/xhci-rcar.c
> > > > > +++ b/drivers/usb/host/xhci-rcar.c
> > > > > @@ -6,6 +6,7 @@
> > > > >   */
> > > > >  
> > > > >  #include <linux/firmware.h>
> > > > > +#include <linux/iopoll.h>
> > > > >  #include <linux/module.h>
> > > > >  #include <linux/platform_device.h>
> > > > >  #include <linux/of.h>
> > > > > @@ -127,8 +128,7 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
> > > > >  	void __iomem *regs = hcd->regs;
> > > > >  	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
> > > > >  	const struct firmware *fw;
> > > > > -	int retval, index, j, time;
> > > > > -	int timeout = 10000;
> > > > > +	int retval, index, j;
> > > > >  	u32 data, val, temp;
> > > > >  	u32 quirks = 0;
> > > > >  	const struct soc_device_attribute *attr;
> > > > > @@ -166,32 +166,19 @@ static int xhci_rcar_download_firmware(struct usb_hcd *hcd)
> > > > >  		temp |= RCAR_USB3_DL_CTRL_FW_SET_DATA0;
> > > > >  		writel(temp, regs + RCAR_USB3_DL_CTRL);
> > > > >  
> > > > > -		for (time = 0; time < timeout; time++) {
> > > > > -			val = readl(regs + RCAR_USB3_DL_CTRL);
> > > > > -			if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) == 0)
> > > > > -				break;
> > > > > -			udelay(1);
> > > > > -		}
> > > > > -		if (time == timeout) {
> > > > > -			retval = -ETIMEDOUT;
> > > > > +		retval = readl_poll_timeout_atomic(regs + RCAR_USB3_DL_CTRL,
> > > > > +				val, !(val & RCAR_USB3_DL_CTRL_FW_SET_DATA0),
> > > > > +				1, 10000);
> > > > > +		if (retval < 0)
> > > > >  			break;
> > > > > -		}
> > > > >  	}
> > > > >  
> > > > >  	temp = readl(regs + RCAR_USB3_DL_CTRL);
> > > > >  	temp &= ~RCAR_USB3_DL_CTRL_ENABLE;
> > > > >  	writel(temp, regs + RCAR_USB3_DL_CTRL);
> > > > >  
> > > > > -	for (time = 0; time < timeout; time++) {
> > > > > -		val = readl(regs + RCAR_USB3_DL_CTRL);
> > > > > -		if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) {
> > > > > -			retval = 0;
> Here will set it 0 too

Doh...

Thanks.


Daniel.


> 
> > > > > -			break;
> > > > > -		}
> > > > > -		udelay(1);
> > > > > -	}
> > > > > -	if (time == timeout)
> > > > > -		retval = -ETIMEDOUT;
> > > > > +	retval = readl_poll_timeout_atomic((regs + RCAR_USB3_DL_CTRL),
> > > > > +			val, (val & RCAR_USB3_DL_CTRL_FW_SUCCESS), 1, 10000);
> > > > 
> > > > Directly assigning to retval at this point will clobber a previous
> > > > -ETIMEDOUT error.
> > > > 
> > > > In other words if there is a timeout waiting for FW_SET_DATA0, but not for
> > > > DW_SUCCESS, then we will return the wrong return value.
> > >
> > > Yes, agree with you, but seems I keep its original logic unchanged.
> > 
> > I disagree.
> > 
> > Your patch does not preserve the original logic. Your patch explicitly
> > sets retval to zero if the second loop succeeds. The original code does
> > not do this. As a result there is a change of return code for one of the
> > error paths.
> > 
> > 
> > Daniel.
> 
