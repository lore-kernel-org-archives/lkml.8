Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24BAC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77FDA207EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599209956;
	bh=/nrikZXWmGqWATpPaqK5tSj+3s+E2skRZx06vI2GbEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HNSdA9gEyEA395Jq/ID7P0k2fucckDt61ZlZwuuRXPg8bowj7tbHxwTbr1ZbYg9im
	 pr0/k6itpsNy9LNy4W+oUgZtSVGgNodQ0jct0HYtI6jnfkjt744cWd4bIiZ4ucZzBK
	 XyA57HoD4jeC/DsMzWGCgmKT9isKqjcgpQNoSxnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgIDI7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:59:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39533 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgIDI7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:59:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id a17so5923472wrn.6;
        Fri, 04 Sep 2020 01:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H126aw9EZKOdIS9GqBp/bNQWMbMK1Mr9xym+R9dtw40=;
        b=oVcxCRXqXPErXrfuBAiv1ZPo+s3jc/j9BCNUJ0O9lOc2xiSkbsqYohctl6iuIcza+n
         NpmpdYuTXVZOsoWCA3Vpa19klmCkwgsIlLjIn0SVi5w8RpHZGSOglD1eLOFeabfhNQtr
         wSQlZ2ervUsJdkt5TeH4wRAfSEdtJVCIQwKY2opmzWTVyWZ3w+2c3k/S3jsSoF1QWyVD
         Tb0omyZaKdRukEBCqYhkV1XdZK9s/QUK1lg5elZMNMBYdPSjJf/4k7QVtvokAzr4b92n
         QLQzsX/np351p3h5WKWedk56ShF5Oit2bIICWFyu+Ag07d5vjBeLEpaegwkXIMuYsGCp
         yQEw==
X-Gm-Message-State: AOAM532U2IljIik1g1STlKLPaLTru4Yv/HQxeg8v0N9Q3SAIXqeXgqjw
        Dmn0YrogpAuCBUYIZuppVSg=
X-Google-Smtp-Source: ABdhPJxzDt66wdKoFnKqYxwCcJ4DAJAvVkoRoLSK5EHTDsvXAoUV3GGc4kgE8bbwME+xepZV/EzipA==
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr6641944wrn.228.1599209944329;
        Fri, 04 Sep 2020 01:59:04 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id v2sm10764750wrn.44.2020.09.04.01.59.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Sep 2020 01:59:03 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:59:01 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 13/13] ARM: dts: exynos: Use S2MPS11 clock in S3C RTC in
 SMDK5420
Message-ID: <20200904085901.GA30093@kozik-lap>
References: <20200901075417.22481-1-krzk@kernel.org>
 <20200901075417.22481-14-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901075417.22481-14-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 09:54:17AM +0200, Krzysztof Kozlowski wrote:
> Use the 32 kHz clock from S2MPS11 PMIC in the S3C RTC node. Except
> making the S3C RTC working, this also fixes dtbs_check warnings:
> 
>   arch/arm/boot/dts/exynos5420-smdk5420.dt.yaml: rtc@101e0000: clocks: [[2, 317]] is too short
>   arch/arm/boot/dts/exynos5420-smdk5420.dt.yaml: rtc@101e0000: clock-names: ['rtc'] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos5420-smdk5420.dts | 3 +++

Applied.

Best regards,
Krzysztof

