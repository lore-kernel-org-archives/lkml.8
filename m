Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B3C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E5A20801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WbvPndXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgBZKby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:31:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36283 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgBZKby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:31:54 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so2318390wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 02:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VlmNmMOEnccWBMpLFUQyGq7ZQSGdCXjPZIAycYxskHQ=;
        b=WbvPndXK5aoVKO58SR6GoFIQp9plmxroG1R8Olizhb1uoUDD0jL2uCxqMvdtfEQBAQ
         sGYvAYGDOq+XDwLV2eOUt/3eXiXSReUtPWyCmgLVAlCE3dStEfMr5K4IoEsLBBdNijpu
         cvp1EWyAPt4AB6sdMzPTgltYYedkoEkfaXI9mRQWrpLPfAwG00yozaaJY4s6u0Hr2hS4
         aFz9YOIXZAJ4V3KGnZYFJkTzFSLA3TRpmrq/0qLzCrk1ZdMuen8KbbMJQVCbAs1HgX3N
         30T9zMztnlPURdDYHjwPcPLiTnkrPkTDA/T0wxCIMSzXHOJBx0gCeFDCt+GKO4L4sBbr
         wA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VlmNmMOEnccWBMpLFUQyGq7ZQSGdCXjPZIAycYxskHQ=;
        b=hM+LAmtHqebEt2O6ow/cAgPqPlUrzsuCZLGvdd2k9xZySlyfQzBeVWHEqJLzytpCtO
         1/Sc5/5cDInLcvZdLeutjW4CNfwElUDotABRZAM6meHd9kdLRYFtHNevYssBnzmgiCxg
         d6QraON43soTdQEAMcuIHZYWnNxQAogitUAWqvyl3bA6utydKqR0w5nOWKcsqQH5eBzH
         sWd1rheq2ouNxzcUmbw33b3rkZzFlKFO2VboeARzlTN1QKnVeGf7kNb1SIzD9jpzcKGK
         anU0iaYuR+OoeKeb2aGVSjF2cdEWH8Rixr/kparZV45IHRjLqASC6WKfv95n6e5KcZq/
         tokw==
X-Gm-Message-State: APjAAAXY8F0Wrh+xAhzQqbQLskocuken5h7PkInx4ZARm3OPVtgpHfdf
        r+obATiveDBbJtk39YM2og6EMw==
X-Google-Smtp-Source: APXvYqz93XBvhXDhBn8QRAlqvgq8Tzy4pJGLOiUuzrksDfRPQP5AO6Mif32DtArQPwf5irPXzxQtgg==
X-Received: by 2002:a5d:6445:: with SMTP id d5mr4733774wrw.244.1582713111035;
        Wed, 26 Feb 2020 02:31:51 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id o4sm2502608wrx.25.2020.02.26.02.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 02:31:50 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:32:22 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: Re: [PATCH v2 1/5] mfd: rk808: Always use poweroff when requested
Message-ID: <20200226103222.GE3494@dell>
References: <cover.1578789410.git.robin.murphy@arm.com>
 <233bf172a5310658d703b11be6e637d6c4d46338.1578789410.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <233bf172a5310658d703b11be6e637d6c4d46338.1578789410.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Robin Murphy wrote:

> From: Soeren Moch <smoch@web.de>
> 
> With the device tree property "rockchip,system-power-controller" we
> explicitly request to use this PMIC to power off the system. So always
> register our poweroff function, even if some other handler (probably
> PSCI poweroff) was registered before.
> 
> This does tend to reveal a warning on shutdown due to the Rockchip I2C
> driver not implementing an atomic transfer method, however since the
> write to DEV_OFF takes effect immediately the I2C completion interrupt
> is moot anyway, and as the very last thing written to the console it is
> only visible to users going out of their way to capture serial output.
> 
> Signed-off-by: Soeren Moch <smoch@web.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> [ rm: note potential warning in commit message ]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/mfd/rk808.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
