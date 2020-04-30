Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8F0C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CF72186A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcS/Ek/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD3Hfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgD3Hfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:35:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8419BC035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:35:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so1944290plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5j98N+kyJG3HhZ4ROV8U2tYLoi9tRHcX6NSDJJqOtoY=;
        b=JcS/Ek/NLrw/zFeQFXDMsRv+5b8YkJqFapKIbmYbIZu5J8iCGJTnzZY5Kqyur+MqLb
         3wAb08uh1nT/TKJnarFdg+XtedtgdBRvQicEA1Y50ks4OnXdWf+1Y0iPIqyGdfyGtvyc
         aIP5z7Jvmlg99b1csm7TSxBu7ZFykOLUyWUL5nd+CqRIZdDIThkW2VKeB+60QIxKzxQn
         lIk/011ysKrrUE5C030fw6vhwb0ITUM591bkMUNTHqdU9ptmCo9Pziq72LqfMzBH+jzH
         rXkRIejqbUbmsn2zQ63x+9VebYys11Rql0axMptefkvwJBGm3m3NADDiVyX2EMgfjgFy
         qqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5j98N+kyJG3HhZ4ROV8U2tYLoi9tRHcX6NSDJJqOtoY=;
        b=HyaSv49rOnDHqlSgGgXoowLNwRsY9Zu8ZQyHSOYWweNEp9aGgQXfb2njWJvEh0ZCE6
         IphbBVhE02HbLuCOZIm40lcyztRAnAKYfbN/a7dxcOHUQ6tfDHG8A3xlnVL3/sZ6oHRI
         t4D51gsZKddUbxI0qb4P0l9XmfiZyYRcpZ/3W6VofIPWQp5MUEpT9NZ5MGf64Mv16zsZ
         TGe6c5qpg/CsLyz45cIwgUPzyqG3MfNtJT+S2NRXJ++IchoU10IgfvwKlxowOnuJYRbU
         ZMuvJaA1l8W5UjdLgCAVsd7gxVJc/R43zj1qwzGweOvu0k0UL38JlajjDfKNf8IXGRZb
         itAw==
X-Gm-Message-State: AGi0Pubejb9MdOnNaVRLCUJf3sRO0Q4LykYjJTdwOZGw1FXCofWaX60+
        KhbWkoRfNH8dtb3lpsITzJ/K
X-Google-Smtp-Source: APiQypKA2FTVHA3mAFE6sqMc81pOC0XsYAaj9CrcJzQecfjqc0mWYdEfh70BzUrTtAC2r3utgvRp2g==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr2524821plr.213.1588232130776;
        Thu, 30 Apr 2020 00:35:30 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6081:946c:419e:a71:7237:1613])
        by smtp.gmail.com with ESMTPSA id t3sm2703551pfq.110.2020.04.30.00.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 00:35:29 -0700 (PDT)
Date:   Thu, 30 Apr 2020 13:05:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     rananta@codeaurora.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH 2/2] soc: qcom: ipcc: Add support for IPCC controller
Message-ID: <20200430073521.GB9449@Mani-XPS-13-9360>
References: <20200430063054.18879-1-manivannan.sadhasivam@linaro.org>
 <20200430063054.18879-2-manivannan.sadhasivam@linaro.org>
 <93afcf6810308580a299905da2b8dad0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93afcf6810308580a299905da2b8dad0@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 29, 2020 at 11:45:27PM -0700, rananta@codeaurora.org wrote:
> On 2020-04-29 23:30, Manivannan Sadhasivam wrote:
> > +static int qcom_ipcc_probe(struct platform_device *pdev)
> > +{
> > +	struct qcom_ipcc_proto_data *proto_data;
> > +	int ret;
> > +
> > +	proto_data = devm_kzalloc(&pdev->dev, sizeof(*proto_data),
> > GFP_KERNEL);
> > +	if (!proto_data)
> > +		return -ENOMEM;
> > +
> > +	ipcc_proto_data = proto_data;
> > +	proto_data->dev = &pdev->dev;
> > +
> > +	proto_data->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(proto_data->base)) {
> > +		dev_err(&pdev->dev, "Failed to ioremap the ipcc base addr\n");
> > +		return PTR_ERR(proto_data->base);
> > +	}
> > +
> > +	proto_data->irq = platform_get_irq(pdev, 0);
> > +	if (proto_data->irq < 0) {
> > +		dev_err(&pdev->dev, "Failed to get the IRQ\n");
> > +		return proto_data->irq;
> > +	}
> > +
> > +	/* Perform a SW reset on this client's protocol state */
> > +	writel(0x1, proto_data->base + IPCC_REG_CLIENT_CLEAR);
> We can skip doing a SW reset here. Few of the subsystems may be brought out
> of reset via the bootloader and the interrupts from them might be pending.
> Doing a SW reset here would clear those interrupts.
> 

Okay, will remove it.

Thanks,
Mani

> Thank you.
> Raghavendra
