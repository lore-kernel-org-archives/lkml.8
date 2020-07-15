Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EA6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5252075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594849497;
	bh=anKYBjcbvOPtsBtRUHg9RK+mp8CGK35PuSptGilkUVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t3MDW8kC+pR9I8V5EIc8W8VrKqIUdmPnfS+0klDHjAPO5htLNTyyfq6E51vQDKYsx
	 U1sY4yIM3k8eODnieBBD3HvYG0aHdshIlalyr5jW/DxZs/I7WyzkYvO9aM8e+V6cqF
	 JeRvi8OsC2Cadz8P2B0a8o8sU0BcH0sOE5YICcfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGOVo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:44:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36156 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOVoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:44:55 -0400
Received: by mail-io1-f65.google.com with SMTP id y2so3897021ioy.3;
        Wed, 15 Jul 2020 14:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G2Mqt7gxRiFgu+zBoG7bPjfYecL9s+S+lyU0ScviujI=;
        b=tDLPz8rWtwGfcf7mR215ep7KtrBZNn/03hbvhHa29SsAybIF1Rc3sDDhbZh9wAzVRn
         B//VEJIS25JacBkBH7KRoKVYA7YPwC2ECmPuI01BuUVSwg5S2LlrjG2/eY8/dWxQbOyn
         LbWLv6Ljyt/RLaKhvEr4kBI1aG+3AJX7nvjOqdlawLPq81x4Q8mdAZm6S1AbXjiQx3+z
         SFuR9Zs27+G6a7QX0Cksq3/BKSkVbxWe0yl6Ov7zq3a5KtKJhbwoOE8NtgO2KI8mf5yx
         LQCwp4oP+YSj94J7tT5CrLu8OduXnt2Z9z4ak85iCsAsL9GdWJ/mplvkjsKTXJPa17fk
         x9ng==
X-Gm-Message-State: AOAM5334BXonM3fO3Y8YJn3YjXpl2g1TV6DINy6gzwypTVo8JmUpwiTQ
        uWxefP9QD3TggICCvB06Yg==
X-Google-Smtp-Source: ABdhPJzmxir1p3e9ru+Hz1g9JLvam/4uHKqg3E7b8w9WMvJYI1Tx2B7G1S7vbF+WtPKipdU9wyqFog==
X-Received: by 2002:a6b:b2d1:: with SMTP id b200mr1314239iof.137.1594849494492;
        Wed, 15 Jul 2020 14:44:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v4sm1632908ilo.44.2020.07.15.14.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:44:53 -0700 (PDT)
Received: (nullmailer pid 869896 invoked by uid 1000);
        Wed, 15 Jul 2020 21:44:52 -0000
Date:   Wed, 15 Jul 2020 15:44:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     devicetree@vger.kernel.org, hyun.kwon@xilinx.com,
        michal.simek@xilinx.com, mchehab@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Xilinx video IP cores
Message-ID: <20200715214452.GA869842@bogus>
References: <20200705075524.22657-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705075524.22657-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Jul 2020 09:55:24 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/devicetree/bindings/media/xilinx/video.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
