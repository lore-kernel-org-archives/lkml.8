Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C611C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5982076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597163045;
	bh=lQ2G7W0fwUgv/M3rd1/YPgotjyMQs4fQXBSjxAUexMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=11+Af03a9uAgsjJ5mvqRHh5WGB8RTrG7SBVHRxo8nES8u7EMayz+3Ckgh4KiHt7FO
	 NOZLirt/iRuaKsGtK2wluT3BSatSwDEcZGFv7e35DLfftAVgGaxCKdaDym6RY9y4wc
	 dN8ixIt8sBQw2Xdc97EnfrPGTbJxTaZP+EccdNyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgHKQYE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:24:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35731 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgHKQYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:24:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id f1so12053255wro.2;
        Tue, 11 Aug 2020 09:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DtpRyILKzc0LouHDjzEvI9K36MDUnhjMvK2V986wT4M=;
        b=LdqvsTagJF3aA/dh6RRzmlDxpTlHXdx1v0klsu34KdMhRvgXnM7lJgQPYsNYeA1MRj
         nQ6ZcHJrHaahIT47DSQtixqag/fwVKtmQwWk6yTPYxbI/VFZRJ17pzYp2aM1RAykTD79
         4uodZYP/AVS/pB5H9CAWm3fBi6v8o0NO1B73OTqrDPIFDmbxaz0ADDT+i4ybB4GNy2Kf
         +/bN1/WiO4Eu5ONB2oHUHbl9ZfGrlDSWhofqYuqLm4A+6YxHlCdGSqFmSE7InCE2zN+q
         DLOZ7BmWeHpDNlyFtxaQDtC3FNKZ4s2W2ZXHG3UVGo2D0ERZeuJOjXipyO16Oeqp+iym
         +LLg==
X-Gm-Message-State: AOAM533oWhuJvlVuj97VRseDsCqBp000nMknCiCBwlQBOXEZqezMNo90
        I4YGkWR2te+iOA0ZEM1xblw=
X-Google-Smtp-Source: ABdhPJxDUFvJBC44I1v+v4SyAecRDMbHo8RnZ1bkxRcesLgksT4BqcDwT9s4wPMoRYiqRGK7FgTjeA==
X-Received: by 2002:adf:fdce:: with SMTP id i14mr29548489wrs.273.1597163041912;
        Tue, 11 Aug 2020 09:24:01 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id g8sm6017509wme.13.2020.08.11.09.24.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 09:24:01 -0700 (PDT)
Date:   Tue, 11 Aug 2020 18:23:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] clk: samsung: Prevent potential endless loop in the
 PLL set_rate ops
Message-ID: <20200811162358.GA7169@kozik-lap>
References: <CGME20200811112518eucas1p2a751f664a907ac7cd8e1dd235dc2fa54@eucas1p2.samsung.com>
 <20200811112507.24418-1-s.nawrocki@samsung.com>
 <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CA+Ln22Hfys7r2EDstOsdks1X88Fuv77DLTuXLWDynTt4kmiCiQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 02:59:07PM +0200, Tomasz Figa wrote:
> Hi Sylwester,
> 
> 2020年8月11日(火) 13:25 Sylwester Nawrocki <s.nawrocki@samsung.com>:
> >
> > In the .set_rate callback for some PLLs there is a loop polling state
> > of the PLL lock bit and it may become an endless loop when something
> > goes wrong with the PLL. For some PLLs there is already (a duplicated)
> > code for polling with timeout. This patch replaces that code with
> > the readl_relaxed_poll_timeout_atomic() macro and moves it to a common
> > helper function, which is then used for all the PLLs. The downside
> > of switching to the common macro is that we drop the cpu_relax() call.
> 
> Tbh. I'm not sure what effect was exactly expected from cpu_relax() in
> the functions which already had timeout handling. Could someone shed
> some light on this?

For us, it should not matter much, except:
1. when on A9 with ARM_ERRATA_754327, but we do not enable it on our
   platforms,
2. it is a generic pattern for busy loops.

On other architectures it could mean something (e.g. yield to other
hyper-threading CPU).

Looks good.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

