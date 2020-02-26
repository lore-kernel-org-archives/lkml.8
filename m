Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE17C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B2221D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582753310;
	bh=znesykQCMfOmSvul5VL4BFR4DGE42T2PfE3cNxDa1jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pUHJnHBG+7hERNRje0Zb7iVh6CFbyFHamvLgqLDvJfNySdekvLbk7VoI307Cd19hi
	 s/iub2x9pAVJHL9vcRoY1OIv2t/MzA3SfM1N9WKbolriDjggNfeqgf0CA7lab7awXx
	 rm6gm8QhIAsG0+Cxga5w6NOPK0aE0a1JxFGP7q7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgBZVlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:41:49 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43644 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbgBZVlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:41:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so1081365oif.10;
        Wed, 26 Feb 2020 13:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=byAUrcii8a0AWXrs5vwsBsgaE4yUvZlmDVkZ5AzS35g=;
        b=M9EqgLI00VTLWu8mGrGqxWNBXT9dyB2Uio7sAAp03z03RBhRK7YzqJX+mrfNoX278V
         pe3i5lBlqDkKYTu0Xcupqvg0G1bQkUOIyqcNzXGo4QFTRQ4u3HhZYs2tiCOwQzqopuxJ
         ZC/Xlf3/2u0oCsiQNLkGKTxzjuPit5cTlENH/tfKBtzziAEDoC4x/irAgQ1oQqSt418B
         60GV9uO1OsX+Yv0OPWAdMwKOyuAwga1oOy5KExqW76n9wFGvdOi2VFZrby03bezaTJZC
         tDjiiiNQL9LcT1QzEN/EUPh5mOTy3C8LFfQGHgnWw+d+N5jdDCAX+l4fuGedPrs4WjOw
         PpPQ==
X-Gm-Message-State: APjAAAUdxsls3XTK4UcGYKA+89wu/rTggI0gfkigZktn9EEyYEiDQ3PB
        R8xossjGrx0T16oYffdndQ==
X-Google-Smtp-Source: APXvYqxncRleU9XUmrQhPNUgmsgZz/wkWA+ajBRa/ZE/p/Nu2nfYhoCyBE4+zxhuQIdH65UenErb0A==
X-Received: by 2002:a54:408f:: with SMTP id i15mr862375oii.64.1582753308418;
        Wed, 26 Feb 2020 13:41:48 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g25sm1213381otr.8.2020.02.26.13.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:41:47 -0800 (PST)
Received: (nullmailer pid 9586 invoked by uid 1000);
        Wed, 26 Feb 2020 21:41:46 -0000
Date:   Wed, 26 Feb 2020 15:41:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: Convert UniPhier board/SoC
 bindings to json-schema
Message-ID: <20200226214146.GA9521@bogus>
References: <20200222060435.971-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222060435.971-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 15:04:33 +0900, Masahiro Yamada wrote:
> Convert the Socionext UniPhier board/SoC binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>   - Remove 'examples' because examples are fold into /example-0 node
>     and there is no way to meet
>       $nodename:
>          const: '/'
> 
>  .../bindings/arm/socionext/uniphier.txt       | 47 --------------
>  .../bindings/arm/socionext/uniphier.yaml      | 61 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 62 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
