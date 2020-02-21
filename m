Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCC7C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7AB220679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582298752;
	bh=Nen23GVdyYonBOzTvdXanZARdnRmJrFrVMnIXLsidWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q8U66e9pAzPTX73E0Pfs8myNwOp9b6guAXx7y6FiWZ5WjSzmpbWdmJ4Ts5Wd3RMro
	 ojL/0wSTa9y4bzMxsZ6Yn/TZtm1W8Tlo8Yiq/WPOuUfwdbeTf4F9oje3VG5/XYC0qL
	 KSHmEfFvPKqkNrAfGqEvDt8zUbhdhTE3eicxaZcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgBUPZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:25:50 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44298 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728528AbgBUPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:25:49 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so1894176oia.11;
        Fri, 21 Feb 2020 07:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSM0EyjvmfxoFHCod2p0l5Pl9JBcuIkD94e/FTwKMK4=;
        b=EUO/m50hA6uJvILkeTee6/13AytgzpZ6p86tB2i03miialvsSdJO7D/HkyhaEfBfbX
         UdnblTWA49D9okfh1WeSIriw4Z4PYF+muCKAVkt+CReblPiDzSzKakwNGkm5HXs+WioZ
         lbf77dVC6+vQ+KDQMp8KkALgWGXuml41m73gaxBWg3dFTrKeFhQfgXbRvM+TPIFPoHYe
         KuMWoYm7d4yO6Y8x4VBrE1M5QpzfbWgeVWCa1oOW+PoZUuMKyCUQGYbwougBq3+I2/MQ
         Puxj0ijxFr6lT2lO+QIChUTOPixlJvqly8BgRexZFHr8yPdmm+NsjV8oCNgddoBE9Snt
         +wZA==
X-Gm-Message-State: APjAAAVpX7/QYV6uLpVQRZB42lrRwR9g29zMlZM+wDCh3wFGIOgUoLxQ
        gk99IuIyN/nobM8Inb32Cw==
X-Google-Smtp-Source: APXvYqwAPapyWF61DOlIKdFT1cYJ5jK5jFsvyQonr/MrRrIlZGCawUtzEC7o3L2NKwc64wuonBhk2A==
X-Received: by 2002:aca:f242:: with SMTP id q63mr2466113oih.72.1582298748045;
        Fri, 21 Feb 2020 07:25:48 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm1131503otp.14.2020.02.21.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:25:47 -0800 (PST)
Received: (nullmailer pid 1560 invoked by uid 1000);
        Fri, 21 Feb 2020 15:25:46 -0000
Date:   Fri, 21 Feb 2020 09:25:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: arm: Convert UniPhier board/SoC
 bindings to json-schema
Message-ID: <20200221152546.GA1327@bogus>
References: <20200221021002.18795-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221021002.18795-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 11:10:00 +0900, Masahiro Yamada wrote:
> Convert the Socionext UniPhier board/SoC binding to DT schema format.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../bindings/arm/socionext/uniphier.txt       | 47 -------------
>  .../bindings/arm/socionext/uniphier.yaml      | 70 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 71 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/arm/socionext/uniphier.example.dts:18.9-10 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/arm/socionext/uniphier.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/arm/socionext/uniphier.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1241745
Please check and re-submit.
