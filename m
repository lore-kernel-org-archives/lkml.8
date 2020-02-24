Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76A3C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A11F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tgtYloE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBXJ4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:56:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43875 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXJ4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:56:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so9577114wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 01:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=83WW05lhEWXGN1JxKFA4ekygi1Trv1Nm3ZrdseE3tVI=;
        b=tgtYloE7TZ6UonSIPskVA7JcMS8ZkE82CuKqfDohvY0umS9z0GjafnpMTiXmBSnyBk
         JYJ6q7a07PbUizh9Tr1EQqK9Rw6CuVPiK3iwJCafR3WLjjm98xDLOXYAAtuuKDHt03W0
         d9JXZBBtl3ALgoRb1T8zTTQW65Y5XPKByLKoaqrfTNBXVkNQ4Mc2GTQduXteAh9EnZuZ
         Z8t60QvEi1gzsBuwfvZNoEJ+9U3FmyWl82GRWkBwAz3OrHlo2uWbQyhb4U3l2jAmT7Oe
         rQ20JFDEXG1iWgGnDH132cGTh4grqoYSda3Hmy/nKHiRj3/6bX+sD5/1916NNKUTTw0A
         6uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=83WW05lhEWXGN1JxKFA4ekygi1Trv1Nm3ZrdseE3tVI=;
        b=kqL2lfE2PiHVEaiG+Shk8y3rWQikOkOLeFQ7AR3Oyt7igQXbLo6DaeMqmYzLJ8s1Ip
         wS5uopHQhEgkcSY87VumCLF+DIXlYI4UvbVdZQd1i1lKvAeJjOL/xhefy41p2WXxGzJE
         dtRtL11Rw/+SkGBskzEMyXtETCDeTY2BhrLAfhnMNbAcku97UVWE6omrJSSmQHX9idpY
         DOAMdBcs6qnV9Scic1vC6PyEsXncXsAfvqIV3j5FWZzDww/S0bGDrrPeeKJ+mTvVteXA
         15HvCFuPnd2ryN5bImIJ1sNWngRwatB91zUJFQLPjCiOUU3go8wnkTbQYB97mhSnIK50
         dj+Q==
X-Gm-Message-State: APjAAAU1z0v1W7EBqimpkVPw+foeWhlaquHC8dIPa5cPR1I/1m+gz69j
        E4AwnYK0hyLh76dGKUpY69/wkQ==
X-Google-Smtp-Source: APXvYqyv+04rATj1+viPMM5ZF5AfpDdU1oN1oxCucdan3Urn52RETMlxPMlSL0lvmXcUKWSljy054w==
X-Received: by 2002:a5d:69c6:: with SMTP id s6mr986853wrw.32.1582538183371;
        Mon, 24 Feb 2020 01:56:23 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id z16sm564269wrp.33.2020.02.24.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 01:56:22 -0800 (PST)
Date:   Mon, 24 Feb 2020 09:56:54 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [RESEND PATCH 1/2] mfd: da9063: Fix revision handling to
 correctly select reg tables
Message-ID: <20200224095654.GI3494@dell>
References: <cover.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
 <c75e6e04281fd8da78cd209a888664c35a6fb8c1.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c75e6e04281fd8da78cd209a888664c35a6fb8c1.1579864546.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2020, Adam Thomson wrote:

> The current implementation performs checking in the i2c_probe()
> function of the variant_code but does this immediately after the
> containing struct has been initialised as all zero. This means the
> check for variant code will always default to using the BB tables
> and will never select AD. The variant code is subsequently set
> by device_init() and later used by the RTC so really it's a little
> fortunate this mismatch works.
> 
> This update creates an initial temporary regmap instantiation to
> simply read the chip and variant/revision information (common to
> all revisions) so that it can subsequently correctly choose the
> proper regmap tables for real initialisation.

IIUC, you have a dependency issue whereby the device type is required
before you can select the correct Regmap configuration.  Is that
correct?

If so, using Regmap for the initial register reads sounds like
over-kill.  What's stopping you simply using raw reads before the
Regmap is instantiated?

> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> ---
>  drivers/mfd/da9063-core.c            |  31 -------
>  drivers/mfd/da9063-i2c.c             | 167 +++++++++++++++++++++++++++++++----
>  include/linux/mfd/da9063/registers.h |  15 ++--
>  3 files changed, 160 insertions(+), 53 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
