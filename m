Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E627C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335072075F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kc3UNpgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731595AbgEZH1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgEZH1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:27:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561CC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:27:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so2218030wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oX55DFCRlmwUFoRiiZXdIvxn1mRyrzPHH9QEEJ6CBmY=;
        b=Kc3UNpgCAQCZwq59P+VNL4aP6xlmDJ4FdAVbs8uqXEEBgNPCq2jjHYuGlkgm92U2OG
         89HbEnXOxA27+S97lV+X4TCgDXvI1yfSKHyPoKkZm7fIzgmz4rAtcHqnbC9b5SW3ZVXV
         G9BPXvYCLxv7MkeZdJpW/Rj8B3sNnCGsBMyvAuirbFCj1Smanz5e5D3s/6PupULXi0du
         f01uI7+NUqkmUFapg0KKOc0fcrMwK2xYYj5ixWR7VjGi70o1PXtkIGf3r9geNikqewOm
         +TnjHnVj+pz3WRmG0Z/HTPCzh+OPykxtbcUvEhw0VpfvEoN1x+l+g3iZBrpO/4AsdrQz
         cBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oX55DFCRlmwUFoRiiZXdIvxn1mRyrzPHH9QEEJ6CBmY=;
        b=Uxop6d5D3ZbynQJbYSlTus57K5iE591iMHEvOOrlEEG+ior4jPO1YYqrRvGhSHg+Yr
         VgLOMKnAp5LKmUFRJYKBkw+RYIkOR7f4v/nkDw1gmWm7zSb+6JokMbujaPpEvfmxidzs
         PAiry/biP2MrOGYaOhP1nKqnX4B4hNVZWv6Z2i3PWUXerN2clCOeOMQzrqKtZraTyzob
         A+wUynrFLeucqkte764WVqfhdClObktf4UbmekMPzou1Al3R2KPKtVfbyOkDx858RMJX
         q5bqcCjWI5sek/z2vvC714+MKkuP3QX75qboZcJtomHtxCpKxvxuHFMSueEN3twigj17
         0CsA==
X-Gm-Message-State: AOAM531pjCWViKOcACzcyHdEoxjgt8Hx3DwqJjc1+PVUmc8ouWsrSbiD
        AvXw3KYAaLrrcNB0PXT2vv2nDQ==
X-Google-Smtp-Source: ABdhPJzsqSQTVxDxq/52LQzAHWkQZWp3IEWvhukr2JFWOmsvjry6+PnvlzbFLZ6ileXrEqAAzFlW7g==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr47969wmi.79.1590478030278;
        Tue, 26 May 2020 00:27:10 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id x10sm21466135wrn.54.2020.05.26.00.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:27:09 -0700 (PDT)
Date:   Tue, 26 May 2020 08:27:08 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] STMFX power related fixes
Message-ID: <20200526072708.GD3628@dell>
References: <20200422090833.9743-1-amelie.delaunay@st.com>
 <f5b3df45-a01a-7cb6-c158-e6edc0117f0f@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5b3df45-a01a-7cb6-c158-e6edc0117f0f@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020, Amelie DELAUNAY wrote:

> Hi,
> 
> Gentle reminder regarding this series sent one month ago.

Apologies Amelie, this fell through the gaps.

If this happens in the future just submit a [RESEND].

I'll take a look at this, this time however.

> On 4/22/20 11:08 AM, Amelie Delaunay wrote:
> > With suspend/resume tests on STM32MP157C-EV1 board, on which STMFX is used by
> > several devices, some errors could occurred: -6 when trying to restore STMFX
> > registers, spurious interrupts after disabling supply...
> > This patchset fixes all these issues and cleans IRQ init error path.
> > 
> > Amelie Delaunay (3):
> >    mfd: stmfx: reset chip on resume as supply was disabled
> >    mfd: stmfx: fix stmfx_irq_init error path
> >    mfd: stmfx: disable irq in suspend to avoid spurious interrupt
> > 
> >   drivers/mfd/stmfx.c       | 22 ++++++++++++++++++++--
> >   include/linux/mfd/stmfx.h |  1 +
> >   2 files changed, 21 insertions(+), 2 deletions(-)
> > 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
