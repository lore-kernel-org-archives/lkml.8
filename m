Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C5DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88956208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590780440;
	bh=p6+yXBaxuRr6UtrPjsePvXMahSM0RC5gMAKoncfMd2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ai74u7Mn7mr+PIJzXeT1508GSF7Kj+jE/sWXIw2wosMhxlTJLEdFCUo7c76QXL6nM
	 pZfGuI8MtajKAaucqT6eVvV8e8XmHAbDFnnP0+LO5asiG90u8tEnfAJ3RU0ordDTfy
	 B+Uz1dDZctUKYJBtAYQszpF2XWNaRuQLQH58FQ2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgE2T1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:27:20 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40086 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbgE2T1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:27:19 -0400
Received: by mail-io1-f67.google.com with SMTP id q8so543999iow.7;
        Fri, 29 May 2020 12:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/aw5rjkKZ1aNLtzNBPRgdXUzA/GNRGygjmxINK2X5fA=;
        b=eV/Mi4WwwWa3DWlq519I98Q3928vrnTRASTCn849XMHBKmAXmumMefZvMbmQ/c39J2
         mf15nHjRuncP+U/dafc0XBoFcS+sA6WTfVWFqdmrJoLKjsC80+1/fv/d4aCW6vat1P2h
         6PsMwmR0M/xEri9+CfvHlmp/C4eJsbAsYDVNe81nNSjhp/Lnk9CHyGz9/8E9q6UWZ2wu
         IEZx6DstJbcZkrgMZ4GBu/+KB6G9Yud7y6srdniKgsUgh/15Tdt/qFNnoDC1cqBfMQh5
         +ZXHfkw2eqG/8OSsxx7SjKLn5iImW42VvUlWe6ef4NchAsQc+srkhgLKYALbMy3uRNz0
         misA==
X-Gm-Message-State: AOAM531ElIaDi2EQtygdQiKcgBwmU9LaQ9yfACV5r4ho6Jg+glTbercb
        lDEWp9KgWYGNGSVaQ2zGlw==
X-Google-Smtp-Source: ABdhPJzI+XOVZoeOXsD31yjOKfbl4d6VkVa2jbPtpd2RLN5CANUU/Kj27igKjwRkwCJ3YG/2Z4DjRQ==
X-Received: by 2002:a02:90cd:: with SMTP id c13mr8587847jag.83.1590780437502;
        Fri, 29 May 2020 12:27:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v76sm5436198ill.73.2020.05.29.12.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:27:16 -0700 (PDT)
Received: (nullmailer pid 2799831 invoked by uid 1000);
        Fri, 29 May 2020 19:27:15 -0000
Date:   Fri, 29 May 2020 13:27:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Pedro Tsai <pedro.tsai@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Stephane Le Provost <stephane.leprovost@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Perepech <andrew.perepech@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2] dt-bindings: net: rename the bindings
 document for MediaTek STAR EMAC
Message-ID: <20200529192715.GA2799386@bogus>
References: <20200528135902.14041-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528135902.14041-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:59:02 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The driver itself was renamed before getting merged into mainline, but
> the binding document kept the old name. This makes both names consistent.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
> v1 -> v2:
> - update the id field as well
> 
>  .../net/{mediatek,eth-mac.yaml => mediatek,star-emac.yaml}      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/net/{mediatek,eth-mac.yaml => mediatek,star-emac.yaml} (96%)
> 

Acked-by: Rob Herring <robh@kernel.org>
