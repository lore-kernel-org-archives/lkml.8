Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4EEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5FB205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVMnQQa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgGVIsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGVIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:48:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF6C0619DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:48:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so822810pgg.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2XMC5RGtEC18Cma6Q9AvZTJswETLyWCWSSbAFrUkvG8=;
        b=BVMnQQa3AsjdzwWRQOHFI5LQ++bYgpCUjROcys7OBMRe+9r+1FcvqlwQDTgb4NFhbY
         MRFvZDwfrVJgYN4Q2hPpSSSDSG0Eq/QYX6YiG2/D2FnGckoA0qMc3e8M9UG6Y61WKUKq
         oHMnzSXe0KEzrMrbiKSyhpiBoTRjG4+5BTD6ez51HISjIMa9F97fnQbHfUqjmfIXJN2f
         Ewm8NE9AIlHQkxGFchJmt4LQz2Q7h/v28X1ViMZBeLO/a5BrnY7AHIzQ7tQyZQGJ9mLR
         zceUmSSqMeyPVe/F4/jx+HOqL1DhAOv44MF4Xz0DMXw+7cjKMesH2iPDHk2Z3XzbDcjX
         c7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2XMC5RGtEC18Cma6Q9AvZTJswETLyWCWSSbAFrUkvG8=;
        b=gv+zEYL4kYRGFZKnQlwiTq19IRiNwWhyV61jEhAbSZBTh5tPZ+n+CoIAVf3FYVNslT
         AFOtrK6TxD9psDg+uwUi3pLpEaSryEoiTwt2D61IIEU/o2szWK5LF2T8pVM+KlgtHGMM
         AkeZVFKqCj2HgkJPyF3oKXqgXSOlZud+BoVuzGRtTo7zowfFvTjBrJwmWn2pQVivC7po
         jIO8r0tdWyUeBo2yFSsoevQAXi46jmhwwjvCANz1oKvpixlxwjyTrAmKYgtWX7yQPcc9
         7cRkSYHlelLBLIfEqYFggn6UU8pj9el22ZriSNVdmrlNmDCwl6+L9J3aA9A9KJF+NAO8
         ZUBQ==
X-Gm-Message-State: AOAM532B1HG9JI9jytM3uXMu9AhpEqR83gSaknjcvmlMxq3yPcMpi3yb
        mg7U50yiCG9eaJx3coh5IRisz8fZT24=
X-Google-Smtp-Source: ABdhPJwMPmap/ES250fUE1ptpDsvTaS8Iq14/4w4/3pyscBrTGIq/rpygg8y8AD2584YTpWphLIIOg==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr29116824pff.132.1595407694228;
        Wed, 22 Jul 2020 01:48:14 -0700 (PDT)
Received: from localhost ([182.77.116.224])
        by smtp.gmail.com with ESMTPSA id c71sm6250020pje.32.2020.07.22.01.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jul 2020 01:48:13 -0700 (PDT)
Date:   Wed, 22 Jul 2020 14:18:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4.19 123/133] thermal/drivers/cpufreq_cooling: Fix wrong
 frequency converted from power
Message-ID: <20200722084810.sigwmd5beiu5gfw7@vireshk-mac-ubuntu>
References: <20200720152803.732195882@linuxfoundation.org>
 <20200720152809.664822211@linuxfoundation.org>
 <20200721114344.GC17778@duo.ucw.cz>
 <20200722053453.xmfcezyiabz2e2dd@vireshk-mac-ubuntu>
 <20200722074317.GA11366@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722074317.GA11366@amd>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 09:43, Pavel Machek wrote:
> OTOH the changelog is extremely confusing, because code would not work
> on the table presented there as an example.

Yeah, maybe I should have updated it too, just missed it completely :(

-- 
viresh
