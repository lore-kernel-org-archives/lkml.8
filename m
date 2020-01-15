Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA29C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8292053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579102968;
	bh=mwQEY3Ww6br5KNOmSwVS7hUcvqZ+uw0UKLzziu3FWeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oqAPzXeHcE4Jev9ZFWcL7TQOB6nIFfQDSf0NDsaj5Mgsu7hfmptabSACZ3fNXhFNw
	 A/Z/hkW9RpOtq3BaSCP1ZR5nmPU7JuW3OMohdYNTTmmulSeNF6jUY+TYlbmL+0bfBL
	 62HQD20msyzUR+xuTv30TtCIT6S6pCRYP212u2aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAOPmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:42:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43624 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgAOPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:42:44 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so15762054oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZ89QzBAoQ2DzrvbjynM5ltUEoPFqx0Q/mdX+QC5z3Y=;
        b=HgLoz6PQoWDw43D0KMwBZW6savJFcjRmylUZMFKgr14Wb0X40ZHfdEb9DjYSZQcODP
         5e8mJr6jFRCSmJXXCEdHzlBHjx02IqF5S7ekUOCJDsZ6VgiHBrm/4eP2Ny17cpjTAluA
         /FYrS7WRJURmE+fOT+OJyb1A2t/+eWH+NI9em7p4qR0bdwjv3j3BS31SJ5+/pFH0jJpz
         2APruWJWrQNjaygBXLkai2/5nomnYvjr/bxnp8a7p/723xRQX6ra5sDtO+m6hKY4fY6x
         n4LpmnMS94/nI8XWJwgVtLODr2HMd7U+VxLHXtrJJ4ziyCqdshMh26HFSdRsFsJKWuMP
         VYnw==
X-Gm-Message-State: APjAAAV/I8+EU8v97P/VmPa0MZklXvSlg6Qv05mzdb4HA7mEZoMToKrM
        pLbDBSL+0c5zeHylpD0z9Rc0ZFI=
X-Google-Smtp-Source: APXvYqx4z8VMxoDwHjJ7NlL9MtC5DYjgsqEkuDZvDg2rW6rUXRuBpaM/ffM+pPlDGy1sPAvXxM3m9Q==
X-Received: by 2002:aca:5d57:: with SMTP id r84mr331030oib.42.1579102963166;
        Wed, 15 Jan 2020 07:42:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 69sm6664420oth.17.2020.01.15.07.42.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:42:41 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22061a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:42:40 -0600
Date:   Wed, 15 Jan 2020 09:42:40 -0600
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
Subject: Re: [PATCH V2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP
 compatible string
Message-ID: <20200115154240.GA15071@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 13:33:17 +0800, Anson Huang wrote:
> Add compatible string for imx8mp
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
