Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C130AC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E5D2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582755209;
	bh=77DYgHeZVhVX2ILtf2aQ/Hu/FiKPxj+mqYEd8Q8oPfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QIwJzNiWd8hAtqRlr4kGx+cROgtavfdOayhA499yr7j3irvs5TV5RIj2y+95GADBy
	 6YyuklAB2pRQBk5ULmXi4AbwBgjO+EzwuZIQJvGpz3XRdUxWRAK2JLPtbvYbT/oBoz
	 dMecSgAzSHIA9yAj7+qatIffW72CJmdiV3SkM+Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgBZWN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:13:28 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39071 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbgBZWN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:13:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so1005415oty.6;
        Wed, 26 Feb 2020 14:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VADzarmrxahCNR8FX+Jii1uaWPHIPd0BL4EYC9qsa5g=;
        b=uhckIdmUzIyw7CVjvy3KDxYz2Qr30DCBHCHUfEe01Oz6Ejuiy8Tj3x/QiLhbp96E7n
         6KkNmPsnwxwBrjYxo9QvLSSD+ig2IddnNDMKzuevf9JZLfxKk8DE55cVFUVJnDypDV69
         ZnR6hh/X0x5GyEim/MMpxfWgVhOMykv71ecd0NopDEdvnLX2Zg5hi4InkjhQG5fApefJ
         8T6jKLyRPNkt/JLDQEF63R07t/mUT9FtC0JqD/JqXnxMPbVVcUp0UeDRT4XF6T1JX3Fr
         N+22caQibtZI+BTM2ROmGph2SZZx8PEbXQSi+wRQ04PCCaJghqDkLwb++lBNwTieKwzC
         xELQ==
X-Gm-Message-State: APjAAAVNgxonM+oAjNiPnqEyKqZRMZyMYMWhEEkb9erjY4oDlaZ/Er0U
        RPTbH2fYzgXzeLQmslVIiQ==
X-Google-Smtp-Source: APXvYqyVYmNd9TzqdRK69Cf9KTihwGV0Co1KZ2Djifo2WvE+upUX9u8H7iL2I4n/LK1KC0WI9bHjwg==
X-Received: by 2002:a9d:2264:: with SMTP id o91mr802190ota.328.1582755207398;
        Wed, 26 Feb 2020 14:13:27 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w20sm1226848otj.21.2020.02.26.14.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:13:26 -0800 (PST)
Received: (nullmailer pid 26464 invoked by uid 1000);
        Wed, 26 Feb 2020 22:13:25 -0000
Date:   Wed, 26 Feb 2020 16:13:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert UniPhier
 AIDET to json-schema
Message-ID: <20200226221325.GA19817@bogus>
References: <20200222110435.18772-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222110435.18772-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 08:04:35PM +0900, Masahiro Yamada wrote:
> Convert the UniPhier AIDET (ARM Interrupt Detector) binding to DT
> schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Some qeustions:
> 
> I was wondering when 'additionalProperties: false' should be added.
> 
> If I add it to a bus controller device (e.g. I2C),
> I see some schema warnings because various sub-nodes
> are added depending on which device you connect.
> 
> On the other hand, the interrupt controller like this
> does not have a subnode.
> So, probably this is the case where we can add
> 'additionalProperties: false'.
> 
> Is this correct?

Yes.

The problem with 'additionalProperties: false' is it doesn't include 
what any $ref includes. There's a json-schema fix for this coming with 
'unevaluatedProperties', but the json-schema python lib we use doesn't 
yet support that.

> 
> One more thing.
> 
> There are multiple ways to do a similar thing:
> 
>    compatible:
>      enum:
>         - socionext,uniphier-ld4-aidet
>         - socionext,uniphier-pro4-aidet
>         ...
> vs
> 
>    compatible:
>      oneOf:
>         - const: socionext,uniphier-ld4-aidet
>         - const: socionext,uniphier-pro4-aidet
>         ...
> 
> I adopted the former because I can save 'const'.
> If there is a preferred way, I will follow it.

I prefer the former.

> 
> END
> 
> ---
> 
> Changes in v2:
>   - fix the schema warning in the example
> 
>  .../socionext,uniphier-aidet.txt              | 32 ----------
>  .../socionext,uniphier-aidet.yaml             | 61 +++++++++++++++++++
>  2 files changed, 61 insertions(+), 32 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml

It all looks fine, so I'll drop the questions and apply.

Rob
