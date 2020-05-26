Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AF7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4241420776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/dXU9fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbgEZH7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgEZH7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:59:04 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5D8C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:59:04 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q11so7275454wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zYdjgpNGKkhHUaPVM1/nhRkNBCVbxfKW4NHkKWtwJ2Y=;
        b=n/dXU9fyQ+2u0G9SXzRKn0Sd6pJTChNHgO3T/qJJlCgWgMb4CS573tIEQx+xoycpt5
         ZH5fEO/STnba6a5noZgK+uleLYZg24fRK4RpI+M93bAfb7iWvfyTECnKeAx3Hs1Nyy8z
         3k6qYlbQlDVjbj7whcev/TQosfr+iCL0jQikOosi/J4RO2+fyTg6NguWXboOJsI/tsAm
         8p2GrWuV0sCQbUNji569BEikqLrJI2tJSONaEZf5CDhmIWZwRenMEDB1rC10eiprVUO7
         djKXcWdnhf+v+kzsegrbQjmBD4aVi//DZxmrvgOt1Z4TYdJ9h3i+v/dLSIU26jWEA2gk
         sp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zYdjgpNGKkhHUaPVM1/nhRkNBCVbxfKW4NHkKWtwJ2Y=;
        b=oGjGbVafD7iVCrsJZtIJQjpyJ9MvN5Epk2edRA2T19Ho70Q+lKGq69XMOdVsC1EFGL
         xOjI3E5Az4IQM8TGfTWuG6W776+WhUGkAg4QJxtV77yH3FeIkMU6nHIPWu0qP8kDZiTb
         CWCg0zsItAO4h+m2rdWX7DYDw66Cm/4b/OdEjLD7fHGLLvIVTi2DqcQAAFU3bOmPBiV+
         jlRDUo6e349zM+mTp45VG3Q4Gnxy6i9eFHwP6/Z1UZOxTDUcEVPlHPbp8Bp2ycgdBPXq
         H0qd6f14QzcHB27PXk8AhwioHW0X8qvPp5Go/IXhfn/ecH5DWUOUrmOo+embM2l+OZ7J
         SUwQ==
X-Gm-Message-State: AOAM532vqObHgAZcD9eiCFDxktktalkNGk29uaOkZ2TGm1lIFKB84tOi
        kKYbzRF/IsLokeBbwJlLW0ENbg==
X-Google-Smtp-Source: ABdhPJzjh8siprJLpdOwjtzMP60lf7tTZJoWmJAVMzTka0tpDJqO/GhIRtY1OB3npRBX5C5TYEDnUw==
X-Received: by 2002:adf:a51c:: with SMTP id i28mr1970108wrb.78.1590479943335;
        Tue, 26 May 2020 00:59:03 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id d6sm22344913wrj.90.2020.05.26.00.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:59:02 -0700 (PDT)
Date:   Tue, 26 May 2020 08:59:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mfd: stmfx: disable irq in suspend to avoid spurious
 interrupt
Message-ID: <20200526075901.GG3628@dell>
References: <20200422090833.9743-1-amelie.delaunay@st.com>
 <20200422090833.9743-4-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422090833.9743-4-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020, Amelie Delaunay wrote:

> When STMFX supply is stopped, spurious interrupt can occur. To avoid that,
> disable the interrupt in suspend before disabling the regulator and
> re-enable it at the end of resume.
> 
> Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/mfd/stmfx.c       | 6 ++++++
>  include/linux/mfd/stmfx.h | 1 +
>  2 files changed, 7 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
