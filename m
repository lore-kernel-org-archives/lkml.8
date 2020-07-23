Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFA6C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF09920768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595539832;
	bh=aYeCzwzW9/htP78CK7AzU3isFmfSOaPwRaSW6TwmK9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sVQAGD5wBNQRZqAS0hXC0+ihBICWjXAFDR3Heds3GyIYlMIt8XCY3DxGyYMBIQRVu
	 mR0FxCVWrb0UPb9EcnXsenj9UhLL+neGoK0CNvwvfmAU4zfJm/cdP+iXE+MCtYBQqT
	 FqY/9Ig1BM0GZYXucoxUUP5Is5FEXXTRgtkIe1jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgGWVab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:30:31 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45777 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGWVab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:30:31 -0400
Received: by mail-il1-f193.google.com with SMTP id b18so405681ilo.12;
        Thu, 23 Jul 2020 14:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JzZ0nBZzhB8jMlslgVQmPmCdOkAHjYRRqrjNvqdfKKE=;
        b=c2oaQlnPUSfdZ99zImdZnXdWuRKasVW0bdXfciIgXBZHQHR93EKQoMlMi+RvLniy3t
         IbeeZP+hBOu4Kd6/a4/RULcV3o+oIsgrfSi0yF3xbf42O1cil+DRknubl94x9XIYqogB
         A7ukJ9LShTDz3fByk7OjxCbBwJEGkFqyIsp/2CxdwPxDTdz+IDljBIV10YabSH/kvfvg
         XKeAwlkIxLcQvnsp7db/tdt2MRaJxCwDV/GAr9KUHnnbrmOhq2DsTf8Ll24C690JnT77
         V/p5oRJZIQAietmWmMfGZve9djzCxdeceQyoFa6V1Cm5MZHmyT3vEHqIc2/iw/GQP3TM
         Ugyg==
X-Gm-Message-State: AOAM530c7LS3ae1LTGhEGl7i0hB7fxgRmsElDgbvouvYNrfikQeADavX
        jZHsmSjVEO1/RarF+U/8Dtb7D+1s2g==
X-Google-Smtp-Source: ABdhPJybyfd5TV9Tvuj9mjuLraHscose5g52+l1W3fANVfhqj4I1xye7ZnvdT4mjM82F6Q8IhmImqw==
X-Received: by 2002:a92:290a:: with SMTP id l10mr7354583ilg.204.1595539830440;
        Thu, 23 Jul 2020 14:30:30 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n7sm2033803iob.44.2020.07.23.14.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:30:29 -0700 (PDT)
Received: (nullmailer pid 892710 invoked by uid 1000);
        Thu, 23 Jul 2020 21:30:27 -0000
Date:   Thu, 23 Jul 2020 15:30:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-rockchip@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core
 EDIMM2.2 Starter Kit
Message-ID: <20200723213027.GA892680@bogus>
References: <20200723123951.149497-1-jagan@amarulasolutions.com>
 <20200723123951.149497-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723123951.149497-2-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 18:09:45 +0530, Jagan Teki wrote:
> PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> 
> EDIMM2.2 Starter Kit is an EDIMM 2.2 Form Factor Capacitive
> Evaluation Board from Engicam.
> 
> PX30.Core needs to mount on top of this Evaluation board for
> creating complete PX30.Core EDIMM2.2 Starter Kit.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
