Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBF7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB07207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrDjElMb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgHSKwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgHSKwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:52:34 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9BFC061342
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:52:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so21059800wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 03:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9gkmD+jt+NPPAfuqcUBQK91Aso2a4xO+LXFVwtygFxw=;
        b=mrDjElMbw8NA6E2pCjzZai3H8/y5gZFC3nyYQF7wTWfgpyCO5b/6UefVl+zv02OTnQ
         lY8s0IN3LajIpW38QnPEKKQfMM0SFOyRmS8TWkTYekNg6Ira5ebYJkV8vwwT3ldbp6wk
         QMDIhKTOHSFQk4ywhNRIsnmz49yfCLvYMPxH9+orJ97qoO85hU6nm9rMYp42fRuyVXnQ
         +ptOQyD80xQ7YOitH4RNSp0W/BMk/7D7ae7pAmcNlHXHk5Jvj+/wKOUD7LcY29PmUMEN
         MdQ16EDPWre8Ai4VcTDT2LWgCC6gRguYRDKKvJsU6PCTP5+IH1zZGe9qbpsbjueRbOGZ
         1Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9gkmD+jt+NPPAfuqcUBQK91Aso2a4xO+LXFVwtygFxw=;
        b=KHOTo7hjscqm5EGuXCWiX8ws7daZA/nOjKsfl2qMy+YCp2rKSnhaTRHm8btIa0db27
         W/dtOqJOnPOTWhmSEki6mzx3PK/rElnhZrm0nizpSRkp655mm2lo72fr0aZbvqTQA56i
         K4V9GpxiuhiYfBHTLMmf5DxcO71jCkDlPjdLxDIgeIOlh6aAh3AMavCBFWBisTxTKfxT
         NNu1vvgc6g2vWoWRWWz+ZCLLPmJeDu/l8kyiN6mIk8KQo0Dd6r9Tc6sqcGjrBjquHPx0
         gVd//+JHihLfuR0/gxk4YPubOmXFY3HKA8wWs3yydnX5VT+P3NwshC74WBAACc22Y37f
         EZWA==
X-Gm-Message-State: AOAM532M8k9fnPTX4ARXaCG5NLr9Th04JdRNkO3k0//Y2S5mmB9CxcWF
        W2byy9YAKCihN2lprKwKCsoo+A==
X-Google-Smtp-Source: ABdhPJwYp3v/FEV8ijzBdLsbUJihb8JD2xh0McefXGdZF4kT9nYWP0mx8pkRxosbgqVUJg9fNL7Kvg==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr25824583wru.372.1597834352734;
        Wed, 19 Aug 2020 03:52:32 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u6sm34957125wrn.95.2020.08.19.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 03:52:30 -0700 (PDT)
Date:   Wed, 19 Aug 2020 11:52:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     sre@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, b.galvani@gmail.com, phh@phh.me,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH 2/2] mfd: rn5t618: Add a power supply subdevice
Message-ID: <20200819105223.GB3248864@dell>
References: <20200815165610.10647-1-andreas@kemnade.info>
 <20200815165610.10647-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200815165610.10647-3-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020, Andreas Kemnade wrote:

> The RN5T618 and RC5T619 both have a charger and a fuel gauge, so add
> a subdevice for it. According to drivers in the wild, things
> should be at least similar, but since it is not tested, add it
> only to the RC5T619.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
