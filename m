Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60743207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590633675;
	bh=IinlJdzE8O7eobG9BiKYOC1gV0CEvgzGlxfyRhs7hao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=w+mys6WDd7K/8vEB93DlUIlYbNwu+SCwM8TceCtTjMvX8aWGBOAXJ5dq4TGy5mRZW
	 bNReSLWdGHWxzUbxFJbfkenrdm5uKxbseDT/8HJPwKRASild/+finEGWVEBwIujngt
	 3UrG50VMErvM037oWXWxjRqBkOCYQMbb+Qj2/V5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgE1ClO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:41:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34791 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1ClN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:41:13 -0400
Received: by mail-io1-f67.google.com with SMTP id f3so28428247ioj.1;
        Wed, 27 May 2020 19:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aJSvdBSUP8hCC8+rgsz4EB7YLn+fmauMUvtrBMNRvO0=;
        b=GaeHl0BcAvbEWtrGEiGCzqzxiFy3QvXT+9AYBiy7kkIN7AsOM2IDUovCG3Hqu9XQpT
         J5KSO3VVJhMnPjkG43twskPeAzHrWK6wTe8TWghXRHWpLAL5T3sOB0qlQq1M3QXnPCwH
         KoWlRVfYWjxP5IC3yZFbrfahL759FtY6Jpxnm2Bd+XKObKcvre6EwbfuZRQ9Cs+tDR6L
         FJ2axtZnm4JRaNzzFbFoFe1rYl0p/gnJgoyd36sRMsYJnBg4TxQXIaIX2wDgbYkwbfee
         UV8d1gUlWTM4+NzexE9mB94ZeOkzdCCtCv+u0lsaLlVC71ed+2dOXJ/feHhPrSey3pUp
         cLcg==
X-Gm-Message-State: AOAM533Z5dyZmfLCSJxKiaZO30ACaMx78pFmWX2IH3dyoaVWQUtYxRmx
        EltlNeTaOcTR6bXePGlIvA==
X-Google-Smtp-Source: ABdhPJwSqz8Y/sFww2/trT6sggJFiwuWfVKWn54mRv6JFqUdmLygooXIQDu0sxeliOzsjWUfS6ELdw==
X-Received: by 2002:a5d:9e51:: with SMTP id i17mr691242ioi.8.1590633672645;
        Wed, 27 May 2020 19:41:12 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u2sm1917979ion.50.2020.05.27.19.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 19:41:12 -0700 (PDT)
Received: (nullmailer pid 3259982 invoked by uid 1000);
        Thu, 28 May 2020 02:41:10 -0000
Date:   Wed, 27 May 2020 20:41:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <icenowy@aosc.io>, Luca Weiss <luca@z3ntu.xyz>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@googlegroups.com,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bhushan Shah <bshah@kde.org>, linux-kernel@vger.kernel.org,
        Martijn Braam <martijn@brixit.nl>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/5] dt-bindings: panel: Add binding for Xingbangda
 XBD599 panel
Message-ID: <20200528024110.GA3259935@bogus>
References: <20200513212451.1919013-1-megous@megous.com>
 <20200513212451.1919013-3-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513212451.1919013-3-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 23:24:48 +0200, Ondrej Jirman wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Xingbangda XBD599 is a 5.99" 720x1440 MIPI-DSI LCD panel. It is based on
> Sitronix ST7703 LCD controller.
> 
> Add its device tree binding.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../display/panel/sitronix,st7703.yaml        | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7703.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
