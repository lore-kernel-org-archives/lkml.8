Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A47C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387DF207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595285965;
	bh=exfrltRkMKfcqhwjcfhhMCD57ePahXv30qxF3x0OcLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RP1zlUEXZA/7iDO/1SenHAP4crtDAx0rNTN3bkNTTbj4QRoZe/rZ8Lr0NtyyIGPNK
	 tYllClQDIwO0L1aZZyTll5zdg5rNGbBKuIPHLICim7GXcSPKu2D84C6M1qyV0S6dyw
	 KECMyhbnKjMxWdM/qCHWTtrNEPW6AfskhCMutfkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGTW7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:59:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39544 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTW7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:59:21 -0400
Received: by mail-io1-f66.google.com with SMTP id z6so1884452iow.6;
        Mon, 20 Jul 2020 15:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ybLjdJnNEzw3PjLa+ida62upYueSqoAHLo8Hga07AFI=;
        b=KjxnXsTuF7xJlLymnRibjL4U/e4e9qLJaw6dXBW+uYMii+WUaGFUGL28juDj6/kTBN
         ae7a7dg1/pd6ppAxcPtA/6Cjodw5bbvUetB6Ltrbu6Lmvhin/ilEpcTFv8+sFJ/0j7ek
         yeMJJSuvoXph7Ox7FfZzW37rPkMA+AZLUIJ/nOpxqbUMIVXZhJGua1C5fj9/MKpTFZs0
         D7IjXnWcGYAKM2r06dWDAAYp7W+u3WaoDDL9N+23jtMdMdGdp82XdSznDDeTj0xOIWYx
         3JOhm+jtdcaHNDmYXukmgh3kipLkoxTj5ww116m7hS13THTYPCq+WN77awMClMd9g4dk
         cU4g==
X-Gm-Message-State: AOAM533nUxrlJyzryNfGdx4uJrlA7fwhlNYpohITzsB++4SXzEI/88m/
        H8HBTlXjPbGlQ2abRi/KGlhvKeb4cw==
X-Google-Smtp-Source: ABdhPJzLaIZ/SR4wIJfqeFdccTnBBLnUptFgZ037ZPt4d8W2AdS6R04ewjeU1fu4LJgmATuLmvJZEA==
X-Received: by 2002:a05:6602:2f89:: with SMTP id u9mr25210319iow.126.1595285960921;
        Mon, 20 Jul 2020 15:59:20 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k14sm9856274ion.17.2020.07.20.15.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:59:19 -0700 (PDT)
Received: (nullmailer pid 3106187 invoked by uid 1000);
        Mon, 20 Jul 2020 22:59:16 -0000
Date:   Mon, 20 Jul 2020 16:59:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, chao.hao@mediatek.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        youlin.pei@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>, Joerg Roedel <joro@8bytes.org>,
        srv_heupstream@mediatek.com, anan.sun@mediatek.com,
        ming-fan.chen@mediatek.com, Will Deacon <will@kernel.org>,
        cui.zhang@mediatek.com
Subject: Re: [PATCH 02/21] dt-binding: memory: mediatek: Extend LARB_NR_MAX
 to 32
Message-ID: <20200720225916.GA3106142@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
 <20200711064846.16007-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711064846.16007-3-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 14:48:27 +0800, Yong Wu wrote:
> Extend the max larb number definition as mt8192 has larb_nr over 16.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  include/dt-bindings/memory/mtk-smi-larb-port.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
