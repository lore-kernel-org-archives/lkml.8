Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E236C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF26207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595285943;
	bh=ptw1adNVxNXKbHydokbj9539+xW43BLZ3J9pPNnuMQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lMi36zyB89R4AUpoPOgx700V9caAy1YKgiZMYTNGBHvBnhOd5TtVMNyjJszJ091Mu
	 hKeDJ6asRt8hGEr5stzh8Ct8dFpxxTdnA9t3u7IKVSzLg1FNt9+InxNC4Beu3W2jzG
	 y1KmmH4tppYPOsLGYqeWIFifdaSnHWy5GpNfcc7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGTW7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:59:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34781 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTW7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:59:01 -0400
Received: by mail-io1-f66.google.com with SMTP id q74so19436976iod.1;
        Mon, 20 Jul 2020 15:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AqV3qpi0FGYhyxxFKRbye9k2fummzEc60BukPe/XJ8Y=;
        b=YaasU7hS9jKgI06xVLKjzhx/1fEkw+mzRVJp+YqCX/TbRuDePZ2sA5phXYoxdl37Wj
         +/RfHM7Kz+K+IgOdtYpxR3q0OScfTImPD60YMxceKU2Or4SQNp86SiwQjiZLNmosGjOz
         SoAbtvlX0VP9V9tRkfsA83bzXkcd1FMtabhaSDp5V3Zxo6Yq+sALuyQ45ue3xwwh1CCF
         ZxrKSLlNL6FQexbdL7+WGsrSGh1uq2rZWP6G8qNpiozdhPLwPF7bLSH/v8ua9meymBYX
         TQTqfdMedxDM4bD/VJGRTEWysoaEzcXgoVVBPS8gzgEE8gQq7JP7TFUopXHI+z2MzDMN
         YnIA==
X-Gm-Message-State: AOAM531v6pEN2pTyNqunytwIqW4b/lIUo72h1N85as/wNqrxJZm7KZJg
        HiX+CPhCrdx/GRn9leB4NA==
X-Google-Smtp-Source: ABdhPJyo2Hp5eLauB8HQjo3cnKWrGzjaOFfQckHGVee5U7GvWwSQW2q4MVMOF13cNUie2SuBdIrSfA==
X-Received: by 2002:a02:5b83:: with SMTP id g125mr28527695jab.91.1595285940732;
        Mon, 20 Jul 2020 15:59:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f9sm9522979ilq.9.2020.07.20.15.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:58:59 -0700 (PDT)
Received: (nullmailer pid 3105685 invoked by uid 1000);
        Mon, 20 Jul 2020 22:58:56 -0000
Date:   Mon, 20 Jul 2020 16:58:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        iommu@lists.linux-foundation.org, anan.sun@mediatek.com,
        Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tfiga@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        cui.zhang@mediatek.com, devicetree@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, youlin.pei@mediatek.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 01/21] dt-binding: memory: mediatek: Add a common
 larb-port header file
Message-ID: <20200720225856.GA3105636@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711064846.16007-2-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 14:48:26 +0800, Yong Wu wrote:
> Put all the macros about smi larb/port togethers, this is a preparing
> patch for extending LARB_NR and adding new dom-id support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
>  5 files changed, 19 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h
> 

Acked-by: Rob Herring <robh@kernel.org>
