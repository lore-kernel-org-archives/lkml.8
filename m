Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37348C433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1773C2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595599890;
	bh=muurSGsYrfMRYrmqraS6Y24L4SfgT9dcARUV8IGr9I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m/LQA3hIImOSqp6ntSa0P78jrLDLh0r1rjhuskNrirS8dhddUEcDSdu8SLKUO1ES5
	 EiVtZ1LHdIqP6X51ObMFe+FIAa3cbsWyl2JrtBqtrGiD4HP2hiyn8suC1WPoZZQ2Gf
	 y5WrPfurX5Er00jbv6KHuc2DKOC2Z4EvbX8IwAF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGXOL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:11:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42043 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:11:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so5489416wrx.9;
        Fri, 24 Jul 2020 07:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2RbvOcNTBCcTHmXNREDJs12mgijnjhzxCtnjRZr8ol8=;
        b=SNdkCVhoJct/6HaSAmYOVPPIMJMwO4ep8ukISDsQDWNQTVxvurXYqZ6j2xLuK5WtKo
         lwBpokG619hUTaGfrw3KRCoIayPAtLTZkgD7ocnV0RAlNX0By6bg8CJnrEceYQX9TubI
         IroOht7820mCWa6oXYxp8tziy2DRWTP26bDtxqzNfyf9/ispk8aA+DzeHCCOx3VUMEQ7
         bN/gjruBBiAbrLisvXQwPqBelHSUup7WUFp26Ixx7U1VT7pgJn5iGS1+TJwrezDxCQ3R
         YwqPw2/5RaozQ3Aeo9jxX/i1ugPvkFQP9Y2tGd0NNdAq9bCYdRZppIyslZTuvk5pdtyX
         AWYw==
X-Gm-Message-State: AOAM530rnpfF9v4R2YINyo4pkgQx5KBzd1Je8XvXo/gXMOZoOssmxeoI
        LzW0ohcM1p1CgcLXVr6Gnoc=
X-Google-Smtp-Source: ABdhPJxuanK99JgtCFD/kyLYhj1m3VPN7GVyIvcjAjLoBgeFmxoxxrCiq+S0zBIRvkmJH9aZHm/a1w==
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr8593283wrw.70.1595599886067;
        Fri, 24 Jul 2020 07:11:26 -0700 (PDT)
Received: from kozik-lap ([194.230.155.213])
        by smtp.googlemail.com with ESMTPSA id p8sm1592476wrq.9.2020.07.24.07.11.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 07:11:25 -0700 (PDT)
Date:   Fri, 24 Jul 2020 16:11:21 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kukjin Kim <kgene@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 14/29] memory: emif: Silence platform_get_irq() error
 in driver
Message-ID: <20200724141121.GF14851@kozik-lap>
References: <20200724074038.5597-1-krzk@kernel.org>
 <20200724074038.5597-15-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200724074038.5597-15-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 09:40:23AM +0200, Krzysztof Kozlowski wrote:
> The platform_get_irq() already prints error message so there is no need
> to do it again in the driver.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/emif.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Applied (and part of pull request to arm-soc).

Best regards,
Krzysztof
