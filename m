Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75884C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 11:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B1732065C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 11:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="HgSh/kqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHLLrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgHLLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 07:47:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13109C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 04:47:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so1643500wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JZ2WleiWXa9fC0ZTk1OSJJ+GJAP9T1SN3/ZXfQMDOLk=;
        b=HgSh/kqPjSSvsIHxsPaFSYLcjr+AA5fgHn2beoKerBATlOXE0aVZwHl9VRSGVoAh0h
         uOMZHeGbMjaZtRUYGUJllM9ZaJaqud5IS6vqF4SA93SrkJwr+jQeKi2dZ7csCPQqBfn3
         Q3hNPGUWzV2pfC8vwluqz1f95NPFCJMvlrZEgSvTXZuwouQP3MwdGoVRshvPCoJnBPAF
         L3eUHFEvVfWTQ2D1q6ahjVp8aSATq7XSuyviaC8LfLmV6mPKNC+ekcJIAUIv2F24tLpC
         oxCIk2fH9tk9NL5+5D3cVGr1FA6a5aaym0nDGr+T2nbl9VyoNGU9yf9hCUTqvRl/ZEXz
         a1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZ2WleiWXa9fC0ZTk1OSJJ+GJAP9T1SN3/ZXfQMDOLk=;
        b=rOapevpYx2TQvQbIURybuRAnfforQ0dTzEZD7e0wyVa/PkCIY+u2WYz6jc1Ddod8jE
         eFFCuyeNe+6Jf0u0UQLngqP9nH1/ndgbtzACICN3XFfpHMT6vzIHxp1Aeh4nZ81SfxLH
         ynMtLYPmhBwmfQ2KIb07G0EtIkgdEx7W6YXnJkWotGaCiMThuEGPvA6hDHxW3MX1yHoV
         ttfshRcWHLJWp1lwnkXdqjXCrJyiLGHZybSINdqDOTDkgXSl/vKhLM1Fis1//BT/Ppls
         rsdB/f0JG4V/mKsrvrex0rH+MGxFRQ49qDBhdEtYpEUrbtOAYumrvnK5TgRbXas/+Yfv
         wyMg==
X-Gm-Message-State: AOAM531QnXSQRnqNoZcgBiB6ZCcYRX3Shsc86JNP18eMTTmVUL7Kq9ie
        zdwzGyzKPdZUOfT9hQ+3gkLkuA==
X-Google-Smtp-Source: ABdhPJyS/QSRySbRg/Y0F1PBJPf1hnw9Gn/GMDNvn0O9h2Lh8eLUgzqoCx/FgAvEdk5ubsFvL0hoOQ==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr8725370wmg.25.1597232828711;
        Wed, 12 Aug 2020 04:47:08 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id i4sm3869208wrw.26.2020.08.12.04.47.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 04:47:08 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Wed, 12 Aug 2020 13:47:05 +0200
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>, sumit.garg@linaro.org,
        ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200812114705.GA16922@trex>
References: <20200811175531.10771-1-jorge@foundries.io>
 <20200812084403.GA19230@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812084403.GA19230@jade>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/20, Jens Wiklander wrote:
> On Tue, Aug 11, 2020 at 07:55:31PM +0200, Jorge Ramirez-Ortiz wrote:
> > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > control this type of cryptographic devices it needs coordinated access
> > to the bus, so collisions and RUNTIME_PM dont get in the way.
> > 
> > This trampoline driver allow OP-TEE to access them.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  v7: add support for ten bit i2c slave addressing
> >  v6: compile out if CONFIG_I2C not enabled
> >  v5: alphabetic order of includes
> >  v4: remove unnecessary extra line in optee_msg.h
> >  v3: use from/to msg param to support all types of memory
> >      modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
> >      
> >  drivers/tee/optee/optee_msg.h | 21 ++++++++
> >  drivers/tee/optee/rpc.c       | 95 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 116 insertions(+)
> > 
> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > index 795bc19ae17a..7b2d919da2ac 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -419,4 +419,25 @@ struct optee_msg_arg {
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
> > + * [in]  param[1].u.value.a		i2c control flags
> > + *
> > + * [in/out] memref[2]			buffer to exchange the transfer data
> > + *					with the secure world
> > + *
> > + * [out]  param[3].u.value.a		bytes transferred by the driver
> > + */
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> > +/* I2C master transfer modes */
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> > +/* I2C master control flags */
> > +#define OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT  BIT(0)
> > +
> >  #endif /* _OPTEE_MSG_H */
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index b4ade54d1f28..b6178761d79f 100644
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
> > @@ -49,6 +50,97 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> >  	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> >  }
> >  
> > +#if IS_ENABLED(CONFIG_I2C)
> > +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > +					     struct optee_msg_arg *arg)
> > +{
> > +	struct i2c_client client = { 0 };
> > +	struct tee_param *params;
> > +	int i, ret = -EOPNOTSUPP;
> > +	uint32_t attr[] = {
> uint32_t seems a randomly chosen type here. The
> TEE_IOCTL_PARAM_ATTR_TYPE_* defines fit in a u8.
> Consider u8 attr[] = { instead.

ok


> 
> > +		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
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
> arg->num_params has an unsigned type. Consider giving i an unsigned type
> too.

ok

> 
> > +		if ((params[i].attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK)
> > +		    != attr[i])
> It looks a bit funny with the comparison at the beginning of the line,
> normally we try to leave those at the end of the line. But
> optee_from_msg_param() doesn't set any higher bits in params[i].attr so
> you could also simplify the expression as:
> 		if (params[i].attr != attr[i])

ok will do the above


> 
> > +			goto bad;
> > +	}
> > +
> > +	client.adapter = i2c_get_adapter(params[0].u.value.b);
> > +	if (!client.adapter)
> > +		goto bad;
> > +
> > +	if (params[1].u.value.a & OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT) {
> > +		if (!i2c_check_functionality(client.adapter,
> > +					     I2C_FUNC_10BIT_ADDR)) {
> > +			i2c_put_adapter(client.adapter);
> > +			goto bad;
> > +		}
> > +
> > +		client.flags = I2C_CLIENT_TEN;
> > +	}
> > +
> > +	client.addr = params[0].u.value.c;
> > +	snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > +
> > +	switch (params[0].u.value.a) {
> > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > +		ret = i2c_master_recv(&client, params[2].u.memref.shm->kaddr,
> > +				      params[2].u.memref.size);
> > +		break;
> > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > +		ret = i2c_master_send(&client, params[2].u.memref.shm->kaddr,
> > +				      params[2].u.memref.size);
> > +		break;
> > +	default:
> > +		i2c_put_adapter(client.adapter);
> > +		goto bad;
> > +	}
> > +
> > +	if (ret < 0) {
> > +		arg->ret = TEEC_ERROR_COMMUNICATION;
> > +	} else {
> > +		params[3].u.value.a = ret;
> > +		arg->ret = TEEC_SUCCESS;
> > +
> > +		if (optee_to_msg_param(arg->params, arg->num_params, params))
> > +			arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> Need
> arg->ret = TEEC_SUCCESS;
> when everything is OK.


it is already there.
but will do an else so it is more evident

> 
> > +	}
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
> I'd prefer TEEC_ERROR_NOT_SUPPORTED here.
> TEEC_ERROR_NOT_SUPPORTED would need to be defined as:
> #define TEEC_ERROR_NOT_SUPPORTED        0xFFFF000A
> in optee_private.h

ok

thanks for the quick review on this

> 
> Cheers,
> Jens
> 
> > +}
> > +#endif
> > +
> >  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
> >  {
> >  	struct wq_entry *w;
> > @@ -382,6 +474,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> >  	case OPTEE_MSG_RPC_CMD_SHM_FREE:
> >  		handle_rpc_func_cmd_shm_free(ctx, arg);
> >  		break;
> > +	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> > +		handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> > +		break;
> >  	default:
> >  		handle_rpc_supp_cmd(ctx, arg);
> >  	}
> > -- 
> > 2.17.1
> > 
