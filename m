Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BFC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB9720578
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XIEgSW1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgIHTne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbgIHPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:52:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A43C0068C2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:00:17 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id j185so9170388vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tJRPLo+J0AriJzHTz4tB+cqM6v8af2cuqs5qOTFB1iE=;
        b=XIEgSW1KV88kuUzhoRuadz6lGFrG4VliZ7auCmMMAlPJEGo9Fv+rD3RcpZVWzKa/jC
         Hc4MsaNyKgjUL9Gn6+/+FjrCQay1ygjM05S2Fmb4xe4LHoXfPt9CFBa2hoBZZIA4/sCO
         Um5z7+bxy8muKu9ywGVyDQe/KVjKJh+B916q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tJRPLo+J0AriJzHTz4tB+cqM6v8af2cuqs5qOTFB1iE=;
        b=q44yuGLyG3ZrlSDxkequCwDxJKNrCSA/yj/DLectMdsumxcP2zjkCwlo1PhcoOItWm
         F4KVM0yjuh8J/ayW4k6l2k4tSAYmt9kd6siQpYfER9h5U6QL28USxPfHHWL4gI4JcM71
         8O0b5S0m0W9Zq8BiDYpSwiee0Y+A8tXgSlkAWWpF530QM9tK+yKUG23b/3kZnHO3d8Re
         G/QOiUF4W8u1gpGI9EyLkUpud2Rggfth6mss8m08ro8eqPHyqu1VcfVsK7tooboCbd14
         GRaZlCxWpsX4hy2qnzTxgcjrv2UayR0u4OA4XABwzr6RiLPJM5NqUR7ZTNiKT6b5Xijm
         nMTg==
X-Gm-Message-State: AOAM5307wjpaM91JjzxWglIjp0U8n8lRwp5sQLivXSZrbfT7VZLoIVBO
        QppUtZOtIQW09x2XapjH8QkpZC+9GIx4yQ==
X-Google-Smtp-Source: ABdhPJwvWr0WDk/zj0fcTKzKuPp9Ru9uhS9Evxup349l28qUEnip/DFRvOQNc1Q2E9oU1/nTwY+jEA==
X-Received: by 2002:a05:6102:40e:: with SMTP id d14mr1107778vsq.30.1599577216241;
        Tue, 08 Sep 2020 08:00:16 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id f190sm1528698vka.1.2020.09.08.08.00.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 08:00:15 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id s127so4144745vkg.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:00:15 -0700 (PDT)
X-Received: by 2002:a1f:e641:: with SMTP id d62mr15027301vkh.30.1599577214628;
 Tue, 08 Sep 2020 08:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <010101746c377537-ce93e925-598b-4dce-bb16-4cda020f4d6f-000000@us-west-2.amazonses.com>
In-Reply-To: <010101746c377537-ce93e925-598b-4dce-bb16-4cda020f4d6f-000000@us-west-2.amazonses.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Sep 2020 08:00:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WsUopZPHJzHe1+pa=pzKQda0yQKUCtnPrni3Dmx7aV3g@mail.gmail.com>
Message-ID: <CAD=FV=WsUopZPHJzHe1+pa=pzKQda0yQKUCtnPrni3Dmx7aV3g@mail.gmail.com>
Subject: Re: [PATCHv3] soc: qcom: llcc: Support chipsets that can write to
 llcc registers
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 7, 2020 at 10:36 PM Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -73,6 +73,7 @@ struct llcc_edac_reg_data {
>   * @bitmap: Bit map to track the active slice ids
>   * @offsets: Pointer to the bank offsets array
>   * @ecc_irq: interrupt for llcc cache error detection and reporting
> + * @need_llcc_config: check if llcc configuration is required
>   */
>  struct llcc_drv_data {
>         struct regmap *regmap;
> @@ -85,6 +86,7 @@ struct llcc_drv_data {
>         unsigned long *bitmap;
>         u32 *offsets;
>         int ecc_irq;
> +       bool need_llcc_config;

Do you really need to add this into "struct llcc_drv_data"?  You use
it once at probe time and you could just pass it in to
qcom_llcc_cfg_program(), or just pass the "struct qcom_llcc_config" to
qcom_llcc_cfg_program()?  It's not a huge deal, but it would make your
patch simpler and keep an extra element out of the include file.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
