Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDE6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E04E2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590695961;
	bh=23XujIOWisZQQB5FCRWNKW4npwdTKqcjIdlTXTRoGdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o0ifjL5Tyhefkj3VmnWcD7/reaVK/E1A6H23DOWOHFY7I60JRT5mqEx+JO9Tr/zun
	 7z18WM4SqjbA/ciGjjJbjf1eLoL+tRX73Xl/qhN2WS5wBz6b0Tf3/1dOZZMoWS85My
	 VWuFNSibDA21YfUeSYe0CC8ilazLyueEC8Bh2q7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406836AbgE1T7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:59:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35894 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406687AbgE1T7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:59:17 -0400
Received: by mail-io1-f67.google.com with SMTP id y18so11080910iow.3;
        Thu, 28 May 2020 12:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kknKsSMTJoI8gmLeG3qit6ojGRVqNCU1BTs8KXTSykU=;
        b=FS0yVBlzQXdD/u/2B3PUBMJN8XN/VgIfL+fCeS8o5asR6nzqPCc8dWYY4f5H+rdcmO
         EwhfgGKhzGkgUhvC6EZcx4976klx1/12zlEODKU3nyBJXUd1UntK5PvUBs5KAdsOI6pk
         ifNGMB/CNzW9wLdhKBQ2jWEgKqgytHyqk9j+CD0fycqbhueEr5KxD0hJ5xf00Z0g0Edu
         /Jrz6qZhx5yoCpN7PrRslu9UIfVLZa0KcTMqq3IXLdbvL3ksJO4WcNTK1N8dkacnt14C
         //S5jaI8M8CfFoi0mevp1qvOd7i6LZyY3rZPxCF4JretxKf/NrYZtkHeUVek5JUvUeoK
         0QMg==
X-Gm-Message-State: AOAM533SQxMXzejtWYBap7C0Q3i3ePF2lEiuQwwtDuQyC670l5svdwZN
        pFZAePc38uk8DaDaCDJWjA==
X-Google-Smtp-Source: ABdhPJxIPzW5HlNlbXXVKKRYIMx6e5UuSWAm/HfNNltKTsPfZADYYFbEPTL1adrf1g+L4+tiTXXJjw==
X-Received: by 2002:a6b:8b51:: with SMTP id n78mr3726080iod.120.1590695956580;
        Thu, 28 May 2020 12:59:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h28sm3829573ild.53.2020.05.28.12.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:59:16 -0700 (PDT)
Received: (nullmailer pid 583331 invoked by uid 1000);
        Thu, 28 May 2020 19:59:14 -0000
Date:   Thu, 28 May 2020 13:59:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/6] dt-bindings: display/bridge/nwl-dsi: Drop mux
 handling
Message-ID: <20200528195914.GB568887@bogus>
References: <cover.1589548223.git.agx@sigxcpu.org>
 <9884c56219e9bdbeec179c27ea2b734dbb5f1289.1589548223.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9884c56219e9bdbeec179c27ea2b734dbb5f1289.1589548223.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:12:12PM +0200, Guido Günther wrote:
> No need to encode the SoC specifics in the bridge driver. For the
> imx8mq we can use the mux-input-bridge.

You can't just change bindings like this. You'd still have to support 
the "old" way. But IMO, this way is the right way.

> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../devicetree/bindings/display/bridge/nwl-dsi.yaml         | 6 ------
>  1 file changed, 6 deletions(-)
