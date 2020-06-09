Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CDCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8939820737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591734702;
	bh=ZTFt6agJWvmtnPNCEyCUjjcDXXDNqQYSXTCnGm+IrUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ct8Ez6Lvvj/HLne+JMe94M7jONA2ODY6YHYY9jy36cqbX/sWBOho+aCMLr8AO6pGH
	 qtkyFk6w+mHKPeku7uKxlOvDtUwgBbzcPFW/K+tG17aPjEkEOgvViTnN6iJo6ocyHt
	 VTqyV/2Z4ujXp6n5KI69qWZZqjZCig5i1gEZZYQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbgFIUbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:31:35 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40012 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731078AbgFIUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:31:32 -0400
Received: by mail-il1-f196.google.com with SMTP id t8so21667435ilm.7;
        Tue, 09 Jun 2020 13:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xpHxwxJyEi+QmAQh0g22EZ0JVBelN+B/lL6QJi2kkls=;
        b=c3QU7h7TbdpJlD0HWArcBA5XGDfNXaR5qy1/dfxvAcmFejTu0QmEcqhigfOfA3D9MZ
         2mdzGPdlJIDze4YifP8zY8TUFzO0daf908cVMb9CiLKMhYcNnZr+yAhY97hN3gl6JWc/
         4v4lxH4ZockqJPDvpCKvBKm7bvZ8Ob1S+RC1QZ6XWxDrr+3pRxPKFdYAXxsr/O1Qpk3w
         1Gag18AqleXdfFh4tI9ckKJdyviZL1l46VtSluRUSCUYDnef2IoD07mGwqJqZWIxExC5
         iOulSE4oi4O+oMaUxtGJHTt57/8rJBf2cSLgGcT8mVJ00ipjUn0IXDp3d7ZQvvFv0yYU
         oz2A==
X-Gm-Message-State: AOAM533mFeDNZse8STW4MYONqo3KCa/rYqAz8ImEKBI01CmceyLsnFPN
        RNnLdJUzaokuvktMbvqi9W25B7s=
X-Google-Smtp-Source: ABdhPJyDdn+hAQ2PPSVGXZ5rLVbU0/5fzDWB5qz782naSnxuAHkG5eN2ZKhBcbafUZj+J+E2dFQVRg==
X-Received: by 2002:a92:489b:: with SMTP id j27mr28987060ilg.295.1591734690074;
        Tue, 09 Jun 2020 13:31:30 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r1sm9823178iln.77.2020.06.09.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:31:29 -0700 (PDT)
Received: (nullmailer pid 1404522 invoked by uid 1000);
        Tue, 09 Jun 2020 20:31:28 -0000
Date:   Tue, 9 Jun 2020 14:31:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, kamel.bouhara@bootlin.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 1/9] dt-bindings: atmel-tcb: convert bindings to
 json-schema
Message-ID: <20200609203128.GA1404472@bogus>
References: <20200529232749.299627-1-alexandre.belloni@bootlin.com>
 <20200529232749.299627-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529232749.299627-2-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 01:27:41 +0200, Alexandre Belloni wrote:
> Convert Atmel Timer Counter Blocks bindings to DT schema format using
> json-schema.
> 
> Also move it out of mfd as it is not and has never been related to mfd.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Changes in v4:
>  - use oneOf to describe possible clock-names list
> 
>  .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 --------
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 131 ++++++++++++++++++
>  2 files changed, 131 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
