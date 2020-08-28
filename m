Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E6C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB7F208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598596399;
	bh=JvylaWXieNyCtyy2+VFl58I1E2W4uhRggj+BhV6CIik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ax3BYZJNHQvPvPErj/BHveu9X889Y3ZHjSB9AGJBQfrLy3yvrh8OydtLSxTZjnaur
	 Upe0uHiBYa9G8hz5HaxZwI7JEuKS3YeNAm86q79dhx1vqagSmYdJrH7JPHwc1FbaP9
	 UVr8AxpkqKDbJkQAMk11LoSvPgMK8+drMyoIk8r4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgH1GdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:33:18 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46088 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgH1GdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:33:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id n26so136118edv.13;
        Thu, 27 Aug 2020 23:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vg8m3jBI5UQMBYtnHdDz9S/St5JXY8tMZCUrYUxpYto=;
        b=nFJZqnbfhKIGFEIO/xZQpv7ptbwXgtE0+NBRQbSZEV1JVzVuK2mnLzZYL2FajIXI0e
         7Hj3q9HPP520smkwtHYOfDWjzpbpF1M4jcijccQZFMtc2ihStlwf8cU8i7VnPdXPKH50
         2l/7jalD1Bq6F7UkZWKg0zJg8yZ+EIK6V+PzbHLHZpJ6EI+GEYcbR2QNCtf08ZQa/UAq
         /x3aCg6EzHV2B5gAtYeL06LsB3+kKeq2lVfRtsfReg8VtMTt7OtTX7n9GjxY3R0E+4jo
         WDcln2emM3k93F3KRSwef7PqIDt5GoV4RTW6bIhMzqrPj92bx/rYZZ62krWfAHBsx0I9
         oghQ==
X-Gm-Message-State: AOAM531CoEeqQcKfHke4xFkwokfwAJ/x/g846Wqp1LpRaWKvkdkucsLk
        Die1ouIJbGNrqAL0OhKAq5Q=
X-Google-Smtp-Source: ABdhPJy72Nl+2Lap2N1ZzNKi4Z5VFds07gmbJkTgUrzJZRXQuDvPeF8JuAeTTbqIJcF0iZyklYXHNw==
X-Received: by 2002:aa7:d284:: with SMTP id w4mr375850edq.258.1598596394321;
        Thu, 27 Aug 2020 23:33:14 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id v10sm134917eda.87.2020.08.27.23.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 23:33:13 -0700 (PDT)
Date:   Fri, 28 Aug 2020 08:33:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/3] clk: samsung: exynos5420/5250: Add IDs to the CPU
 parent clk definitions
Message-ID: <20200828063311.GB17406@pi3>
References: <20200826171529.23618-1-s.nawrocki@samsung.com>
 <CGME20200826171552eucas1p28ace6b1efbcdab420aaa4458ac8bad08@eucas1p2.samsung.com>
 <20200826171529.23618-2-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826171529.23618-2-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 07:15:28PM +0200, Sylwester Nawrocki wrote:
> Use non-zero clock IDs in definitions of the CPU parent clocks
> for exynos5420, exynos5250 SoCs. This will allow us to reference
> the parent clocks directly in the driver by cached struct clk_hw
> pointers, rather than doing clk lookup by name.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5250.c |  4 ++--
>  drivers/clk/samsung/clk-exynos5420.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
