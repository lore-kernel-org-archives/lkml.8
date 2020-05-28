Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6D1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0722084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590629864;
	bh=kJtP+7Irq4CmN81f4Wnz0MAfkfOnlRY0LJtOZ2B99eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uu5FE6YocOiSIZ9ZTVuVZXzAKvDveNwrryM5qa4J5lKQtHETynr+kemtUu37E/Ju6
	 aAgZG9ANECpD5G4tg6VuWmnrtXdX/X9frQb5K3jZy2J+WW95lHSPTk3X4iCNxNKlH4
	 yssClXBRFRQ8q2zgwpMl6FTVBluxF1x1oI+QQmqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgE1Bhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:37:43 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34902 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE1Bhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:37:43 -0400
Received: by mail-io1-f67.google.com with SMTP id s18so14314314ioe.2;
        Wed, 27 May 2020 18:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nbx5PheTegOHEEr/4nd2amubzWo0SUuwMck94zzOXno=;
        b=a+3UM0baI2Xq+V5W/OamNlccaOq9aPipXutXBuxQJwajdivNgqzAiGKxJtAqZjdBKk
         8yyfaLfTshmBBpUgu2fht5SPNBeA0pEufYuhNC7w3QSPPdyLGJ1eng/49yq56o+kn6F4
         ZRVIXoIOZk2H74eZOjN/7MeV2rL29sT2O8Ql6ouWbpzNgeu2L9kGkimNSCthXvycS36H
         3v0wW6q5tZ7owO23Av+0Sj5cncHR5pvGrZyAqYhLFRuMbdx2f+CKWXpF9MOXwy70C833
         NLWBl3FSgJ6k+t44FEDD8GWg/nrbBPILba7muj3jmIvPotBHtYEXH1ptC3zZ5cU5UQk+
         6NuQ==
X-Gm-Message-State: AOAM5322kMDj+PGe37DZlID6Hgnofv6VqTWYqxVSHtQrbh+AbT2bF6WJ
        p8Ly8iwbzpLD1BRn7WxhZA==
X-Google-Smtp-Source: ABdhPJyw9o9EnKs0HcIDKMaQ4TcrHd2XeHo+9zjE0fdpnilS5FbjfGLGSCLKvxuGkF3aQHm53AYG2g==
X-Received: by 2002:a02:3705:: with SMTP id r5mr648818jar.29.1590629861926;
        Wed, 27 May 2020 18:37:41 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n17sm2046869ili.1.2020.05.27.18.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:37:41 -0700 (PDT)
Received: (nullmailer pid 3175224 invoked by uid 1000);
        Thu, 28 May 2020 01:37:40 -0000
Date:   Wed, 27 May 2020 19:37:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/3] dt-bindings: display: bridge: Add documentation for
 LT9611
Message-ID: <20200528013739.GA3174723@bogus>
References: <20200513100533.42996-1-vkoul@kernel.org>
 <20200513100533.42996-3-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513100533.42996-3-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 15:35:32 +0530, Vinod Koul wrote:
> Lontium LT9611 is a DSI to HDMI bridge which supports 2 DSI ports
> and I2S port as input and one HDMI port as output
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../display/bridge/lontium,lt9611.yaml        | 178 ++++++++++++++++++
>  1 file changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9611.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
