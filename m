Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E56020714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="l4f9ayPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgG1KIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgG1KIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:08:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B654C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:08:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d6so6221029ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=em1KZWijnQIs6/lYjcU+FHv7CE2sWjgWXPkYXcVOh7I=;
        b=l4f9ayPrmfdWurLQht4J7s1wrpk6U3aK4h2ISGhyQLofoDzOprfvGnG2D3G9VZ3Hlb
         LsOnG0uBqq9Uef33oxiFbZxnwoT24Dx84NmtUc6XIePdlPDT+BBUveGE3787uZslk5jN
         MNo0a3ByPzk2jdEAr8liVKIjS/dH2DLHaFSHnCDAKFCU9gqLSqLz+RoCO+WyLnXXWwwz
         /405eyZ4TvF7DaskhWjStN8Dbcj4vdW5g0WnSeL3KejjZ1HBm6xZmDM59C+teXuHllL2
         hvoWfP7PDaIhKW3pgMdrzzS7aMJaOBe9WL/pBwX+6xUowqaDCiD5fdPPO7i3nh0wIrCH
         xyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=em1KZWijnQIs6/lYjcU+FHv7CE2sWjgWXPkYXcVOh7I=;
        b=lAh4/zuHTDg5SZCH5td4RENbIenApnnmJ3fkC5sVBsudcv6kKHztp7cJDHy76ULq4x
         LMOTO4376eTvlwXc24a1aS48igRmWRsWQyBP7rmBR/zTWVZAgwNjelZRHamCbkga0MAN
         pT+92kF72P+N/gfWks+FChTZwZ/hnmJvGihgmWsaqI8o2F4H6mKgu5u59+IR8olqnMlY
         zzwvOPMSgmkGfkjWYLhhDGuLWXLas0xdxFlrkDWHS16Y98hJEWKK8XxC0kYwjP+8wskp
         W8AuSA6h3/Ae25om/56AVz3epyJA6aDAlxBXaC5JRNveP4YfQamZrSlKmNObQlZCQfNi
         XcOA==
X-Gm-Message-State: AOAM530QzeHdDJ4sEW3rkDBR6mXaaWH9Jf7QiN4T1gCjhRpZv5G/kRpI
        +AsafvZ0VLqWk+2aGefpVWQs0VNSQ5g=
X-Google-Smtp-Source: ABdhPJxgTk91RIzHh8s7Y3BqeIvXINzjt5kCV+TQocLkXAKBXoQq3hKxexSx4PPQsI37GwhcBitLmg==
X-Received: by 2002:adf:a19e:: with SMTP id u30mr23917339wru.274.1595930931163;
        Tue, 28 Jul 2020 03:08:51 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id p15sm15507909wrj.61.2020.07.28.03.08.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 03:08:50 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Tue, 28 Jul 2020 12:08:49 +0200
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     jens.wiklander@linaro.org, sumit.garg@linaro.org,
        ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200728100849.GA2365@trex>
References: <20200722212105.1798-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722212105.1798-1-jorge@foundries.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/20, Jorge Ramirez-Ortiz wrote:
> Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> control this type of cryptographic devices it needs coordinated access
> to the bus, so collisions and RUNTIME_PM dont get in the way.
> 
> This trampoline driver allow OP-TEE to access them.
> Tested on imx8mm LPDDR4
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  v6: compile out if CONFIG_I2C not enabled
>  v5: alphabetic order of includes
>  v4: remove unnecessary extra line in optee_msg.h
>  v3: use from/to msg param to support all types of memory
>      modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
>      
>  drivers/tee/optee/optee_msg.h | 16 +++++++
>  drivers/tee/optee/rpc.c       | 88 +++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 795bc19ae17a..14b580f55356 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -419,4 +419,20 @@ struct optee_msg_arg {
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
> + * [in/out] memref[1]			buffer to exchange the transfer data
> + *					with the secure world
> + *
> + * [out]  param[0].u.value.a		bytes transferred by the driver
> + */
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> +
>  #endif /* _OPTEE_MSG_H */
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index b4ade54d1f28..5fd5c6c93896 100644
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
> @@ -49,6 +50,90 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>  	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>  }
>  
> +#if IS_ENABLED(CONFIG_I2C)
> +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> +					     struct optee_msg_arg *arg)
> +{
> +	struct i2c_client client;
> +	struct tee_param *params;
> +	uint32_t type;
> +	int i, ret;
> +	size_t len;
> +	char *buf;
> +	uint32_t attr[] = {
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
> +		type = params[i].attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK;
> +		if (type != attr[i])
> +			goto bad;
> +	}
> +
> +	client.addr = params[0].u.value.c;
> +	client.adapter = i2c_get_adapter(params[0].u.value.b);
> +	if (!client.adapter)
> +		goto bad;
> +
> +	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> +
> +	buf = params[1].u.memref.shm->kaddr;
> +	len = params[1].u.memref.size;
> +
> +	switch (params[0].u.value.a) {
> +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> +		ret = i2c_master_recv(&client, buf, len);
> +		break;
> +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> +		ret = i2c_master_send(&client, buf, len);
> +		break;
> +	default:
> +		i2c_put_adapter(client.adapter);
> +		goto bad;
> +	}
> +
> +	if (ret >= 0) {
> +		params[2].u.value.a = ret;
> +		arg->ret = TEEC_SUCCESS;
> +	} else {
> +		arg->ret = TEEC_ERROR_COMMUNICATION;
> +	}
> +
> +	if (optee_to_msg_param(arg->params, arg->num_params, params))
> +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
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
> +}
> +#endif
> +
>  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
>  {
>  	struct wq_entry *w;
> @@ -382,6 +467,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>  	case OPTEE_MSG_RPC_CMD_SHM_FREE:
>  		handle_rpc_func_cmd_shm_free(ctx, arg);
>  		break;
> +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> +		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> +		break;
>  	default:
>  		handle_rpc_supp_cmd(ctx, arg);
>  	}

any comments to this feature?

TIA
