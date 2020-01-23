Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E9C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515E62071E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHB/RV9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAWMA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:00:59 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37452 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:00:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so1280523pga.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 04:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xsupKns0vCTM3WeJcGkVjDP+YbP5uYoNms0JHy0fvAM=;
        b=dHB/RV9/Z0x+PyahfYcA/w3hi0IXq91YXf34XiKLEBPH7PVcQB3ly2nZNmJIfFosSh
         tfju8Bz7/ljCBPKPqeFO2RXN6V9nqsdtEK3slMAXurUXxdfgbJyrwE++vJRJjX4jSogo
         od+wWoDNC7GcaB18EqZrn5BTX0VP53HsxAlE6A5YVRZnnMpEnp+uF5Y222hDXRIZIykC
         vYcz3MlH2qI0q3+XyRu74FTf/21m/WHahvQXdDXMzsO5fobC0Y54Dd2WAXwgs/bl5wGU
         sTRwq7LDAK5xkzv8cnenJLCs2emZOsrU6U9TE8EOkYafvUVEP9l89bPXkAjgBnptMStZ
         yCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xsupKns0vCTM3WeJcGkVjDP+YbP5uYoNms0JHy0fvAM=;
        b=KxTEo4EEgcM11TK2125wr/nzW/8dPPiHT93J7rL1VpqTrAJRmwfLhI6LzmTVOzKKwN
         WlKinbM/zrm8UmJE0v+IWWKrwJKK8+wDt0zEd4oSG4g1t3FoNUUvcXtKouoO4kdMBM7p
         N/tytkLD6kUkaOHpWezBHH3STG81zaPGXo0MPojkEBMklNuNwkD6Pw2Js7NjghHkQJF0
         +yLISGyGK5W8C3mIr9nH8lI+bJlTXJepl1ezeMH8fFXxuXVi8UqAiQxe6eO48dMJlQfV
         ZQqwh4nj2/pSAwycCDmVVsREsydql6TAaVPx+qXTy4L76pdh4EETk/UUuXSodEInASlZ
         M/tA==
X-Gm-Message-State: APjAAAU+uCDD9UvL1ZEeaoALIj9ey7gI+HFIO1f8kFo9uwwGRo6hciuA
        wYznV7uzIP1BP3hqQeMzAtQO
X-Google-Smtp-Source: APXvYqx87g/e7WC505+cEagRJXfEeDjlYeTZUqvcM8Ppu1p39CKD9QfMfVAClfv/Qg5lNSR8rjwWNg==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr3524288pgc.133.1579780858733;
        Thu, 23 Jan 2020 04:00:58 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id k23sm2602114pgg.7.2020.01.23.04.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 04:00:58 -0800 (PST)
Date:   Thu, 23 Jan 2020 17:30:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>, smohanad@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/16] bus: mhi: core: Add support for ringing
 channel/event ring doorbells
Message-ID: <20200123120050.GB8937@mani>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
 <20200123111836.7414-6-manivannan.sadhasivam@linaro.org>
 <CAK8P3a2pZEdsAi6YQ5z3YD=zD1iZLu+WPirhwmxeZ33k7sjkeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2pZEdsAi6YQ5z3YD=zD1iZLu+WPirhwmxeZ33k7sjkeg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Jan 23, 2020 at 12:39:06PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 23, 2020 at 12:19 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> 
> > +int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
> > +                             void __iomem *base, u32 offset, u32 *out)
> > +{
> > +       u32 tmp = readl_relaxed(base + offset);
> ....
> > +void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
> > +                  u32 offset, u32 val)
> > +{
> > +       writel_relaxed(val, base + offset);
> 
> Please avoid using _relaxed accessors by default, and use the regular
> ones instead. There are a number of things that can go wrong with
> the relaxed version, so ideally each caller should have a comment
> explaining why this instance is safe without the barriers and why it
> matters to not have it.
> 
> If there are performance critical callers of mhi_read_reg/mhi_write_reg,
> you could add mhi_read_reg_relaxed/mhi_write_reg_relaxed for those
> and apply the same rules there.
> 
> Usually most mmio accesses are only needed for reconfiguration or
> other slow paths.
> 

Fair point. I'll defer to readl/writel APIs and I also need to add
le32_to_cpu/cpu_to_le32 to them.

Thanks,
Mani

>       Arnd
