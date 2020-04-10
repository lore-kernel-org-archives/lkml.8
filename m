Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959C2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA3C2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586540822;
	bh=e4T6wr8Q4Nw+PsS/Yni6kuiQWpNyp462Qaw7cdynGDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gEhNHaictfcKscC51xir4E2/gTm7+2oUCTsJrVC8zv4fJhug5Oh7DsKSayfkO+zJ4
	 jG6HZo53q5Mvr9HYWPJZFlkcegMvfBEFKUGRA1PXNC6FqjSC3vYBKnl6fYUBJaOF1b
	 smo3pNvUGfu/IbExFTchtqU0BMsYRTiJCM55UaWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJRrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:47:00 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40560 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:47:00 -0400
Received: by mail-oi1-f194.google.com with SMTP id a7so1979135oid.7;
        Fri, 10 Apr 2020 10:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YOlnayCpN0x6fsTC4gjjNKTPcCx7CoULGGzJuytpQFg=;
        b=AiHs1HaJ2/kw4hHO9LuAUOnrosulrYIWvSYs5qRKMH/JdpHJfSOfdYHyURpP/dEbTj
         ek7o4TH+GfurmIc5cDnWrjmsIuXMOdw9twGP5ccMTXXRj80jEZkDxI/e0xATq5kL6Cwu
         RWPfLqSyhiOHnrL8fA/nCssRu6I5UKx2V5IAhi3Y2qM8Qj4w1OTQK0fF941xaSwLjKcy
         9v/lBvBx8jZSUmZ9blqGTd1Z0NdC6ztciFoJu3QHpf+zpO/hh+dPCPO7gpMlbMDG5gka
         wkFSLYXYymDvchvL4XiTLagyOwO3xQZpG+xQJsqjvrvKqoaDTqaQIavidwxEdTu9J9b6
         hsLA==
X-Gm-Message-State: AGi0PuZ1oYmGK5zlipIF2/FBBJzWTh+jLoSHGRfcfE8HjzUQouQ9Ho93
        THoFUfAwrNpr8lIjUqbhxGQsuDk=
X-Google-Smtp-Source: APiQypI+q90EcJYQgIP5foBVizKnUwxg5NykGbL2hgbN/7Z9tebeDhCVPgGy4H9xSz9z9wr3rhbSRQ==
X-Received: by 2002:a54:4519:: with SMTP id l25mr4255258oil.92.1586540819869;
        Fri, 10 Apr 2020 10:46:59 -0700 (PDT)
Received: from rob-hp-laptop (ip-173-126-55-226.ftwttx.spcsdns.net. [173.126.55.226])
        by smtp.gmail.com with ESMTPSA id d3sm1596066oib.15.2020.04.10.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:46:59 -0700 (PDT)
Received: (nullmailer pid 25668 invoked by uid 1000);
        Fri, 10 Apr 2020 17:46:58 -0000
Date:   Fri, 10 Apr 2020 12:46:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com,
        narmstrong@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/2] clk: meson8b: export the HDMI system clock
Message-ID: <20200410174658.GA25608@bogus>
References: <20200330234535.3327513-1-martin.blumenstingl@googlemail.com>
 <20200330234535.3327513-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330234535.3327513-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 01:45:34 +0200, Martin Blumenstingl wrote:
> Export the HDMI system clock (used by the HDMI transmitter) so it can be
> used in the dt-bindings.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.h              | 1 -
>  include/dt-bindings/clock/meson8b-clkc.h | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
