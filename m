Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800A1C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517572176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654737;
	bh=5aAgZWUNV+NXj0M0iD9EkcX4Cz3sEx5/dL/QWrK/Mic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j5HRk+gc0uGhUo4E/UtcgqZQa9dWr2D6isi/qoWl+Tdo9tl2mXa0QSlOy1viGqquc
	 +cAAu9O1Nuq1rntR3X08c/b+iRxKbWlXkbqIcxlgvokAIAARY9YKZ/To1ZMBjtNtbZ
	 zwhJMwsRSKOz2dxN9vlXmMDTKuzc9EDlavfffwRo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgBYSS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:18:56 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35264 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:18:55 -0500
Received: by mail-ot1-f66.google.com with SMTP id r16so447453otd.2;
        Tue, 25 Feb 2020 10:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RPJpzQ7qVLMRwYfQxH0mQ4XcwC515bx4Mj+WIiFTEM8=;
        b=iCyW3wCJgcyI5wi3AYzLlcOUOQt89ofwnd2f1Up9EqZ0aD3Ljv8/DGivC0OgjmcBDS
         429z6hDXz+XRwizdJzIuG8iiKYWB8pX3fFls0XB5+Q29urrTVCW+iH/3hDyVQQyjbpWp
         bAZrwHiPDfyHX5cU0NXH7cbgRkUnlHRcJ376X5wBqjmcSZ/m69+Xe8FvyH3njOlQDO0A
         tminIgNiVprratwMoS5aoRH6J4SDHI77tFFiQf0m4/3zdJF5AFSfTAp/Qne8ILJra075
         veUMoHJOxmgwYojxx7nENKHalbUbDfTlg8z728DsHNpTLtmVdpi9EQIb9xR4nOiCkziI
         jq5A==
X-Gm-Message-State: APjAAAXwYrjDm4tBbu9mO95CuEEPSyqR/hBNh4QNowS6BYJkphE3QOfq
        rCbU+1HLllcUAUoOfAoRPw==
X-Google-Smtp-Source: APXvYqwEScy4jWFHUW9DGv/Sg6SXMs0ZEWy29yqmpSnpIXZifq4TCxqdxvNoIQACN+DtxZDdqznkKA==
X-Received: by 2002:a9d:784b:: with SMTP id c11mr43420213otm.246.1582654734973;
        Tue, 25 Feb 2020 10:18:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 9sm5897437otx.75.2020.02.25.10.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:18:54 -0800 (PST)
Received: (nullmailer pid 7004 invoked by uid 1000);
        Tue, 25 Feb 2020 18:18:53 -0000
Date:   Tue, 25 Feb 2020 12:18:53 -0600
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
Subject: Re: [PATCH 33/89] dt-bindings: display: vc4: Document BCM2711 VC5
Message-ID: <20200225181853.GA6954@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <d8df122abf3875d9924a20996673bea49174dbb1.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8df122abf3875d9924a20996673bea49174dbb1.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:06:35 +0100, Maxime Ripard wrote:
> The BCM2711 comes with a new VideoCore. Add a compatible for it.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-vc4.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
