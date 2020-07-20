Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739EEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CEC2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595272613;
	bh=EHwMPy6IQXswdK67BjR0rYM+TV1MliZGzMuMoUzDj4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SZywSbudV8TMlSKPEdMDoZMptc9Q0PIN0R+zqRsEPBXUU2mZ5vBMhUdWBWOwpxveL
	 /86i7RUPnH/C5EDkGZThBRumxtgLJhjcG3ypmWfLChDNxpKMggbE9N2rFOX10DT+4L
	 D4f9avVGz2EcJO6kcXPrYg4TE+anCNiEGSXgU+C8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgGTTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:16:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38212 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgGTTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:16:51 -0400
Received: by mail-io1-f68.google.com with SMTP id l1so18783685ioh.5;
        Mon, 20 Jul 2020 12:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9DxOFAwGubvLaH0SqU66V6v/xpX2Y+fOYrMivn+O2rE=;
        b=TpxbEuYwAIDqfVTyQqh/8n1U1xazDQx9aSCeUA5Axd/+P+DYqwYV1ExLSrl3xyxfPF
         1jOwib+16hfUv1GyseOvrLJJd+zQCNI4IAbuxebNpSEPUplJCLMjaCb6zHLCd15P/57K
         I+g2NfBmnQ6MfyYxRWjDG6u10jE3XfK6DJ+0W9pnAUU4rrxIXB/h52Y4xp/YOvWsbgfV
         VZV1WEfILQC4xPYGMMXFjFivOdQdyAkcVoJ6eP8o0DHUVescs8ghUmJSjoEsRgm4LrHa
         fvBaZfOoJwfOETUbImdwiQ3M2jgCfV1+C4sAsWKkrQTbGXJC7MpHL1ZqRnmBY41xNczc
         Rb+w==
X-Gm-Message-State: AOAM532Z4ImUJwRmMQfBDE5hZdl1HaF672C4Y8OGHouR5TO3cqdDFZtO
        zvIA2Hn8/3qE7nqgnYVDPg==
X-Google-Smtp-Source: ABdhPJwDvnqCPn7Oyfjjd7gooOxNb+wsLKuQ9z1lj2cFeSgqmv+cp/N9EzVRFmsyv9yv5gtVlK7fZw==
X-Received: by 2002:a02:c789:: with SMTP id n9mr2187151jao.40.1595272610287;
        Mon, 20 Jul 2020 12:16:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y12sm9224404ilg.84.2020.07.20.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:16:49 -0700 (PDT)
Received: (nullmailer pid 2845221 invoked by uid 1000);
        Mon, 20 Jul 2020 19:16:48 -0000
Date:   Mon, 20 Jul 2020 13:16:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        manivannan.sadhasivam@linaro.org, cristian.ciocaltea@gmail.com,
        andre.przywara@arm.com, vkoul@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        dan.j.williams@intel.com, afaerber@suse.de,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v7 01/10] dt-bindings: dmaengine: convert Actions Semi
 Owl SoCs bindings to yaml
Message-ID: <20200720191648.GA2844925@bogus>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-2-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-2-git-send-email-amittomer25@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 23:11:58 +0530, Amit Singh Tomar wrote:
> Converts the device tree bindings for the Actions Semi Owl SoCs DMA
> Controller over to YAML schemas.
> 
> It also adds new compatible string "actions,s700-dma".
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
> ---
> Changes since v6:
> 	* No change.
> Changes since v5:
>         * Removed Rob's Reviewed-by tag as his bot found errors
>           running 'make dt_binding_check'.
>         * Fixed the errore reported by Rob's bot, adjusting the reg
>           property in example.
> Changes since v4:
>         * Added Rob's Reviewed-by tag.
>         * Re-order it from 05/10 to 01/10.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * Addressed Rob's comments:
>            - removed unnecessary description.
>            - added unevaluatedProperties
>            - added relevant information about
>              dma-channels and dma-request
>         * Added power-domain property.
> Change since v1:
>         * Updated the description field to reflect
>           only the necessary information.
>         * replaced the maxItems field with description for each
>           controller attribute(except interrupts).
>         * Replaced the clock macro with number to keep the example
>           as independent as possible.
> ---
>  Documentation/devicetree/bindings/dma/owl-dma.txt  | 47 -------------
>  Documentation/devicetree/bindings/dma/owl-dma.yaml | 79 ++++++++++++++++++++++
>  2 files changed, 79 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
