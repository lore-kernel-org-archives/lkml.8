Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C229EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E82063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe1X843T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391403AbgF2Vm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgF2Shx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:53 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED73C02F031
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:59:48 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 5so13775796oty.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O9Y/+e/e29D9znyzVTDfGPWcbDE2sgU04HkRdXVP2Y0=;
        b=Pe1X843TCcJC8mG7AsPGFWzJt/6SM1sl85DIfk19L1KrVD6knekTW4seEvRud51YLG
         yF9aKcbBg4q775aYOUzlkGAEJOOOKRiyuBwuilfm4pPJIUy3YX/pmL/EAGHifRbCyiJq
         k3FQUeAHHiajm2816UP4/LUgQgs/2o4zcgAYmf9l28dk5cUNyniMVkGWO1vxa6IShY/S
         pO1B9AxL0HEbQeut+iS4tR4xrH+F+Df/XvWpU4Erj+xwyJzWZWqIbFAIJuInnq9P1U+g
         FKrIUvKc+LBQf2TFAwHy/02dsywvHZkFa6sDSr5r6rYstA7KtHHXW06HvIlHVuk20on5
         ycjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O9Y/+e/e29D9znyzVTDfGPWcbDE2sgU04HkRdXVP2Y0=;
        b=D3J4/Jm4fOQmu/rF0fXBRN1uRz0UNDuCkX7AR1eSZzHBOuW5Lk6I05k7zEoDcVmwyx
         Wj/pvq1/zrl34qD55/K0ltNHqH1jT/RS0d2G/NAQZw8rnpjOFpC8L/Hmehv2EM2Fmscy
         DWZssHmkIuJ1vEczQC/JkFfuYRCBf6NN7nft/XZNsrgPeOWhnVS7LRJNJoOFnxI4uWOs
         uXa3JUbfamMkRiMqiwkMHJzQfqZ70Qqp9FrSntBLwyHiJipNzzUYFzRJakctjyCd7y5z
         do82bbG8+joWdq8WMQTX7EMwSl+2jBnRh2s4m0A+e/elBmub6dTQA2TAloQ4l8oW7kOE
         o1Nw==
X-Gm-Message-State: AOAM533+/2hBRYqYYSRvKzowRw5oPTFFtZR7n4yUinRhoqqpav1diwU9
        CpFha7jx0WP+cSyqep4orIQgwRQ6NotMi9Y2oMY=
X-Google-Smtp-Source: ABdhPJxlHj+j8ZYs6uJnfSfCiAx17n4DDEDtLjPmb8ihqGFXQe3xIjU2VD3uRKFJGZJB9fzSwltqlI9xmBA20MbcoMU=
X-Received: by 2002:a4a:dfb5:: with SMTP id k21mr6039768ook.27.1593442787765;
 Mon, 29 Jun 2020 07:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140442.1043957-1-lee.jones@linaro.org> <20200629140442.1043957-6-lee.jones@linaro.org>
In-Reply-To: <20200629140442.1043957-6-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 29 Jun 2020 17:59:19 +0300
Message-ID: <CAFCwf10QWLtuK3FmS+251o-aD+t8AOp4CHFaUwm-2fCQqOLvGA@mail.gmail.com>
Subject: Re: [PATCH 05/20] misc: habanalabs: irq: Repair kerneldoc formatting issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 5:04 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> W=1 kernel builds report a lack of descriptions for various
> function arguments.  In reality they are documented, but the
> formatting was not as expected '@.*:'.  Instead, '-'s were
> used as separators.
>
> While we're here, the headers for functions various functions
> were written in kerneldoc format, but lack the kerneldoc
> identifier '/**'.  Let's promote them so they can gain access
> to the checker.
>
> This change fixes the following W=1 warnings:
>
>  drivers/misc/habanalabs/irq.c:24: warning: Function parameter or member 'eq_work' not described in 'hl_eqe_work'
>  drivers/misc/habanalabs/irq.c:24: warning: Function parameter or member 'hdev' not described in 'hl_eqe_work'
>  drivers/misc/habanalabs/irq.c:24: warning: Function parameter or member 'eq_entry' not described in 'hl_eqe_work'
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/irq.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
> index 4e77a73857793..6981d67153b11 100644
> --- a/drivers/misc/habanalabs/irq.c
> +++ b/drivers/misc/habanalabs/irq.c
> @@ -13,9 +13,9 @@
>   * struct hl_eqe_work - This structure is used to schedule work of EQ
>   *                      entry and armcp_reset event
>   *
> - * @eq_work          - workqueue object to run when EQ entry is received
> - * @hdev             - pointer to device structure
> - * @eq_entry         - copy of the EQ entry
> + * @eq_work:          workqueue object to run when EQ entry is received
> + * @hdev:             pointer to device structure
> + * @eq_entry:         copy of the EQ entry
>   */
>  struct hl_eqe_work {
>         struct work_struct      eq_work;
> @@ -23,7 +23,7 @@ struct hl_eqe_work {
>         struct hl_eq_entry      eq_entry;
>  };
>
> -/*
> +/**
>   * hl_cq_inc_ptr - increment ci or pi of cq
>   *
>   * @ptr: the current ci or pi value of the completion queue
> @@ -39,7 +39,7 @@ inline u32 hl_cq_inc_ptr(u32 ptr)
>         return ptr;
>  }
>
> -/*
> +/**
>   * hl_eq_inc_ptr - increment ci of eq
>   *
>   * @ptr: the current ci value of the event queue
> @@ -66,7 +66,7 @@ static void irq_handle_eqe(struct work_struct *work)
>         kfree(eqe_work);
>  }
>
> -/*
> +/**
>   * hl_irq_handler_cq - irq handler for completion queue
>   *
>   * @irq: irq number
> @@ -142,7 +142,7 @@ irqreturn_t hl_irq_handler_cq(int irq, void *arg)
>         return IRQ_HANDLED;
>  }
>
> -/*
> +/**
>   * hl_irq_handler_eq - irq handler for event queue
>   *
>   * @irq: irq number
> @@ -206,7 +206,7 @@ irqreturn_t hl_irq_handler_eq(int irq, void *arg)
>         return IRQ_HANDLED;
>  }
>
> -/*
> +/**
>   * hl_cq_init - main initialization function for an cq object
>   *
>   * @hdev: pointer to device structure
> @@ -238,7 +238,7 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
>         return 0;
>  }
>
> -/*
> +/**
>   * hl_cq_fini - destroy completion queue
>   *
>   * @hdev: pointer to device structure
> @@ -269,7 +269,7 @@ void hl_cq_reset(struct hl_device *hdev, struct hl_cq *q)
>         memset((void *) (uintptr_t) q->kernel_address, 0, HL_CQ_SIZE_IN_BYTES);
>  }
>
> -/*
> +/**
>   * hl_eq_init - main initialization function for an event queue object
>   *
>   * @hdev: pointer to device structure
> @@ -297,7 +297,7 @@ int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
>         return 0;
>  }
>
> -/*
> +/**
>   * hl_eq_fini - destroy event queue
>   *
>   * @hdev: pointer to device structure
> --
> 2.25.1
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
