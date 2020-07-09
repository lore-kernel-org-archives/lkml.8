Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFB6207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594327376;
	bh=RgBt8z6Oy8lJFig7s7Mb1k0GThuXtTthaVvtmzqcdz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z60Lm+aZG/bACiiVKGKaom6Dub04ZgwEg/zVmK0/QQeC+NNFbxFD1BLcghqSHhAWF
	 i5ZuTkftMQUicyzZDKaU2wUpH7+sLCIhiDKV+qmIs7ulutvXgtVtHEIaGceDl8Ihj/
	 uEhB10+h/ehzX4I21rWdiKYvw6AyWFM+/L73AOmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgGIUmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:42:55 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38163 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGIUmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:42:54 -0400
Received: by mail-il1-f196.google.com with SMTP id s21so3203607ilk.5;
        Thu, 09 Jul 2020 13:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QRIStQyCkIoaSqHfpji8UZGXhFbUGYsTTZ730xKq2G4=;
        b=mERc9sediT+ELm9iH+xv/CZc/dtlBFP2GYQFVe5pzzACuJQX6ZeZzn5EUfuEpcqyVd
         MQx3uHfXOOceVt4HblrE6SieMTCgi2B8fPcO6Bo8L2CiuANOb2q1oMBAY/c3rGGcF1zS
         SuMxwXpIYBLPjaxqj/3rbeOFEl9hrA9dVyjbO1t2ET5po+1w6nlScTAK54YYTV2fyLit
         2eNt73jm0RiUtOewSC13WUvLwBULKhuRF+b+y3YlDL59T8F4kGM4Q3BC/rbp83xX3vQz
         HfWBAZHUfQckH9D/ICbKhWNAFBBbmlMbbK1cwUW80FV7dpOubkDYZxEg4O8KYO/mcUjU
         nyyA==
X-Gm-Message-State: AOAM531MhpWYRl684Gj5zc5hp8npcc1uY11doBjC+uBOhiBfF7FhiLOi
        dzkoJsQQEUIEPlgfVjLDPw==
X-Google-Smtp-Source: ABdhPJxRpTkSd/WJSCFIsf6B49REhAYLdyj/koXazQPOq/svM5+yEgb4ot3AwlT930+WE7ERTMlHLg==
X-Received: by 2002:a92:1805:: with SMTP id 5mr45546138ily.127.1594327373701;
        Thu, 09 Jul 2020 13:42:53 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id z20sm2690327iot.15.2020.07.09.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:42:53 -0700 (PDT)
Received: (nullmailer pid 853786 invoked by uid 1000);
        Thu, 09 Jul 2020 20:42:51 -0000
Date:   Thu, 9 Jul 2020 14:42:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinay Simha BN <simhavcs@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
Message-ID: <20200709204251.GA853727@bogus>
References: <20200704092511.20856-1-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704092511.20856-1-simhavcs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 04 Jul 2020 14:54:39 +0530, Vinay Simha BN wrote:
> - converted from .txt to .yaml
> - dual-link lvds port added and implemented
> - dsi data-lanes property removed, it will be picked
>   from dsi0 ports
> - VESA/JEIDA formats picked from panel-lvds dts
> - proper indentation
> - single-link and dual-link lvds description and
>   examples are added
> - license modified to (GPL-2.0-only OR BSD-2-Clause)
> 
> Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
> 
> ---
> v1:
>  Initial version wast .txt file
> 
> v2:
>  From txt to yaml file format
> 
> v3:
> * Andrzej Hajda review comments incorporated
>   dual port lvds implemented
> 
> * Laurent Pinchart review comments incorporated
>   dsi lanes property removed and it is dynamically
>   picked from the dsi ports
>   VESA/JEIDA format picked from panel-lvds dts
> 
> v4:
> * Sam Ravnborg review comments incorporated
>   }' is indented properly in examples data-lanes
>   description for single-link and dual-link lvds
> 
> v5:
> * Sam Ravnborg review comments incorporated
>   license modified to (GPL-2.0-only OR BSD-2-Clause)
>   changelog added
> ---
>  .../display/bridge/toshiba,tc358775.yaml      | 215 ++++++++++++++++++
>  1 file changed, 215 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
