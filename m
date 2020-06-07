Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70580C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 17:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4093520659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 17:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="N7cLr+d3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFGRiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgFGRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 13:38:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE5C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 10:38:18 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u26so12666077wmn.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yWwk+LcbqYHYkQbZUBX7pohTVSc/QhxHp1KS9ZURvL0=;
        b=N7cLr+d3J0QwTkFhX7pg47V0rMH5t2yNauqVS23Hq47dc1fb1mNHYrkiyrqsHNa7k6
         ob64FTrQ6J3W8/1nz+H54jA6YqzzVL38CxUh30ayj9J8VX3b5e4wkv+Q2HL5b7KeZb+D
         85x/8rkKor8/vU6ZXVOB/Qo/MhGNyqZHKKP9oPR6tHwzOAYiBGwi1HhQT2fuJZVLFfiQ
         pXuCA5AbJGQHZXCw96mGHkUvl1VLQ6IFxcUqof/uVUlQmabVrgw9TRM6ThWO+9WN/82S
         +E6C0Th/bLB+eg7TkY4zl2odIDSfle29dS5iWXm1jC0cKkuLoUVHj4bvhDBTFWBUBehQ
         WScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yWwk+LcbqYHYkQbZUBX7pohTVSc/QhxHp1KS9ZURvL0=;
        b=fRCrRu4tiOpxsrlAjlPkdeQx6Y/gGErHwYxK7lx9Hhpwep3WHjqiNgtzWoekICqWpB
         GuyKrkiGLlNSVaM+1z4KbAdIKb+V3H4JLVcLUX+iiiKlXbehV6J29gzdfKzSaPhkjZIw
         Wn+GGxb842qU3J/sNru6Efn/Y20997nVMF5Y5g7TKctFZzAJg379U6jb/w8RPhEuzBcX
         tozaZXLEhalupdzKxMONPXTEvqGmdGduP9jEOgJ4acxsvc0pIRMfFr0r6m/mNbJri9JG
         x0C+4kBqDIzXWPv4ANvUtVXulk0ZM2VyIyVbOFHO3cNBInmTio4LbIKS8CJ3AxYzpq5G
         AyuQ==
X-Gm-Message-State: AOAM5302OOP7eWdSqUQizQwLrUA+S9uEBvXTmLgnFPcjElL9bEN7z1z1
        34Sfig0AMOA4b9ymanmkAuk6Wg==
X-Google-Smtp-Source: ABdhPJy0aFEOcp9amvz3TFtf8YvQgM1HvbM04vcUA3PLcSxuRl5D1uvfRywDsebVHGQrjmqF6Cc8og==
X-Received: by 2002:a1c:188:: with SMTP id 130mr12835837wmb.93.1591551496723;
        Sun, 07 Jun 2020 10:38:16 -0700 (PDT)
Received: from trex (98.red-79-146-85.dynamicip.rima-tde.net. [79.146.85.98])
        by smtp.gmail.com with ESMTPSA id d16sm20113040wmd.42.2020.06.07.10.38.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Jun 2020 10:38:16 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Sun, 7 Jun 2020 19:38:14 +0200
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     jens.wiklander@linaro.org, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, ricardo@foundries.io,
        mike@foundries.io
Subject: Re: [PATCH v2] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200607173814.GA30457@trex>
References: <20200531231135.12670-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531231135.12670-1-jorge@foundries.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/20, Jorge Ramirez-Ortiz wrote:
> Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> control this type of cryptographic devices it needs coordinated access
> to the bus, so collisions and RUNTIME_PM dont get in the way.
> 
> This trampoline driver allow OP-TEE to access them.


any comments please?


> 
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
>  #define OPTEE_MSG_RPC_CMD_SHM_FREE	7
>  
> +/*
> + * Access a device on an i2c bus
> + *
> + * [in]  param[0].u.value.a		mode: RD(0), WR(1)
> + * [in]  param[0].u.value.b		i2c adapter
> + * [in]  param[0].u.value.c		i2c chip
> + *
> + * [io]  param[1].u.tmem.buf_ptr	physical address
> + * [io]  param[1].u.tmem.size		transfer size in bytes
> + * [io]  param[1].u.tmem.shm_ref	shared memory reference
> + *
> + * [out]  param[0].u.value.a		bytes transferred
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
>  	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  }
> +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> +					     struct optee_msg_arg *arg)
> +{
> +	struct i2c_client client;
> +	struct tee_shm *shm;
> +	int i, ret;
> +	char *buf;
> +	uint32_t attr[] = {
> +		OPTEE_MSG_ATTR_TYPE_VALUE_INPUT,
> +		OPTEE_MSG_ATTR_TYPE_TMEM_INOUT,
> +		OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT,
> +	};
> +
> +	if (arg->num_params != ARRAY_SIZE(attr))
> +		goto bad;
> +
> +	for (i = 0; i < ARRAY_SIZE(attr); i++)
> +		if ((arg->params[i].attr & OPTEE_MSG_ATTR_TYPE_MASK) != attr[i])
> +			goto bad;
> +
> +	shm = (struct tee_shm *)(unsigned long)arg->params[1].u.tmem.shm_ref;
> +	buf = (char *)shm->kaddr;
> +
> +	client.addr = arg->params[0].u.value.c;
> +	client.adapter = i2c_get_adapter(arg->params[0].u.value.b);
> +	if (!client.adapter)
> +		goto bad;
> +
> +	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> +
> +	switch (arg->params[0].u.value.a) {
> +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> +		ret = i2c_master_recv(&client, buf, arg->params[1].u.tmem.size);
> +		break;
> +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> +		ret = i2c_master_send(&client, buf, arg->params[1].u.tmem.size);
> +		break;
> +	default:
> +		i2c_put_adapter(client.adapter);
> +		goto bad;
> +	}
> +
> +	if (ret >= 0) {
> +		arg->params[2].u.value.a = ret;
> +		arg->ret = TEEC_SUCCESS;
> +	} else
> +		arg->ret = TEEC_ERROR_COMMUNICATION;
> +
> +	i2c_put_adapter(client.adapter);
> +	return;
> +bad:
> +	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> +}
>  
>  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
>  {
> @@ -382,6 +436,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
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
