Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B3BC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25F24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0DNfOwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgAVXJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:09:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38328 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVXJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:09:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id t6so467052plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 15:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nKS4ZgdlHHnHLUwY8RgxlpKouMlIJtGCSDCXGaIr8ik=;
        b=u0DNfOwoANhlQX2iaeD/Rd1l0fTDY4rKp4scoyXbG98q2ezDtpsrnZotpTkejKufHl
         213geWr0bo/PO/QkXs5pRtXn2ip2IYPuJXb1OlBnJG/6dkuwFvfFcelM/oPNa2rQX9a5
         6kcnY4VZ9X9Ksld/4jx/0Prah4EUh5Cn5r/LMI5xE7VPe/vFWQrqreNjrRmY+f8uFdp/
         iwvhHDsL/nuBiSi6QOdcjq7gG01NwHlIYdenXFTDWv5lAS7lFb+NGjoP3XSRn78at3vV
         a19LK+/DlB2vCPQA99d3CM6LGuAJa1QUyPYJyJw8w2jOEZ25TngUfrOV97VxujoVh8Eb
         ueDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKS4ZgdlHHnHLUwY8RgxlpKouMlIJtGCSDCXGaIr8ik=;
        b=EP2VFC76M+cFIej5CCwzizj9z0MupvlzzzZYX8fEv0tYHrTquOHpHPIeiQYCcadmOX
         W3vwGum20jjMT0M6sCuJTy9szku5xNrAg8rFdk/cAQDR3BQ14VYWgAivY9qyb4H56WA/
         WpEISWPB0bDZCHnjLAjPUVl9VvkVDdPGFEZ+tp+lKGYzSNqVmcXzoeIWwoTIK912BGOw
         4at0Q+Jj7Egd/2Mnz8BaqfaKGT3nexhs1SGgtm3nnEEpK+zuqzXNXQsTYrdEtKu6bMnT
         aLXWP/5fhiQlc9UTqoYjyeJCRCkfXwh4bQDqRmQ8fqiXi5UDKssesiN3nfM7s+fHMzll
         LT6Q==
X-Gm-Message-State: APjAAAVOk0jTkc8V26n6F0VUSrYT2nyMWY47dq4Gq4IvJguDTItBSdK8
        qBgZRet/+V6nugLE5VODEBFTZA==
X-Google-Smtp-Source: APXvYqyBFXtJqp1jOWq2KNpdMpTmjOylVfH3v84i0J511zxYJkbS9tWibL8rKRyReKS3P6Lcs4fWfw==
X-Received: by 2002:a17:902:704b:: with SMTP id h11mr13773573plt.147.1579734563159;
        Wed, 22 Jan 2020 15:09:23 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g18sm14101pfi.80.2020.01.22.15.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 15:09:22 -0800 (PST)
Date:   Wed, 22 Jan 2020 15:08:49 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     rishabhb@codeaurora.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH v2 2/8] remoteproc: qcom: Introduce driver to store pil
 info in IMEM
Message-ID: <20200122230849.GC3261042@ripper>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
 <20191227053215.423811-3-bjorn.andersson@linaro.org>
 <60c10082ba90fbba0f056df8575d205f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c10082ba90fbba0f056df8575d205f@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Jan 14:56 PST 2020, rishabhb@codeaurora.org wrote:
> On 2019-12-26 21:32, Bjorn Andersson wrote:
> > diff --git a/drivers/remoteproc/qcom_pil_info.c
[..]
> > +static int pil_reloc_probe(struct platform_device *pdev)
> > +{
> > +	struct pil_reloc *reloc;
> > +
> > +	reloc = devm_kzalloc(&pdev->dev, sizeof(*reloc), GFP_KERNEL);
> > +	if (!reloc)
> > +		return -ENOMEM;
> > +
> > +	reloc->dev = &pdev->dev;
> > +	reloc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
> If there are multiple entries like "pil-reloc" in the imem node
> mapping the entire imem multiple times may not work. Is there a way
> we can somehow just iomap the required region for pil?

With the entire imem being represented as a syscon this will be
ioremapped once and all callers of syscon_node_to_regmap() (or one of
the other syscon getters) will get a regmap back that reference this one
mapping.

So doing it this way allow us to "map" sections of imem that is smaller
than PAGE_SIZE.


That said, it means that all imem users/clients should access imem
through this syscon regmap.

Regards,
Bjorn
