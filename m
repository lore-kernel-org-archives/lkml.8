Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD54C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4016F20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595525554;
	bh=/SsUMjF5DYDiERnMvKAQfDrpzKcuVZUN3jKHmDT1jjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OzXmKTNVkA5x6AfFGKu4dj+Mu924LPx0wP3ZOZcJMwwWpc3ntXZm7GSbfTOVh1Aav
	 z7Buuwe4pa2NTVYyJUDQM3v+4bH8SqGVYN9mYwJeE+ByFgZYRbZeTziR0cR2cuW7BK
	 e2SrTs1GXHNn3CSWUPY/mnydD+OOE5h4BShO7r44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgGWRcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:32:33 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:39194 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGWRcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:32:32 -0400
Received: by mail-il1-f193.google.com with SMTP id k6so5017187ili.6;
        Thu, 23 Jul 2020 10:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6flyhC4ycfiZJcGIIv1sGGK8Z2R9l9tVntRkY9zO51c=;
        b=Hbg1CP0gCK6Hw9VygsGJNfowrSnzrtM/8coYthchAYvtyTneCyssKuTpZIpgAGnQqk
         ZOmp5easlMVF8ciLHMJBrWjLn7qdf8XEI0bgwfnRSq5IU9vCfYlzKPWJMM/F12xzUMY+
         T8uvjGNTmLst/03tW2lmBDHMSFHvN94HiBV8tiNDiI7lmgPXT6LeQITZNR0AKy2JH7G/
         jxezFTgK2c6UQGEp0ramZabSWMo8Z2hqqk1n8m2uWZmrjoT1gYuAQrVSPJiNroEsGEmt
         TkEgYLElzZ/ZKbDsX/xuPDOEpy6w5iffo8CtXdbW4D391o7qdpTjRzmkYmGfFSLWS7Su
         X7rg==
X-Gm-Message-State: AOAM5307qASqxkmH36tdJbUKs2gARf8AJ98yzmOCvXg2kCZhMZWndL3O
        WYNWrIwZeJN+gNfFnFxCqGMCaCkatg==
X-Google-Smtp-Source: ABdhPJynOYkAzsitaDa24xfZd7L2XOvkozCFT9pk4AwwE6EFaSNOryw3lOL18JE32MV1qyGXXkHFSg==
X-Received: by 2002:a92:8451:: with SMTP id l78mr6054828ild.234.1595525551966;
        Thu, 23 Jul 2020 10:32:31 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w15sm1854130ila.65.2020.07.23.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:32:31 -0700 (PDT)
Received: (nullmailer pid 575965 invoked by uid 1000);
        Thu, 23 Jul 2020 17:32:29 -0000
Date:   Thu, 23 Jul 2020 11:32:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sasi Kumar <sasi.kumar@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: usb: bdc: Update compatible strings
Message-ID: <20200723173229.GA575916@bogus>
References: <20200722170746.5222-1-alcooperx@gmail.com>
 <20200722170746.5222-2-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722170746.5222-2-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 13:07:40 -0400, Al Cooper wrote:
> Remove "brcm,bdc-v0.16" because it was never used on any system.
> Add "brcm,bdc-udc-v2" which exists for any STB system with BDC.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/brcm,bdc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
