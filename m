Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A82C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E53420826
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 08:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/dNHTQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgEVIHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 04:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgEVIHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 04:07:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5897BC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 01:07:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so9241622wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O8d7KRaVnTOYXbysuI91JxBTkFpRwhQV9rw+72hpaS8=;
        b=G/dNHTQ35mXQKHenUhOBnQl4YBjCar5Smta1ZVS05OfG3JnGXyUgOMqTTIFecZ4RpJ
         QVs8IH21VCyyv8jJe05KrL0dOHZToLB/p9dUWi9V4IRoIJaFis5g1Y8G80/oUMzh67wS
         JkZIsiAgncGU8tB3eFwpuqToHAxb4oxryfOjUe+zIXUVeBDVU/MKN2J0Nupve/6mLuXL
         5cNSxXsCHnR+qot00GbqlO+TzdGzgsUpAfQYyjT/VbETx+WawHBJGNm94sRcppuI1tv4
         jy4KjLXauJ951srf059okjvTOFbBHwEP5F1Wa0L/fbL5kefaK75OpkJO3xC2/aNbKQ34
         DBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O8d7KRaVnTOYXbysuI91JxBTkFpRwhQV9rw+72hpaS8=;
        b=p9i2eGFg4q0YXKrRCn5pj3HPP9HwAHI60tcVPAYdeUIZLiquVXarDpa8d4hTJCfftH
         l3lyibM73dVBdIsKqTAPne0dKBO3Tq0kgvj+ahFIv11XEDUP7JaY+4wHPQ/Ak5bCMDhS
         vtcMmzzT7GoBBhP5oPD4sVYseD3ScO1LQyuxTiPVL8va3tPezHYBz6Kn8C5dsnQJnhB9
         D53q1gAn9wUBnfrDx5MoOiLDD3mwh6W5bcWr/mDCwShb77ti3ue5wFD7fabMMvYqMXWE
         CD+z1XX+m+WZY0YEf3j+E8DtqhFOXyfeTnKX/6HVd0amu1Mp+XyvLyHZch0byzqSlfpd
         uhig==
X-Gm-Message-State: AOAM532C5sstFdBrSt3Ho0+5uROIncFdghE90Q3EgsWj9tk8Am1t7LAn
        MhGrP+x7ZpPEIJUE30cV5L5HXQ==
X-Google-Smtp-Source: ABdhPJzK2pPNBTiomUPCXFOUqiKwd1QeBg43v4ZVNsVsWWhj1zS52qpTGnmcOXW17aVaF5waVx03yA==
X-Received: by 2002:a5d:5449:: with SMTP id w9mr2412511wrv.106.1590134868149;
        Fri, 22 May 2020 01:07:48 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id s19sm5119770wmj.21.2020.05.22.01.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 01:07:47 -0700 (PDT)
Date:   Fri, 22 May 2020 09:07:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 3/4] mfd: wm8994: Silence warning about supplies during
 deferred probe
Message-ID: <20200522080746.GT271301@dell>
References: <20200427074832.22134-1-m.szyprowski@samsung.com>
 <CGME20200427074843eucas1p2235840d80cfa81a1e1eee513ed88c794@eucas1p2.samsung.com>
 <20200427074832.22134-4-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200427074832.22134-4-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Marek Szyprowski wrote:

> Don't confuse user with meaningless warning about the failure in getting
> supplies in case of deferred probe.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/mfd/wm8994-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
