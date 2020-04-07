Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4B6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899DC20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vo5B1mgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgDGPcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:32:51 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44245 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgDGPcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:32:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id h11so1363187plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FghI9CGje7bQZiVsZZ6C1elOlQeB+Hd1LlrvzJxqs+E=;
        b=Vo5B1mguXpOlYk6Y0joNe6L7wU6R9dxOzmjXbWxzDMjzBlQwsC90H68Oe0TnyxTw/z
         z/c+L1r8BIJE0yPZyDCzbdCpcz2H5GIUEkKuV3gYp9QSgCe2vGVnOXbr1AD2VfyKHfiA
         Xgd1jK9yCZkzT1GiUc9oSsJvAW7v66Xk1d9M5uaK/zqRzFm1mC2glXrM0z/IWBe/Bh22
         yPCuWYAvFBNPOtcOJITbvKkGk3LcoClCxK24YSaQDodDGy/t4JaKdetIn4mjPogy+GQT
         585HLXflcH5lwXtjZOWKu6PFL5oA6H86LRzvD5AKhOdedXDnBl2xd08F42ytaRoL+YC0
         LSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FghI9CGje7bQZiVsZZ6C1elOlQeB+Hd1LlrvzJxqs+E=;
        b=Rgot24sHhSrUGsNh1mJJdYkkNOYjRQmrFgY1J5LAkxZWsP/MhW7kUgJ/6WhLV5EUC8
         fdbEmN9hQ4eJLwAwZvJ/RPjNm8bH86a84krwK9V9lzLTf/KJz0GCGi8njdJbBPgIy8lt
         itfit9xrH9VDw4c8FDKqNVugeDONIJn9kHj8Jv/oV4GTyY6cp59SFy2XpMSgDpXnd6Hj
         D1ci6nXIlBQRXC36Y2mITQJCBeILPUfW778n4Hxo/dpQju1Cs1x/nx0ocriPRl9T7FJX
         Mf5b3V4Kav2sQkmio1wDUhqxH074Pi2CvIo5UZAr8i0nhCkofQ0Td8DCNw1D/j+DT3nL
         SKsQ==
X-Gm-Message-State: AGi0PuY7t5b41I5GcOPb6FDX5GpHmDW/DeU6R5qyn0ZSbzoEZb4DBsbI
        z7qVTnZBZMEZNv5KswcEHh9e3XYueQ==
X-Google-Smtp-Source: APiQypLCHMymCfBwKdznDru4hE2vjy8+J10/HPuhKamSykwdzpUXXiqcWIT7rE0CpA7M4vGl4ewSmA==
X-Received: by 2002:a17:90a:2a89:: with SMTP id j9mr3370974pjd.64.1586273569513;
        Tue, 07 Apr 2020 08:32:49 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e86:d03b:65ee:cb40:6d79:8376])
        by smtp.gmail.com with ESMTPSA id r63sm14379471pfr.42.2020.04.07.08.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Apr 2020 08:32:48 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:02:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] bus: mhi: core: Handle syserr during power_up
Message-ID: <20200407153244.GJ2442@Mani-XPS-13-9360>
References: <1586207077-22361-1-git-send-email-jhugo@codeaurora.org>
 <1586207077-22361-2-git-send-email-jhugo@codeaurora.org>
 <20200407062641.GC2442@Mani-XPS-13-9360>
 <f63b0a23-97d3-e690-70ae-a4485d42b28f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f63b0a23-97d3-e690-70ae-a4485d42b28f@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 09:11:33AM -0600, Jeffrey Hugo wrote:
> On 4/7/2020 12:26 AM, Manivannan Sadhasivam wrote:
> > On Mon, Apr 06, 2020 at 03:04:35PM -0600, Jeffrey Hugo wrote:
> > > The MHI device may be in the syserr state when we attempt to init it in
> > > power_up().  Since we have no local state, the handling is simple -
> > > reset the device and wait for it to transition out of the reset state.
> > > 
> > > Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> > > ---
> > >   drivers/bus/mhi/core/pm.c | 20 ++++++++++++++++++++
> > >   1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> > > index 52690cb..cd6ba23 100644
> > > --- a/drivers/bus/mhi/core/pm.c
> > > +++ b/drivers/bus/mhi/core/pm.c
> > > @@ -9,6 +9,7 @@
> > >   #include <linux/dma-direction.h>
> > >   #include <linux/dma-mapping.h>
> > >   #include <linux/interrupt.h>
> > > +#include <linux/iopoll.h>
> > >   #include <linux/list.h>
> > >   #include <linux/mhi.h>
> > >   #include <linux/module.h>
> > > @@ -760,6 +761,7 @@ static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
> > >   int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
> > >   {
> > > +	enum mhi_state state;
> > >   	enum mhi_ee_type current_ee;
> > >   	enum dev_st_transition next_state;
> > >   	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> > > @@ -829,6 +831,24 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
> > >   		goto error_bhi_offset;
> > >   	}
> > > +	state = mhi_get_mhi_state(mhi_cntrl);
> > > +	if (state == MHI_STATE_SYS_ERR) {
> > > +		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
> > > +		ret = readl_poll_timeout(mhi_cntrl->regs + MHICTRL, val,
> > > +					 !(val & MHICTRL_RESET_MASK), 1000,
> > 
> > Hmm. Do we really need a max 1ms delay between each read? I'd prefer to have
> > 100ns to reduce the wait time.
> 
> 
> I assume you mean 100us since that's the units of the parameter, and
> usleep_range is the actual delay mechanism.  Please correct me if that is a
> bad assumption.
> 

Yep, it will get extended to:

usleep_range((__sleep_us >> 2) + 1, __sleep_us)

So the max delay (range) here would be 100ns. Anyway, I'm okay with 1ms. Please
see below.

> I chose 1ms to try to avoid flooding the bus, since on one system we care
> about, the round trip time was observed to be ~1ms.  However, that is fairly
> arbitrary, so a factor of 10 reduction don't seem like a significant issue.
> 

Hmm. I thought 1ms is too much wait time but just looked into some downstream
controller implementation and they seem to be allowing the timeout value upto
2000ms. So this is fine. Sorry for the noise!

Thanks,
Mani

> > 
> > > +					 mhi_cntrl->timeout_ms * 1000);
> > > +		if (ret) {
> > > +			dev_info(dev, "Failed to reset syserr\n");
> > 
> > dev_info(dev, "Failed to reset MHI due to syserr state\n"); ?
> > 
> 
> Ah yes, that is clearer.  Thanks
> 
> -- 
> Jeffrey Hugo
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
