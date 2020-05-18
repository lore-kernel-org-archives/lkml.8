Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F486C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67C020715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589841407;
	bh=UDtiReFY25s+f23VlmoZ6pnQHEcJoADgtqNLzJ6WKr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IuJq8Qt5nX5TMROdwwSGrnLABW+uFJiOMe3Ylvk002cdK3tEKBE2ticTX3fnSoIlo
	 riUu5H5jt9PwaUBkZvuEHIeAIBUo3DNXWyzvJphrElOGgBND26i/L11ROK5cgaC9qc
	 isjMIwFN0eE2oVYPGDMdpS6owp1COCLdNMJKywKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgERWgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:36:47 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45702 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbgERWgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:36:46 -0400
Received: by mail-il1-f196.google.com with SMTP id b15so11512543ilq.12;
        Mon, 18 May 2020 15:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDHijTmy+IOAetUHiwAUcflxm9U9CcYAXapEIE7xXd0=;
        b=FiAChHXI8kgtqgLRlbKTwvm76orL+nMD3DVsrRxRrDuzJE1ab37cNL03CBzd60wdWT
         zK/YC8Uao8Os/rLk/VvYa+82T+OkTIc6l94yOxWpAsg10UQ6AS9jZ0wOI1/Id01Tl3jb
         7LGYXSO7kkf/+UTP6EaYc1uLZXiHc+esG3D7Q0CCF+pWPnaCB0u7+3aiJ518i1uouLAJ
         2uNs9TnLDqIBMGXCe6+dGASS7NiHnmQeVF3TP+X/KtNFjzVOdRYSK8phs/L7r5sElWl0
         /e6jmii3Xnk4xL0I7NhuSG1t/pUeeOLv+ILLvZNVDteWKkVOnQb9/4X9LqkgQ5diQuMx
         hpeA==
X-Gm-Message-State: AOAM532UONrv4unyCjvh59l1fn5qWmidUFwHVFPCyR1kxj1CJMYGbrQR
        goMz33fjSzI2qKnhw0rc/w==
X-Google-Smtp-Source: ABdhPJyfB//q3n3N5C4f18+VIRekJCumkD01M8aTVQWfd0ekd3pS2p2Qu/LenJQcXvB2ZvLMqPEexw==
X-Received: by 2002:a92:afcd:: with SMTP id v74mr18237211ill.305.1589841404926;
        Mon, 18 May 2020 15:36:44 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c26sm4336676iod.16.2020.05.18.15.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:36:44 -0700 (PDT)
Received: (nullmailer pid 4555 invoked by uid 1000);
        Mon, 18 May 2020 22:36:41 -0000
Date:   Mon, 18 May 2020 16:36:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     nikitos.tr@gmail.com
Cc:     dmurphy@ti.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, pavel@ucw.cz,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/3] dt-bindings: leds: Add binding for aw2013
Message-ID: <20200518223641.GA4338@bogus>
References: <20200511111128.16210-1-nikitos.tr@gmail.com>
 <20200511111128.16210-2-nikitos.tr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511111128.16210-2-nikitos.tr@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 16:11:27 +0500,  wrote:
> From: Nikita Travkin <nikitos.tr@gmail.com>
> 
> Add YAML devicetree binding for AWINIC AW2013 3-channel led driver
> 
> Signed-off-by: Nikita Travkin <nikitos.tr@gmail.com>
> ---
>  .../devicetree/bindings/leds/leds-aw2013.yaml | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-aw2013.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
