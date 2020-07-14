Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF73C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 373AD22574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FV23NmzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgGNRSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgGNRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:18:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB87C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:18:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so7857938pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2Bgo+EwlywQpFj0pE/Su+4bABsjD1sCVUR7hvl6xKBo=;
        b=FV23NmzIE04DIi8PhPUdryuuclb6dWf24zsJIveBqunEq3yjAFNoKc4vpw+PTmPF8R
         eMu1v6Lz0x9QKnUQdQIWGtu7CvPMqmJmUPAhpF2UjXnRVfSprk7A1DvW6FYJLbWwoIgc
         FC9Y+w942Q5uz6h/EqQls2Q4XVpMYwM6k4h5EOat8wRvJizYu3sK5oAIeEk8IR5rsE80
         5GFvYA4rsonni5Ibeohb9BUzsNOGm5bhZXDhmAp68Jw+TorW7AGhHrJkFISo/FhgPN87
         jc89oJ4Uf7Cw4rsaE5e/iIDwM4SkWoHSewGHxAy+hGLcL5U9TewXLj69im6rSAivgrxQ
         9OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2Bgo+EwlywQpFj0pE/Su+4bABsjD1sCVUR7hvl6xKBo=;
        b=Ca104QHlQ0D67p2uW3YRTooRQVdHDOux8HoBv5LvrNa7+4AAKZIhUQtUwN2jvs6QgV
         AOlpLMrqyguUA04UpZWIpUFpjA81nY9GQQQgqKo2MaJCh0iBLVD6HIF8UfD2CsHwsUkH
         UEWAtDgyG7DmEz33m2nacjnqqt1Yi8L0MRU71kql1d5IyZTDIZQMPqNKk8l1G3xluc1i
         C3AEhs0S3hOSk2qk+fZWOh7Ww1/fMWd0W2TDGjpWQ4J35lCFt5tUSBGnPwOcc076FoA/
         XpeamheDB8YZq7sRVEcogxCteLUnZw21SmT6sXEkSQzWQqDpDwSeqTuKcAakQnRAPVtb
         bOhg==
X-Gm-Message-State: AOAM533eu4AsqnjkfXuS2uGka0Hhv1wgWGZldl9oC3wS78RB7g+lGUAU
        d7IZLuWaqEJVOBEnZjxdaxeY
X-Google-Smtp-Source: ABdhPJyEqwY1nnJOTN22awXt+uGZJ7NHXl3YxP9b73/ZkOSKPCwl5Y+BHZbe5WvqX7p+q/Fs1C+S8A==
X-Received: by 2002:aa7:8557:: with SMTP id y23mr5117516pfn.148.1594747111587;
        Tue, 14 Jul 2020 10:18:31 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6d83:a4f:d:a14d:ca62:5c15])
        by smtp.gmail.com with ESMTPSA id y7sm3088884pjp.47.2020.07.14.10.18.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 10:18:31 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:48:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        David Liu <liuwei@actions-semi.com>
Subject: Re: [PATCH 01/25] pinctrl: actions: pinctrl-owl: Supply missing
 'struct owl_pinctrl' attribute descriptions
Message-ID: <20200714171824.GB7260@Mani-XPS-13-9360>
References: <20200713144930.1034632-1-lee.jones@linaro.org>
 <20200713144930.1034632-2-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713144930.1034632-2-lee.jones@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:49:06PM +0100, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/pinctrl/actions/pinctrl-owl.c:52: warning: Function parameter or member 'clk' not described in 'owl_pinctrl'
>  drivers/pinctrl/actions/pinctrl-owl.c:52: warning: Function parameter or member 'irq_chip' not described in 'owl_pinctrl'
>  drivers/pinctrl/actions/pinctrl-owl.c:52: warning: Function parameter or member 'num_irq' not described in 'owl_pinctrl'
>  drivers/pinctrl/actions/pinctrl-owl.c:52: warning: Function parameter or member 'irq' not described in 'owl_pinctrl'
> 
> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: David Liu <liuwei@actions-semi.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/pinctrl/actions/pinctrl-owl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
> index 5a0c8e87aa7cd..7efdfb4f3e9ba 100644
> --- a/drivers/pinctrl/actions/pinctrl-owl.c
> +++ b/drivers/pinctrl/actions/pinctrl-owl.c
> @@ -35,8 +35,12 @@
>   * @pctrldev: pinctrl handle
>   * @chip: gpio chip
>   * @lock: spinlock to protect registers
> + * @clk: clock control
>   * @soc: reference to soc_data
>   * @base: pinctrl register base address
> + * @irq_chip: IRQ chip information
> + * @num_irq: number of possible interrupts
> + * @irq: interrupt numbers
>   */
>  struct owl_pinctrl {
>  	struct device *dev;
> -- 
> 2.25.1
> 
