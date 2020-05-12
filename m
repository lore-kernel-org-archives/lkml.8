Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C49DC2D0FB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D876420747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589323710;
	bh=SfSO7QENcLztGvCGxj//ifkcHyHqNWEb1L+LM0/695o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KVnjNMd09E7PIklRQh06tLF/sKULcJZdZAwcMW+f910VnmJpv+u8FImlxjjppkRyG
	 1hNs3Y1CZruE4Eu8t43RLI4H5aAV7y694S4potMqNPBAi1sMblZp26IMGKWIMZ+Rf4
	 tItuSouwuLRNL127bNU921BzzVgj9MU5F0CYuQLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgELWsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:48:30 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39223 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELWsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:48:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id m13so11909775otf.6;
        Tue, 12 May 2020 15:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JfommdF5aR26pvoOz0doQHmjh7MsV0X4kV8GfQPofGs=;
        b=JoAH4UrxcAi0mWxmG8nf51SCq9vVZAU2cQ0O8pQgh9FRgQ+fsKOe+yd5AA9RNHDxo6
         tZDWgriwXmfTnu/k8VoW77iNtKfQn668vYcldFRW3PTflJnqsAcvgXVIy3F5swlUQsvY
         YRKwqyaHn3X38513LHurFbaZgYRp/0mkwY/jtL63I+YGXRtDMTWDi0THdxUKGmO04txr
         pKzu6KWa/lAfrk8aK4DGvstJSraPeMgNIMHHuR8GWC/3/MGD3koqcfkwjeaVUkKYh3rW
         tHB8U0Cv1mYBGPCW0bmS2Id112mTTiNX2JDDG+8u54bthIbhzckhJhKPGOU8D0b/JXmx
         Vd+w==
X-Gm-Message-State: AGi0PuZrPnFWgiv/UsCQNTZn3hUhylFVXIENI9RTKd7L9syEo61WxtLb
        5On1BJxFfI8dBlyCZlMwxw==
X-Google-Smtp-Source: APiQypJAfsKJMWuQSU+ktRpo3PU8ZTfcIbP+UZi1He62ca8nLhPfscQRLXOXF0BGkC5TXvCxXzMT+w==
X-Received: by 2002:a9d:6442:: with SMTP id m2mr17934732otl.213.1589323708858;
        Tue, 12 May 2020 15:48:28 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a29sm3840493otd.45.2020.05.12.15.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:48:28 -0700 (PDT)
Received: (nullmailer pid 18177 invoked by uid 1000);
        Tue, 12 May 2020 22:48:27 -0000
Date:   Tue, 12 May 2020 17:48:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mturquette@baylibre.com, devicetree@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH] dt-bindings: clock: Add YAML schemas for QCOM A53 PLL
Message-ID: <20200512224827.GA18046@bogus>
References: <1588573803-3823-1-git-send-email-sivaprak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588573803-3823-1-git-send-email-sivaprak@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 May 2020 12:00:03 +0530, Sivaprakash Murugesan wrote:
> This patch adds schema for primary CPU PLL found on few Qualcomm
> platforms.
> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,a53pll.txt      | 22 ------------
>  .../devicetree/bindings/clock/qcom,a53pll.yaml     | 40 ++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 22 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,a53pll.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
