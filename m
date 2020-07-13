Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B6BC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC972067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594666584;
	bh=vJxtHNyypGwk+TVMTfBp6a4pXm9+pEwfS90i5ULCyk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RmoB8qrPT2nYEUkXgO58Szq9eOpESogqhKf9txr8A6WJ/sTMVFZtohpiP52oYxZbe
	 2O55JD6ZJlmiboLLrdwXoBzUsTmHoDfmruauLbhivSo8g6OIRS2v6VAdh1PCwhpIC3
	 YGhNaMIwDAP8p5M296QJk3fOj0tZ9roHFr4X5I6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGMS4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:56:23 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34766 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMS4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:56:23 -0400
Received: by mail-il1-f193.google.com with SMTP id t4so12153238iln.1;
        Mon, 13 Jul 2020 11:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wBRljf8a76QkMbCGgSaV3rmV/O8aNaO6gVPNQt+BPsE=;
        b=kNzAXSR5j8oTU4YJIcYQa7tfPNcMvmnLSY55ZVNsp8MInluNyFdhA17C8RwDgjLAFk
         /jNMClP+GH8MaBHp6EfrXW+xs2i6AlpzNqrW4lQY4/J11Z/a9M3ZFzC0NrEnapN2+UA8
         83hpQshMi3GbGJBFQKLQQAiGmsCPz5xrWisXUSnpSbXdLicjJ2nQ9pwkTRMB/CSy1y+b
         yPo3rpS8JA8ZLi5FE9OEt/JEIAuDUhMLRTuJF5K24vQhrgqqS116DM+q9sBYWqV4FyEI
         KdTgcEdTK0jC5fbMmurFhE0UpAnMvs2CS+YZT1puVbBbHvrU/tUIhUUUGZn6OYX6l3uS
         99OQ==
X-Gm-Message-State: AOAM530Dg4jiVhzMY32KmW8cdSAm2refT46zH58zsmD/SlFubh/OFh9U
        WJ1pEoP3lF67fKyRpT6oMA==
X-Google-Smtp-Source: ABdhPJxVbEIjjkqvnsRGA1SmUFQu6iYUO9mgTJpyARM/RzrZDkLb8kFi01kyilc1wn4xnCxAxXF8gw==
X-Received: by 2002:a92:cf51:: with SMTP id c17mr1132198ilr.122.1594666582255;
        Mon, 13 Jul 2020 11:56:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b24sm8021122ioh.6.2020.07.13.11.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 11:56:21 -0700 (PDT)
Received: (nullmailer pid 538227 invoked by uid 1000);
        Mon, 13 Jul 2020 18:56:20 -0000
Date:   Mon, 13 Jul 2020 12:56:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Anton Vorontsov <anton@enomsg.org>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-gpio@vger.kernel.org,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Tony Luck <tony.luck@intel.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v3 7/7] mailbox: qcom: Add sdm660 hmss compatible
Message-ID: <20200713185620.GA538180@bogus>
References: <20200622192558.152828-1-konradybcio@gmail.com>
 <20200622192558.152828-8-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622192558.152828-8-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 21:25:57 +0200, Konrad Dybcio wrote:
> The Qualcomm SDM660 platform has a APCS HMSS GLOBAL block, add the
> compatible for this.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml   | 1 +
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c                      | 5 +++++
>  2 files changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
