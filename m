Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A42CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2C720782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598392485;
	bh=UadddTvuyBtrVP3c3jR7hL0X3Xz+QT2D9MUYEpJ/CGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jVB7YYIXll0nGj/ScuitZsQ24Q5t2nap1ShQkKbhTW18FfcrPxB+5TvUgn6snEr8H
	 7lT4pKU8s9EQxYfkKGPmqAYDOW11aLKG5D5vhhTQSTiQmdV1hCcUepvFXKE0kViQTD
	 XKCYTWCvBFZfWzjQ1uqFhWY8Kbk19T2e2L9JfN0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHYVyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:54:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46233 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYVyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:54:44 -0400
Received: by mail-io1-f65.google.com with SMTP id d18so38053iop.13;
        Tue, 25 Aug 2020 14:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AXgpF78WVo5FFCMhxBNh+NmqVg1TDWWj6afz5WYYhbs=;
        b=AsaoRna/TZvzZcYCSsE/8fZF9BmpT1Np1lGZYSwuizqHLCa/LH4fPeTeg4mtlRUGR7
         sp5yvFXNrc86KrvP8DkPmRYsCU2N+B6TaDRgslCGC9lJs7/EvB1A/KqbRHDRfmKAT4dg
         y9Wdd4p7GGlVWmjJZg7C8r6EQ0k1aC2Djgq4yaDescD9yjIIOIZS1XSNeizZv4MqSMIy
         tZ2nsjm7i//lSah15oeEFXFHgCqhxTVQ16VMtyeLJPX8Q5Oqj66Ra2PSsCLC+FDRc/Bq
         KQ0T4zuiZrbnsjQfVdfNlighoxmgwej339ngbBZdqaTBLyFoyqT1xy0KcWa7Y41v9rSr
         TWdw==
X-Gm-Message-State: AOAM531gkoYdqlQUz/RWiWTVu2pGAgGh3qPgyj5gkJ3BLQLltFd4S/6u
        TDU301e73NXCu6xVgCp0Aw==
X-Google-Smtp-Source: ABdhPJypF+PZ2Q26P3uIyId/gUF6uvU9h3TD4NtAGvuNXl1cQsqt9aXVrnWkBeV3wxxrorZptjlGsQ==
X-Received: by 2002:a5d:871a:: with SMTP id u26mr10104129iom.92.1598392483867;
        Tue, 25 Aug 2020 14:54:43 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id k7sm46346iow.21.2020.08.25.14.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 14:54:43 -0700 (PDT)
Received: (nullmailer pid 1406034 invoked by uid 1000);
        Tue, 25 Aug 2020 21:54:38 -0000
Date:   Tue, 25 Aug 2020 15:54:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: himax, hx8837: Add Himax
 HX8837 bindings
Message-ID: <20200825215438.GA1405975@bogus>
References: <20200819102246.634039-1-lkundrak@v3.sk>
 <20200819102246.634039-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819102246.634039-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 12:22:45 +0200, Lubomir Rintel wrote:
> Himax HX8837 is a secondary display controller used to drive the panel
> on OLPC platforms.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v3:
> - Moved to bindings/display/
> - Added the ports
> - Converted to YAML
> - Removed Pavel's Ack, because the changes are substantial
> 
> Changes since v2:
> - s/betweend/between/
> 
> Changes since v1:
> - s/load-gpio/load-gpios/
> - Use interrupt bindings instead of gpio for the IRQ
> 
>  .../bindings/display/bridge/himax,hx8837.yaml | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/himax,hx8837.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
