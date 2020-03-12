Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B208C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8478206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584045849;
	bh=cU1GD5X2Y0L5c6ySahhdon/Ip/7FLhldT9I7XZclNMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yclpyRS0w65I1dbdnvVGQmcTVuzKc7ynUzu8fOIzZ3x2/4bQ+UBQPtRMclKpfktt3
	 eMEEIXlpHUHv9VdpZZnosdQyizAqWXv0Ox6I8kUwF9YpfsiuMzPw8Bjnv4sLl3wxJn
	 AoQ8JMyffqyKKbAEP8FCQbwfJdlGIepNNk2uq/bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCLUoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:44:08 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41604 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:44:08 -0400
Received: by mail-oi1-f195.google.com with SMTP id i1so6962881oie.8;
        Thu, 12 Mar 2020 13:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bf/mniPvgv/hyidCSVXAA0PznIXPMrUrlLxoUaBO5E4=;
        b=jnPl5P+dSGW/rSpjff9KuFb6qf9tErM3JuhqAkf8bwNWv2JaP8CZlpFJy/wjBxBWbW
         JQ5Sb+a3+OoD75U3QqA9UpOcxAaJBKT3pX8elBxAeRNSYUcyjPAitf/ee5BplJw+omR7
         OzjUDbynKd5icdtSuxd7Mo7jwHunKnpORU+yFcKOl4llr+aLlklyrkTdtjnLdXWeX9a4
         7KuQ3hCEJAT8u+sSm+N5e6npsCFS75qRkf3kR0rmsXL/GK348QUBt8VxsZEU+qOcM4ka
         74ued8mNaG/bkbYtgObwsfr1sLdNUlkSNKvXkYgPqcBIuxYFblY6OrV9gS9RUYBOL2qf
         kkvA==
X-Gm-Message-State: ANhLgQ1cRQOS0cjhHhEd8n32dcggp4cUeUVldO/ngwRe7KWyrJ9RZwnh
        x5slIFFs2tSR5PxZkAMtiQ==
X-Google-Smtp-Source: ADFU+vu12lPkGVzdrIc8Kmu31z1cZSRT3mJtmGey2zd3WfeSfiPOTSTWLggHp89RbmmTJLde5D8/og==
X-Received: by 2002:aca:4bc5:: with SMTP id y188mr4293335oia.9.1584045847828;
        Thu, 12 Mar 2020 13:44:07 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c2sm225330otm.27.2020.03.12.13.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:44:06 -0700 (PDT)
Received: (nullmailer pid 8135 invoked by uid 1000);
        Thu, 12 Mar 2020 20:44:06 -0000
Date:   Thu, 12 Mar 2020 15:44:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/22] dt-bindings: Add vendor prefix for Baikal
 Electronics, JSC
Message-ID: <20200312204406.GA4654@bogus>
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
 <20200306124832.986FE8030793@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306124832.986FE8030793@mail.baikalelectronics.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:46:47PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> Add "BAIKAL ELECTRONICS, JSC" to the list of devicetree vendor prefixes
> as "be".
> 
> Website: http://www.baikalelectronics.com
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 9e67944bec9c..8568713396af 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -141,6 +141,8 @@ patternProperties:
>      description: Shenzhen AZW Technology Co., Ltd.
>    "^bananapi,.*":
>      description: BIPAI KEJI LIMITED
> +  "^be,.*":
> +    description: BAIKAL ELECTRONICS, JSC

Also, is 'be' a well known abbreviation for this company. Perhaps 
'baikal' instead?

>    "^bhf,.*":
>      description: Beckhoff Automation GmbH & Co. KG
>    "^bitmain,.*":
> -- 
> 2.25.1
> 
