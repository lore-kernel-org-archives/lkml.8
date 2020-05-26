Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB044C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8088620776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A7d9iE7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgEZH6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgEZH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:58:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C09C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:58:23 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v19so2227989wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dJ7nNUH8waduGIyWxEV016jy3YBm4py1dEFZ4+moc0s=;
        b=A7d9iE7b9Upf36zlLWHFUh7N1P1CY4mQqszhIpb9d5Sl8zevcB1DdmcwQavIqWQbmw
         pX+23S3Y1u3fl+wZ932ldGkO8w6Lrtdl76NH7X0zFC1xB8ALdR3JhznT+pd07/KSSnsf
         hCNw+RSP5VLmcXqsozFu77d+Obd993ZdQ9KthTUkdwwx5xKTcb+n12El7J8g2uHUZw7s
         T/kxf3Nm+HWWBNgPaItR7FgJhTv8WyEaKfpONmcc1Py0NV6pLjU7LcHxvNrlRdSJr7im
         ACQBHGegYS3SNrFf59kTSNyyP10AXgMMR2wvqDAM4Wh2QHgxSgJIYVk/PAfvvrItr5on
         ZwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dJ7nNUH8waduGIyWxEV016jy3YBm4py1dEFZ4+moc0s=;
        b=CCOOB4+hoJwBQRbOrs78Ffr3vEr6S3z5YCTs9mjdF8uJCH7Jqg+Xe5qq+OhIPJptZt
         1ytRT7XpYO0h/VZFZ8/MbexThCHtEv2fEMC3PnBB4Ic+2iOeOdVIx7d6prXDOUjBTX9o
         5IJIiPl5zxyjpE6/bGs6R+6qSO+k3CtKiZxI8NwV8rQwz4AanbwWGO9KgNacEqPDQpt+
         iMCZDSnNBtLIQyYF8yO2FC66av1xfk2089C9TWDLV/7SejjcWcIon9mnHP3bocYtGCgk
         +AxZpbU12H5/qg46CJJho77KBwoNgrLbyAZf9RziOx3DpDSz9Rd8bt8waH545BBjqeA8
         bN2A==
X-Gm-Message-State: AOAM531lbVjo3jOEbenjtUNH4SnDBCS3uedghQB5+SvAjP7iENq45LiE
        t4ze/qLPlkcRhZgob6sMKkizv0trLTw=
X-Google-Smtp-Source: ABdhPJy8TQ7mKu5n0oMECEFkFjYc1EBZIzKzt2vRKCSKp3QhxeDkjqVyOGQXnuS+OyFgvG/1kqiDJw==
X-Received: by 2002:a1c:a1c5:: with SMTP id k188mr176648wme.41.1590479902146;
        Tue, 26 May 2020 00:58:22 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id j4sm18893746wrx.24.2020.05.26.00.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:58:21 -0700 (PDT)
Date:   Tue, 26 May 2020 08:58:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mfd: stmfx: fix stmfx_irq_init error path
Message-ID: <20200526075819.GF3628@dell>
References: <20200422090833.9743-1-amelie.delaunay@st.com>
 <20200422090833.9743-3-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422090833.9743-3-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020, Amelie Delaunay wrote:

> In case the interrupt signal can't be configured, IRQ domain needs to be
> removed.
> 
> Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/mfd/stmfx.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
