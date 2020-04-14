Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C11C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF192054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586905993;
	bh=sy+Whlg2RCdb35wEFhj/BGmcgA87Vhsr6L2apXyQFl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QmKG7fF+6Xtjwc0QM5R+C57bSJb0nxUetaULtTMrd1C/kPyVTRAwK2EemXcc9ce8n
	 r69pkYMfeFZVcW+B7YdfZXg2fxOpnTxugK3uCZcR9hgdqzrRf78jL+hdo5s8hZd8ZQ
	 xfcZBp+Bq8kcA8DehFON+M6Ku9B4g/GqIEgq7lh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392036AbgDNXNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:13:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43764 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgDNXNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:13:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id j16so11979822oih.10;
        Tue, 14 Apr 2020 16:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VvYN+POzUP/HxZIW68dFGmEkR5GANu8XsXmHkqwh3r4=;
        b=LuYvRXYeP411lHfgR4fLTUPU7Og85b7wQxEkF2BBtbTvlzLrtELtbYrXQ0IwZQ1J2o
         6vhiT5fDDdNlnVLNr+/DU3LgmscXOzpPiHDXL+oRf/95CZey2gmLM651cchi+GHUAxmI
         brIgLwKhPZkR8dfeI47chcH18/I/VYav0iVOUqPf/QQy4LSDI6pGaABXfEK1kdUeOsGI
         /VQqbNMwhYPFg4O3NmLPpwQaTEi2PNJHEBp0W13QXisQsda464B95Ezhc1U5hRod9cgQ
         xitniWvRx5odmlTfrdFBgb1yD6OY877KFoF8V0Ji56liLQCsmYdOp4bl4OSzlJACvC35
         IZMA==
X-Gm-Message-State: AGi0PubKXB/F40v1Z6NJLiQswXheK3goSsq678YJXWy2IsAFbqZXdxcz
        I8utuO3hCf7WTBU4tc1FzQ==
X-Google-Smtp-Source: APiQypK61RTHR9kuSvlYPwIECBbuocsSAp6KyPuha5OGWWkV7afY5lGlf+sLaVr7JcOhZjc7RQrgHw==
X-Received: by 2002:aca:403:: with SMTP id 3mr12694157oie.166.1586905989246;
        Tue, 14 Apr 2020 16:13:09 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm5911183otl.12.2020.04.14.16.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:13:08 -0700 (PDT)
Received: (nullmailer pid 9163 invoked by uid 1000);
        Tue, 14 Apr 2020 23:13:06 -0000
Date:   Tue, 14 Apr 2020 18:13:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hyunki Koo <hyunki00.koo@samsung.com>
Subject: Re: [PATCH] dt-bindings: memory-controllers: exynos-srom: Remove
 unneeded type for reg-io-width
Message-ID: <20200414231306.GA9106@bogus>
References: <20200406104554.29773-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406104554.29773-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Apr 2020 12:45:54 +0200, Krzysztof Kozlowski wrote:
> 'reg-io-width' property is an enum so there is no need to specify its
> type.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/memory-controllers/exynos-srom.yaml   | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Applied, thanks.

Rob
