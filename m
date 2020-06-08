Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADF5206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="HCHijGb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgFHIZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgFHIZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:25:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1626AC08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 01:25:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k26so15598655wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 01:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qoE1kt3W6sqxioLLMjkPbqfVy5kRnQOGrdpTsyg/UnQ=;
        b=HCHijGb4wpA4dnfsezlY41O8ZUdeFNOVptTI+NXfUBxRnS0ZHWUZSKcWLMUNQX4gTM
         /Y8/Adn4K2A7N9e5OqUQvMTXcXlWnZUvYuiHZc3s7Di6ou1Iv2YzpI5Z0DABfwriO+aS
         rK4X9b2rBRPE3gY+Kn7D1WgqRiKp8PT6E8zqzudOphMH4yRVSVu518Rrh9lZhvIhcuOC
         L9tpAYZzjyONKj4UVu8+pLVtuBWCXuZIvW7Za3FOSkbu1uonWasBtf5Ir+n4/dqnPMt+
         /M1cwaiEkGSawtcCkc4Mas0iejUrG3kiR0X7fB+5zoDnLP5sK8LzZbVe1mnK9/lZ+Afs
         vmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qoE1kt3W6sqxioLLMjkPbqfVy5kRnQOGrdpTsyg/UnQ=;
        b=DC+wFIAtb5gz7TPOvEjb1hOW4pXP85DSsF6VQcx5EaTd326BB6+CDIpXpO8yxLOqJC
         gvvTjiYnlMc8hNZBd9AiqFmWSFFb1IrBDrGH98BtDzENit021kHOuOsBKhJxGJ4S7iYt
         LM3VoUNBJ7ECpjrlBJ/4zWtwejCjtoHFW4Yr0jkwjZwwTxvebUu4IiiU/6ITInpQONey
         J+CiJvF4OGnd22VSQxlL0bDgECwdwAgVPRC2LqaOtFg4iAvYx3qaLXMCdvmWZ2x4Dtb3
         zpWapitZK60YlgDLkqCRH0ts+vEMSU2ScW5fipA2uH5K95TXMOVJucQnUkzqtsnuoy0i
         GFkA==
X-Gm-Message-State: AOAM5315CQLLIWlctaHjsF50xpFVblCI+ee1Nlok9P74iIb6fPvNny6r
        9ulJYdd1z+n/JfnJEEGy1S7L5w==
X-Google-Smtp-Source: ABdhPJy7Kji6zjWK5BBMBEcHnwVNl++tbFxKxL1/7dtn1D11+2/VUsIV5Ln0fdtiW93KjXKMvK1pMA==
X-Received: by 2002:a1c:df57:: with SMTP id w84mr16373007wmg.52.1591604711551;
        Mon, 08 Jun 2020 01:25:11 -0700 (PDT)
Received: from trex (98.red-79-146-85.dynamicip.rima-tde.net. [79.146.85.98])
        by smtp.gmail.com with ESMTPSA id h12sm21971909wro.80.2020.06.08.01.25.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Jun 2020 01:25:10 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Mon, 8 Jun 2020 10:25:09 +0200
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>,
        Sumit Garg <sumit.garg@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        ricardo@foundries.io, mike@foundries.io,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Tee-dev] [PATCH v2] drivers: optee: allow op-tee to access
 devices on the i2c bus
Message-ID: <20200608082509.GA21803@trex>
References: <20200531231135.12670-1-jorge@foundries.io>
 <CAFA6WYNKSgkGzuz47MBzdYzKd3__zPP2HNaOv7P-KR8RFea9fg@mail.gmail.com>
 <20200601072446.GA28120@trex>
 <20200608064904.GA1187395@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608064904.GA1187395@jade>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/20, Jens Wiklander wrote:
> On Mon, Jun 01, 2020 at 09:24:46AM +0200, Jorge Ramirez-Ortiz, Foundries wrote:
> > On 01/06/20, Sumit Garg wrote:
> > > Hi Jorge,
> > 
> > hey
> > 
> > > 
> > > On Mon, 1 Jun 2020 at 04:41, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> > > >
> > > > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > > > control this type of cryptographic devices it needs coordinated access
> > > > to the bus, so collisions and RUNTIME_PM dont get in the way.
> > > >
> > > > This trampoline driver allow OP-TEE to access them.
> > > >
> > > 
> > > This sounds like an interesting use-case but I would like to
> > > understand how secure is this communication interface with the secure
> > > element? Like in the case of RPMB, secure world data is encrypted
> > > which flows via tee-supplicant to RPMB device.
> > 
> > right, the data in the buffer should be encrypted in both directions
> > (in the case of the SE050 [1] we have the option to operate with or
> > without encryption which is what I am doing during development
> > [2]).
> > 
> > But ultimately -before any product can be shipped- all comms must be
> > encrypted: this means that when OP-TEE uses the SE050 for crypto, it
> > must encrypt the data on write and decrypt what is comming from the
> > SE050 on read. I am now looking into how to enable this.
> > 
> > [1] https://www.nxp.com/docs/en/data-sheet/SE050-DATASHEET.pdf
> > [2] https://github.com/ldts/optee_os/commits/se050
> This link doesn't work.

apologies, I updated the SDK release to 2.14 (latest)

please use the following:
https://github.com/ldts/optee_os/commits/se050.2.14



> 
> > 
> > > 
> > > -Sumit
> > > 
> > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > > ---
> > > >  drivers/tee/optee/optee_msg.h | 18 +++++++++++
> > > >  drivers/tee/optee/rpc.c       | 57 +++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 75 insertions(+)
> > > >
> > > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > > > index 795bc19ae17a..b6cc964fdeea 100644
> > > > --- a/drivers/tee/optee/optee_msg.h
> > > > +++ b/drivers/tee/optee/optee_msg.h
> > > > @@ -419,4 +419,22 @@ struct optee_msg_arg {
> > > >   */
> > > >  #define OPTEE_MSG_RPC_CMD_SHM_FREE     7
> > > >
> > > > +/*
> > > > + * Access a device on an i2c bus
> > > > + *
> > > > + * [in]  param[0].u.value.a            mode: RD(0), WR(1)
> > > > + * [in]  param[0].u.value.b            i2c adapter
> > > > + * [in]  param[0].u.value.c            i2c chip
> > > > + *
> > > > + * [io]  param[1].u.tmem.buf_ptr       physical address
> > > > + * [io]  param[1].u.tmem.size          transfer size in bytes
> > > > + * [io]  param[1].u.tmem.shm_ref       shared memory reference
> 
> This should be "[in/out] memref[1]" instead to be able to use
> all kinds of memory references.
> 
> > > > + *
> > > > + * [out]  param[0].u.value.a           bytes transferred
> > > > + *
> > > > + */
> > > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 8
> > > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> > > > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> > > > +
> > > >  #endif /* _OPTEE_MSG_H */
> > > > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > > > index b4ade54d1f28..21d452805c6f 100644
> > > > --- a/drivers/tee/optee/rpc.c
> > > > +++ b/drivers/tee/optee/rpc.c
> > > > @@ -9,6 +9,7 @@
> > > >  #include <linux/device.h>
> > > >  #include <linux/slab.h>
> > > >  #include <linux/tee_drv.h>
> > > > +#include <linux/i2c.h>
> > > >  #include "optee_private.h"
> > > >  #include "optee_smc.h"
> > > >
> > > > @@ -48,6 +49,59 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> > > >  bad:
> > > >         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > > >  }
> > > > +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > > > +                                            struct optee_msg_arg *arg)
> > > > +{
> > > > +       struct i2c_client client;
> > > > +       struct tee_shm *shm;
> > > > +       int i, ret;
> > > > +       char *buf;
> > > > +       uint32_t attr[] = {
> > > > +               OPTEE_MSG_ATTR_TYPE_VALUE_INPUT,
> > > > +               OPTEE_MSG_ATTR_TYPE_TMEM_INOUT,
> > > > +               OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT,
> > > > +       };
> > > > +
> > > > +       if (arg->num_params != ARRAY_SIZE(attr))
> > > > +               goto bad;
> 
> Use optee_from_msg_param() to translate this into a struct tee_param,
> that way you cover all kinds of memory references. Before returning it
> nees to be translated back with optee_to_msg_param().
> 
> Cheers,
> Jens
> 
> > > > +
> > > > +       for (i = 0; i < ARRAY_SIZE(attr); i++)
> > > > +               if ((arg->params[i].attr & OPTEE_MSG_ATTR_TYPE_MASK) != attr[i])
> > > > +                       goto bad;
> > > > +
> > > > +       shm = (struct tee_shm *)(unsigned long)arg->params[1].u.tmem.shm_ref;
> > > > +       buf = (char *)shm->kaddr;
> > > > +
> > > > +       client.addr = arg->params[0].u.value.c;
> > > > +       client.adapter = i2c_get_adapter(arg->params[0].u.value.b);
> > > > +       if (!client.adapter)
> > > > +               goto bad;
> > > > +
> > > > +       snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > > > +
> > > > +       switch (arg->params[0].u.value.a) {
> > > > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > > > +               ret = i2c_master_recv(&client, buf, arg->params[1].u.tmem.size);
> > > > +               break;
> > > > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > > > +               ret = i2c_master_send(&client, buf, arg->params[1].u.tmem.size);
> > > > +               break;
> > > > +       default:
> > > > +               i2c_put_adapter(client.adapter);
> > > > +               goto bad;
> > > > +       }
> > > > +
> > > > +       if (ret >= 0) {
> > > > +               arg->params[2].u.value.a = ret;
> > > > +               arg->ret = TEEC_SUCCESS;
> > > > +       } else
> > > > +               arg->ret = TEEC_ERROR_COMMUNICATION;
> > > > +
> > > > +       i2c_put_adapter(client.adapter);
> > > > +       return;
> > > > +bad:
> > > > +       arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > > > +}
> > > >
> > > >  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
> > > >  {
> > > > @@ -382,6 +436,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> > > >         case OPTEE_MSG_RPC_CMD_SHM_FREE:
> > > >                 handle_rpc_func_cmd_shm_free(ctx, arg);
> > > >                 break;
> > > > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> > > > +               handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> > > > +               break;
> > > >         default:
> > > >                 handle_rpc_supp_cmd(ctx, arg);
> > > >         }
> > > > --
> > > > 2.17.1
> > > >
> > > > _______________________________________________
> > > > Tee-dev mailing list
> > > > Tee-dev@lists.linaro.org
> > > > https://lists.linaro.org/mailman/listinfo/tee-dev
