Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2B9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB1F206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="PYZihS92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgEUWGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbgEUWGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:06:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:06:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so3977494pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=RSyLfeB8dEV3z/y2+gsh4gqtdB6V3zK8f0AJi0FU88c=;
        b=PYZihS92UbncqYg8RENTRyepp1+gJxWWtrvM8AQ4PbNw4yze3AgQe3kX7lTgECAt2O
         E1PyrVTytLesvJO3C1CyhdX6TyW0fg768gYWdv0HKnY93uPWTs3QD1UA92Ie6M9aRg3j
         W2vXXHNROHn0lDjrRXVbOaIZ+M5cFMJV655YYjr/5j1OZi9ZC1+IxBrfIkxq7hiQX/YV
         Ns9NOX4cYCLH0CndzCPCuoS59MsoH3TRVF2GS0paDkj8ClPQGDTOG8kmOO/4KHJTv8lK
         Kg6aVwtUdzY/2X5yqoaNsHZ/t3EweovVsXmht1qQYqrU8OTV7TfqTm9i5xuDff7loECr
         +UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=RSyLfeB8dEV3z/y2+gsh4gqtdB6V3zK8f0AJi0FU88c=;
        b=h9Wu+2zFI/8svVrq4r32v56BKCXcntPXdYUtjLH5OaNQAq/s6fzKNHOXm44ECqCv25
         sbBxLxmvRE6sG92wa+38qJ5I2U06VbLNNQUd8hlh9SdUcGGdAbRncFDjteXQySzoiitS
         uLOiWFOF9B9aGs71Vrl/auCVMXpYt6W1OSjj09evrDjOZihsGQgF7turvY/9CEk5w3hV
         B/sHMTWlM8qMSBkIjKtCQf0lO9SFEU67XSKO/nX1SnJtb+fIkhViv0of2+aHkEADuHey
         A1OGqWvTPrtehAL3e7jypaKDzIaeUSePcInv37eOzSSRxXOAruMr2m3kjEAGqyzOq1IO
         bcUA==
X-Gm-Message-State: AOAM533qaL+K7T0qK0hU+1hGH0I+MEAoslke4l4lKbrah/coOJvUMuHI
        0mlsp0tBBmtznBwEb7q6ruxVeA==
X-Google-Smtp-Source: ABdhPJzlvinwMq9zxQPR3NnO8SjsL0onlz8PyEjH3sglw8mhSJzduIZnAHkgAy/OgBR+Zv2cLgKc3A==
X-Received: by 2002:a17:90a:1c81:: with SMTP id t1mr595819pjt.177.1590098780793;
        Thu, 21 May 2020 15:06:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id mu17sm5941296pjb.53.2020.05.21.15.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:06:18 -0700 (PDT)
Date:   Thu, 21 May 2020 15:06:18 -0700 (PDT)
X-Google-Original-Date: Thu, 21 May 2020 15:00:02 PDT (-0700)
Subject:     Re: [PATCH v2 3/3] irqchip/sifive-plic: Improve boot prints for multiple PLIC instances
In-Reply-To: <20200518091441.94843-4-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, tglx@linutronix.de,
        jason@lakedaemon.net, Marc Zyngier <maz@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-552cff49-648e-42e9-850a-50d0855fc9f4@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 02:14:41 PDT (-0700), Anup Patel wrote:
> We improve PLIC banner to help distinguish multiple PLIC instances
> in boot time prints.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 6c54abf5cc5e..d9c53f85a68e 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -380,8 +380,8 @@ static int __init plic_init(struct device_node *node,
>  		plic_cpuhp_setup_done = true;
>  	}
>
> -	pr_info("mapped %d interrupts with %d handlers for %d contexts.\n",
> -		nr_irqs, nr_handlers, nr_contexts);
> +	pr_info("%pOFP: mapped %d interrupts with %d handlers for"
> +		" %d contexts.\n", node, nr_irqs, nr_handlers, nr_contexts);
>  	set_handle_irq(plic_handle_irq);
>  	return 0;

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
