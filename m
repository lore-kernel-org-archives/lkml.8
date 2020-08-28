Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECCAC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024BC2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 08:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oTLBXCow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgH1IoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgH1IoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:44:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B82C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:44:09 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id p185so189177vsp.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 01:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cc1vQbGgqf+amiBHWY1IMOdydTFZAVrY20aisiaS4NM=;
        b=oTLBXCowz2Ivx/xHjp7O1Rprgu+UMpXnYOiQYm0n8/koXHdrGf5Ve7teQgcZfCJmJT
         MHgI1EldAJBP9e09MJiJttVh7F2E8HBzic7FpEr+4y5FyYGBomdDRQPJDxq1Gu7S29jG
         ToYOkzkQcim7Ew6uj93SgJ4CPA2waF3IY4JcbDObmD1llZ5BbflMZDgriJgK90VXVbxP
         3944TPjQxvAOc9q+F2O6nMo1OT2CcWbS0r8ciy3QSGiwDnQLuzB5HkyFOYs5BgaWBfDq
         ujVozHVlqa6wLm4saROIYs6KlBaxnlyapZcm+B5gj9EVKKOpyOepKntBHI2j8dpSbZy4
         trpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cc1vQbGgqf+amiBHWY1IMOdydTFZAVrY20aisiaS4NM=;
        b=scrG/bGw4Xfe0msy2+C7kPzbRAceD6dYpp+QCNHbxyBVADCQZmfn0q6/M1nzdalDHx
         T/kr3g00kELsXhHsaa9HvMCPIx6j2oKqI5l5X8OK9x78iB5NJiVMYqt11tzQYS2JsVFr
         U0dewkpFwxQFggTn5hhdem0HILAJHJ7lBy4uX8ZDR75rsPWEyBlXfkTywoqo0FcnduPT
         K3+hGbazk3jbraDoxub9Zhyxok4vbNvQCkT7VCiISUrzAdEoVx4mUUWn4GJ6lPMKtyMR
         pa02WMUJj8zSqMyWHgaO6wx6f1IkHuYdxnLuXJIrIGQGKiw2raSNOJChf9Umf3nU5BRG
         PT+Q==
X-Gm-Message-State: AOAM533bwQ9QXYyH5wqHPDrS1JMnncwbN9rdrICwlwqVqT4/XVv21W1/
        LtnSwm1nl4jso0P71yi2fw9JmDDPXsco+LdyreMzQg==
X-Google-Smtp-Source: ABdhPJyvt0SgqChpFNDVYjXJ0/DC6HvRsyVJUsGo3Bms2o4vGVp5b7mr9mpFbvMeJtwH0XDSySioP0MMC0zCH+J2hbw=
X-Received: by 2002:a67:f8ce:: with SMTP id c14mr185410vsp.14.1598604247538;
 Fri, 28 Aug 2020 01:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200826130106.22889-1-lars.povlsen@microchip.com>
In-Reply-To: <20200826130106.22889-1-lars.povlsen@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 28 Aug 2020 10:43:30 +0200
Message-ID: <CAPDyKFrksttM_cxL4xKxe_pXDPMFr=HCVq3ns09zEbC58ivuKQ@mail.gmail.com>
Subject: Re: [PATCH mmc-next] dt-bindings: mmc: Fix mmc node name in DT example
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 at 15:01, Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
> This changes the "mmc0@600800000" node name to "mmc@600800000" to be
> compliant with devicetree naming rules.
>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

Applied, but squashing this into the original commit, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> index c9a572863b88..55883290543b 100644
> --- a/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> @@ -50,7 +50,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/microchip,sparx5.h>
> -    sdhci0: mmc0@600800000 {
> +    sdhci0: mmc@600800000 {
>          compatible = "microchip,dw-sparx5-sdhci";
>          reg = <0x00800000 0x1000>;
>          pinctrl-0 = <&emmc_pins>;
> --
> 2.27.0
