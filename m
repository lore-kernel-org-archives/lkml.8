Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A53C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAA1206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlMOfJsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgHLIoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgHLIoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:44:08 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A487C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:44:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so1308676ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3ont+IhtubZM/wNhWwpAZ22FZM1pN72lm7x2Pj1MhxA=;
        b=nlMOfJsU3u1Vk+cjBPriOLQ1YmDHxHYtAd5Nx/V0dToEc2WLOA18mw9NhsaJWiDjbQ
         BDeEtHBgdGsWPa8G8qjSJAQ6LDmL2oYIGiwsnI2z3gzDjF/pZmNC4jReSjonp7Lp4KQG
         0e8RvwDfVuZAsS8nAk5SiYyqT8WzO+CVGSEYF9cR77eTX/IHXj3yly8T4OrR0pfOkzJz
         ebtIrE1mLe3u7AgESENmg71s5S8PWWeAo0bwjAoE43mh/EtYcjzzSDVz15JGtKqGlamB
         oDw+R8UNDPzhjz1XigI72xGu+tQNJyAu85frGrKDMr+mBlTULnk8VHPoLCdGiODIMRvu
         DWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ont+IhtubZM/wNhWwpAZ22FZM1pN72lm7x2Pj1MhxA=;
        b=oYnTXjJSUt9LMsICBgfINBfQgfk8WxAZXX1WXVgSuTtb/oECsYbH+tFQRrmBRAZxVR
         xz6QiRDXfTmSjJpWCEaMmTVYsNVz3/6+xQwXgpIW0YJZwUXjOhX0nFSMiEqP7BzZO0Mb
         DBMP2ONlZWzTdRUZlTlbZIcSy056Odu7C9hcptWB/GvVDByoe3gSAjXMrUuV6hL5Regk
         Uacl6//Io05pFIy87ioERrYLH9opw3p+wsl01FRa8ID/2naSXSu4jS1a1FMKy1RJiWvh
         wtWW/KdtAEMOlRJgz7/KtMYvNfMHBEzYpKyueyNlOepmLR9aZMnY9N/3x6yCWTYmVrK5
         X7Fg==
X-Gm-Message-State: AOAM531UljvzAfNyj202y5WfOhMf2lMV41nPUP3y+cW5VENi57KzK4Qn
        Z6ZmWZmD1BqBIsjpc5RVjEFEBpWse5Y=
X-Google-Smtp-Source: ABdhPJwxgabrvImUUJkP/9sclpmZ7f9yeVpOa6SXHL/v9oqVHRfEYuaabFYhv43tBPaLKyTpDJZDlQ==
X-Received: by 2002:a2e:914e:: with SMTP id q14mr5109227ljg.182.1597221846457;
        Wed, 12 Aug 2020 01:44:06 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id j18sm296687ljg.5.2020.08.12.01.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 01:44:05 -0700 (PDT)
Date:   Wed, 12 Aug 2020 10:44:03 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200812084403.GA19230@jade>
References: <20200811175531.10771-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811175531.10771-1-jorge@foundries.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:55:31PM +0200, Jorge Ramirez-Ortiz wrote:
> Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> control this type of cryptographic devices it needs coordinated access
> to the bus, so collisions and RUNTIME_PM dont get in the way.
> 
> This trampoline driver allow OP-TEE to access them.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  v7: add support for ten bit i2c slave addressing
>  v6: compile out if CONFIG_I2C not enabled
>  v5: alphabetic order of includes
>  v4: remove unnecessary extra line in optee_msg.h
>  v3: use from/to msg param to support all types of memory
>      modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
>      
>  drivers/tee/optee/optee_msg.h | 21 ++++++++
>  drivers/tee/optee/rpc.c       | 95 +++++++++++++++++++++++++++++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 795bc19ae17a..7b2d919da2ac 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -419,4 +419,25 @@ struct optee_msg_arg {
>   */
>  #define OPTEE_MSG_RPC_CMD_SHM_FREE	7
>  
> +/*
> + * Access a device on an i2c bus
> + *
> + * [in]  param[0].u.value.a		mode: RD(0), WR(1)
> + * [in]  param[0].u.value.b		i2c adapter
> + * [in]  param[0].u.value.c		i2c chip
> + *
> + * [in]  param[1].u.value.a		i2c control flags
> + *
> + * [in/out] memref[2]			buffer to exchange the transfer data
> + *					with the secure world
> + *
> + * [out]  param[3].u.value.a		bytes transferred by the driver
> + */
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> +/* I2C master transfer modes */
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> +/* I2C master control flags */
> +#define OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT  BIT(0)
> +
>  #endif /* _OPTEE_MSG_H */
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index b4ade54d1f28..b6178761d79f 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
>  #include "optee_private.h"
> @@ -49,6 +50,97 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>  	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  }
>  
> +#if IS_ENABLED(CONFIG_I2C)
> +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> +					     struct optee_msg_arg *arg)
> +{
> +	struct i2c_client client = { 0 };
> +	struct tee_param *params;
> +	int i, ret = -EOPNOTSUPP;
> +	uint32_t attr[] = {
uint32_t seems a randomly chosen type here. The
TEE_IOCTL_PARAM_ATTR_TYPE_* defines fit in a u8.
Consider u8 attr[] = { instead.

> +		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> +		TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> +		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT,
> +	};
> +
> +	if (arg->num_params != ARRAY_SIZE(attr)) {
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +		return;
> +	}
> +
> +	params = kmalloc_array(arg->num_params, sizeof(struct tee_param),
> +			       GFP_KERNEL);
> +	if (!params) {
> +		arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> +		return;
> +	}
> +
> +	if (optee_from_msg_param(params, arg->num_params, arg->params))
> +		goto bad;
> +
> +	for (i = 0; i < arg->num_params; i++) {
arg->num_params has an unsigned type. Consider giving i an unsigned type
too.

> +		if ((params[i].attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK)
> +		    != attr[i])
It looks a bit funny with the comparison at the beginning of the line,
normally we try to leave those at the end of the line. But
optee_from_msg_param() doesn't set any higher bits in params[i].attr so
you could also simplify the expression as:
		if (params[i].attr != attr[i])

> +			goto bad;
> +	}
> +
> +	client.adapter = i2c_get_adapter(params[0].u.value.b);
> +	if (!client.adapter)
> +		goto bad;
> +
> +	if (params[1].u.value.a & OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT) {
> +		if (!i2c_check_functionality(client.adapter,
> +					     I2C_FUNC_10BIT_ADDR)) {
> +			i2c_put_adapter(client.adapter);
> +			goto bad;
> +		}
> +
> +		client.flags = I2C_CLIENT_TEN;
> +	}
> +
> +	client.addr = params[0].u.value.c;
> +	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> +
> +	switch (params[0].u.value.a) {
> +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> +		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
> +				      params[2].u.memref.size);
> +		break;
> +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> +		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
> +				      params[2].u.memref.size);
> +		break;
> +	default:
> +		i2c_put_adapter(client.adapter);
> +		goto bad;
> +	}
> +
> +	if (ret < 0) {
> +		arg->ret = TEEC_ERROR_COMMUNICATION;
> +	} else {
> +		params[3].u.value.a = ret;
> +		arg->ret = TEEC_SUCCESS;
> +
> +		if (optee_to_msg_param(arg->params, arg->num_params, params))
> +			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
Need
arg->ret = TEEC_SUCCESS;
when everything is OK.

> +	}
> +
> +	i2c_put_adapter(client.adapter);
> +	kfree(params);
> +	return;
> +bad:
> +	kfree(params);
> +	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +}
> +#else
> +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> +					     struct optee_msg_arg *arg)
> +{
> +	arg->ret = TEEC_ERROR_COMMUNICATION;
I'd prefer TEEC_ERROR_NOT_SUPPORTED here.
TEEC_ERROR_NOT_SUPPORTED would need to be defined as:
#define TEEC_ERROR_NOT_SUPPORTED        0xFFFF000A
in optee_private.h

Cheers,
Jens

> +}
> +#endif
> +
>  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
>  {
>  	struct wq_entry *w;
> @@ -382,6 +474,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>  	case OPTEE_MSG_RPC_CMD_SHM_FREE:
>  		handle_rpc_func_cmd_shm_free(ctx, arg);
>  		break;
> +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> +		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> +		break;
>  	default:
>  		handle_rpc_supp_cmd(ctx, arg);
>  	}
> -- 
> 2.17.1
> 
