Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7FBC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F8C024125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579644042;
	bh=jjd2W55JSywcf78Gs8efzi1YR2Q4ypi+HLytDtUj1NE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E3drY/H5mWctopMKdP1ukYVCTG8NnJd/CWy2YI+TxqbNg41n9rN5SiteVuuccrdZ3
	 Gi618qwOlac3AQZVzLngw7Reel493DOUtQ6ADSfAfXom+Iu7/CV6tE409I04Q9mQLR
	 eFMyPtiAVfYP9ezY8qPqpBAap89wWZ2T4Qt9+YQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAUWAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:00:41 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37244 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAUWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:00:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so4444559otn.4;
        Tue, 21 Jan 2020 14:00:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YR+Zx3t0R9EtJawzXHJuAJ023/cuhAooUF5TnzNGC0s=;
        b=Oc+jRRcUlG7fvjhGZa1/ptuvAOYN7VQvXPKg0qX2NHvHg8WfEK99GQAJRhbc7HHSaH
         ukjkZh2UuZqvBlOML7iESAj4NR74bFyWf7lMHsoHI8MpGUhkBOZPQ9F1lfNGQdRNYsXp
         0yKvIfjNp2gAFUX8l+Y+MjlG0X/GaKAOP0+ZdSGe5vq1OiyMDDJVGE8IdJmhO1yt49be
         DGDc1X0Sb5flMwiajBj8Rb4Rpn7XdsMOFeMq3F2e8822GA5y0+tn0zDzGPBrKmOKIe+W
         0NAZ3ayFq3jRXYeheftJwrkW4nVp+uc7yCOSZJ+CLU/uvlokiZgoISwwQJQx7TArknvs
         w5uQ==
X-Gm-Message-State: APjAAAUu+NEKmWhSUdZc/F957TzckkZzwEYl6f8QDkAc2vJ4L+ptYlnJ
        2uv0mNwOwKGYvwG/L2JT2VUkQoo=
X-Google-Smtp-Source: APXvYqxcLtKqgiW0rjqOQtnpGB4zMIDBsBFxY3KVfQ8Uv1rKit0T2fEj2ciq1t+IrUPzAInLx3dGkw==
X-Received: by 2002:a9d:588d:: with SMTP id x13mr5021535otg.6.1579644040203;
        Tue, 21 Jan 2020 14:00:40 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm9071739otv.20.2020.01.21.14.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:00:39 -0800 (PST)
Received: (nullmailer pid 13825 invoked by uid 1000);
        Tue, 21 Jan 2020 22:00:38 -0000
Date:   Tue, 21 Jan 2020 16:00:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Message-ID: <20200121220038.GA13566@bogus>
References: <20200120034937.128600-1-jian.hu@amlogic.com>
 <20200120034937.128600-2-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120034937.128600-2-jian.hu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 11:49:33 +0800, Jian Hu wrote:
> Add the documentation to support Amlogic A1 PLL clock driver,
> and add A1 PLL clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
