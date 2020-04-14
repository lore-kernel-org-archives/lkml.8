Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42737C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D5020767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586887717;
	bh=v0ImH5Gk48gyfDpP9ZgwU/4UTDXPLc1upanBsDnxI28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dOcTGtU3YqNX74nvuD+Cp2bdmsD8hmECuAoEQ7ivKfFseBzUMc4PnopWe0Bdri9Ao
	 m/Oj52+HmvyiQdTkUGMs5rj8yOOUiTQzLVAkufdN7Rrjolvq3LTLgBqFpKcGu0aqW4
	 c3RDVHoN8taFl5sJakzTGDJe4t9wCUTdVFMcE8Is=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503426AbgDNSIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:08:35 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33849 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503393AbgDNSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:08:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id m2so643574otr.1;
        Tue, 14 Apr 2020 11:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aH6/bJSeqki/Vi5JpbdIfubPaLu43WdUQzhVPta/M28=;
        b=taxHxQv0JhxLp/Zu6zCbrupHAGHPBncl1jdK3oj3sIqBS8FT/zORUZFYPl10tL1is/
         iILEE0vTYGA5+SDiZMiMcXZA0QFhkd4RM3As0SuJJvnZ+C29K+Wr9Ep7vIkkkzqH3TWL
         N5zsXsgVCzyTi6zoEkn3J9qb8ACVzlKaevzbg043Mt+aJB7YM9rT1gBrHQkWDl5OapnG
         igg/5qBk6GpY7pmOG8p7jsjoYH4CTK64hbfYtb+s4GWExco8YGIu2dTbN1dl0ACGJGok
         Ldfixzs5vlX3CW2o1wj3+rUPtGnq+GE0Urmu7pMI3CpwO+myAlFKATj59OmIxO+kX9pA
         itfA==
X-Gm-Message-State: AGi0PuaYO9ROsXMgEIziXPr4wibrzr5+8LFz86hsno+EY7B2wkN7otta
        KJANUq5rig/nRJBfTLXifA==
X-Google-Smtp-Source: APiQypKhRc4T3Riyr7q0PMZ9dtddK4y6BcSReW/3d5i8PAegHYWIM3ilgiExMX1m/wo3haK89CSjYg==
X-Received: by 2002:a4a:be89:: with SMTP id o9mr13224323oop.20.1586887704452;
        Tue, 14 Apr 2020 11:08:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 62sm5490196oty.73.2020.04.14.11.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:08:23 -0700 (PDT)
Received: (nullmailer pid 31612 invoked by uid 1000);
        Tue, 14 Apr 2020 18:08:22 -0000
Date:   Tue, 14 Apr 2020 13:08:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Helen Koike <helen.koike@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, robh+dt@kernel.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, kernel@collabora.com,
        dafna.hirschfeld@collabora.com, ezequiel@collabora.com,
        mark.rutland@arm.com, karthik.poduval@gmail.com, jbx6244@gmail.com,
        kishon@ti.com
Subject: Re: [PATCH v2 5/9] dt-bindings: phy: phy-rockchip-dphy-rx0: move
 rockchip dphy rx0 bindings out of staging
Message-ID: <20200414180822.GA31542@bogus>
References: <20200403161538.1375908-1-helen.koike@collabora.com>
 <20200403161538.1375908-6-helen.koike@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403161538.1375908-6-helen.koike@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Apr 2020 13:15:34 -0300, Helen Koike wrote:
> Move phy-rockchip-dphy-rx0 bindings to Documentation/devicetree/bindings/phy
> 
> Verified with:
> make ARCH=arm64 dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml
> 
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> ---
> 
> V2:
> - no changes
> 
>  .../devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml           | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename {drivers/staging/media/phy-rockchip-dphy-rx0/Documentation => Documentation}/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml (100%)
> 

Acked-by: Rob Herring <robh@kernel.org>
