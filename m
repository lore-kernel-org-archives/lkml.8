Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC31EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802AF20773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595283443;
	bh=t/mTSjX44Bm+vUObNdPyAid7AcAA0ch71Q3AD09G+7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h1zxL6jBrWzDo3/8wWsnRx6zej6RqtDch0MFaygvwjgdGUwSxRM60xC7ztEmB3+yn
	 j0f3BnMIbzThfNH7kJ3un/VpC0aDHE5BuqZ9LMpp9iRhjGVWK77KgEVaNDkBNqqSPp
	 rqB7VXs9efQphPtBiMfUD7f1CO1TLAEDQbcxklJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGTWRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:17:22 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38013 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTWRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:17:21 -0400
Received: by mail-il1-f193.google.com with SMTP id s21so14681593ilk.5;
        Mon, 20 Jul 2020 15:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xw+kNgrmN01tKflF96Ap8WHL6nw90wmHAHL9pG+Op5w=;
        b=Xtb36kvgU0BYYO9DYZDYQKLv6pjx48BWSuREbWECkjMjudp9PeBfMhV1Bwu1kuPjd6
         C7DyOj3sk9NYNK99K7rDw8rKaqM+8789WNA9Fx0WZ73dUVV4+YYeEXx7aXdtFPII97+b
         Ug1xp0xT4ZYFqVnIf0S987JveJQtiae4Nb49SWku/Lv9pehF5DPGwPSDW3ZDgmx4xmTe
         nuPUuhB523FFL/XTRBEfA+EynME9sCz5d6ygvRixTeKpX7yhnyY17K1X7Inq83upfdEs
         k00atftZgWoFP1vdIJCYUk6EDiH/AXNpS9at+wRTDPT+f7p+YUVncQwdKb/YTcEtw6Ya
         sTSw==
X-Gm-Message-State: AOAM5312sEn4HaMyvBf5CHJgMCtjKLV4H7/X2UVOCVZj5fI3X5jzviI1
        mlnaRzUVj4j2CgcKOQ9bOQrGiNnfbw==
X-Google-Smtp-Source: ABdhPJx+fNU/JtjCpCBo//kxlDsXhsQbzWwWFEXUKfxOZlq/lfplFg9f61K0t0ozpjZvqBn4ZDC5Dg==
X-Received: by 2002:a92:8b0e:: with SMTP id i14mr24153739ild.307.1595283440805;
        Mon, 20 Jul 2020 15:17:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b20sm9756658ila.5.2020.07.20.15.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:17:19 -0700 (PDT)
Received: (nullmailer pid 3049330 invoked by uid 1000);
        Mon, 20 Jul 2020 22:17:18 -0000
Date:   Mon, 20 Jul 2020 16:17:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: remoteproc: Add common TI SCI rproc
 bindings
Message-ID: <20200720221718.GA2899451@bogus>
References: <20200717234800.9423-1-s-anna@ti.com>
 <20200717234800.9423-4-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717234800.9423-4-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 18:47:57 -0500, Suman Anna wrote:
> Add a bindings document that lists the common TI SCI properties
> used by the K3 R5F and DSP remoteproc devices.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v4: Addressed both of Rob's review comments on ti,sci-proc-ids property
> v3: https://patchwork.kernel.org/patch/11602317/
> 
>  .../bindings/remoteproc/ti,k3-sci-proc.yaml   | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-sci-proc.yaml
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

