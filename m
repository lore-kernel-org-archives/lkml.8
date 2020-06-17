Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB1EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29122083B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592432575;
	bh=TOUdlwiuSWOEfadPXcx+Kwk5gfa8Nks7tFZharF2H8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dleegoK0EJ+p/Z38dImMkjlqz7g0zAgPIVJWPXElg9qrMUua3kCdQS/8RLOTzovP5
	 w48AkgJo65Yz5bCgC4UdBxLuf19e+3EWNUEQoEAs1mp77d6iW+kNLShAUm2cc88xWz
	 GgxLiFgiYFkP0r/KewBtKgyKNz+aEMWrN/t70lCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgFQWWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:22:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36200 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgFQWWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:22:53 -0400
Received: by mail-io1-f66.google.com with SMTP id r77so4845765ior.3;
        Wed, 17 Jun 2020 15:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cZs4DMmV9+4KYcd4h6vQwLKgeDMHogArG6hcyQ007uM=;
        b=gVpbsZdEhDysjWmMMcZ4tiUNZtAM3zl10CcYwhLlqY5hGMcf2B6+s0hGcjlelrYQCZ
         YO8jpRlpvN5ABhgYIW0AUo4rhIT6wqSxZYKPXUrcpUbBXDCZIeVjM7Umw9LsYkujXRu+
         4R/SzzQ7Dvd5MP5smw8JbwOywzng5X7EAhJVV6Jb61Ojsv//cGMdPHjAJZ5+DKihlQtH
         ukV8h3eM/PdZD/GORy7dCUmFpmzQAuSQsa+2bLG4BNEa35q9bqb98jCNXyXR7ztC70pW
         HXzDT/5HisCyfdLT9o+N25AQfpRGnFbgpyVZdMGfC2yEFAdg7pWykaW/5zX3aTrFTft0
         X19A==
X-Gm-Message-State: AOAM530Vw36zdgWdGqHhW7pb8tQ+X1NylqBkMXSKgo182Rtelffe8BIx
        i7cf7hAIbceK4fnWQ+eTEg==
X-Google-Smtp-Source: ABdhPJwVLzRisP+uIxnL1NbxlXTfqVaPm1HmkXIu0ChWO56rldgx6wkKleV2KmMwEts15aMvaS5Bcw==
X-Received: by 2002:a6b:8d44:: with SMTP id p65mr1805887iod.24.1592432571789;
        Wed, 17 Jun 2020 15:22:51 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p25sm630019iog.47.2020.06.17.15.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:22:51 -0700 (PDT)
Received: (nullmailer pid 2941342 invoked by uid 1000);
        Wed, 17 Jun 2020 22:22:48 -0000
Date:   Wed, 17 Jun 2020 16:22:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        ludovic.desroches@microchip.com, maz@kernel.org,
        jason@lakedaemon.net, nicolas.ferre@microchip.com,
        linux-rtc@vger.kernel.org, tglx@linutronix.de,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: rtc: add microchip,sam9x60-rtt
Message-ID: <20200617222248.GA2941290@bogus>
References: <1591779936-18577-1-git-send-email-claudiu.beznea@microchip.com>
 <1591779936-18577-3-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591779936-18577-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 12:05:35 +0300, Claudiu Beznea wrote:
> Add microchip,sam9x60-rtt to compatible list.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/rtc/atmel,at91sam9-rtc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
