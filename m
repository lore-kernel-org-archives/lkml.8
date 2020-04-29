Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC56AC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B809B20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588195838;
	bh=x6wwUTbcTQAfxv4M0Qh7JjVjfFB25HWQLomULmrZdRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xu36fsLsVhwxz5z+lunFL6NgshujVljr9uC4WYwIKDrGIBZJx0GpLQm9cZyoJ6+/J
	 LTkq0xYHKEpLAF9hPHSls2Is5XwYvQ9Vh30RLLlmZifdcIaHM6786Tq6e69T5xQ3hi
	 tTm5QfZQrt1tzo3O7AYYFixEzJizq9oO9vn7cwE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgD2Vai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:30:38 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:47083 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2Vah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:30:37 -0400
Received: by mail-oo1-f68.google.com with SMTP id x16so774479oop.13;
        Wed, 29 Apr 2020 14:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sNKlT+9/zIdQsL5FmjDdatJ2sdOrBvQb7gIEQfxHgsc=;
        b=oDejzVcHBZpxMOik06C5g+oqWY+IcVQfYJY1IUI+n5ke30tUbHdDOMS5jyi/X2M10c
         JYbyY+PbvnH1dDmw0F8PF0SkKVN5aHoLiOM/vWoRgxfkD+t7b/rl+VZHyw9ZD/IPkP0P
         G4RtKrmC9aHGBbGyVcIWelvV9p1D4HOuV7nnW9oX2oCzxW6LrqdVCxDIIfh2h3GqJj7l
         nBmOI+fxd9WUN7qW8JikAPifQTPp9ptz+A/Iy+woZOSFyCI20zApk7qKgmEQvwZ3Esk1
         KRjc92czpcs60ZanWBPIiRHidVvyC3gFpMNIS6X19DeY/ywrtgEvGn3+YYyROEX2W2vM
         PpUQ==
X-Gm-Message-State: AGi0Pua542Hwep7Kl7tAh/8Uw8yfSlcAz1QOkKd8fVWmIB+W8vS0q16X
        p1kpLgfISco1PVPa+4DjScVyj8Y=
X-Google-Smtp-Source: APiQypK+APtg89af1Xjg8bKvZAVWBN2auKSMy5LvFjCDfw9Xw+dgMjfH9LB7Dui73Y7zFNedvbVvyA==
X-Received: by 2002:a4a:e5c5:: with SMTP id r5mr88626oov.56.1588195836410;
        Wed, 29 Apr 2020 14:30:36 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t13sm684710otr.43.2020.04.29.14.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:30:35 -0700 (PDT)
Received: (nullmailer pid 31939 invoked by uid 1000);
        Wed, 29 Apr 2020 21:30:34 -0000
Date:   Wed, 29 Apr 2020 16:30:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Min Guo <min.Guo@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy-mtk-tphy: add the property about
 force_vbus
Message-ID: <20200429213034.GA29572@bogus>
References: <1587100986-3104-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587100986-3104-1-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 01:23:05PM +0800, Macpaul Lin wrote:
> For some platforms, they don't have vbus pin connection between usb's phy
> and mac. Hence we need to control force_vbus related registers to keep
> hardware works normal.
> This patch add the required bool property force_vbus.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> index dd75b676b71d..6b49b651becc 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> @@ -37,6 +37,9 @@ Optional properties (controller (parent) node):
>  		  calibrate
>   - mediatek,src-coef	: coefficient for slew rate calibrate, depends on
>  		  SoC process
> + - force_vbus	: if the platform has no vbus connection between phy and mac,

mediatek,force-vbus

This is board specific? If SoC specific, you should drop and imply this 
from the compatible string.

> +		  (force_vbus mode), then this property should be exist.
> +		  Otherwise not to add this property.
>  
>  Required properties (port (child) node):
>  - reg		: address and length of the register set for the port.
> -- 
> 2.18.0
