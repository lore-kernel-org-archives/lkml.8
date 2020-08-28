Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A5CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47CDD2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDezp3wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgH1KM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgH1KMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:12:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B906FC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:12:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k20so387747wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8Ovq6P3MQ3z6dqGKr0Zb9utX+dneiZHadAh26MWglZM=;
        b=ZDezp3wkEqtgdk6LmoGQzRQAoxHxEoE6rmuSVOSht7+w5dF0j0t+Vo/9Iy0v6Vr8ZQ
         90M6+oCgfkbk782ciBITtNz/PGaHbvXI1im6Cg7Ar47ZRO749/qpJlSJoKOf3AImpA5c
         kDuLG0cktm73ACvMnjXYG6RIjYk1isLNXulrfQ9tijq4yj+N7q7f4XYXmrXi1y2Mf8bA
         tC/ke+Dx4BziV1myVVkTFooasFkI9oTIIv+GVyPLsNpOJCjL3FiyJurngi6Z2PyHxQbM
         irOhPCAd/ohUAWI/ZIcj9rIyBlecrWgSqqO2UI5ZvaDYxz+xzdetbdtLR7h0zgLqRUcp
         4o7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8Ovq6P3MQ3z6dqGKr0Zb9utX+dneiZHadAh26MWglZM=;
        b=gj2DuuvVkZp+UAh2OnigmFY7Su0qlROpMjUx0/IBWMOqBfNF6CnUg34dVoYvTUu2c+
         aAj5T8jcIUSjtzEZH6DEpVzkGz2I+zN7OP6z7MKVcQAfE6L0yNHCi0StqQ2Hfc/T3IJl
         4iHDmtuSl5IetqFc+5S3XD2y0OmOCVFiEmHb4RcW6cj52v2hgYHzKu4t8idqTCX7kK3/
         RTglUtu4mIg1muRwx10uEQZ0CSOamoB58k/zX5g7vmi5nAgjp7UaDxWUeeVu8+25YDG6
         CfUdlYthBYqlaRyzl04IQf9qTIo1AzNJWJliKqb+rauDTgRwhBziz3nHDXtstlSwA+Wo
         frJA==
X-Gm-Message-State: AOAM5331LpZ6cfJvbqYy9oOdiLftX/mYsaMdsGZzWgDwMQYh4YQIXgxu
        cRUPGOpzUkTS+SeyRcuIlMCUlw==
X-Google-Smtp-Source: ABdhPJyKmmE5smzdiPFgAo8SYJdXe+GE4Q9uo0Te9LwlUMOPWP9Iygbh8Dex7htNXU7nZnetQsDnUQ==
X-Received: by 2002:a7b:cc90:: with SMTP id p16mr940437wma.100.1598609542190;
        Fri, 28 Aug 2020 03:12:22 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id g18sm1251588wru.27.2020.08.28.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:12:21 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:12:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH v4 1/9] mfd: mt6360: Rearrange include file
Message-ID: <20200828101219.GK1826686@dell>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597661277-27862-2-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597661277-27862-2-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020, Gene Chen wrote:

> From: Gene Chen <gene_chen@richtek.com>
> 
> Rearrange include file without sorting by alphabet.
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/mt6360-core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
