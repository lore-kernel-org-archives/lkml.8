Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F30FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EE92204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uodq02pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404812AbgFYMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404650AbgFYMvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:51:03 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4125AC061573;
        Thu, 25 Jun 2020 05:51:03 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dg28so4105231edb.3;
        Thu, 25 Jun 2020 05:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N5xdqXN4pByK/c/El7s5XQxKysn8uxcESYqnb3B0SSY=;
        b=Uodq02pSyEHEYvOyoFDLOthozVoIQHursJM0fQdBYD7A4eHwU+ndxPxT8rP2gQ0wlo
         e+dgS4C0QPyRsYEKHtJkpvPo/P4qq8xEJxLJ2u29jgF6s+GqV1fgoL2ECkohg0B6cqKR
         Kz2SFuQGhsXHY/OVt3QUThr29mcPMz8Lni8C0bqQTykTo7FCAoMfyIvmy+A+dKatjjKz
         ehzw89CyPQ09/y+MYOfTSvce7xnIqg0OcyqZb7Pkv7z8mjivH2SYLR8UfspF/w1HH4Qj
         gZADIYqj1vd7gpxMulfxJ6wu+sMFl7/FJv3M4AX/n1SLpmqAQ5ENE2c4pIOnotYxOQE+
         reUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N5xdqXN4pByK/c/El7s5XQxKysn8uxcESYqnb3B0SSY=;
        b=WVQGhJEH+Udqy0L97je9m4xWOId4VwVDQZhpI2JOJXK3Gqvd8wv9i7oYb0RwcESjlr
         BQaCS4R5KW1B91oRco+5fgMyZg8M7lho6Qe2wAEM/SVgI+t8UhxtKEz5Pmiiyo+Gki39
         RkdDN4GRuV5KKrPISowPNApU1s+W9CGDrbRpdvbqtiok28V/ahKogeD0uWwtyAPgzy30
         Z4TTF4NuIpGYCd9Zp1Pqm/Y3FXB/9LE3HwlxhCZjmJ8EhUnJPJZxKXhoU0+1KaWgc+4S
         Vte7dAoh4HyG9z9nZIgYZ93c6krjBUGbgLJ0jBcP/zrQJQZNTQ1zvMaDiBQ32sp7hefe
         6HBA==
X-Gm-Message-State: AOAM532uWBHHZ9NL0WjohZWMFU1CbbSPe6gK2QG+d6j5brfBc5eNZF6R
        +rXEDMcepNd2pJZErwAEb8nqsO8hwOE=
X-Google-Smtp-Source: ABdhPJxoIqovY/xp+IsyFcU4cOHD+zDcH9zQZh4i6ihasUsCklQcG1D8sAfGZypJK0xdZafQEZ0N/A==
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr3260704edv.258.1593089461882;
        Thu, 25 Jun 2020 05:51:01 -0700 (PDT)
Received: from BV030612LT ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id v5sm17049224ejx.123.2020.06.25.05.51.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jun 2020 05:51:01 -0700 (PDT)
Date:   Thu, 25 Jun 2020 15:50:58 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: Add APB, DMAC, GPIO bindings
 for Actions S500 SoC
Message-ID: <20200625125058.GA7400@BV030612LT>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
 <1998440a1debe07f838899ccbb15c72518b6b94f.1592941257.git.cristian.ciocaltea@gmail.com>
 <159303816030.62212.1603754983340876289@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159303816030.62212.1603754983340876289@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:36:00PM -0700, Stephen Boyd wrote:
> Quoting Cristian Ciocaltea (2020-06-24 10:47:53)
> > diff --git a/include/dt-bindings/clock/actions,s500-cmu.h b/include/dt-bindings/clock/actions,s500-cmu.h
> > index 030981cd2d56..a391d1651257 100644
> > --- a/include/dt-bindings/clock/actions,s500-cmu.h
> > +++ b/include/dt-bindings/clock/actions,s500-cmu.h
> > @@ -33,45 +33,48 @@
> >  #define CLK_BISP               15
> >  #define CLK_VCE                        16
> >  #define CLK_VDE                        17
> > +#define CLK_APB                        18
> > +#define CLK_DMAC               19
> >  
> >  /* peripheral device clock */
> > -#define CLK_TIMER              18
> > -#define CLK_I2C0               19
> > -#define CLK_I2C1               20
> > -#define CLK_I2C2               21
> > -#define CLK_I2C3               22
> > -#define CLK_PWM0               23
> > -#define CLK_PWM1               24
> > -#define CLK_PWM2               25
> > -#define CLK_PWM3               26
> > -#define CLK_PWM4               27
> > -#define CLK_PWM5               28
> > -#define CLK_SD0                        29
> > -#define CLK_SD1                        30
> > -#define CLK_SD2                        31
> > -#define CLK_SENSOR0            32
> > -#define CLK_SENSOR1            33
> > -#define CLK_SPI0               34
> > -#define CLK_SPI1               35
> > -#define CLK_SPI2               36
> > -#define CLK_SPI3               37
> > -#define CLK_UART0              38
> > -#define CLK_UART1              39
> > -#define CLK_UART2              40
> > -#define CLK_UART3              41
> > -#define CLK_UART4              42
> > -#define CLK_UART5              43
> > -#define CLK_UART6              44
> > -#define CLK_DE1                        45
> > -#define CLK_DE2                        46
> > -#define CLK_I2SRX              47
> > -#define CLK_I2STX              48
> > -#define CLK_HDMI_AUDIO         49
> > -#define CLK_HDMI               50
> > -#define CLK_SPDIF              51
> > -#define CLK_NAND               52
> > -#define CLK_ECC                        53
> > -#define CLK_RMII_REF           54
> 
> This number can't change. Just add new defines after and update the
> CLK_NR_CLKS define.

Thanks for pointing this out, I wasn't aware of this restriction.

I will add CLK_GPIO immediately after CLK_RMII_REF, since it is part
of the same peripheral device clock group, then I continue with CLK_APB
and CLK_DMAC, documenting that they belong to the system clock group
above.

> 
> > +#define CLK_GPIO               20
> > +#define CLK_TIMER              21
> > +#define CLK_I2C0               22
> > +#define CLK_I2C1               23
> > +#define CLK_I2C2               24
> > +#define CLK_I2C3               25
> > +#define CLK_PWM0               26
> > +#define CLK_PWM1               27
> > +#define CLK_PWM2               28
> > +#define CLK_PWM3               29
> > +#define CLK_PWM4               30
> > +#define CLK_PWM5               31
> > +#define CLK_SD0                        32
> > +#define CLK_SD1                        33
> > +#define CLK_SD2                        34
> > +#define CLK_SENSOR0            35
> > +#define CLK_SENSOR1            36
> > +#define CLK_SPI0               37
> > +#define CLK_SPI1               38
> > +#define CLK_SPI2               39
> > +#define CLK_SPI3               40
> > +#define CLK_UART0              41
> > +#define CLK_UART1              42
> > +#define CLK_UART2              43
> > +#define CLK_UART3              44
> > +#define CLK_UART4              45
> > +#define CLK_UART5              46
> > +#define CLK_UART6              47
> > +#define CLK_DE1                        48
> > +#define CLK_DE2                        49
> > +#define CLK_I2SRX              50
> > +#define CLK_I2STX              51
> > +#define CLK_HDMI_AUDIO         52
> > +#define CLK_HDMI               53
> > +#define CLK_SPDIF              54
> > +#define CLK_NAND               55
> > +#define CLK_ECC                        56
> > +#define CLK_RMII_REF           57
