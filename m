Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94464C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687142074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595882421;
	bh=rUt9rhTuXxrDU9oSTEBd/GawsqrRg//hGHy5AT4wb1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wq9S/XANy4qyUhi/W0UVYvW23S3c17oXYRKp4JHu/JNSAcwbM5zj32pxeB3FZoDDL
	 OYe9Yb9zjuP9joYdiXHNbHYdqK4FDcXQGkESk6aYxD/c4Mh/htYMB3ChjPokdFc5Ng
	 lwdUYGFIuo3XywKiR28J1RXJ9u7cqtUnsRaopzM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgG0UkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:40:20 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45399 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgG0UkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:40:19 -0400
Received: by mail-il1-f195.google.com with SMTP id b18so9087295ilo.12;
        Mon, 27 Jul 2020 13:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Td7E5j/pYqR2qW0Pg0Jh7MYMZ/6aP3UbVq7wrH2KwU=;
        b=P7ufcaAyPe0G8VWMfCVYgKcTx59t54PnBkR4gWC5D50omrx0TCx8zMCp2jqdnt/qVL
         tftjfVnBwG/LVb6+fBXsUn1skCVuRrPAiWcSyLscxXjmFwMLz6M68pDsfn3krlygF9pu
         GQ+dOcHI8U8IfMZvIhlbVGjBC67MsAdOtoj3xRKK1YJt9Km85wgWB283bMi4ldIlQ0oD
         6UD6Eu1L6eiskAa5uYfXH8ZWMqd955h37XBL75c9HwrpWOosZi+LpYsPh/XAo+G/kZIy
         RFrI5RIAIAAcStj9DOiG0/T6XlUqjZGeL0vUN4I39vE393+RLyTFvpHHpc1QuNPwtCmD
         DHRA==
X-Gm-Message-State: AOAM532cgPHfoVpKNeIsv6qCI5r4siov1r8v1N4iJGZbVK2MtxmSvf6k
        FSVjU5Gy1hieT4+bJ4OsbwPqrjX0Fw==
X-Google-Smtp-Source: ABdhPJzar3qYNFH1SZmi3V2Zmsfs0YajeL0JEZlhth0eNa+AC1Dv2WRzclj3usZ6oEjse4MS+1c1Bg==
X-Received: by 2002:a05:6e02:ead:: with SMTP id u13mr26030263ilj.46.1595882418215;
        Mon, 27 Jul 2020 13:40:18 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w22sm2280193ioc.24.2020.07.27.13.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:40:17 -0700 (PDT)
Received: (nullmailer pid 836467 invoked by uid 1000);
        Mon, 27 Jul 2020 20:40:16 -0000
Date:   Mon, 27 Jul 2020 14:40:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc:     b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4] video: fbdev: ssd1307fb: Added support to Column
 offset
Message-ID: <20200727204016.GA836415@bogus>
References: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595622138-3965-1-git-send-email-455.rodrigo.alencar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 17:22:18 -0300, Rodrigo Alencar wrote:
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.
> 
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
> ---
>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
>  drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
