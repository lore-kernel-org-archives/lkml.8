Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B4C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657D521973
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 02:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594692638;
	bh=5c3QuihQALTZgxjxEZz4oU51gs2BZpZ72z0g/xS6hOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0CvYBLTtny4Xuw9VcLXo47C79oghzhhOawdg04OfTn4r7cHIlJLfYxpDr/wbKzMJF
	 kahrAh9SPyX6oSOpsPgb4wIGl0+QroWAlBY8uLSQGmMkFukr27Kxnx48Gu27JwRPtL
	 CLTGw0chmiBApcGiY6mOiXpmnCgdz147vpIU2Muc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGNCKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 22:10:35 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36928 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgGNCKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 22:10:35 -0400
Received: by mail-il1-f193.google.com with SMTP id r12so12978245ilh.4;
        Mon, 13 Jul 2020 19:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HVXpc1NITyP8Pn7hV8yHkm5mpbKPnCCTBIkt0whb6Rg=;
        b=Ht3klcZqrim1JKB9RDNEG+uQZ9bYa3jRIPWPPzmLVv1/AO7UWkdCzBX6IQn8wv50rt
         0C5l4XITjxooGNPfdhdW0BQf9286Tlq99mswV7pG1wKaDovk2KVABWu2+TfDBkEU9Arl
         oz+DzeX1lonmfH5tCOjqVsyjkTBBOz8i04m+euutKemOoals+4Pr9cxEl8RnuC4ObcEm
         A9mWUULZu+j/PMJ/PdbMcZvdeFMur4JpVYCVo7Ii2wTqgsyDXM0P9no0bEp9ZcvQq7LJ
         pD3Sv/ZOjoCVd47H5dB7uMq6B4D58K6A0XH/Qv6wyQ4xEKJNbYGp0BHfv6cVDkGnSbOQ
         hxZA==
X-Gm-Message-State: AOAM531ZzuDAB6gD4R2U4iANwXeWgKEjffeA5vxsuCe5XIqyk9CrdbDw
        /JZLLMrpfndWd6PntG7kaA==
X-Google-Smtp-Source: ABdhPJy4v9p582B3IXAulABtnT2za4K9ObvrGcmXa2ozTEF7GFMR0uLu7Df/Wks6wX7CDeERYr3Dxw==
X-Received: by 2002:a92:5b4b:: with SMTP id p72mr2605911ilb.285.1594692633956;
        Mon, 13 Jul 2020 19:10:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d6sm8425355ioo.9.2020.07.13.19.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 19:10:33 -0700 (PDT)
Received: (nullmailer pid 1133963 invoked by uid 1000);
        Tue, 14 Jul 2020 02:10:22 -0000
Date:   Mon, 13 Jul 2020 20:10:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: hwlock: qcom: Allow device on mmio
 bus
Message-ID: <20200714021022.GA1133914@bogus>
References: <20200622075956.171058-1-bjorn.andersson@linaro.org>
 <20200622075956.171058-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622075956.171058-3-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 00:59:54 -0700, Bjorn Andersson wrote:
> In modern Qualcomm platforms the mutex region of the TCSR is forked off
> into its own block, all with a offset of 0 and stride of 4096, and in
> some of these platforms no other registers in this region is accessed
> from Linux.
> 
> Update the binding to allow the hardware block to be described directly
> on the mmio bus, in addition to allowing the existing syscon based
> definition for backwards compatibility.
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - None
> 
>  .../bindings/hwlock/qcom-hwspinlock.yaml         | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
