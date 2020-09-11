Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93BAC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953C22073E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599838624;
	bh=6keDr/55ouiXdkOuQjrwwrkDTDmO9FYqVGzhAp2EJok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XW6ZaL32sKEFlBLsMu2gWTBQ+WxajQwHqY3Ivki1C9MgEnA4cWz4/LInb+IlZ/r7F
	 oLTyczrTnDlM7L1Mw7zKAIBKm278V2cxvCqmlyGm9Q8Y6fUVo+6UJB88qpikLYoniF
	 5yEli8Ys+FEyWEkEKR1TQJfrCmZUrp92fqURF9aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIKPg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:36:59 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:34435 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIKPev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:34:51 -0400
Received: by mail-ej1-f65.google.com with SMTP id gr14so14415951ejb.1;
        Fri, 11 Sep 2020 08:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rv8Uq4Yh5DeMvinWPQeAnG3AGmpR0//uZ7bahTCq3MA=;
        b=fBCXLhQwqrOv0pQfJf1y+MYbej+W1b8afBKPcx+bN33I15Jh/Gd2qOk+/GZixNboSs
         +wVEG3Eh69m8uObPoxKqPrEhbNhjgjVDpDi9qJs38jCoBMt4V+bYIT+FnEUVN0XffPax
         W1AlwFSK393PL6XaP8SSAsszefrmJk2Mc3U9THxTiIBDPWLNDlqkJltgCFNN4P+4RyYa
         Yz7wfClH/SeqfTd5ACzbGI0zEm6utDWrXUREo6KHFOwtpna5TvBF7uPRomrLd1cIwEWd
         KqnMAmfkGugb3dsrdQfsxYxziW7NBWTDkCr1SKlG2fxGwG8XxS+dDO2q0s9Ywg52CW87
         wILw==
X-Gm-Message-State: AOAM530Aubek8yJuqH7N77Ne8TZ8gEkUlohpXXRPyqo78Uj+Z5cmu0XX
        Vc7On/xZBHUpAIlMnLfDkqM=
X-Google-Smtp-Source: ABdhPJwqMxehrWj5AIk6bwgWo/6J4nFSeUNA+neqTDckmCySfnip8jOFjrj8I8PS1NPWYbv5f2Tj9w==
X-Received: by 2002:a17:906:7d0d:: with SMTP id u13mr2745908ejo.448.1599838484902;
        Fri, 11 Sep 2020 08:34:44 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id 16sm1970663edx.72.2020.09.11.08.34.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 08:34:43 -0700 (PDT)
Date:   Fri, 11 Sep 2020 17:34:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 01/10] clk: at91: Drop unused at91sam9g45_pcr_layout
Message-ID: <20200911153441.GA18190@kozik-lap>
References: <20200902150348.14465-1-krzk@kernel.org>
 <20200902163558.GA4137028@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902163558.GA4137028@piout.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:35:58PM +0200, Alexandre Belloni wrote:
> On 02/09/2020 17:03:39+0200, Krzysztof Kozlowski wrote:
> > The at91sam9g45_pcr_layout is not used so drop it to fix build warning:
> > 
> >   drivers/clk/at91/at91sam9g45.c:49:36: warning:
> >     'at91sam9g45_pcr_layout' defined but not used [-Wunused-const-variable=]
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> > ---
> >  drivers/clk/at91/at91sam9g45.c | 7 -------
> >  1 file changed, 7 deletions(-)
> > 

Hi Stephen,

If the dev_err_probe() waits/skips/goes to /dev/null, then how about the
fixes in the series? This patch and few other?

Best regards,
Krzysztof

