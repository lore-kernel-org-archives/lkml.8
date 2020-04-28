Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5630BC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EB7206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 04:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufQlri23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgD1EQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgD1EQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 00:16:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ABDC03C1AC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:16:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c21so7018042plz.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 21:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zcgS21itL78D0fddZORH8FPW/WTSqwnt4JvHvdMFx7M=;
        b=ufQlri23Hn5ru/QSTcDsigIaefd5C8Jo5G5DkNvJRr4nSLBva7mhaxr6KHKCH3qeTx
         /Bc79XJKqxu+ihH4ya/wTgZdOnZywUMQ1JP7qtjss5SWsvyAH7Su9xWwd49NLWmbd4hS
         5qxZMnb5z7V+twQp5imipUmU2MwThi/RgGG4LLd33jcXNPiI3vy1tgAjd6etrFwyYWwF
         P/AKKwj6SjqwCUMWQctIla27pnCn3KxHWUkk7i8YF/UbPyEBHrHtiKng33yKzHJuHywy
         nb3BfPt+Z520YNe/axeSo8pf1paBOXEafEZqqdtGssUlVesX3uOgJ+u4mn66VmcGpgHA
         pJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zcgS21itL78D0fddZORH8FPW/WTSqwnt4JvHvdMFx7M=;
        b=mdH8qk7zfEYNfXMS7gUWJgpdzQRFnW55Aub1KTtG4/nD4ymaiYYR+51sFPv29Vcsl0
         qjgw7nG1hBm43/dgSnWY0cOxn0x3aZjEdgwc9WcIA9TRD2CWhSYXS3g5WkkP1L7tUE89
         /MekYy94oNdDQccap8hecYgwBJN/eJCfQw6xlmCTMXblM+wqbCeTwSf2z+t6PGAauwPF
         UYHB9+zRZ7V8BjE//7VEBFgsWeBo9xyapT6g0c64mqRMoKEaKNsYJeRTqXYtuxY3UsDb
         oyqEEaNqGrO9+TZ+T0tkNq25tQuA3VWv3gDjRhch3G1RdP00HhC5rOct6Bc2rKk/w3zE
         yerw==
X-Gm-Message-State: AGi0Pub4DIwtSm1mSoHEPyLtf13HuSrq+7gFMBPq38YUj80J4bMtAt85
        rkSqMCNyYwq6ce6FzW5CO/ZxWQ==
X-Google-Smtp-Source: APiQypLHi61r4xiv8wVJwGtp90je7+VC7t1lXTr4tVyxSHVN84FrrQP9s5jjTw2j/zSh39NDp6sR0A==
X-Received: by 2002:a17:90a:690b:: with SMTP id r11mr2630271pjj.119.1588047401459;
        Mon, 27 Apr 2020 21:16:41 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id f30sm752667pje.29.2020.04.27.21.16.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 21:16:40 -0700 (PDT)
Date:   Tue, 28 Apr 2020 09:46:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Peng Fan <peng.fan@nxp.com>, kernelci@groups.io,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: next/master bisection: baseline.dmesg.alert on imx8mn-ddr4-evk
Message-ID: <20200428041636.loakok7yfqg3hcsl@vireshk-i7>
References: <5ea44ff8.1c69fb81.f246c.d02d@mx.google.com>
 <8af4842d-d576-fd6f-ac6b-2ef3482742b7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8af4842d-d576-fd6f-ac6b-2ef3482742b7@collabora.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-04-20, 14:00, Guillaume Tucker wrote:
> Please see the bisection report below about a boot failure.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.

@Peng: I have dropped your patch now, please resend it once you have
fixed the issue.

-- 
viresh
