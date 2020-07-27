Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE89C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B1B20729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595883738;
	bh=SKloWjMdbUWcoMaZtP+WOV8qA3BcFcPEsEZO0ThMqMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IXcv1i68/0916eToO5aOCA1ZpsvQBz5XU/dVcuwmZCH65hUcCmwO2JajunejVsw78
	 NFDIV1GR4GFWGQRWeO9Sor55gjvMNqK8z0YZNNtLwIMI3c83pIqyzxPYz7GOmUpod6
	 GF2k+vm43dqfS6O2HnHPdHEF8B5l29/6E3r2EroI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgG0VCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:02:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44385 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgG0VCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:02:16 -0400
Received: by mail-il1-f196.google.com with SMTP id j9so10949975ilc.11;
        Mon, 27 Jul 2020 14:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2uE9MbnZjSGJIApeYv2nTioz4BYTAMleHDWe7FX3HTU=;
        b=s/JMrkI3IszOd/y+OhwZylBYqa3DdDkwFsRgGZm5QjPD7y9DqmuJZCvz1gvi4dJFFM
         CiQqWavYACKIXbNJ+kTR649QzjCtXeoRYJanZc6Ld+gXYeAhIbz+dhcIVHrt3fWBcSEt
         GYp+GnmlHUuAp5Gx0Vt/8xL50kpr4LMOd7mqqJby3IPaDz6kz9fQFQZ91Hcv0ukHo6mu
         3IA9/0QhqryfV2y/ClLOZYSB4YnxiSjmzWY7VU9PggpXoKZ68VgycNapbSU5tMMLnO2i
         Q9PEUimz6irJjv94tY0fJZUMAdB3NI+f/H/Nyz3onL72Xktn3DZ9BhcEobPnckZURWWm
         qBhg==
X-Gm-Message-State: AOAM53311UwYiPORALJDV7CM8T0iyR74ZuJs3uCBOMLTVfBD7ZRet8+l
        Ow1x3QPalFY4RaROFHVU2w==
X-Google-Smtp-Source: ABdhPJwDRgceruN5TK389OkZGIbB3Miq0TQVJkiQSnuO2dIxFe5+mwy3r3L+V2DxoSKynzGjXgU1sg==
X-Received: by 2002:a05:6e02:682:: with SMTP id o2mr17828542ils.188.1595883734272;
        Mon, 27 Jul 2020 14:02:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u6sm1549202ilk.13.2020.07.27.14.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:02:13 -0700 (PDT)
Received: (nullmailer pid 865775 invoked by uid 1000);
        Mon, 27 Jul 2020 21:02:11 -0000
Date:   Mon, 27 Jul 2020 15:02:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     devicetree@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: panel: Add bindings for
 Tianma nt36672a panel
Message-ID: <20200727210211.GA865728@bogus>
References: <20200727074348.26116-1-sumit.semwal@linaro.org>
 <20200727074348.26116-2-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727074348.26116-2-sumit.semwal@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 13:13:47 +0530, Sumit Semwal wrote:
> The nt36672a panel from Tianma is a FHD+ panel with a resolution of
> 1080x2246 and 6.18 inches size. It is found in some of the Poco F1
> phones.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> 
> ---
> v2: remove ports node, making port@0 directly under panel@0 node.
> v3: updated to replace port@0 to just 'port'.
> ---
>  .../display/panel/tianma,nt36672a.yaml        | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
