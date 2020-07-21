Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D62CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C26420720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595347378;
	bh=fQQCBOyDQWb60C0s27XMaIMd5c5BtwjBWjlNEXDTDC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lm+oh9sa5RDs5tGVWQ2kHwu0PewQISQIWEXd1VIA0yErLMC9cLuPjgkjq5l4ih2Xg
	 2ev4G+RoMgRciqF+aTGQSJDQlkSUTALKB5DNGZBDY2aJ6n+hu6nCFFH9mtLKTi/1Lg
	 uFPL0k1j7IWdtnKbuEon6Rz60sIyyAwHKCYiWFnw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgGUQC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:02:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43719 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgGUQC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:02:56 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so21948509iom.10;
        Tue, 21 Jul 2020 09:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YwalK1RQnq3CwXPePKJZqsfuaCdWC1+FyIER6ijuGx4=;
        b=lOKQ8qw4PCwdbF8TsSMkRD2DGibFejqDSi2B6XYg6QNRvvl0XXDrep6MMt3M7B5eF4
         NAl/Kq5bAvYxU3SQ7PkfVy+CXev7JS5DrjfsFeJRfC60mn7fPgWr5MAIu/H8IgTqeKXe
         WXMD2uv6Uz0sjPGlbXCSKl6TiPkeaTiN0rRn8b/5E1Ass8h1O5yDDoUqULvW4ioE+xOX
         YzvgoiEk43kjYkUH27n8f+xV51cZccueha0n1hZLlz9/OvFDaHJcxHZrj0ITNGmsK/tH
         b+tENPEjenzRY+70OSoMvXLHm8KkraKaIU7EuebGgzHOhmNzr12doJLUeGi9LBqRgKXK
         GI5g==
X-Gm-Message-State: AOAM531hODTUgZLwsnF9ThLLMGSmf3nNvmjn+Vd/UWdXZHQh6xMdKLEX
        A8UjeGxyocZS5qDEU4Nnrg==
X-Google-Smtp-Source: ABdhPJwd72ipD4E8/OySWEaZwXAbNXJiZHx1bqKEq3A2mBDY1mlkJrHxS8eBEz7M3yC39Zddd7TShQ==
X-Received: by 2002:a05:6638:601:: with SMTP id g1mr33001644jar.137.1595347374981;
        Tue, 21 Jul 2020 09:02:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y12sm10759945iot.49.2020.07.21.09.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:02:52 -0700 (PDT)
Received: (nullmailer pid 378076 invoked by uid 1000);
        Tue, 21 Jul 2020 16:02:49 -0000
Date:   Tue, 21 Jul 2020 10:02:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcin Sloniewski <marcin.sloniewski@gmail.com>
Cc:     a.fatoum@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mani@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        sam@ravnborg.org, allen.chen@ite.com.tw, robh+dt@kernel.org,
        stephan@gerhold.net, broonie@kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, heiko.stuebner@theobroma-systems.com,
        lkundrak@v3.sk, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add Seeed Studio
Message-ID: <20200721160249.GA377907@bogus>
References: <20200721152015.11608-1-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721152015.11608-1-marcin.sloniewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 17:20:13 +0200, Marcin Sloniewski wrote:
> Add the "seeed" vendor prefix for Seeed Technology Co., Ltd
> Website: https://www.seeedstudio.com/
> 
> Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

