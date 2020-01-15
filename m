Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AECC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B2A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579102975;
	bh=eBGLvhXJudq8c8ns1iD/SjohF++SLfZwoKDFp3HQgcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kiXze7khX4gp6FXEBC1INyFTdNd/kMhJ7ODadoZeSDnBBlTwJwS7fgYAjtEkWlU1k
	 RZ+eAnW2Y/k6pdkEQ/0efkWv8FKlev8RiRvfFMEdoA4S46IJ1rK/69agOkTxuLatlM
	 4M8QlbYv4Pi+hg8xFFzj8N0782uh8/eX6sq7mhvU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAOPmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:42:54 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39963 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgAOPmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:42:54 -0500
Received: by mail-oi1-f196.google.com with SMTP id c77so15763737oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:42:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUBHE4XJm85NFA8oPl1FMyCsYkpngZCS0u/hs5fFTfs=;
        b=ioHEoSjmrUQT/JvGlcfGxkgtll5IhNBHO642nHx2U1xPutzxuRuCM5b76sDx70Izzt
         WD5UwrpoM54fPKUeHlcRcStVcVOiFyRMiyhSjbA2YnqPKp7cz9tG9U2DYuQs+/GJB/zN
         kN8Vs6rJ3RTTVXEx2uaNgUUJJsp6oDpV6ZKgpctkV8T21lJfbeFc1/dEDkKuPeeHpMMw
         FOH9IybLAXIdgEbJmhH3xrl72xl20hEdLgxv6XxGqbDckbaj8R55rv1xxO7ZJN9/r7Na
         a9A+qS9GiXfXNyecP4hXI5cbKqgPCDK3Pi9ZzGbGTaKlMFuTJeGAXcyNr+DX/NOEa7UP
         BVqQ==
X-Gm-Message-State: APjAAAWvM/kMYbxiXiS9ZwamBJVQWRt5sgv7iQqtcIX8M8Kqduh2exaU
        ZUR71ivoRrAnEiUGkmksBZeaXc0=
X-Google-Smtp-Source: APXvYqzYy82981lf/vu/dsMflh+jr9F2qwxqjB/4xBNPLW7UWA6SZ1+GW1iR6Hh1tWSjIx9Nby6GvQ==
X-Received: by 2002:aca:534f:: with SMTP id h76mr299554oib.23.1579102972914;
        Wed, 15 Jan 2020 07:42:52 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e13sm5817076oie.0.2020.01.15.07.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:42:51 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22093b
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:42:50 -0600
Date:   Wed, 15 Jan 2020 09:42:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 3/7] dt-bindings: imx-ocotp: Add i.MX8MP compatible
Message-ID: <20200115154249.GA15419@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 13:33:18 +0800, Anson Huang wrote:
> Add compatible and description for i.MX8MP.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
