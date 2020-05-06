Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64B8C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8920B20747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588793797;
	bh=uAMQvip1+58/TgaaSbFxo+PJakeM582Z+rHAF7IZJf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=foTwdt3fiZ2ghD8xa2Mfw1vIw4DUc/MjwjjZbeJCOZ/ICF0r1zv3cBPSMvDIdBHbP
	 61qZystfzVjFgW954S1oTyby1Qr50xWv3JvhIQybQGaKr/sqJDi3EflTXkESW1xNcL
	 DUueuNbzvQIgHh/qwH00qUgx0Oj0NfXNRgpcLrzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEFTgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:36:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46284 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbgEFTgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:36:36 -0400
Received: by mail-oi1-f193.google.com with SMTP id c124so2620735oib.13;
        Wed, 06 May 2020 12:36:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnfpFrTk6qQXOr8sM3/2W6CmEzipxR2+8pAqFytyXqI=;
        b=pYMSbESToWSZRgzeGNHGjAWZbELb7qL3F9lB6ZzfFbpNN2bj1+u0ns5tN4xophy300
         8BN/dcaWq5Gzs8qkHtiim0xNbfjJN7nH/amAXl9yv8bNcobucSI4+Bi3bTzv2TPGy7me
         HHpZyxcJJfnC1jxufTxrooaoFmkGBRvEKVzlDPAnh4mCj5MWZUa87H5Op8M3+r1kIDvG
         FJ/t32QcwZd5+BEs+wzm8koAPtNCu3KAR/PR7BF/Ga+NJ8/Gxej0TbNCBpiSBE0rOHWh
         NsaOK075ZfDD80RyS9oEQRkvGYuzfditjNP9whMw77mnIoh2Ynp+YH6mXL9hYCYh584V
         T2tw==
X-Gm-Message-State: AGi0PuYTEWGXRo0UaqERlZcxD0ApmFWcEZzaWHCThRtjDyqClsXXE754
        60Ff0yOrzP7YDDyderc35Q==
X-Google-Smtp-Source: APiQypK/PKmOgedCZiIdqA69OthKkxGU0LMfRCwhmWEdBjKXwWsK4lkiQOyMamTfj38oAd46ZV0DbA==
X-Received: by 2002:aca:4541:: with SMTP id s62mr4017103oia.100.1588793795634;
        Wed, 06 May 2020 12:36:35 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s69sm770207otb.4.2020.05.06.12.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:36:34 -0700 (PDT)
Received: (nullmailer pid 21850 invoked by uid 1000);
        Wed, 06 May 2020 19:36:34 -0000
Date:   Wed, 6 May 2020 14:36:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, eajames@linux.ibm.com
Subject: Re: [PATCH v11 1/8] dt-bindings: soc: Add Aspeed XDMA Engine
Message-ID: <20200506193634.GA21647@bogus>
References: <1588697905-23444-1-git-send-email-eajames@linux.ibm.com>
 <1588697905-23444-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588697905-23444-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 May 2020 11:58:18 -0500, Eddie James wrote:
> Document the bindings for the Aspeed AST25XX and AST26XX XDMA engine.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  .../devicetree/bindings/soc/aspeed/xdma.yaml       | 103 +++++++++++++++++++++
>  MAINTAINERS                                        |   6 ++
>  2 files changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/xdma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
