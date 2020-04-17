Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F3C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82793208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dlO8RvCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgDQKZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728869AbgDQKZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:25:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53659C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:25:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so2397333wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7q6Jr729CYPyB+SZq18Uo5FBiWv9vtwUqdtC6T3/0KY=;
        b=dlO8RvCXvGGmr6yzDqAZ9YvBrhmjSkPSe8h0tKG5BmXImFbDltrIrkxQZ4TeZo04JI
         YMJ0uhz1Yq1d50kOOWywT4WR9uo6mWknaxmFiyJnV1LZ9I3AK1KsD3Dah2xtvmE/dgRC
         SK6RfTl50sxwT9QsPChaYauj1M1saCADdqXjl+8Lp/4lGZ8iZlKNtEjoIjEMvfYiFdP9
         cEj9kMTHWoQSbJCIox3TvJlfLA+advfZuM78uz2H8ippl6he89qd8rKlPKIgFmd55rO2
         WSi1LCTNtfNeE6mzhswYg9IfERLWleAwr2VeDwpeq0/Aefpa7zjJVnKgfO8AF43nn5+D
         V0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7q6Jr729CYPyB+SZq18Uo5FBiWv9vtwUqdtC6T3/0KY=;
        b=t4A6nKllHmeyaJiJwkWF+ig7MXt5AgT6alp7L64kdaF26m+NrcwiZZ4f4f0vxPlYp5
         +7tMTB3LDYOYv59Hu9KfKQoWmGkDAvfUFqH297gc06wCjhv1rXvHfUOtv+EA1uk5CrTj
         zd9HUdXdNicL1W5iZPWFwze+H0MYP8o8mH3UwqLui1YVqvYEyjjczlzfgNfmR9kM5Yq4
         eg4y8E/56emUg6gw4F3RPr1S5ZZhg8NqUqnV/kRKTXFwkf0T9j2+IpxCyGtjQru3fgm6
         w6wvgYlNSjrRy5715ytxwOEcCLJzgsz6ZUnA4ObHgHjWOUP+BvnGoCfl2sZ9/9UKbQ93
         BbDA==
X-Gm-Message-State: AGi0Pua4jNk7BrV83o+pZtO57+bU5zSFI2eVFVVDLL9gSoN3fjhp4Dls
        Ejpz3sCm438DBomBrGdn54YgiPVyMHQ=
X-Google-Smtp-Source: APiQypIesHKULrJQELVTc4QG4A4qrye3XjdCXJO3F/sfsVC3VlmxnFnm9C4pa+YIPQH5+uD+fQYmlQ==
X-Received: by 2002:adf:eccb:: with SMTP id s11mr2953592wro.138.1587119134099;
        Fri, 17 Apr 2020 03:25:34 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id 1sm7302840wmz.13.2020.04.17.03.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 03:25:33 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:26:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: intel-lpss: Update LPSS UART #2 PCI ID for
 Jasper Lake
Message-ID: <20200417102635.GC3737@dell>
References: <20200414095134.80135-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200414095134.80135-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020, Andy Shevchenko wrote:

> It appears that preliminary documentation has a typo in the ID list,
> i.e. LPSS UART #2 had been advertised wrongly.
> 
> Fix the driver according to the EDS v0.9.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
