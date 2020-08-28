Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F96C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC0B208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598596902;
	bh=UCB42pXjCqrAOwWGGrcCtsZIoT991dmtYxnXSw1wGTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FiFiY4HrKH3owUGLs3S1JV8iyz8aZ9rLyA0TEGXu4BQnbyPfdu1+bz1beRRs2/JSO
	 XW3qZE+AQzMYuhJM2r867YtXbAOgaKLEpM6/Of7I6mMZOkYnB3pvewyuSprnBvezW2
	 oEyGUOeXbqRnmq4RyA6rvhf+FgZO7tF0hi/64GMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgH1Gll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:41:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43516 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgH1Glk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:41:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id n13so158729edo.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 23:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OazcN7HN9a5E/rLdGkA2HsRtgNCRVnTkO1Ngzs4zc+8=;
        b=PTSKpuW2EEiwSCIRVw7lAcFqrKAvyv2AqPoJlV4fRobBRm8MGKyyxqnRm21PU9t1MZ
         W+2q93QFje6XplYbz+7KFToWUIQAnf5qgUV/R9hV89FzAJBxccSyPy4aFM6noPl4SlWO
         yD2uCIMWxYvH/QdX/ZvaQwYRhnX/DJl2zGeyPcRXcN+VWXXbaz0teygyzatwGXKcKzln
         h0/4rfF/D2X66iBXOzBrtvUBdnQqLq83nRJh15keawUwRd7RzWrDSt+3QhDsW62om8Tg
         foZJaIwnlmG3ICmgp8AsQvhdfmZrOaVIhdLFz4UMQWvUW+yK1uKTF66TA3FXqZXcVCen
         g5NA==
X-Gm-Message-State: AOAM532WQCRg4p95dWx0LDE47+vJ0xUBNVaPDUbvqYMif5X+4JYZEOwe
        dTlFriM6MWK4VHBFYR5lhJ4=
X-Google-Smtp-Source: ABdhPJxlucmdLtn/w19BIOYgR0oWbv9wc9kgrscFOfXHuFO0oaArewtxh298XtJFINJNK8GEvN3ZEQ==
X-Received: by 2002:a05:6402:2359:: with SMTP id r25mr377310eda.65.1598596898438;
        Thu, 27 Aug 2020 23:41:38 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id j92sm156054edc.82.2020.08.27.23.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 23:41:37 -0700 (PDT)
Date:   Fri, 28 Aug 2020 08:41:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH 1/2] ASoC: wm8994: Skip setting of the WM8994_MICBIAS
 register for WM1811
Message-ID: <20200828064135.GD17406@pi3>
References: <CGME20200827173411eucas1p1283200677c5e077c5e07af938934eb5d@eucas1p1.samsung.com>
 <20200827173357.31891-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827173357.31891-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 07:33:56PM +0200, Sylwester Nawrocki wrote:
> The WM8994_MICBIAS register is not available in the WM1811 CODEC so skip
> initialization of that register for that device.
> This suppresses an error during boot:
> "wm8994-codec: ASoC: error at snd_soc_component_update_bits on wm8994-codec"
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/codecs/wm8994.c  | 2 ++
>  sound/soc/codecs/wm_hubs.c | 3 +++
>  sound/soc/codecs/wm_hubs.h | 1 +
>  3 files changed, 6 insertions(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
