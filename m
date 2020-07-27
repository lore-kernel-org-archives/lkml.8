Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78618C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F6C2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595879867;
	bh=AiBAqpFxeHeNSbRY4yUHFgFczRLguUfLgWkOYhJBDA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eWW0DhlNoO5xP+kpxfcH6NQqWiaeCDIn6/yJQ+vMuUGVAMAmclAg70B9w6G3mnPgW
	 HcMJLrhJS67NrNucy6vbZeLoOEeYFQGPIT3FZwSlQRWndHZQFjoYpoj0f6HBPPalGZ
	 QblR2Nip7ug+NKajtmLW7lcO6naVI5Kt2Gy+IgbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgG0T5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:57:46 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38859 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgG0T5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:57:45 -0400
Received: by mail-il1-f195.google.com with SMTP id s21so14172048ilk.5;
        Mon, 27 Jul 2020 12:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QdSK9CKXiKnYsb9McMD2F1lNWXWXRWad4Tt2Gt7Chdw=;
        b=uEeQ6GlG937sc6RUDr3HL3gHPI2VaiFZ3FKTxefj11fmemHVMKdBxiDt626mnJu7DP
         EzHUaE3FjpDNpfreC9S/lCjG7OD+Se4OAiFsoui1UF1vPRlPG+4y4Muu3T7b7f3/ZMKG
         ForLPBBhV0wHhxwkkLJ/7qFu2d9fNoYJrWiUyatSYRThxGpuxZG+lKUQdU4CAh/I1h/t
         VTXNEbuQLmfWthqDfrDjaxblQJWbB/o9QGJxGWemUyWCs7F8U+5nSlCyU2+Jsfmq59gV
         Gt5lUPrn9PL23lDcUzxtaK2fOnsHFj4IT4KeC28Zb475wxtC5lsaG5uE4i+91CNkznva
         GSzQ==
X-Gm-Message-State: AOAM5318fufTbE4KcZGwUIT2F+zZX1USkCDR+Cs8Mlv+BbSQwLjRnBr0
        a/JxQ4WVUhZ0c7CyH6TkCg==
X-Google-Smtp-Source: ABdhPJxMcbGDddXTkDmm/J97zqehf9CyotRBkcoipmAMTTHYr9DZNZktmNji7EACPPz7EowekWZvHA==
X-Received: by 2002:a05:6e02:128d:: with SMTP id y13mr24745157ilq.305.1595879864663;
        Mon, 27 Jul 2020 12:57:44 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id x185sm3036863iof.41.2020.07.27.12.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 12:57:43 -0700 (PDT)
Received: (nullmailer pid 780250 invoked by uid 1000);
        Mon, 27 Jul 2020 19:57:42 -0000
Date:   Mon, 27 Jul 2020 13:57:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, wens@csie.org,
        liyong@allwinnertech.com, mripard@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-clk@vger.kernel.org,
        huangshuosheng@allwinnertech.com, tiny.windzz@gmail.com
Subject: Re: [PATCH v5 02/16] clk: sunxi-ng: add support for the Allwinner
 A100 CCU
Message-ID: <20200727195742.GA780202@bogus>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <1eb41bf6c966a0e54820200650d27a5d4f2ac160.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb41bf6c966a0e54820200650d27a5d4f2ac160.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 14:58:43 +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add support for a100 in the sunxi-ng CCU framework.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig                  |   10 +
>  drivers/clk/sunxi-ng/Makefile                 |    2 +
>  drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c      |  214 +++
>  drivers/clk/sunxi-ng/ccu-sun50i-a100-r.h      |   21 +
>  drivers/clk/sunxi-ng/ccu-sun50i-a100.c        | 1276 +++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-a100.h        |   56 +
>  include/dt-bindings/clock/sun50i-a100-ccu.h   |  116 ++
>  include/dt-bindings/clock/sun50i-a100-r-ccu.h |   23 +
>  include/dt-bindings/reset/sun50i-a100-ccu.h   |   68 +
>  include/dt-bindings/reset/sun50i-a100-r-ccu.h |   18 +
>  10 files changed, 1804 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.h
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100.h
>  create mode 100644 include/dt-bindings/clock/sun50i-a100-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun50i-a100-r-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-a100-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-a100-r-ccu.h
> 

Acked-by: Rob Herring <robh@kernel.org>
