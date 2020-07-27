Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDF92074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iH5n0MEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgG0Pgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgG0Pgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:36:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CF9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:36:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so13636186wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9Sxz73y7RgL+u8rtUA8o/y4P1sug9uuvbcujn5qnKbQ=;
        b=iH5n0MEYtT4YX4vz0+es0cG6ngjgu8JZkgehP9d1Bac8LeJBip7FVVyiY0MVpzYDOa
         z1+qJnnWCG0bhO/7hP7PJnr4wjg1smeucxRq6DamKSBf/86PS1DS7G/fBV5vQesgnxVN
         j+E7kKqmYvUW5bOghim2SeKo26bigiIkvcWnKSbqlo8BZDmYM0d6Ia8MgE198BNkNtj0
         Uxjs1O28nvudo6Ced6APXqNqGP/Y7iJDwYQrZ3iyJE/7VMfE3L2mYpxEmHnz+4MxG2GU
         FvlYU32xK+jYorluwclaGotK+Tf2ok4aZ4XNNVcRovbVxkqhvKgwDo16A+ytuH7Fp//G
         oLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9Sxz73y7RgL+u8rtUA8o/y4P1sug9uuvbcujn5qnKbQ=;
        b=fNaA78SJUSsA0P+aqJFx5CAeM/+YUJPAAySiDF/C+V45LuK8zQ4CQrapCXMDZ/JyNp
         Dx9UKbTBH54vwSJdctsZti6w9SYiw7wj3poTRglPthY7/4NZJy010K/1/TXY0/cJDMHx
         XbwnRt65WEx+UGTsDirKgBNaSXuWDDHAv4S4j0MlR3haQlOJirnxroIxamZyzs86RnYW
         VKwWmMeJRhnYxZ7/4bPGPjE6eqw8gu3RObQSxxXBRHEUN5QGbAzFhZziyv9Vq9T9MDMO
         hObrnuJDQNa1q7FnB9KKGXsakFdVrpxZGxw6qptQE8sTw+wGozPPIu2RfJ3/lFQPGNcA
         9i3Q==
X-Gm-Message-State: AOAM530OhhUpkRmRQLv0c62lwxazwKX38vwbcOPiHmGg/zTNHDQcLpk+
        ZiiVJqZYC8QsvCHY6aNanScv3Q==
X-Google-Smtp-Source: ABdhPJzDd+slK0xeJj9N8JVIU+68m7qp81qNM4BOeECx6/igXbWfKhNRBt+GUriqZEYH6Z8lCODsUw==
X-Received: by 2002:a1c:19c4:: with SMTP id 187mr21778043wmz.100.1595864208416;
        Mon, 27 Jul 2020 08:36:48 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id k126sm19423810wme.17.2020.07.27.08.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 08:36:47 -0700 (PDT)
Date:   Mon, 27 Jul 2020 16:36:46 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     wens@csie.org, linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com
Subject: Re: [PATCH v5 10/16] mfd: axp20x: Allow the AXP803 to be probed by
 I2C
Message-ID: <20200727153646.GX1850026@dell>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <c19530b2ee1f377bfeb1273f07a7ceb4ea4372ab.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c19530b2ee1f377bfeb1273f07a7ceb4ea4372ab.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020, Frank Lee wrote:

> From: Yangtao Li <frank@allwinnertech.com>
> 
> The AXP803 can be used both using the RSB proprietary bus, or a more
> traditional I2C bus.
> 
> Let's add that possibility.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)

Why do you keep sending this?

It was applied in v3 [0].

[0] https://lkml.org/lkml/2020/7/16/745

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
