Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDF9C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280DB20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qRt7DBLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgBTNhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:37:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38078 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgBTNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:37:17 -0500
Received: by mail-wm1-f67.google.com with SMTP id a9so2077235wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 05:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=B4PLo7ULnoL8yyxNbBuvmhizTKdxVbJiDyyciEc36Lc=;
        b=qRt7DBLZBTVQjM1tmi4ELDLZ8ufVlBTbCqFqtzgJ9BHN030AEdAoh3uAIzOzj+XaUd
         qGcHTGaeJ7u4Pl392ptxOLZvSLUN/rNczq8f87EnApfyE1oEpsNf6NjIsXHqF5fGolJt
         QkIOU219N8LG8XCiKD7oZMb9rtkxOVG3H8u73O9Su5KwaQHYtYxU+uwx5d1PfHUk9kc5
         dy02FIlFosCGGi/uUmJmptrHNTYXjJqRw/xpzmM/yU0dNMmX7r9ys4t1FYLo2qQGTxo7
         lvREku+RWOMk7LtwEikUgSNvEUKxKzpKZdJ6jhDJXqKFqIdOkdeDSou4B6vHcWhVnOf8
         9tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=B4PLo7ULnoL8yyxNbBuvmhizTKdxVbJiDyyciEc36Lc=;
        b=rNSOi7hTAImM3+phoDgAPeCG2g2QmoTihe35kZYocUS+ij+2xy0RWxRrGzuYOeoZ/X
         f/zQCOpwf+Rzg7ewJOYZ7+ydzsw5c/OS6hhiOgwujg3kxX6vhC6yGxu+5myIZwXywre5
         btKZZ1ZUyAsRpI+5GF3s/cjbouaePU7BM6Ly4f7/ZPE5fZOjf1H0ZByHgmLocPHHxuvl
         E0n1xWxaTjLQ7tPejw28TArIQGwCncH1a6TuNrLC3E8m8yz2fopKt5wvtlomjwVsT2W9
         0/IfS+XTitVVL1mC8CKdViaKjCVNn7eQyt4hd049DwhYBP0grZs8JiR0tF6P1O5148Dz
         B3qg==
X-Gm-Message-State: APjAAAUFDgBrn0OQspo1eHvM4tyFajcemWUGArw538cAmsMIEn70ay+D
        WSfnMjN/6aOAAdCDkcJ3y8d2/g==
X-Google-Smtp-Source: APXvYqxeEECe1zPsmH3M53hHGcqRTpW593ckp3/6EuRcU0KckGtsaWYA5KUQiu8gYOO5hhf+lwdcPg==
X-Received: by 2002:a05:600c:2c44:: with SMTP id r4mr4567137wmg.140.1582205833995;
        Thu, 20 Feb 2020 05:37:13 -0800 (PST)
Received: from dell (89-145-231-170.xdsl.murphx.net. [89.145.231.170])
        by smtp.gmail.com with ESMTPSA id u14sm4551648wrm.51.2020.02.20.05.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 05:37:13 -0800 (PST)
Date:   Thu, 20 Feb 2020 13:37:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, tglx@linutronix.de,
        fabrice.gasnier@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mfd: stm32: Add defines to be used for clkevent
 purpose
Message-ID: <20200220133739.GG3494@dell>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-3-benjamin.gaignard@st.com>
 <e9f7eaac-5b61-1662-2ae1-924d126e6a97@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9f7eaac-5b61-1662-2ae1-924d126e6a97@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020, Daniel Lezcano wrote:

> 
> Hi Lee,
> 
> On 17/02/2020 14:45, Benjamin Gaignard wrote:
> > Add defines to be able to enable/clear irq and configure one shot mode.
> > 
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Are you fine if I pick this patch with the series?

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
