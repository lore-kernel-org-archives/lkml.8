Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2206C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B072145D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594681350;
	bh=csKVKFceH1rTNOC33g9fwVMVIRFcnnH039GM85S3mFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jFoONWpVSH9sG9jlwwZ9aRNOh5WW6wZNxEjnIjYJC0JDYZ/FqpZYMm0+bvbIN2Xoc
	 mJXyyNe6fOWjV9Hv96idS+mc18wDffS62+m9WtC1zpeuTt6yrVnfOpL/Yg6UdnRAVh
	 fWvFlNULqJ04tFkuRPzHfW3grFwrz7XkajPkQ/Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgGMXC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:02:29 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39183 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGMXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:02:29 -0400
Received: by mail-il1-f194.google.com with SMTP id k6so12687307ili.6;
        Mon, 13 Jul 2020 16:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yirNwoaDU0pMBRql/rjy3m99mfgLldryNB/4qbEp9l4=;
        b=fdLbn0M5WNK5EDFtiR2HLC+fINOgNqeCssFZSraVjc22at0y2uzb9L0tcB5Suw/Jrq
         3LgHyUAFX77vPTzZjXkYzLg1gHjXUEU1iaRGXgvZf/cwsIG1eEwdR/TzJsUDNd/W96gp
         0gn813mnC0mjVji5A/VaCKKusCXEsSS3EHQgMeHHfdnOH4pVSKd+XjI9CFhuTbpPatlw
         xlZIeic55rPQtkoVDqWOUDIOvi0v7C1XLSPp5mJ3GKH/94odNmNa/0JbfUvtA5MmO1cY
         ehhP+vVRfGstPDYjt4e+yBNZ4TxeYm5A4twTbgKjBGZaqI1pe/kvz8iY3hqAmkavJ/tA
         MCxQ==
X-Gm-Message-State: AOAM532gD1vYcY8+0LyhflIPhbD1odUXnWn2TQmtHwOQ3nSt4Wa53Jzv
        svSBW1ir2WhGvviknNwVzQ==
X-Google-Smtp-Source: ABdhPJyZAeCAYfbgxeF+m2aVu/0mz1s0JaD5lb9g3nwPagtlQhkjqauUsh0bigiv0Uq4PjZuNCAi4Q==
X-Received: by 2002:a05:6e02:e08:: with SMTP id a8mr2187875ilk.171.1594681348293;
        Mon, 13 Jul 2020 16:02:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u62sm9154379ilc.87.2020.07.13.16.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:02:27 -0700 (PDT)
Received: (nullmailer pid 884711 invoked by uid 1000);
        Mon, 13 Jul 2020 23:02:26 -0000
Date:   Mon, 13 Jul 2020 17:02:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     clabbe@baylibre.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, wens@csie.org, mripard@kernel.org,
        georgii.staroselskii@emlid.com, huangshuosheng@allwinnertech.com,
        tiny.windzz@gmail.com, devicetree@vger.kernel.org,
        megous@megous.com, linux-arm-kernel@lists.infradead.org,
        liyong@allwinnertech.com, icenowy@aosc.io
Subject: Re: [PATCH v3 15/16] dt-bindings: arm: sunxi: Add Allwinner A100
 Perf1 Board bindings
Message-ID: <20200713230226.GA884639@bogus>
References: <20200708082719.5644-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708082719.5644-1-frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jul 2020 16:27:19 +0800, Frank Lee wrote:
> Document board compatible names for Allwinner A100 Perf1 Board.
> 
> Signed-off-by: Frank Lee <frank@allwinnertech.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
