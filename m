Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4053B22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="hNmZtfw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgHEUQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgHEUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:16:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D09C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 13:16:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so7579186wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mvZaPjIJLvtOgPYXMFlMx5wZd5X7d+jAa4ldSeMhyoQ=;
        b=hNmZtfw9e/tJMFfp21LgePx8DltnNpnr8FBE74vgHDQa3ZEWgdq3dOKzsjFaTdcQuC
         IVdke6Bv8KWffSRpEPYckwOf4LVo7qFLJHL/BO3kBQATUcGYdiN/GRSvmGOTPR28B6dU
         azuHtBLy6G52GZktGNjtuBcqEM3i4TlpNWZlPHyjBC4n08n4F/WZvvkxoKlLy+bIyvXM
         +MsAakuwy8XNXNvIXjsOw28Ov4b7z4WeLrQin4hbQEWkRqMuvEM8Gx/hi7GeQVHp29EE
         0Sbux34JbU+C15v+nnMmpGjrD28xSEZIpfNLo5AqZxW48l6PPTlH0SUaXhaCVO2eKFA9
         u4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mvZaPjIJLvtOgPYXMFlMx5wZd5X7d+jAa4ldSeMhyoQ=;
        b=LdJVw8jAnObZcklcEiAqybNtxsGCG7XFsJIxjuNzbn75KcP9IGyyrwCMLmm8Pwfvhx
         6Up8n0U/RMEjuTYao1VXHUA4bcwkUL7/fkf2+I8hOhu7Sf8DUyzB1ibEbVTkyFP4qsYs
         iZHisc4KDOlcmfzzygeuqIzsXSRl+dhvbKIs8/WW9TVJCt9cOZu4Q/J4Uhxhf9UP+fbe
         d21OdO8DAiFHKlBc9u3gYJabJWyWZqezxH+nAA0UTpu7b7tgVOnFjtlwiBKZZwpXoFFj
         umnOeJS6RrXpSfFt725BbuNPclmJXVKWHKv4ygWGn+v/qeBxUMLhQzrfqvRTsl/Ci2ER
         J48w==
X-Gm-Message-State: AOAM532+0ckh0Dvg4MP34u1EfMj0TXbPe6Myg6J3Ywd+DaS/UPRHr82b
        t6ibnlMjmsHdMShXD1tyh6Bigw6vhlEqcw==
X-Google-Smtp-Source: ABdhPJypxMiLvEy3JIjRjWxtXQqYwQQdXvAIyJE7Grq1AVxGxkensdbRojbsN4BLEOzzq+XjL66ohA==
X-Received: by 2002:a1c:1d91:: with SMTP id d139mr4933808wmd.144.1596658590287;
        Wed, 05 Aug 2020 13:16:30 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id l1sm4076167wrb.12.2020.08.05.13.16.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 13:16:29 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Wed, 5 Aug 2020 22:16:28 +0200
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200805201628.GA11492@trex>
References: <20200722212105.1798-1-jorge@foundries.io>
 <20200805133501.GA8360@trex>
 <20200805142404.GA550721@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805142404.GA550721@jade>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/20, Jens Wiklander wrote:
> On Wed, Aug 05, 2020 at 03:35:01PM +0200, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 22/07/20, Jorge Ramirez-Ortiz wrote:
> > > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > > control this type of cryptographic devices it needs coordinated access
> > > to the bus, so collisions and RUNTIME_PM dont get in the way.
> > > 
> > > This trampoline driver allow OP-TEE to access them.
> > > Tested on imx8mm LPDDR4
> > > 
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > ---
> > >  v6: compile out if CONFIG_I2C not enabled
> > >  v5: alphabetic order of includes
> > >  v4: remove unnecessary extra line in optee_msg.h
> > >  v3: use from/to msg param to support all types of memory
> > >      modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
> > >      
> > >  drivers/tee/optee/optee_msg.h | 16 +++++++
> > >  drivers/tee/optee/rpc.c       | 88 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 104 insertions(+)
> > > 
> > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > > index 795bc19ae17a..14b580f55356 100644
> > > --- a/drivers/tee/optee/optee_msg.h
> > > +++ b/drivers/tee/optee/optee_msg.h
> > > @@ -419,4 +419,20 @@ struct optee_msg_arg {
> > >   */
> > >  #define OPTEE_MSG_RPC_CMD_SHM_FREE	7
> > >  
> > > +/*
> > > + * Access a device on an i2c bus
> > > + *
> > > + * [in]  param[0].u.value.a		mode: RD(0), WR(1)
> > > + * [in]  param[0].u.value.b		i2c adapter
> > > + * [in]  param[0].u.value.c		i2c chip
> > > + *
> > > + * [in/out] memref[1]			buffer to exchange the transfer data
> > > + *					with the secure world
> > > + *
> > > + * [out]  param[0].u.value.a		bytes transferred by the driver
> > > + */
> > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> > > +
> > >  #endif /* _OPTEE_MSG_H */
> > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > index b4ade54d1f28..5fd5c6c93896 100644
> > > --- a/drivers/tee/optee/rpc.c
> > > +++ b/drivers/tee/optee/rpc.c
> > > @@ -7,6 +7,7 @@
> > >  
> > >  #include <linux/delay.h>
> > >  #include <linux/device.h>
> > > +#include <linux/i2c.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/tee_drv.h>
> > >  #include "optee_private.h"
> > > @@ -49,6 +50,90 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> > >  	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > >  }
> > >  
> > > +#if IS_ENABLED(CONFIG_I2C)
> > > +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > > +					     struct optee_msg_arg *arg)
> > > +{
> > > +	struct i2c_client client;
> > > +	struct tee_param *params;
> > > +	uint32_t type;
> > > +	int i, ret;
> > > +	size_t len;
> > > +	char *buf;
> > > +	uint32_t attr[] = {
> > > +		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
> > > +		TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
> > > +		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT,
> > > +	};
> > > +
> > > +	if (arg->num_params != ARRAY_SIZE(attr)) {
> > > +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > > +		return;
> > > +	}
> > > +
> > > +	params = kmalloc_array(arg->num_params, sizeof(struct tee_param),
> > > +			       GFP_KERNEL);
> > > +	if (!params) {
> > > +		arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> > > +		return;
> > > +	}
> > > +
> > > +	if (optee_from_msg_param(params, arg->num_params, arg->params))
> > > +		goto bad;
> > > +
> > > +	for (i = 0; i < arg->num_params; i++) {
> > > +		type = params[i].attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK;
> > > +		if (type != attr[i])
> > > +			goto bad;
> > > +	}
> > > +
> > > +	client.addr = params[0].u.value.c;
> > > +	client.adapter = i2c_get_adapter(params[0].u.value.b);
> > > +	if (!client.adapter)
> > > +		goto bad;
> > > +
> > > +	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > > +
> > > +	buf = params[1].u.memref.shm->kaddr;
> > > +	len = params[1].u.memref.size;
> > > +
> > > +	switch (params[0].u.value.a) {
> > > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > > +		ret = i2c_master_recv(&client, buf, len);
> > > +		break;
> > > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > > +		ret = i2c_master_send(&client, buf, len);
> > > +		break;
> > > +	default:
> > > +		i2c_put_adapter(client.adapter);
> > > +		goto bad;
> > > +	}
> > > +
> > > +	if (ret >= 0) {
> > > +		params[2].u.value.a = ret;
> > > +		arg->ret = TEEC_SUCCESS;
> > > +	} else {
> > > +		arg->ret = TEEC_ERROR_COMMUNICATION;
> > > +	}
> > > +
> > > +	if (optee_to_msg_param(arg->params, arg->num_params, params))
> > > +		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > > +
> > > +	i2c_put_adapter(client.adapter);
> > > +	kfree(params);
> > > +	return;
> > > +bad:
> > > +	kfree(params);
> > > +	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > > +}
> > > +#else
> > > +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > > +					     struct optee_msg_arg *arg)
> > > +{
> > > +	arg->ret = TEEC_ERROR_COMMUNICATION;
> > > +}
> > > +#endif
> > > +
> > >  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
> > >  {
> > >  	struct wq_entry *w;
> > > @@ -382,6 +467,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> > >  	case OPTEE_MSG_RPC_CMD_SHM_FREE:
> > >  		handle_rpc_func_cmd_shm_free(ctx, arg);
> > >  		break;
> > > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> > > +		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> > > +		break;
> > >  	default:
> > >  		handle_rpc_supp_cmd(ctx, arg);
> > >  	}
> > 
> > 
> > any comments please?
> 
> As you know we're still reviewing the secure world counterpart at
> https://github.com/OP-TEE/optee_os/pull/3905

yep

> Where we're sorting out the ABI. Thanks for your patience.

after the initial comments on the first patch it was not clear why
there were none on the follow up ones. but sure, thanks for taking the
time.


> 
> Cheers,
> Jens
