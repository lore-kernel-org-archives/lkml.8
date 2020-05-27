Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C76C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BC620663
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590601559;
	bh=T1GjXLv+EZSRvqkwtSa3V7THEgYBBgtapp6alY6WhbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B7i4LPIOMczVO3lYCz7qxHROejoDj7u0mP/aC/zaAaKCcCWtZyozZI8FaaMw0ZFRP
	 jtTKKL6768BKQW0hlRvqFZVKGO5zXEWxMCDrebGiT/LE/Ua1PleInfglB3a70Hl/TX
	 qQtNj9n9dE71IDqDdzfCuflSyyv7omhoyICfefW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbgE0Rp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:45:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41494 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE0Rp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:45:57 -0400
Received: by mail-io1-f65.google.com with SMTP id o5so26967312iow.8;
        Wed, 27 May 2020 10:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sVTzITm9fKAAnCNSpjrfLe6Kk44w4LPZfPBZk2o/PmQ=;
        b=ElUhGVxiX2bqxCve/pSwIFA7UJJ1sR6VhTSaK+Q5gAfgyOah9cmHSUzynuDe9TdXaJ
         PCiHTKf6yyYi5L1UFQohayDVuh1CL354FU+my3KzBC9Rw82FFCh/Fv2a2VTAWBXwSr9+
         rMZb5kvH/RGq25Ymqs1U6UyNtHgjfxAQD99in99WnfWxqAguEuLchJde/KSAprRJI8bV
         1YoeyTVIRJ50oNUK9lHh/x62+nyp/rzbXRZcFNzgZE7W3MdcdCRMeSnfqYcMottdmRqD
         xWkpbUy7g6X+tCMyLoDCN2gSMm7JLb3v6xjoTDmxYPkUvp/oeCsvyqBOJIA6yv4iDwfX
         L76A==
X-Gm-Message-State: AOAM531Af0S0SEhBKq0DqI7FDzI94mbNDgZvMXHFNsBV8T8CYCtW+++3
        SpgYStiiaMcMYVFLNU7eMQ==
X-Google-Smtp-Source: ABdhPJzl5kwE2ktzrUqu8Vcb6SwnSrl21RCWKfYWJ4UxBbo1qDaM4Lp/9DCoplWj9snJ3bGnwpTKKw==
X-Received: by 2002:a02:c88e:: with SMTP id m14mr6768762jao.5.1590601557242;
        Wed, 27 May 2020 10:45:57 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x13sm1854475ilq.48.2020.05.27.10.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 10:45:56 -0700 (PDT)
Received: (nullmailer pid 2438193 invoked by uid 1000);
        Wed, 27 May 2020 17:45:55 -0000
Date:   Wed, 27 May 2020 11:45:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        patches@opensource.cirrus.com, mturquette@baylibre.com,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, linux@roeck-us.net,
        broonie@kernel.org, jdelvare@suse.com, robh+dt@kernel.org
Subject: Re: [PATCH 2/5] ASoC: lochnagar: Move binding over to dtschema
Message-ID: <20200527174555.GA2437570@bogus>
References: <20200512152359.11839-1-ckeepax@opensource.cirrus.com>
 <20200512152359.11839-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512152359.11839-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 16:23:55 +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v2.
> 
> Thanks,
> Charles
> 
>  .../devicetree/bindings/sound/cirrus,lochnagar.txt | 39 ----------------
>  .../bindings/sound/cirrus,lochnagar.yaml           | 52 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 39 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
> 

Applied, thanks!
