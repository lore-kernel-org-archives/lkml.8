Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00DBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62002076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597842413;
	bh=CWItnTqRFN3yuH8ano/fBbVxEL5ubVpgqDWWwD/gv+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aKy6FXyMG26+xtKjYVVOUVuZo52tOYJBvL44McH0LNL75wTVTGFBgUzu3n29WuURY
	 TaZp3eKDKKa1F/rcpTisuKc5RZIEpf04F+IFfU6vAQBm0k1mCqzo0d/ppX98Sah3HU
	 GD4Ikpp+jER61DlTwbLUd6kSM341yrXicDmkdmGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgHSNGu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:06:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39955 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgHSNG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:06:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id a14so18043819edx.7;
        Wed, 19 Aug 2020 06:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CkoDptvaZZNmItnX5xuwQ9H/oO/axh2EK0TfitHqla4=;
        b=F35GqTTzex8JKyFEQg2EAtaeIHm9GLPislERqtmmyiWQhXbqw+u20x1oRrT2uwRbTV
         rxGZhyEQkfiA0S/QP21iYLfwPA7ccFlI6jiQYtfQtcqFMT5oU/vtgoYhd1zAlKlDgZud
         BZIyKM3x7WLBPEbOZzvxeCFb5SQCHwy1TwpZU1SLakhbAKu0wXE0pSBSwRbcZbM/Om0e
         DFd6l4lbMJLeRJIWjmkM/L2lVSxvD5BDtOBRI3/MUCHPTWsPRkGpi24KoNFmuj96+QoJ
         V11+I8yUzsf1A9VapSbDIK4/4z8qGIfkCSbsGZ3V6yUbQ2MStpWtIhOqJMz0K3NsX/0Z
         /atg==
X-Gm-Message-State: AOAM533Xa9Q21hhfVC4fUFdT4wIB90+w1PQBOFKhOWztgjVlDDsY3y8y
        eYIlXp7P/0doWnMK5X1VGlw=
X-Google-Smtp-Source: ABdhPJwwV0WcCmfVD+ifyEbNBaAywbSmIL4jqkHxU7ZQ9/DqvY9iD0ZSEWtUmwD+rCU4DKZ8XHcN9g==
X-Received: by 2002:a05:6402:1504:: with SMTP id f4mr25029186edw.163.1597842387461;
        Wed, 19 Aug 2020 06:06:27 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id dc12sm18833409ejb.124.2020.08.19.06.06.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 06:06:26 -0700 (PDT)
Date:   Wed, 19 Aug 2020 15:06:24 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Kukjin Kim <kgene@kernel.org>, Andi Shyti <andi@etezian.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 2/8] spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for
 Exynos3250
Message-ID: <20200819130624.GB18970@kozik-lap>
References: <20200819123914.GC18122@kozik-lap>
 <CGME20200819130122eucas1p27e9e84c4399d01409858de6d01e11b52@eucas1p2.samsung.com>
 <dleftjpn7m23j2.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <dleftjpn7m23j2.fsf%l.stelmach@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:01:21PM +0200, Lukasz Stelmach wrote:
> It was <2020-08-19 śro 14:39>, when Krzysztof Kozlowski wrote:
> > On Wed, Aug 19, 2020 at 02:32:02PM +0200, Łukasz Stelmach wrote:
> >> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> >
> > Add a quirk - why?
> 
> Because stuff does not work without it and works with it and it is
> turned on for other SoCs which have simmilar SPI HW.
> 
> > There is here no commit msg, no explanation.
> 
> As I wrote in the cover letter, this and previous commits make things
> work on Exynos3250 (ARTIK5 precisely). I can't explain why. I read
> everything I could about this HW and there were no details about
> automatic CS handling other than how to turn it on and off.

At least this information would be useful. If vendor kernel also does
it, that's another argument to use, since there are no better ones...

Best regards,
Krzysztof
