Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6877BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6F220848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IAx8P+Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgBKSlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:41:39 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37592 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728375AbgBKSlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:41:39 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so1617734pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xu7EuHlbPmEdsWxeqhcpcHFWwOAxYugDEE3/io8b6Ag=;
        b=IAx8P+TswPBtEzqo31P99hOqElFCCby5txh+Oscc2zELCGSh+V8oy9xOqlpkGbH7Ef
         UFy/In+m0b4c3AGRoJGmixJlOzszq2Anj2nYT4LB+CjyumYjiOR9OwKa5M5eVJ9yrCQj
         LsYE2AgdmmEVKL+ctWTreHKJiTPUspZyAsVoLnq2QY8iA6BJoabhj2etPGc+26+Xoe6H
         rBe3EuzUVbQp45qhLda9c913cu/r8Soi8GmTUZ114PwZD/pP2wONUEpfJh8PHRkdLViT
         HKNiH6pd0H7IQUZacCiMT5n8woKav6OgIXxSTJQ+VvypXnIouZyZPQeAplbzEnWV4EGm
         0QAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xu7EuHlbPmEdsWxeqhcpcHFWwOAxYugDEE3/io8b6Ag=;
        b=UPxEK6acylOaJ18l7MPXEFUgtECHFSaVoCDEBstx8dx2izQ7lvuE7a+ZipFRLNaFy3
         FMC+u2RGDzWVAVq/uDv8pyWbQ24dms6Fzd4Tnzg2fSkeeYydVrrQhp6vWUQ43JkaM1rL
         dX1OBxQ5ZMxtwJdjCRFYnL/5cCRkzEFvSW3uC6oR2bv+yYUZs94a6QyiIAPTYyOzjNz2
         23JGB9cI/szojSphPwfUbJXhEu3i4JT3D4TmrVphqBfN6VkF6/5FhIfu59jzMWGSIZqB
         F6IKTAJObpCQbsABEAkeayOiL4127XL+sgkliu8nWyzXo460FkCGzWmyWTAemaMvwy1m
         r/Kg==
X-Gm-Message-State: APjAAAVtkOeeS9a9WKfWNVE+9hpr/wl5uIj3VOKOQ8AZgrdexe3MLuQs
        ZPBcP2LdSsyLreRX0vHLj0tz
X-Google-Smtp-Source: APXvYqyCbupqRjFu0F6Wmci9gu6Qa/pIo2z9Yh3R6s5WBj8zjYf0kfRk0xoYd4RlP8k7jZYwU+Q/oA==
X-Received: by 2002:a17:90a:a881:: with SMTP id h1mr5209231pjq.50.1581446497757;
        Tue, 11 Feb 2020 10:41:37 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:638b:7653:754d:196d:c455:1f88])
        by smtp.gmail.com with ESMTPSA id q66sm5543024pfq.27.2020.02.11.10.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 10:41:37 -0800 (PST)
Date:   Wed, 12 Feb 2020 00:11:30 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/16] bus: mhi: core: Add support for registering MHI
 controllers
Message-ID: <20200211184130.GA11908@Mani-XPS-13-9360>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-3-manivannan.sadhasivam@linaro.org>
 <20200206165755.GB3894455@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206165755.GB3894455@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Feb 06, 2020 at 05:57:55PM +0100, Greg KH wrote:
> On Fri, Jan 31, 2020 at 07:19:55PM +0530, Manivannan Sadhasivam wrote:
> > --- /dev/null
> > +++ b/drivers/bus/mhi/core/init.c
> > @@ -0,0 +1,407 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
> > + *
> > + */
> > +
> > +#define dev_fmt(fmt) "MHI: " fmt
> 
> This should not be needed, right?  The bus/device name should give you
> all you need here from what I can tell.  So why is this needed?
> 

The log will have only the device name as like PCI-E. But that won't specify
where the error is coming from. Having "MHI" prefix helps the users to
quickly identify that the error is coming from MHI stack.

Thanks,
Mani

> thanks,
> 
> greg k-h
