Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026DAC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6644207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597863759;
	bh=Bes5gAE/OeXnjsxIVe+19tzrqDrPF4k1abhGj2/onYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QTci2055Esly1uZezPbFIcmOJhxRvUWv0dGvlD4GHMBMphwAyd4aYilYs8anChWaL
	 7QW8oBpdh8wU5cicpaAmNnBLTMuCFthC4+RCh6rsVUWFclPFAH/S+4TukLkAxT0qvg
	 dy2V2xgF8JEXaEoUJlCwNK319OCM9zqkh93FZViY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHSTCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:02:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41869 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHSTCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:02:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id w17so18977167edt.8;
        Wed, 19 Aug 2020 12:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KGGY3D3pTn+rblImU0N+zXuHhPpD8sOvtylyTgiCNHk=;
        b=PbK9O80lRR/mJDXsZ9dYM2y7fKDyN8PbdYcwAN1nDP7rU1mwPIVvNmjAB7rOBVcgsa
         Ym/jDBZ32Zkgx85pMFO3T7O8otdZuOPhgGs/Ghw5GzIvbpHp8OsahdN5E31LYLxCUaIW
         bXRq565C3KuxoOyQA50SylW1JGQ5G6vztyqky8I4b4YitZHIGW2zN6Yk+4WNfqiC9MBE
         ehNfLRXJP95BEhFmdy4fG5/YmL8j7xn4i3HysmYSixc/Fl93LWZ7A93EmID9fQu5YDzY
         LhdsyG+RSOMu+VBxUEAnD+6Vxr61F8z8WBHPZ/CDlr8hXL0cnYyMJc0OSABDwS8qTELI
         1UEw==
X-Gm-Message-State: AOAM532BGW4wrq975DgpRHpqvl8n6p6Jw7ClFMx5bvJv4Fsi2YXPq34M
        oj6PyaknhRg+Kn6T94XAf6E=
X-Google-Smtp-Source: ABdhPJykIMcrjaRlsdKqIfVe6NXArnUjcmqPPS3YQOJSQ7mlY5sLLKuYBtT6RLqjt3fPz4B0GXb52Q==
X-Received: by 2002:a05:6402:1504:: with SMTP id f4mr26630154edw.163.1597863755505;
        Wed, 19 Aug 2020 12:02:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id t18sm19193122ejf.38.2020.08.19.12.02.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Aug 2020 12:02:34 -0700 (PDT)
Date:   Wed, 19 Aug 2020 21:02:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 01/41] ARM: s3c: Remove unneeded machine header
 includes
Message-ID: <20200819190232.GA18183@kozik-lap>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-1-krzk@kernel.org>
 <159783932455.55025.7979458249415199743.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159783932455.55025.7979458249415199743.b4-ty@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 01:15:29PM +0100, Mark Brown wrote:
> On Thu, 6 Aug 2020 20:20:18 +0200, Krzysztof Kozlowski wrote:
> > Not all units use the contents of mach/hardware.h and
> > mach/dma.h.  Remove these includes when not needed.
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!
> 
> [1/5] ASoC: samsung: h1940: turn into platform driver
>       commit: 2c5c4fdc710c5d3beff78ac5605c5732ebfa8ae5
> [2/5] ASoC: samsung: neo1973: turn into platform driver
>       commit: a65e8a320846b8c69f53a758dc3662e4b42e6a48
> [3/5] ASoC: samsung: rx1950: turn into platform driver
>       commit: a0f3315a2558e22e75873e1184d0c213c2f8315f
> [4/5] ASoC: samsung: s3c2412-i2s: avoid hardcoded S3C2410_PA_IIS
>       commit: 2f1525848844c996990aafd3104bddf0f0cb3a28
> [5/5] ARM: s3c24xx: move iis pinctrl config into boards
>       (no commit info)

Thanks Mark.  Could you provide me with a tag/branch with these to pull
into samsung-soc?

Best regards,
Krzysztof

