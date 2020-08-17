Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F69C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E8C2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690273;
	bh=okS449SiMJwhh6wi/76ByFQ04nynJXjMuYg/drWDrzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=agKqVm2+2O6oxJgyEI1OZA514FWjqbPH8l0mCUX1ufpMJ2AjRNa7KV3rrQ2EK6yOC
	 nmpePq3FDwj3KXtLUNHIY9e1+GqProjHdvc4WZCxKkr3c9pNdZUbKH0XXGkAGEqcJE
	 HIx7GxoKHscj+5WlzZX7hnP72Mw+h2SSebMi+HPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403925AbgHQSu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:50:58 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:42758 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbgHQPxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:53:16 -0400
Received: by mail-ej1-f65.google.com with SMTP id g19so18292388ejc.9;
        Mon, 17 Aug 2020 08:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vtt9zu3rKhz+aEK+qnCz92XQFKGN9MiYVulnhNcc6uc=;
        b=iNxev2U48j+e+L2L+O+F3IcRXtfg52cFOMJ2ItjWmlKEDNdiuz7Fo4ICIsveJTHomT
         v/a7I2pDlu4riySf07tc1BvCl+ulFsMO01KedwF0vq0fFBZ3LODtJD3e4t3AC80RZ5r9
         /PNv+Mm0hTUPgh4F4XdRtT5H1fnLwZQ06a69DkSL4jSyXYttqPKBsmSmVJrwmoAy0XKV
         5+OcKMA7I+c0rk9IRGsUQZrsfilLnTemce377EQ9QFTpQZLoQSeaxNwUOr4MTuO39Ogt
         mCg6rLzitKsmwqRopXg8IIKELoJQuEbXpiMlT/yAI1T45gsCVpANE+HUc6kGW98AHWwW
         m/kg==
X-Gm-Message-State: AOAM5300GZh81AGoQf9g1fo7K54WeSE9g2JxeWMECi905Dxkffzpj68N
        BYyQOFLaAqj1hYzsoonCUQI=
X-Google-Smtp-Source: ABdhPJwyKhWu7DD4MWUN9q9tsLJuBm/9FV41CT+IeC5LSQzePyUu1SGYQjo0fVxodFmVcFMiWrd2NA==
X-Received: by 2002:a17:907:aaa:: with SMTP id bz10mr15533045ejc.304.1597679594754;
        Mon, 17 Aug 2020 08:53:14 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id y14sm14305273ejr.35.2020.08.17.08.53.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 08:53:14 -0700 (PDT)
Date:   Mon, 17 Aug 2020 17:53:12 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: s3c64xx: use simple i2c probe function
Message-ID: <20200817155312.GD15887@kozik-lap>
References: <20200809172243.15192-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200809172243.15192-1-steve@sk2.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 07:22:43PM +0200, Stephen Kitt wrote:
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
> 
> This avoids scanning the identifier tables during probes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
> Changes since v1:
>   - split into per-sub-architecture patches.
> 
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c | 5 ++---

Thanks, applied.

Best regards,
Krzysztof

