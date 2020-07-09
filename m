Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E76C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EF920720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594335864;
	bh=w1Yzb5QAxbEEnz2T0/hjiTR9qC8L/gDsZ5VeC/Cy1h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J4+jwGLxt38Fwl30yyvSQ1GOARcb9+/JXypXDSWQg5sfo3FUx8A0US/kjsxLwjcVJ
	 rBYML7xve3dch7Yp7Ik7paiDSgr8pBKdWH4mmecIB2nGlShQBRCqhUV7PM8aIa9L+A
	 CffP6uukJRLLdk3HXzNVpElxUJadpYidxF827iQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGIXEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:04:22 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35955 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgGIXEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:04:22 -0400
Received: by mail-il1-f194.google.com with SMTP id x9so3502809ila.3;
        Thu, 09 Jul 2020 16:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JM/ovs0f6QOJJ45kJT1h07bdb12XYq7f+vUrzQEmo/E=;
        b=N/cS/K89f6N8z+O3gKiNh2b6y6ye6ICOoKLJncQrvQCTtzqgR1seuXv63bno8fQCAI
         8UW00Z601GqvXJ2GAYBKw6RfX2Z95/COHy5x7IErmEvtDBxQNk241Y5ZECMTqbbkAI2w
         9cGkFR7iIVqWBKi2TC1/QqtLldc7Ql4yioJIXFy4i62orzYwlAhcHwNIwLMsoi/1XyCp
         Pt4w+g5SArFhk3xRElU+glhRa+PoK/sN/FsH3s1tZmqFjyXXR4MRO6QUwaIfzXU1ftGK
         zR6RspF3zeWWRVU19qmy3zmktqTrlIoBnUIVxSPnEGLCPkSgReU6Dp2o2vB6X0dg1wpr
         JXzA==
X-Gm-Message-State: AOAM530U+gXumyG1nE+jvXzBkFpJROuyG/+Du39KxbdyKr9UWmraDD6w
        Mf0CfkI8/WOd9b7cRCrcqw==
X-Google-Smtp-Source: ABdhPJwNRDxDrexShSV227nN3rYPpkhvf1elFDx8MiQbC0jy+/FkeY4jzw9CMUdW0CT96zNZd9xsNg==
X-Received: by 2002:a92:9fcb:: with SMTP id z72mr20653546ilk.195.1594335861079;
        Thu, 09 Jul 2020 16:04:21 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id e1sm2585117ilr.23.2020.07.09.16.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 16:04:20 -0700 (PDT)
Received: (nullmailer pid 1058244 invoked by uid 1000);
        Thu, 09 Jul 2020 23:04:19 -0000
Date:   Thu, 9 Jul 2020 17:04:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 01/12] dt-bindings: vendor-prefixes: Add mstar vendor
 prefix
Message-ID: <20200709230419.GA1058166@bogus>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
 <20200616121525.1409790-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616121525.1409790-2-daniel@0x0f.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 21:15:14 +0900, Daniel Palmer wrote:
> Add prefix for MStar Semiconductor, Inc.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
