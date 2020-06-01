Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F857C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 191A42074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 06:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXBpLs1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgFAGaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 02:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFAGaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 02:30:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC51C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:30:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q2so6666643ljm.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 23:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HMhaoQG1A1Rjl4FLG38IxlY1tBcTJX8s4fGnxMw0aw=;
        b=tXBpLs1w6NSnIf3SSuroi6t6n4yXGYaWFrA3FxSV//fXkj2BREssIsUyuB23mQ9rol
         KrnSL0W5uq3aaLmDaug23gE2gyi8o7LpyK2SB7Z6cckwck4JS+h0nurOIsajSrSmCZ+Y
         yzaRKWoOHRReKbqlZmVPph9ECdmfwTMFjB1jGBdsGlS1SgVrs6UOjh51bdm2T4NMF1S4
         B4guJbkHy5ft7SNSX83kGAYMhPNwPN4ascwMKsnEzLBOdy0fHPOV7xy41B3/kqzccVU8
         6cbooD63jFd7Y97Tm3xR6GTlb9nrHAdQ6QIFX7zF5CrXGTTpx9ipOCegJCsLlwTYElea
         XutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HMhaoQG1A1Rjl4FLG38IxlY1tBcTJX8s4fGnxMw0aw=;
        b=NtsMISxFjbvH8+KjjO5fUf+c+9TaTtt/KOWdSyZE3KXqTv0eegJTO/p4c/xrjftn/z
         0uVk1s/nXd5Llz+wzBu0xCw4HXX03aiV8T3j34wk390zLIR62sToMzdk0aY8LITvxEc6
         ifa+FZnFt2vRNAXGCAOuXJozZXZ9T9NHe1N4H/uw/BgbnzstH1hs/oj9ctgikVA7jcLK
         9wkZkRkC5/3H7Izb94F/iyb7LuUBlHUx5xCcinaQxPxPsQnIhey4o1jPcAcEkdiNOLpE
         sAxgRlDTMwt+dB7lnNTJQ/g9KZJZshNIZ1+Er6PbPSKFNrVpUZhrfElFq891Ko9NYuQo
         /zmw==
X-Gm-Message-State: AOAM530z9khrAPY1fXCvV/mUArqB2sHXMiMZvtjd0/vQ5XRHB2gOWkdY
        bzRlZU9NSKq9ooPTojFUeBcrwaSzW7dz/9t0qmGb2Kxi
X-Google-Smtp-Source: ABdhPJxEVPR6ZSSdXrNEm5O8hmoyO8drEBnlCBSZFCqkHX3JH6bFBJLL0VejR/HSe+C12PrDZGW3vBIWWEnzRt4fbrk=
X-Received: by 2002:a2e:a16e:: with SMTP id u14mr9322517ljl.427.1590993021760;
 Sun, 31 May 2020 23:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200531231135.12670-1-jorge@foundries.io>
In-Reply-To: <20200531231135.12670-1-jorge@foundries.io>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 1 Jun 2020 12:00:10 +0530
Message-ID: <CAFA6WYNKSgkGzuz47MBzdYzKd3__zPP2HNaOv7P-KR8RFea9fg@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCH v2] drivers: optee: allow op-tee to access
 devices on the i2c bus
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        ricardo@foundries.io, mike@foundries.io,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On Mon, 1 Jun 2020 at 04:41, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> control this type of cryptographic devices it needs coordinated access
> to the bus, so collisions and RUNTIME_PM dont get in the way.
>
> This trampoline driver allow OP-TEE to access them.
>

This sounds like an interesting use-case but I would like to
understand how secure is this communication interface with the secure
element? Like in the case of RPMB, secure world data is encrypted
which flows via tee-supplicant to RPMB device.

-Sumit

> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  drivers/tee/optee/optee_msg.h | 18 +++++++++++
>  drivers/tee/optee/rpc.c       | 57 +++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 795bc19ae17a..b6cc964fdeea 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -419,4 +419,22 @@ struct optee_msg_arg {
>   */
>  #define OPTEE_MSG_RPC_CMD_SHM_FREE     7
>
> +/*
> + * Access a device on an i2c bus
> + *
> + * [in]  param[0].u.value.a            mode: RD(0), WR(1)
> + * [in]  param[0].u.value.b            i2c adapter
> + * [in]  param[0].u.value.c            i2c chip
> + *
> + * [io]  param[1].u.tmem.buf_ptr       physical address
> + * [io]  param[1].u.tmem.size          transfer size in bytes
> + * [io]  param[1].u.tmem.shm_ref       shared memory reference
> + *
> + * [out]  param[0].u.value.a           bytes transferred
> + *
> + */
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 8
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> +
>  #endif /* _OPTEE_MSG_H */
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index b4ade54d1f28..21d452805c6f 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
> +#include <linux/i2c.h>
>  #include "optee_private.h"
>  #include "optee_smc.h"
>
> @@ -48,6 +49,59 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>  bad:
>         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  }
> +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> +                                            struct optee_msg_arg *arg)
> +{
> +       struct i2c_client client;
> +       struct tee_shm *shm;
> +       int i, ret;
> +       char *buf;
> +       uint32_t attr[] = {
> +               OPTEE_MSG_ATTR_TYPE_VALUE_INPUT,
> +               OPTEE_MSG_ATTR_TYPE_TMEM_INOUT,
> +               OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT,
> +       };
> +
> +       if (arg->num_params != ARRAY_SIZE(attr))
> +               goto bad;
> +
> +       for (i = 0; i < ARRAY_SIZE(attr); i++)
> +               if ((arg->params[i].attr & OPTEE_MSG_ATTR_TYPE_MASK) != attr[i])
> +                       goto bad;
> +
> +       shm = (struct tee_shm *)(unsigned long)arg->params[1].u.tmem.shm_ref;
> +       buf = (char *)shm->kaddr;
> +
> +       client.addr = arg->params[0].u.value.c;
> +       client.adapter = i2c_get_adapter(arg->params[0].u.value.b);
> +       if (!client.adapter)
> +               goto bad;
> +
> +       snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> +
> +       switch (arg->params[0].u.value.a) {
> +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> +               ret = i2c_master_recv(&client, buf, arg->params[1].u.tmem.size);
> +               break;
> +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> +               ret = i2c_master_send(&client, buf, arg->params[1].u.tmem.size);
> +               break;
> +       default:
> +               i2c_put_adapter(client.adapter);
> +               goto bad;
> +       }
> +
> +       if (ret >= 0) {
> +               arg->params[2].u.value.a = ret;
> +               arg->ret = TEEC_SUCCESS;
> +       } else
> +               arg->ret = TEEC_ERROR_COMMUNICATION;
> +
> +       i2c_put_adapter(client.adapter);
> +       return;
> +bad:
> +       arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +}
>
>  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
>  {
> @@ -382,6 +436,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>         case OPTEE_MSG_RPC_CMD_SHM_FREE:
>                 handle_rpc_func_cmd_shm_free(ctx, arg);
>                 break;
> +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> +               handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> +               break;
>         default:
>                 handle_rpc_supp_cmd(ctx, arg);
>         }
> --
> 2.17.1
>
> _______________________________________________
> Tee-dev mailing list
> Tee-dev@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/tee-dev
