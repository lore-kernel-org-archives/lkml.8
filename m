Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8947C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8890F20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAEpuhFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgBUQbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:31:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33808 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbgBUQbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:31:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id n10so2750983wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=muhYMYyNdDfvlVS1W6A8155VlvU9hOCKJJBq/3HzzrA=;
        b=jAEpuhFukQluRFnZBmBDPpd8pkpsKq77GTH0uIwz6fTDBOGl4egx2C6o8c1mkern2i
         1LcNwTbI9ErJ6JAo4APWRiPMSSQPpi5iEHsXR/RybQZXm7GP6YuMc7IxLmlDjN9MEYcc
         ca7TXvdwTumpfxwVcH2vWp0S+Mx/spd1/zwQvt0TKJ93iPrQcBI5uSQcPOLrOznCg5SM
         i0SLgzWybbOhrL1S3IrhsZqihlPSeruXaptKreyxhJzX4uVypkzScOTW3+DDwgzsO2/2
         8omL2bf9aNKq1ZbQekLEt0UlfK5C1y//jA2WXkPGsL6qUurjygkNDP6s51N2KQ4Q24c8
         DEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=muhYMYyNdDfvlVS1W6A8155VlvU9hOCKJJBq/3HzzrA=;
        b=eEUXZ+EHSj5gomJ2dMVFwOBP1JL833V21xmrOr6ETzTaN7a8wOTgqJ3jzsKrLPV00A
         2vs2yK9d1Zzpk4uuuOoCwDABkCUfc8E/gvBSB6qlhEGw4LP2aD32F2p+tkdPVYGm8pRm
         xuluyjmEVVVfZyWSJg+NAg8/3OYRqGcUeY0K37LNhP3blaLoMoqsCX1nqwgolqElb64t
         Y7U3kCI0GVCxOkCjNf4K+FFi3o49WBIJx5JdV8fJhqP8TkU7tSzZezOVSjomYvUofUC4
         inW1pn/7HWINIJxdMyKYJJ4fcw4wmZ03Ve4XBS9GzXAibSEKHLr14DzqNIY9AN79QwHs
         LJMg==
X-Gm-Message-State: APjAAAVurcKNI3GLCT7yRMk307NJIzlZALQrGqfMqgL5CwKIJDknZfBv
        bCD/QBV/G3dH4M4FlHxIM2/FzodtgdQ=
X-Google-Smtp-Source: APXvYqwtjF/xTCCQSvgccSEZSt4BtnbDwfdZENTnVhEbODBN1INuYTC08KPJGM84k2OlOfj2MaTKNw==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr47408861wrp.238.1582302673952;
        Fri, 21 Feb 2020 08:31:13 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id h13sm4718473wrw.54.2020.02.21.08.31.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 08:31:13 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:31:10 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 17/17] ARM: tegra: Enable Tegra cpuidle driver in
 tegra_defconfig
Message-ID: <20200221163110.GS10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-18-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212235134.12638-18-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:34AM +0300, Dmitry Osipenko wrote:
> The Tegra CPU Idle driver was moved out into driver/cpuidle/ directory and
> it is now a proper platform driver.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
