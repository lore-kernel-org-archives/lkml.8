Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8C2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1A02076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="agV0pjX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgHETyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgHEQtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:49:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC98C0A54D7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 06:35:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 3so6379462wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XXeGLz34bYWmNFzqfqhBtWZ9iEar1i2pmO1UJcovYN0=;
        b=agV0pjX4C9pKnYX6aRQmdh11gXtpju5b6eyH31dPeE3+d0t0s8UmTLMKvFzbX0NGql
         BIpbiK5CXTPlUl1NNaefSN+RGPcsEsE8uwZF6QV6hBcDQlus9BFWTGCyHPV8CdbSNtTH
         DnI0EJBOdA3WYLC5MQ0ImCA9JghATjNOsXvcFiKgk9vqXb4jopbwUqxQiYJCS+S3dzZD
         e0GBLF0MRh7ZMmmY+McX6c3oQAryC8Il5xlx2AB+so/UCiZBnnxqDuIi2xjwNkBB1dnz
         XU5zN0E+8uZu4QRAcUkvoDRYMKN/6mg/5c2HZvKmOk9WdG4tJ4Kw/r67W8rqJD0jtN+m
         vyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XXeGLz34bYWmNFzqfqhBtWZ9iEar1i2pmO1UJcovYN0=;
        b=TvXM1kQ77UAn+WHgucl+MCOwQoJNGqEr2yTcmLnbc1NZ0MWlyb/FrullAucpIK9aS2
         4EBt+aGpWTnvjRnBcns34gsWG0It/RgUtDJFokQsfIUmDSJbpbehKnCFaLOmz66y8gpT
         fn2URdYnTph+ohD31bJhQr7f/jK75f7JzjuVwtRJlbfLUoojJdOnW56uB6wDx9Vd49F4
         4O0BynIV8KbQnug/XHQR+Q3AlgoNzfpR4uixB34uuUgTFDCkX8ksEc+vMyarQbwQSY0H
         b+OLB4lI4APM+tZjccDKSp579jmn0vaT0G6kFzQYZro4OBk7lKc+F3KF4ShTRCfuCRer
         M88g==
X-Gm-Message-State: AOAM532GMVkgDBoYYpYjRVlT+UXKtH2aNzELT763FahFT763INmPnYSf
        FFjBH+is3hMrgBEAlFgGQlaQpw==
X-Google-Smtp-Source: ABdhPJyUOCJay8eOBTQR8YFF6VpCvXgQAeXKUqTHzNDQGKnWVXRjM4m9NzNk3pSzAwtzcQVabNFsqg==
X-Received: by 2002:a1c:9952:: with SMTP id b79mr3389342wme.68.1596634503172;
        Wed, 05 Aug 2020 06:35:03 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id f15sm2948383wrt.80.2020.08.05.06.35.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 06:35:02 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Wed, 5 Aug 2020 15:35:01 +0200
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     jens.wiklander@linaro.org, sumit.garg@linaro.org,
        ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200805133501.GA8360@trex>
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


any comments please?
