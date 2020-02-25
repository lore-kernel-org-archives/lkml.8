Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D49DC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A0021927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654757;
	bh=TjmAFMon2BGDMooyYsbidRPBajR4JZkiXXFa8LGhUoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tdnFBEsMn9ZUQvq/IdwEKlEbw491To+KA/dAf9wAi2rnYJzT0wNnGiP/ItnKOEF6C
	 VAOZMHxVSP6IHp8y8DVycsJs87U8q8h75y0F5GjFbN65OXGyRE3ugRJMnwKntC6a6w
	 g5qHqpj4Nm9vXIOGH/3BoJg0MoE2MKPwoXfoWlgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731482AbgBYSTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:19:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44910 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:19:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so213837oia.11;
        Tue, 25 Feb 2020 10:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSNFodvA5lKumKKqhkZzGA6DFgZu/Be6kzIV2/+7uvI=;
        b=nIz9f7tdSxDlTZ3LbgaPeAJ1yf0oD+3kxtisbsGlTWzVTpkKrUrwfZyxAFeViLaBe5
         oSabcOL7rCIDdeshzHmb6lnSdvOrRwLeok9ozLMp3aBPcN7Aj4LEHc0SlRcuqG97ooAi
         3Z/v8wmoE2YzpL24N6Qy9jhPq2RkMYlDqu5c2Sm0Qz2S5VBNf49eC0f4TQb0hQd8AS7P
         hGrgByN3eSg6S2L2b45bZM8lr52XooB+hawoscAQjOp/g/tv4ML1yf5PGSz+WIX3yEIs
         2WGxWZXzyYz+aaI9griXRnK6IbBi77D1I8ETlGbI3alNNP/9+SAfKvSYnXG7TIa1mMsu
         B8dg==
X-Gm-Message-State: APjAAAW3iGjKe3xGNnxMnFj//o7XEhKcb/N3rwOmjeWlZYsf0v7F2Zb8
        zffOIvovTZYtZxvp7RwQXg==
X-Google-Smtp-Source: APXvYqylGxOIYQjx7oEtM4f5L4ZlqydvtMZMW3lXsVUQ+Cx55CgvSY6HFR33P45JatrRLi9lFN5i7w==
X-Received: by 2002:aca:d544:: with SMTP id m65mr158319oig.177.1582654754520;
        Tue, 25 Feb 2020 10:19:14 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y6sm5921513oti.44.2020.02.25.10.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:19:14 -0800 (PST)
Received: (nullmailer pid 7582 invoked by uid 1000);
        Tue, 25 Feb 2020 18:19:13 -0000
Date:   Tue, 25 Feb 2020 12:19:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org
Subject: Re: [PATCH 59/89] dt-bindings: display: vc4: pv: Add BCM2711 pixel
 valves
Message-ID: <20200225181913.GA7531@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <4a3c6e3cad10eeff93fafbc512c35b0c69dd1c68.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3c6e3cad10eeff93fafbc512c35b0c69dd1c68.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:07:01 +0100, Maxime Ripard wrote:
> The BCM2711 comes with other pixelvalves that have different requirements
> and capabilities. Let's document their compatible.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-pixelvalve0.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
