Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA8FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF5D12072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbxz9yBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgHXIDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHXIDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:03:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC34C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:03:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so7252384wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wKJc5ULgCn42W6AwcfwI3Hdq2Fzfi0fveyMXzJJAKrY=;
        b=gbxz9yBDQHOwuGzJ5Qk5ghgQOOxR0Ouhkgfb1VS6Uy7LYzP/FmADjdWs0Uiu61H7fo
         VygFzNWJkzDiacnQLMZm22o/zImr1E+Bd2QOuFbGk3SzsE+TuFHVMFlfsPmShJ85VzRB
         s4x1E0HGraM+JW8/E7nc22zQX1anC2On4RhlpHL2+3wiUQDq2GUE9kRxPTjMPSJ3wf/b
         1O9H8OVlKt4ULaMWEjMmM9DhPXCucHeuzX0J7FyitQDaEy8FBXBzv5qtqZrdV3ZhI+L7
         KtookbD7tlILe2RYjCSNm3oPlyFK0zHfJtxy/VgE0nR3dTGM3gra0CZP9SpJ4dR8SdfA
         CapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wKJc5ULgCn42W6AwcfwI3Hdq2Fzfi0fveyMXzJJAKrY=;
        b=oEhIbvdxaKZ7y+Sl2BkIjPyWQF3UovpNm3ggoHODXyyKX/KCaIuD7adXAHuEeUxQjl
         GCnzB34xFOd9b7GFTTzR1Bu3xChZnKelF1NCtw7lJUIw38JFi1dtmzUIaVfbMJbP40LR
         DbUlmn5GDJ3YE2qKd0+PmCMsJipk2I+K5h5Tgdg0pS1HK8nyBthlX1hFfDoNrPDZXMfg
         5HECS32ix8iIy8kIZ/kKKPbIAFNo6g7u5CjBKMAvxmM+9Es3QbBLkCQAFcEflWnbCi82
         l47aGfU9KztcLuQaEgd8zAktDiWkocI72xLq2PuwyW/zd/nvR2pAgT51L2Y9XpEH2uvi
         RHsg==
X-Gm-Message-State: AOAM5318fYMqVcyhved8h1j/2Tqa2S7y8N7gvbydHcRzOGAkMmT1zpCH
        V47mU9QiDgohMjgK8xSXX0ffUQ==
X-Google-Smtp-Source: ABdhPJxhP4O285cUjTPV8Pjdnaoq8z1UBcqsLgHoqRVsvaIjEIql35jIFj2R9mZ0+oVu8MNCrmEBYw==
X-Received: by 2002:a7b:c448:: with SMTP id l8mr2868949wmi.132.1598256210420;
        Mon, 24 Aug 2020 01:03:30 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id s2sm21533632wrr.55.2020.08.24.01.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 01:03:29 -0700 (PDT)
Date:   Mon, 24 Aug 2020 09:03:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     Frank Lee <frank@allwinnertech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, gregory.clement@bootlin.com,
        Thomas Gleixner <tglx@linutronix.de>, jason@lakedaemon.net,
        Marc Zyngier <maz@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        "p.zabel" <p.zabel@pengutronix.de>,
        Icenowy Zheng <icenowy@aosc.io>,
        =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        clabbe@baylibre.com, bage@linutronix.de,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, linux-i2c@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v5 00/16] Allwinner A100 Initial support
Message-ID: <20200824080327.GH3248864@dell>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <CAEExFWsvScMgi_Dftfq06HZiF8CFAmym8Z_tgQoHHAfiGxWt0g@mail.gmail.com>
 <CAEExFWuwjmqAh0c3kMLS3Gs6UC2A8TtY-9nJeWxFPRDugtR4pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWuwjmqAh0c3kMLS3Gs6UC2A8TtY-9nJeWxFPRDugtR4pA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020, Frank Lee wrote:

> ping......

"Please don't send content free pings and please allow a reasonable
 time for review.  People get busy, go on holiday, attend conferences
 and so on so unless there is some reason for urgency (like critical
 bug fixes) please allow at least a couple of weeks for review.  If
 there have been review comments then people may be waiting for those
 to be addressed.  Sending content free pings just adds to the mail
 volume (if they are seen at all) and if something has gone wrong
 you'll have to resend the patches anyway so [RESEND]ing with any
 comments addressed is generally a much better approach."

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
