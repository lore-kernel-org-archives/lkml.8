Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290FAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05043208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovPlbeG7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgGCRQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgGCRQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:16:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BF3C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 10:16:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so22351867wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FxRve2hMtUdns9GF1PPX+8MR3XJWnuq1p7ahPKHL6MQ=;
        b=ovPlbeG7KEIVK7o4qcP59Ok3ZPRGlLd5S1y89McrPEzOQBlFT4tNSB24viKBYqRQWg
         MlQ6G4FIJ/GSe4ipD7CVWoXpIRebMvjS8TfIpPzXLCur6k5HJitZM4Ail2i4iDq5z7Xo
         luYVhegMxIl2EFx8iD5XHSeDNxkwiSB3WWdTLjYhXlrPi24NHlsswbIcLeEQO9SLErM0
         HoJaaBnvW+QhecPljYZ9jr6YCGK+hLEG9FqR7Ev+riqOTrTMLtdoW+T6IYMPApJdsWqp
         ixPdFtHnl4oH4jItXSrDHtQ2f5WDM6WrQmsrxCdiduXLya8qP6RKxikuIOXXc/OVAVAt
         v8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FxRve2hMtUdns9GF1PPX+8MR3XJWnuq1p7ahPKHL6MQ=;
        b=NZPpLyt4ZbCrxxiMH6xTSQe4CGo+MVWeTPLJOO97I9p8I8DDx+uBS7nSwNMR/WqiiT
         NgDb5q/aRAUqV+pduqkOjYR9yoIsJru/teitRIGT4EKyUsI491uA5RepHsBsr5XP9hHw
         EyRvDbHDAdafBSnHymVdgidst/hCma7ZWJ5NnfqgsvRCbWw4KoI1ciOydnJlLLGRv5cD
         B2UKgBU2lBb/tFKtaFefLRK+WT0uA+HZk2ZT7q1v4aTtHd4N9E2Lt7UvLnoyLGq1EAFV
         37QMgw+c8Em0Xfl49P8tS3oI5N1DUlrY7JHz5LJ/efFgKZAMZ/Oq9M4YWn9FSThCTfQh
         l5KA==
X-Gm-Message-State: AOAM532zQWKdaAGbo4u4TK4JnjuDPK0R2PQE89beoCl3xnZxliUdtpQp
        iIs6Rhc0kpWai1qFJKL7yye/3g==
X-Google-Smtp-Source: ABdhPJz6FPloh+OkdzSbAuHwscGFSOCatxSX27yxxqeWQ0bfdGxYpH2xoP1pjXeNtfBsfLlVZdOYiw==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr37102882wme.171.1593796593761;
        Fri, 03 Jul 2020 10:16:33 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id j6sm2243550wro.25.2020.07.03.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:16:33 -0700 (PDT)
Date:   Fri, 3 Jul 2020 18:16:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH 11/30] usb: dwc2: gadget: Avoid pointless read of EP
 control register
Message-ID: <20200703171626.GC2743379@dell>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
 <20200702144625.2533530-12-lee.jones@linaro.org>
 <20200703072926.GA2322133@kroah.com>
 <e88abd64-4acf-31f6-f76a-5a333df3d46a@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e88abd64-4acf-31f6-f76a-5a333df3d46a@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020, Minas Harutyunyan wrote:

> Hi,
> 
> On 7/3/2020 11:29 AM, Greg KH wrote:
> > On Thu, Jul 02, 2020 at 03:46:06PM +0100, Lee Jones wrote:
> >> Commit ec1f9d9f01384 ("usb: dwc2: gadget: parity fix in isochronous mode") moved
> >> these checks to dwc2_hsotg_change_ep_iso_parity() back in 2015.  The assigned
> >> value hasn't been read back since.  Let's remove the unnecessary H/W read.
> >>
> >> Fixes the following W=1 warning:
> >>
> >>   drivers/usb/dwc2/gadget.c: In function ‘dwc2_hsotg_epint’:
> >>   drivers/usb/dwc2/gadget.c:2981:6: warning: variable ‘ctrl’ set but not used [-Wunused-but-set-variable]
> >>   2981 | u32 ctrl;
> >>   | ^~~~
> >>
> >> Cc: Minas Harutyunyan <hminas@synopsys.com>
> >> Cc: Ben Dooks <ben@simtec.co.uk>
> >> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> ---
> >>   drivers/usb/dwc2/gadget.c | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> >> index 116e6175c7a48..fa07e3fcb8841 100644
> >> --- a/drivers/usb/dwc2/gadget.c
> >> +++ b/drivers/usb/dwc2/gadget.c
> >> @@ -2975,10 +2975,8 @@ static void dwc2_hsotg_epint(struct dwc2_hsotg *hsotg, unsigned int idx,
> >>   	u32 epctl_reg = dir_in ? DIEPCTL(idx) : DOEPCTL(idx);
> >>   	u32 epsiz_reg = dir_in ? DIEPTSIZ(idx) : DOEPTSIZ(idx);
> >>   	u32 ints;
> >> -	u32 ctrl;
> >>   
> >>   	ints = dwc2_gadget_read_ep_interrupts(hsotg, idx, dir_in);
> >> -	ctrl = dwc2_readl(hsotg, epctl_reg);
> > 
> > As you know, lots of hardware requires reads to happen to do things, so
> > are you sure it is safe to remove this read call?
> > 
> 
> Greg, yes, it's Ok to remove this unnecessary read which remained from 
> previous implementations.
> 
> Lee, please add "Fixes:" tag and resubmit v2.

Is this suitable for Stable Greg?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
