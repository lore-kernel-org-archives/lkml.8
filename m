Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB79C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3615E2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579119402;
	bh=e+lLd2ouarqgvj3XyOeY7c4JM/uuzjYlHWn1R3xKEjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i+g91dV9QAhkiqFOD9HbR7l4odwHxBQLheVOZdQi25akMstmRHOALBKAVRyUze0Zf
	 lLRjkWlxihQTdohiCP/ms0wEihGnfdhCokYBghdKaEKh6mUI1nFWbqsVtUFhbQns69
	 rJbgOCtZI40JDBdOb3Z+btbKaRVR7kiHCIRIhIZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAOUQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:16:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40537 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgAOUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:16:40 -0500
Received: by mail-oi1-f193.google.com with SMTP id c77so16684399oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 12:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=1BVQS3/CT2AwFowBzdJp24DkQzhe3BERjAeXkX0Uz7k=;
        b=YjugY8w5qtO2cS4OnYWm0tT5h0EMUJFo5iM20PXNR3ra96uYHHPOOfLf8QMSGUmS+9
         4wQQWorzdj0O/5Jk+tGGmD1r1GIBX4009/+CYKmOCfpXq+9MLWlxyVG7irxJvR1qdd3U
         hU+xfbagZHGUVTgXw4FtYQRe7ZsShTjy0rG/mcR+bTdqQFPF3HyZjpKZhhT6QFORLQUE
         KCI2CYDKgtojBitwJva9JxOLyolsuET5xt4vXhYRaPDewFO/OJp6RG2K82JmwnX1lb2P
         EmL8zZPsmKjpToaAJH4urDMJKP09hGJSLQDEBUZPTug20yycTqXjwM4iSG9NtU2An2qB
         23FA==
X-Gm-Message-State: APjAAAW4RrsqmMrRJZIFMt0WnOSVkq/tgktyH37SaRmasbT961Cn5r8o
        x8mJyQuZVj0cNeid+BW+uYCWEvw=
X-Google-Smtp-Source: APXvYqxVrfkfk2NxWhdfx54KxDPrSVoQWKVRhhppgkQvS65DICVdPN80vHdMzxlLb3jZm13sv6EyxA==
X-Received: by 2002:aca:2419:: with SMTP id n25mr1327184oic.13.1579119399739;
        Wed, 15 Jan 2020 12:16:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g19sm6911928otj.1.2020.01.15.12.16.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 12:16:38 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 14:16:37 -0600
Date:   Wed, 15 Jan 2020 14:16:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        sashal@kernel.org, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>, ray.jui@broadcom.com,
        wangglei@gmail.com
Subject: Re: [PATCH v9 1/2] dt-bindings: edac: arm-dmc520.txt
Message-ID: <20200115201637.GA25883@bogus>
References: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbf026a-4878-cd65-55f7-7d992782b331@gmail.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 06:32:27 -0800, Shiping Ji wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>      Changes in v9:
>          - Replaced the vendor specific interrupt-config property with interrupt-names
> 
> ---
>  .../devicetree/bindings/edac/arm-dmc520.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/arm-dmc520.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
