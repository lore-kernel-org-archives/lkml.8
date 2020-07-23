Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E066FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D1F20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595525375;
	bh=JTaR6osrOGy51LwUpYc5aNzaKnUPUAyBtcEaHG5n60k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0uHVaAFDxPhVy3xPp1j5NL1C9XoJjT9i1fnlb62Rpc/z181KKs3uUkecepG6PwCI+
	 LxF0vhr7Dpg7Z2qfB4lMlv76dgctXAfKYYwWGu4G2YW4gLZNapBNxfD20OG3SpcGuz
	 RFxiQmlY6DCaSI55W0NJZIN9xxyRo1NNozGIiym8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgGWR3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:29:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37369 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgGWR3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:29:33 -0400
Received: by mail-io1-f65.google.com with SMTP id v6so7108915iob.4;
        Thu, 23 Jul 2020 10:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H8SSOSWK9ZQn/87T9a7cJ2FJvmQuT0AXY8yIP6WSR7A=;
        b=TivqGAVE+6jXfb3+irgstqkvGPeDHnpKxUV5qq2fKt371FrB0JpzltwJEHHJ15dXPC
         C8c5t3te+km6KK+tAODeb6XXPT9WzRjIk6yKDQgr9LFLE1TJZH7i0Q601uwBK5JLWVTS
         MXeRUtA/HeWyCuU1qFWr+9beYAgdDjEKjntbK9fp2qEwUvI/tV3/BPFNKrVx898hALgk
         Ivfpsk6DhRLl6lDfPZM3L19ls+JVXt/jiDTsanEU/yk6Yl8jsVcW7AuufJRIT/IslmBO
         8SqEHrYfa79DLuCZV5LUeZeHuxs9TeQme/iQ3TyP0wX3hA+oWRySAeB0xD7Ie8SonKFz
         XgGA==
X-Gm-Message-State: AOAM53119Ukz6D8wi1JBz027rzi4sKA5oOgg8yT2VLfiBOwA9AQ5lggX
        Lh6Ztw11OwFGcAoM/NWej+u5PM/pOw==
X-Google-Smtp-Source: ABdhPJyPr4WMPdjwerziMWECWbOdCrzVcN5jJ7eSieuD6AEc74+VXTYIYYRCuWOF4RprQSk/2AlpkA==
X-Received: by 2002:a05:6602:1225:: with SMTP id z5mr6127039iot.64.1595525372555;
        Thu, 23 Jul 2020 10:29:32 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r23sm1795922iob.42.2020.07.23.10.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 10:29:31 -0700 (PDT)
Received: (nullmailer pid 571644 invoked by uid 1000);
        Thu, 23 Jul 2020 17:29:29 -0000
Date:   Thu, 23 Jul 2020 11:29:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v4 3/3] dt-bindings: clk: versaclock5: convert to yaml
Message-ID: <20200723172929.GA571596@bogus>
References: <20200723074112.3159-1-luca@lucaceresoli.net>
 <20200723074112.3159-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723074112.3159-4-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 09:41:12 +0200, Luca Ceresoli wrote:
> Convert to yaml the VersaClock bindings document. The mapping between
> clock specifier and physical pins cannot be described formally in yaml
> schema, then keep it verbatim in the description field.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes in v4: none.
> 
> Changes in v3:
>  - schema syntax fixes: use enum to constrain reg, don't use defines as
>    enums, drop type for standard unit suffix, fix syntax for clock-names
>    property (all suggested by Rob Herring)
> ---
>  .../bindings/clock/idt,versaclock5.txt        | 125 --------------
>  .../bindings/clock/idt,versaclock5.yaml       | 154 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 155 insertions(+), 125 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
