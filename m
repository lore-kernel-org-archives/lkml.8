Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5887C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C646B2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594681572;
	bh=u38qQRxtP91hc9Pn5P9p4w1ZGDjrKxTm6yZGnkMhX2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LLPCXdco6oTOcF34NflGLN4dZDwh3TSmT4wTxB0/a/u0f9Vcb0zLIZZ8YSTvw+VeZ
	 xSAgmKtQMeS3BBwyCVUNwzuTsLXIC7tgHGa6VWrUo7wVHm42Iq6G9mD0I9HTsC0Y+F
	 lXu+Z0CIdefqj2n8ha/B4cJOxNrFAJ9pRTKbCl6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgGMXGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:06:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33150 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:06:10 -0400
Received: by mail-io1-f67.google.com with SMTP id d18so15374962ion.0;
        Mon, 13 Jul 2020 16:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XA4BB6FazEGBX1PaMryq6/o+Tzg4dFJ0aIRvH8y7LQw=;
        b=SFaBh/U59eYp/GflsGEy6WRf1pzaeDLN+FKuK90GMVU1JeV1oQ6pr+f0UdEKZNA9Xi
         kJT1vfOFMKQ1RTXnLvMpChhEVFafxQg5M2fiUcRe52OaHVKAgXYfDzgFvaHjH9VvCpht
         LvyRcPRLuZCaVcMZ8w1wNnPc0IxorWr/0AVfww8hmjYhGWfdkRw1++hIOR2oh7ukINnt
         fi0hK2kz9a0HpAzsj/Y4xav3Cyj8t7/k9/6prGry1t/MdD0ZCNEHTAXZJ/zBkr1ULHxS
         RxCpkpb/7rCLQI9kQoIRmjxzkUmaAEa8x7VTL4NJtsQqh9zRJZAf/Vyl2S4AGPkRtT/8
         Oh/w==
X-Gm-Message-State: AOAM532smzZK5ZkJq/inOwzzy2MKz2twL52xZOg+xuoyaHuO33JADhQB
        +DNpP4Bqoj0RF4Pmli5alDMMt9gw8Q==
X-Google-Smtp-Source: ABdhPJy0Eu8uS8XRgfOhXG3Xs4i0VS/SjjD9lFH6csH0UXcJR4J//DEYTVmu1BbLa7MVTota+1JNRQ==
X-Received: by 2002:a5e:9b08:: with SMTP id j8mr531727iok.116.1594681569149;
        Mon, 13 Jul 2020 16:06:09 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x12sm9111916ile.14.2020.07.13.16.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:06:08 -0700 (PDT)
Received: (nullmailer pid 889798 invoked by uid 1000);
        Mon, 13 Jul 2020 23:06:07 -0000
Date:   Mon, 13 Jul 2020 17:06:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/14] dt-bindings: clock: combine qcom,sdm845-gpucc
 and qcom,sc7180-gpucc
Message-ID: <20200713230607.GA889744@bogus>
References: <20200709135251.643-1-jonathan@marek.ca>
 <20200709135251.643-7-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709135251.643-7-jonathan@marek.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jul 2020 09:52:37 -0400, Jonathan Marek wrote:
> These two bindings are almost identical, so combine them into one. This
> will make it easier to add the sm8150 and sm8250 gpucc bindings.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>  ...qcom,sdm845-gpucc.yaml => qcom,gpucc.yaml} | 14 ++--
>  .../bindings/clock/qcom,sc7180-gpucc.yaml     | 74 -------------------
>  2 files changed, 9 insertions(+), 79 deletions(-)
>  rename Documentation/devicetree/bindings/clock/{qcom,sdm845-gpucc.yaml => qcom,gpucc.yaml} (82%)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-gpucc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
