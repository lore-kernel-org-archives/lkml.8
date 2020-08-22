Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA33BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DE9207DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598099863;
	bh=y+uYYhtLEOfbvNnfBiysXjxm+oiH9s3TiclB+UrIng8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zH07fnWUCEPatrXSSEMHhcp2s4CzkTqZqOJ5SKQhCqyGczTeY6Un7VoqFTF3lnecY
	 rAkKAPY9ARbUX3l3eupt9xOtVLM+ruS5uDsNkpxPG6Lur6egFmO/06TDguSYK+OFoM
	 dPH2g2O1S98Gqu+DCRVv7+hOFQgnSfQtYOmhvIqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHVMhm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 08:37:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42647 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbgHVMhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:37:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id d16so4301104wrq.9;
        Sat, 22 Aug 2020 05:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Zsjdj30vPVAczb2I1jVNJYKyxUg3Yx5VcTWg2Jlo+tA=;
        b=Vx1LklBS0TeKPVb267O/2XxB2ZDPeeLVibAs0k1/aA4XcXzHmNQqoJCkL3DnAnG8k3
         EpZLz3zBza0/XZXJDitpXxchLetSgXGPslql55HwTL7lS615X/jKcxZ/sk+SVE27ZFh6
         fnDwRUnr4nDzX9053buvrEpWfE8NiZNV8Co5om/Vs/VY3JZoCHbd4Ze4pTl/0D76Yth1
         g3Y4sSfh0aCjGK10zzGH1HI0T69smWMGwvHQmw1IoKM5hZY2vwU6ObgzJrKDuIlW24/j
         mcUDPDiM51lkEUw37qtGakblQZCwI0rp1N8+jV8NvEchCo3qOqb9qlNOQ8asBXu1s1ms
         EA1Q==
X-Gm-Message-State: AOAM533093hfpnHcq8+t6hPmpLlk7WnYvzCZ1IxgfICiyHq4sCyUZGX9
        FnggEP49863N7ECre+pmTLs=
X-Google-Smtp-Source: ABdhPJwo5o2OAD47RHyw+Dj9k7IKZPp5XYf8G1qZV84pX0QS5b6avXYEWnIUugbLv5moZpspzH1B8A==
X-Received: by 2002:adf:fc52:: with SMTP id e18mr2269869wrs.185.1598099858314;
        Sat, 22 Aug 2020 05:37:38 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id g70sm13284254wmg.24.2020.08.22.05.37.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 05:37:37 -0700 (PDT)
Date:   Sat, 22 Aug 2020 14:37:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 6/9] spi: spi-s3c64xx: Check return values
Message-ID: <20200822123735.GE20423@kozik-lap>
References: <20200821161401.11307-1-l.stelmach@samsung.com>
 <CGME20200821161407eucas1p116af63a668bdbb75fa974589e5f6139f@eucas1p1.samsung.com>
 <20200821161401.11307-7-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821161401.11307-7-l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 06:13:58PM +0200, Łukasz Stelmach wrote:
> Check return values in prepare_dma() and s3c64xx_spi_config() and
> propagate errors upwards.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  drivers/spi/spi-s3c64xx.c | 47 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 8 deletions(-)

This should be a third patch - backportable fixes should go at
beginning.

Fixes: 788437273fa8 ("spi: s3c64xx: move to generic dmaengine API")
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
