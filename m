Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D05720657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594844846;
	bh=1XriL811AeVvdrQBcfpHdqhiUnKrJIY5s1lHezFVnoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bfDWbPjdCjF4lB418XiH10K53QyETxKtkvp2g+gafTlV/KAgbE3yT8gzgzM8pKe15
	 DlJgYUuglI4Rb1dQ/FsSg6VUkFrOoSK+0kAJIKcPEL4Qf1OIaELZ5y93rSmLSob8Ar
	 xHAYoaCT4qwx+waWMQX+xaEPdvluaRCvoMigNyKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGOU1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:27:25 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38816 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgGOU1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:27:24 -0400
Received: by mail-il1-f196.google.com with SMTP id s21so3154131ilk.5;
        Wed, 15 Jul 2020 13:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hp5HmzJiHOmmnapmKHc4+WA+MfvOrYT+drbJbUm7gKg=;
        b=UvWVrXvG5O1ipP0/BuhJSeUTg2w4NuvDm5/CRk/3oPyGdD6kZlv+dUwY6NqyTx0Hmo
         aG27HDF4gDLI1MFbZsEoURGvTUdDOGiVPwM85HsZb5rUHPJir6ceIWSToVAHnq+JSo80
         G+4b+4eIpuiUxMpKmMQIwE3nnoxMKna4h8YyAwcAHN7Q/A/223+Z0xOtdMPGkPLxN+EJ
         o/Epsj8Emw/NK+Y5JKn0gmLZqsH0afDGxkqkyPlyPtsOvSHJcA5F6T8f8F1px4/Gl1wE
         FMU94I1fBZoNxsj5lm0I2z7FwKVwVD1aZm4Hk6CB66haopqcoa4JSmc9jptrtlsbtNQQ
         D3RA==
X-Gm-Message-State: AOAM533MDQNGOj2VfwLNbR8bAyys7kPWpTvfiKA/dpuzrKIjGZLP7PN6
        /9LXkWQw67Hz/cJi/TndItyJalotdg==
X-Google-Smtp-Source: ABdhPJxXvFJvhAfWEuKEbOGO1wNXti8nZgtJ+L13uNRdVTDvDYHxTrzya0aAkmOv1Hxo8Ie4S8fOww==
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr1283656ilj.9.1594844843463;
        Wed, 15 Jul 2020 13:27:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c16sm1563716ilh.54.2020.07.15.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:27:23 -0700 (PDT)
Received: (nullmailer pid 762998 invoked by uid 1000);
        Wed, 15 Jul 2020 20:27:22 -0000
Date:   Wed, 15 Jul 2020 14:27:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: samsung: Do not require clkout on
 Exynos5260 and Exynos7
Message-ID: <20200715202722.GA762968@bogus>
References: <20200629203859.17298-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629203859.17298-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 22:38:59 +0200, Krzysztof Kozlowski wrote:
> The PMU (Power Management Unit) driver is a clkout clock provider (for
> clock signal monitoring) only for certain Exynos SoCs.  It was never
> implemented for Exynos5260 and Exynos7.  This fixes dtschema validator
> warnings like:
> 
>     system-controller@105c0000: '#clock-cells' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/samsung/pmu.yaml  | 22 ++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
