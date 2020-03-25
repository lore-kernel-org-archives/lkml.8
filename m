Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1CDC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667B3206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 09:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOCrmYgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgCYJYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 05:24:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44196 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgCYJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:24:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so1909646wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e/WRJY9hQuNERtjXc09PjFiO3i3OW3unssmQAUH0xA4=;
        b=TOCrmYghtMdNGSvBQLK0URmEQ2tphjMCtWdqTNQLfEEIKlWc630TT8syVVPNq7H0gx
         hc53Ll+uNR/z6pxaCIe8CXsOCYie9+qyGH+pKXSF262iX0H+0IZrKoDy1LkXpwtAzZnj
         so3gCvF9WEAQx7FLcg59c+RWWXjSyoJVwpqg0ghvz91XFhmPQK1sJt1Jc+McGvhBaafV
         40qBsJTYJN1Jb2LhMO4j3qdDmHEWozzjlq++36QgQACcnbdi10CoPqSJ4tZJ+DL3KEEz
         QAEQzieg6yqjV5DmCk6DfKhw32c30sJIV+RRzc1MF+aY4HevxngSE3KlZpPx7DGuAmmP
         NSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e/WRJY9hQuNERtjXc09PjFiO3i3OW3unssmQAUH0xA4=;
        b=n5H5YCQgz457vMnstUY/EEZYLVzgWPPCRLSYBaddVx/Hn9PrTJqm6PEwSDrRBRGv/T
         nrth8ObNDLaRgtp0ySdTo7wj/WuGyo+KOg54ZxX9z+zpDROo86gE1yb5baCXacEuYwtH
         l9naOBsFBUrUat1ALY+sSmXLwweZlazDjIZ05sNkM5dieWDaia82D7hyKWg3Sev+KMjA
         XYcEfF2N+E54OhQ0658/OJjrCxAubPvh6T7FGaFOCz/S636C6nmGDtCQRY2+4m6zYLgn
         ckDGQVzpdUc63cAOWtaHkGiZiDl8c5jvGlSIlHMDjA7uX23vMyb+6q7GZJQ+siGqzEmI
         BFUQ==
X-Gm-Message-State: ANhLgQ15GQrOZ83USkHaHlsrdmVb5s9iCphJBaG6SIvUrip5imo1C2wi
        ZV13GD6dUxmRGhYGzW3g9hJg4bRAqyI=
X-Google-Smtp-Source: ADFU+vvtM0r7YTLHYZmqyR/58pxdWaO+bfZ5E24Een0DugXny/ubfRaizT1o8b5ABKmii6yJ3QXIbg==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr2523301wrv.302.1585128259469;
        Wed, 25 Mar 2020 02:24:19 -0700 (PDT)
Received: from dell ([2.27.35.213])
        by smtp.gmail.com with ESMTPSA id l64sm8381606wmf.30.2020.03.25.02.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:24:18 -0700 (PDT)
Date:   Wed, 25 Mar 2020 09:25:08 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: aat2870: Use scnprintf() for avoiding potential
 buffer overflow
Message-ID: <20200325092508.GG442973@dell>
References: <20200311074738.8679-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200311074738.8679-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Takashi Iwai wrote:

> There is still one call of sprintf() without checking the proper
> buffer overflow in aat2870_dump_reg().  Replace it with scnprintf()
> call for covering that.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/mfd/aat2870-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
