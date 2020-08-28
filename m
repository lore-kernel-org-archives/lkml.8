Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1500C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC9D2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQHJGCK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgH1L7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgH1L7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:59:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44C2C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:59:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d22so551845pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f3M5XF5W0Ou1L4FlWGEToI/r8sFWhVsFqUJE3/bLn34=;
        b=xQHJGCK0B2uggZDjemc59dlPqiHHOQOQxKJgC881EiNtYbPS6vQcqMnAGJbDk+dh/8
         mZRaHS47c24rUo8IYz9YInOhMGyIxLOIsL//rPPukHaL1kMoJ85pcvqOI5IaFejVdtNb
         3quYFmeMZSMoGznKgdrNuJ9q9WhOjV6MYw5WNmadI2Z4raah1MPuWbLG4jpX3lbsvY8I
         enD1Gl5wfInoWwH90nuCSAV5kFj6vNABqlFhLJy81pL9iPnymyRM89ogM7yFrKFy8v1r
         aYP5IXSqPbIT6RxC8Wsu0+0GFzik/s/LULAyG5xXXQub+SyPlYmtOTkkvdmp2ci+t/mN
         zgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f3M5XF5W0Ou1L4FlWGEToI/r8sFWhVsFqUJE3/bLn34=;
        b=o9fo8MyLAOeqczB3vxGl5nq3VIWgOHbHsfs2QPi4w+frVFJkhbrJqfzP8vYtWUTyAK
         67Ycb3hsfk+c0hd9OEGEZR5XQKKN6iHWFVy1Rs/bjhObtV9OuKuitaFDHalqZsanIdcO
         6slG5/iHNPm8fO1iRj3t9GHZzxeo1L8sAcFOtv2aZNFG4kdgle4qqAajpHECkk4mJ8jk
         dvuMdwQbrlYjb0k6hOfX+UAl7QYNVYgiP0TrKaIGsBGOJSwQvKcM7zebKsXDMCtRmo7e
         dnOC7yND1ZRUQ3CeJxMR45lep1sVXONmz0Ik1aF5Aw3ovCTCWs4uGbLDnCrKNdjYojYN
         9Yrg==
X-Gm-Message-State: AOAM531qwPWbgC0v3DQJnEDTTAlEwQ0HVmBu8e6De06PPbgrjqZhnBxk
        Nh5Jwx7k282ioEfelJCZupf2
X-Google-Smtp-Source: ABdhPJyIQPriGzUhD/kooRpusgj4ae9zzs5ryWPt+Dt3pzJohWg9d39yfSEvoRnBvsL7p42bTxhpEg==
X-Received: by 2002:aa7:838d:: with SMTP id u13mr964850pfm.158.1598615971163;
        Fri, 28 Aug 2020 04:59:31 -0700 (PDT)
Received: from mani ([2409:4072:6d87:4cd4:5db4:99cb:1fe6:fc86])
        by smtp.gmail.com with ESMTPSA id a69sm1562195pfa.116.2020.08.28.04.59.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Aug 2020 04:59:30 -0700 (PDT)
Date:   Fri, 28 Aug 2020 17:29:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 08/10] dt-bindings: mmc: owl: add compatible string
 actions,s700-mmc
Message-ID: <20200828115922.GC9143@mani>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-9-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-9-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0719, Amit Singh Tomar wrote:
> The commit adds a new SoC specific compatible string "actions,s700-mmc"
> in combination with more generic string "actions,owl-mmc".
> 
> Placement order of these strings should abide by the principle of
> "from most specific to most general".
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Here also, neither Ulf nor mmc list is kept in CC. Please resend!

Thanks,
Mani

> ---
> Changes since v6:
> 	* No change.
> Changes since v5:
>         * Added Mani's Reviewed-by: tag.
> Changes since v4:
>         * No change.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * Added Rob's Reviewed-by tag
> ---
>  Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> index 1380501fb8f0..5eab25ccf7ae 100644
> --- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> @@ -14,7 +14,11 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: actions,owl-mmc
> +    oneOf:
> +      - const: actions,owl-mmc
> +      - items:
> +          - const: actions,s700-mmc
> +          - const: actions,owl-mmc
>  
>    reg:
>      maxItems: 1
> -- 
> 2.7.4
> 
