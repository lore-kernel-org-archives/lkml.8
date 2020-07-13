Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C411BC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2662065F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594681597;
	bh=jqPgjc8TI++YpoK3JhvBvO7ergHcGxgHVewn8rfk7gY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=faikA2aFLfxUAZCG21EhV5S8ecU4d9fPQctyJ5COLYG6AgTUfWOreZh3OGDKnvHAo
	 MIrgEuj9E4NzA10i+ozueK5HQDydzy3/ya/4bJKiKtQgCoEZ6fyfq3N9OctScN9uQ3
	 VJrN5QQ7pOK4kjgwONFm0WmyAiZfbNKZDLfcCJx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGMXGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:06:36 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:37549 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:06:35 -0400
Received: by mail-il1-f196.google.com with SMTP id r12so12699004ilh.4;
        Mon, 13 Jul 2020 16:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kli/ERNjChHPAj39/TtpIETaZE6bm/hF+PLW7AJe0iM=;
        b=AACDXrBZtUA+AL82tytbscN1NUvuBo/h+DTAePsLW56xWkOM3QHXDtaojjjeqXBILu
         5B4yeMeRdqx352wW3f5zwk8Pk9Bvz08YFax299EK3CxOUs2U0W0cDXl4AJV+rOwmD+Gn
         C9BcHQlfZe0jf5iypFWNfb8msvqOpKmawDBT3mkq4iN+lM1rYKrQ469sQ8gYoJaNJiPI
         lMZ0Xf7CPe8u88mrqLBWNPi1VDEyK8/5vmO8YqO2HXctjDjdKm/vbpB6NxlaLd9a9h30
         gMr9g95PUMYOZAnxlVePzFtjHuZWXQ8VygnlPfyKvqrC5tSKgA7mzLa/t+VAi6uPKJpL
         q+HQ==
X-Gm-Message-State: AOAM532g5ZkKPpRgGqRYRXnZ3QueXIudT6qQhnff1NrkRN7e7/D4dTys
        9NtobdotYlaw2ka3uaWpHg==
X-Google-Smtp-Source: ABdhPJw6Tyw7LqZOCGy2V6k2TA6bmv7SMhqebB6kbj7uS544zJ58gv9zfsamtdIrmmU5ogHaHvCkAw==
X-Received: by 2002:a92:cc50:: with SMTP id t16mr2142111ilq.180.1594681594672;
        Mon, 13 Jul 2020 16:06:34 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r11sm8936009ilm.2.2020.07.13.16.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:06:34 -0700 (PDT)
Received: (nullmailer pid 890427 invoked by uid 1000);
        Mon, 13 Jul 2020 23:06:33 -0000
Date:   Mon, 13 Jul 2020 17:06:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v3 07/14] dt-bindings: clock: add SM8150 QCOM Graphics
 clock bindings
Message-ID: <20200713230633.GA890380@bogus>
References: <20200709135251.643-1-jonathan@marek.ca>
 <20200709135251.643-8-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709135251.643-8-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jul 2020 09:52:38 -0400, Jonathan Marek wrote:
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM8150 SoCs.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  .../devicetree/bindings/clock/qcom,gpucc.yaml |  4 ++-
>  include/dt-bindings/clock/qcom,gpucc-sm8150.h | 33 +++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8150.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
