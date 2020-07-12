Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC6AC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58AFA20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upPgI2S+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgGLR0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgGLR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:26:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4AC08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:26:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ch3so4979781pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hzeascj2XCa1OYknGvF/fsco34LrcSYuFbtvrfksp3s=;
        b=upPgI2S+ZJy/GExdD2qzp0knzt+CNMOGr8Am6fo32jENn6mYRgDBJU/RCUfm8m+R/c
         nbjwBi/1I9a533Cy6C90oBObqGSP8psl/gdmMzNTqxIqPgonalIstidUmFYn5aFN5wqt
         VT7zqOGhlu0vn+ZQFTy/rbmX91TQQpexGc5FitFu9oXzMtxalcaAI9Jp82jhtMwxtct2
         m1zSdSDhr4ejYT47G0+zEfo1kb5Hl7aiq0LMdOM1slgUwFKkH/TBFmsLZJ+Hh+jrrPlL
         M8czWUrInWSXzuqPJiufgkYG85FnpnyOzV799LYfwBuiUdmzdkUAOh2yfmLnQgGU6QZc
         waUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzeascj2XCa1OYknGvF/fsco34LrcSYuFbtvrfksp3s=;
        b=kmwMqfPno4ydoStOuKhjePTYyWk94/a9r1DmcWbz2tFHJOTFYrNWOOA6+aTtuzZK2d
         sjux+LWuBOpBA+35sM77NOHu3y6FulLDtH+5NJaqVfs6Pj+NbOtmhs9K/vAHViRiHnhA
         +XPS8Qp1kH54pyWtHTyeGvc0eV7qjKH/HpAzOfG/NsSLOZqiG0Jc6MAnFsNmRXxyQ+bb
         SIRDt+fFVKVk8nTudGf6sVnNQCkzsGdXivXMiCdQoqS9pKQ16wHw6r6OhoVF9F5Jg7fQ
         73p2/6BWYvO668WuBV+2hWTso3C0LmrbUpO2I58CSv1Nmen9oB+ZRBpGjloZkhWWihZV
         +xwA==
X-Gm-Message-State: AOAM531hSMlyuxKNGrq2Q2vqz/hJqupWXZ1ORh0Z0vEs62YTYRuKTGP7
        hpO9cLwnYdinPrfAUIBNhnRF
X-Google-Smtp-Source: ABdhPJzc95iQjLKs3H3XJtLZ7plTR9MqKrwLMZRA49J5BqIWf5Tq1vBsXJS/yd71mTHJLuKVvzwvDw==
X-Received: by 2002:a17:90a:2846:: with SMTP id p6mr16022228pjf.163.1594574782931;
        Sun, 12 Jul 2020 10:26:22 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id az16sm11773569pjb.7.2020.07.12.10.26.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 10:26:22 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:56:17 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 08/10] dt-bindings: mmc: owl: add compatible string
 actions,s700-mmc
Message-ID: <20200712172617.GJ6110@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-9-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-9-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:22:54PM +0530, Amit Singh Tomar wrote:
> The commit adds a new SoC specific compatible string "actions,s700-mmc"
> in combination with more generic string "actions,owl-mmc".
> 
> Placement order of these strings should abide by the principle of
> "from most specific to most general".
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes since v4:
> 	* No change.
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
