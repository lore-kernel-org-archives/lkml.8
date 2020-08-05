Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96165C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60B242067D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 16:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9b9xRUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHEQso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgHEQqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:46:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E5C0086D6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 07:24:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so13425676ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4sZV1/gQN/258iL0rr5Xs5RZ6T6r7SkqFDya4T9+hhQ=;
        b=E9b9xRUZtCoNc7BmcnjKZKhPMW4C6kTS55eaU+9K6uRzDuW4TNj3CRV97WvzO/of2Y
         zwdRFO6qTxVL/8AJOZFe2VwM18ZDpa2zt7HE8TMzl/K9XNvba6QLBigNU4LDkz9fEp8h
         TozZAI8dmNwaLYwAj+rpf5m+fZxw1RFzua2mawTi4OcXBq0HskcqEmw7dfMK3gjhlI1f
         6+d48Ygix+b6dZvLFiZNPH1GLGnwyTP2eBGGnUlCxJzjYvmkqZ5LhvG60bflC5NfrouR
         qteTlbkjDme/q3Om8n6GR6GNVSRNYYXYVd93qBD8bFFI+1Ok7+GkCFm4Mbwy/lZUE3se
         BxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4sZV1/gQN/258iL0rr5Xs5RZ6T6r7SkqFDya4T9+hhQ=;
        b=BagE2tJGSGl1v1FIKI3lsO5tFWuaajOWfP6T7ecXxthnEf6rSmDeNly6ZPbc1x2Tgo
         Uq8NoEkSulX5mokfH2KPxGrlSOQRAHYCEm4/qC6Wb4soiAsuVRIYhwK2Kod7HJ26nXhh
         nwII8xgXjnf3DySfLn1OcASD5mQBkVJZbGMb2IUNRv8PAfGM3Ps8sJ31g2BbmlJ7fDCu
         J4GZ24weZRemVCsMPpIh+LcC4s7LRqVriCIIKVA5ce9EOKKMqgEtHEctz0oamSbSfWmW
         JxfUDCi5XJs7aPsXlJY0kCUCEyQMyD8VdnpzM3U5yURrHvfrNJJwiXut7oXMGbAD2wyL
         Sd6w==
X-Gm-Message-State: AOAM533bEFgE+r0vQ12opG4O+h8ZjlXo9d554FLkX8/y226ZVkpcqzub
        oekwywQlRq1uAn8q6GoRQ2SzYw==
X-Google-Smtp-Source: ABdhPJx5GVKqBcJfUrSinpyw/JPyAmFuCbg4ibeeyeBsa4MFulh9QF9PIbff8txGT7dzYpPegeBNSw==
X-Received: by 2002:a05:651c:3c5:: with SMTP id f5mr1467608ljp.209.1596637447389;
        Wed, 05 Aug 2020 07:24:07 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id e69sm1172866lfd.21.2020.08.05.07.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 07:24:06 -0700 (PDT)
Date:   Wed, 5 Aug 2020 16:24:04 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200805142404.GA550721@jade>
References: <20200722212105.1798-1-jorge@foundries.io>
 <20200805133501.GA8360@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200805133501.GA8360@trex>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 03:35:01PM +0200, Jorge Ramirez-Ortiz, Foundries wrote:
> On 22/07/20, Jorge Ramirez-Ortiz wrote:
> > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > control this type of cryptographic devices it needs coordinated access
> > to the bus, so collisions and RUNTIME_PM dont get in the way.
> > 
> > This trampoline driver allow OP-TEE to access them.
> > Tested on imx8mm LPDDR4
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  v6: compile out if CONFIG_I2C not enabled
> >  v5: alphabetic order of includes
> >  v4: remove unnecessary extra line in optee_msg.h
> >  v3: use from/to msg param to support all types of memory
> >      modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
> >      
> >  drivers/tee/optee/optee_msg.h | 16 +++++++
> >  drivers/tee/optee/rpc.c       | 88 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 104 insertions(+)
> > 
> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > index 795bc19ae17a..14b580f55356 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -419,4 +419,20 @@ struct optee_msg_arg {
> >   */
> >  #define OPTEE_MSG_RPC_CMD_SHM_FREE	7
> >  
> > +/*
> > + * Access a device on an i2c bus
> > + *
> > + * [in]  param[0].u.value.a		mode: RD(0), WR(1)
> > + * [in]  param[0].u.value.b		i2c adapter
> > + * [in]  param[0].u.value.c		i2c chip
> > + *
> > + * [in/out] memref[1]			buffer to exchange the transfer data
> > + *					with the secure world
> > + *
> > + * [out]  param[0].u.value.a		bytes transferred by the driver
> > + */
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> > +
> >  #endif /* _OPTEE_MSG_H */
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index b4ade54d1f28..5fd5c6c93896 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -7,6 +7,7 @@
> >  
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > +#include <linux/i2c.h>
> >  #include <linux/slab.h>
> >  #include <linux/tee_drv.h>
> >  #include "optee_private.h"
> > @@ -49,6 +50,90 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> >  	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_I2C)
> > +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > +					     struct optee_msg_arg *arg)
> > +{
> > +	struct i2c_client client;
> > +	struct tee_param *params;
> > +	uint32_t type;
> > +	int i, ret;
> > +	size_t len;
> > +	char *buf;
> > +	uint32_t attr[] = {
> > +		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > +		TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> > +		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT,
> > +	};
> > +
> > +	if (arg->num_params != ARRAY_SIZE(attr)) {
> > +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > +		return;
> > +	}
> > +
> > +	params = kmalloc_array(arg->num_params, sizeof(struct tee_param),
> > +			       GFP_KERNEL);
> > +	if (!params) {
> > +		arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> > +		return;
> > +	}
> > +
> > +	if (optee_from_msg_param(params, arg->num_params, arg->params))
> > +		goto bad;
> > +
> > +	for (i = 0; i < arg->num_params; i++) {
> > +		type = params[i].attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK;
> > +		if (type != attr[i])
> > +			goto bad;
> > +	}
> > +
> > +	client.addr = params[0].u.value.c;
> > +	client.adapter = i2c_get_adapter(params[0].u.value.b);
> > +	if (!client.adapter)
> > +		goto bad;
> > +
> > +	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > +
> > +	buf = params[1].u.memref.shm->kaddr;
> > +	len = params[1].u.memref.size;
> > +
> > +	switch (params[0].u.value.a) {
> > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > +		ret = i2c_master_recv(&client, buf, len);
> > +		break;
> > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > +		ret = i2c_master_send(&client, buf, len);
> > +		break;
> > +	default:
> > +		i2c_put_adapter(client.adapter);
> > +		goto bad;
> > +	}
> > +
> > +	if (ret >= 0) {
> > +		params[2].u.value.a = ret;
> > +		arg->ret = TEEC_SUCCESS;
> > +	} else {
> > +		arg->ret = TEEC_ERROR_COMMUNICATION;
> > +	}
> > +
> > +	if (optee_to_msg_param(arg->params, arg->num_params, params))
> > +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > +
> > +	i2c_put_adapter(client.adapter);
> > +	kfree(params);
> > +	return;
> > +bad:
> > +	kfree(params);
> > +	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > +}
> > +#else
> > +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > +					     struct optee_msg_arg *arg)
> > +{
> > +	arg->ret = TEEC_ERROR_COMMUNICATION;
> > +}
> > +#endif
> > +
> >  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
> >  {
> >  	struct wq_entry *w;
> > @@ -382,6 +467,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> >  	case OPTEE_MSG_RPC_CMD_SHM_FREE:
> >  		handle_rpc_func_cmd_shm_free(ctx, arg);
> >  		break;
> > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> > +		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> > +		break;
> >  	default:
> >  		handle_rpc_supp_cmd(ctx, arg);
> >  	}
> 
> 
> any comments please?

As you know we're still reviewing the secure world counterpart at
https://github.com/OP-TEE/optee_os/pull/3905
Where we're sorting out the ABI. Thanks for your patience.

Cheers,
Jens
