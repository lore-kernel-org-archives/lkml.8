Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA08C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0232206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591309447;
	bh=TDOL76JWf1f6r/ZxeYlblYP7A4HnYRE4P8DKoRVJg6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1GrHx8I1pcKuvw1LV7aGUs1e9dYJAKhFLqnk23jYXVujc0MAV2Kxz40mwKEB2ltvV
	 G/MKCCuOdMTubgJmxRBGv+aEeq0hNTp+JastGZhwhNSwibiKm1MVyqL1TcmqjBpqS8
	 X40Y/DLgMLlDziVKRIla39AopgVuy3HZ7F8ciR18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFDWYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:24:07 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36284 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgFDWYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:24:06 -0400
Received: by mail-il1-f194.google.com with SMTP id a13so7698061ilh.3;
        Thu, 04 Jun 2020 15:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9twZbcOiLW0yLQJYmRVs4qavY+XNMKpL9WdtifUyAH0=;
        b=TgdDvg0VrcfpXjBomNyWCWb1ONF6TzjqCI0Ws8m6eOmOIAk//kt/DQxOcopsv3UL/5
         P18spWE5Rc0WrAeZHJvo8Y4UMwWTaSdpLLtzwe7KupCOE5rWJtw0JftZd5qKXMkLUdlJ
         tZmZYW6Ig/0wl557FVzv4w4YTsBgsxKoM/M4L7lsrXfxR9kG5DW8/ogm9t+i6LWlKQgN
         /O3dimuXx0DyhuYUshJ6ZtXTAQrLESxBdUYOTMr+U0HYslCbGdIrgo/SneKLiiOnGEFN
         zH1lm3RB+xJgnRn6L0l82k24BK+/0IyWOC6a1v1vBWRQD8LBrezLAfBrdqUf4F2NKI51
         3QFQ==
X-Gm-Message-State: AOAM533n2rBTilxdEM4PtuZe+2CbsUEjuDkfaMNFa/LUMEg94Ncmz/ky
        6OA5RDvlJuJ7lKWH4iHtrw==
X-Google-Smtp-Source: ABdhPJw4Iafe1pMJfz84rEJOIVETUZQAgI9tRhEJzB4YXRVgrQvOWSYePNiqSlZkykkFuA1ew6Sl1w==
X-Received: by 2002:a92:b001:: with SMTP id x1mr5480753ilh.18.1591309445557;
        Thu, 04 Jun 2020 15:24:05 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p5sm2004317ilg.88.2020.06.04.15.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 15:24:04 -0700 (PDT)
Received: (nullmailer pid 4153174 invoked by uid 1000);
        Thu, 04 Jun 2020 22:24:02 -0000
Date:   Thu, 4 Jun 2020 16:24:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sheng Pan <span@analogixsemi.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v12 1/2] dt-bindings: drm/bridge: anx7625: MIPI to DP
 transmitter DT schema
Message-ID: <20200604222402.GA4153046@bogus>
References: <cover.1591253353.git.xji@analogixsemi.com>
 <eb82c52574bf41b5edad488e14c27cabad39b922.1591253353.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb82c52574bf41b5edad488e14c27cabad39b922.1591253353.git.xji@analogixsemi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jun 2020 15:56:36 +0800, Xin Ji wrote:
> anx7625: MIPI to DP transmitter DT schema
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml  | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

