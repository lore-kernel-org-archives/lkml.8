Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C4BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528872078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592237400;
	bh=4vibHUpfXnNsO60rZstWWs3DH4fZjS17/55KHu+PzII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HKI+BuzI3Y3eYnO5yrQwQQfIf7NUMVrQKk6G1L0a2SVlLOkiGvwNdzUUokZqvH/UH
	 YjSsrEpdJIMbWe1CI82/xBR2j5Z8n8pO7QjaxV29/2lEo8/7mCWj8a6e+3WrJ0RNV8
	 RP4FUK65rYSNOSFu2n8mqXJ2DsDm4yK/wItg4fEQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbgFOQJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:09:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41786 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgFOQJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:09:58 -0400
Received: by mail-io1-f68.google.com with SMTP id o5so18450944iow.8;
        Mon, 15 Jun 2020 09:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6pcmdJx4HNdfvoURK0pS/uo9gcQBvUR51Fl9F7RD+2g=;
        b=QDK2cHpHva3SyEo3fgkVwwT0ALXAJ9iq5u8Y7NnLgrjcwS9iu+jqO0kDaAIndbe7aA
         8JUdqeVbmO2n7MsNMMDoh4CCo3Ef3BbGn7jwwmoRVa6rzKSUCwUg0aJjhMmJkM9m3lOW
         qlSDTaAXwD6So59MvecYVn93bymrTRqfqhSHVhNGgykVDpqtnULQnFH61ZaGw9ViZ5Nn
         gSL/TG7ypWrx1VvVXzRManTRq6V6VsBc0+akUh3/fjF/RrnjGscM+tczuJRkoQLfuQrm
         CTEvew5/+A6MdTANFSnj0Cdc1oh2AQIbm4jaLHtkgN7ZGWJXCO1Xu8/n6dmC8cc69W6c
         rSVA==
X-Gm-Message-State: AOAM531b6soeXa36J/A9HDsQCgt1Dgnd2T6kQUju0EXOtxEBffYSjR3D
        wYtaEUnps0Kbz1tdi4MsdQ==
X-Google-Smtp-Source: ABdhPJxjLCBX9sKIbflLAfGJFvnKwPQdtJxMytSuki4Cyx5b84o8tX12LEkI1o1hSS+BanuS7tOEZQ==
X-Received: by 2002:a6b:4413:: with SMTP id r19mr27931825ioa.162.1592237397848;
        Mon, 15 Jun 2020 09:09:57 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j63sm8448166ilg.50.2020.06.15.09.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:09:57 -0700 (PDT)
Received: (nullmailer pid 1861733 invoked by uid 1000);
        Mon, 15 Jun 2020 16:09:56 -0000
Date:   Mon, 15 Jun 2020 10:09:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, cawa.cheng@mediatek.com,
        dri-devel@lists.freedesktop.org, huijuan.xie@mediatek.com,
        eddie.huang@mediatek.com, srv_heupstream@mediatek.com,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>, yingjoe.chen@mediatek.com,
        stonea168@163.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 1/1] dt-bindings: display: mediatek: convert the dpi
 bindings to yaml
Message-ID: <20200615160956.GB1861039@bogus>
References: <20200614073036.63969-1-jitao.shi@mediatek.com>
 <20200614073036.63969-2-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200614073036.63969-2-jitao.shi@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 15:30:36 +0800, Jitao Shi wrote:
> Convert display/mediatek/mediatek,dpi.txt to display/mediatek/mediatek,dpi.yaml
> and remove the old text bindings.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  .../display/mediatek/mediatek,dpi.txt         | 42 --------
>  .../display/mediatek/mediatek,dpi.yaml        | 97 +++++++++++++++++++
>  2 files changed, 97 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.example.dt.yaml: example-0: dpi@1401d000:reg:0: [0, 335663104, 0, 4096] is too long


See https://patchwork.ozlabs.org/patch/1308901

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

