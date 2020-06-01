Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8A820823
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="2Bfbk/Vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFAHYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAHYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:24:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE3EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:24:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so10241801wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FAKMpIpHFvQp3zgS4QFpXD2KONnNwtUil2UzoSlI21A=;
        b=2Bfbk/Vh3g2NKKULAuwDi+0omjMueFykMBrUZJdsSPf1JxF/+BBFpN553HYvz7aXgf
         6WDD/ML9fWpUe7ISNqGrJDzq0x436l2fKzJTXoFMGUrIo3R0lpld5cYORJApUeGVuZCc
         HIND5FcSNGPR4uZ+njQGcnHKWdkQRD/DmBH3c360mSNpBIilZsJdFnUGvO0CKQdiCRb/
         99qAc95/n9oVB7ZAF+SVwblQ6UsFg72+/pu0lOQyFTrJ+v1GlzCWryEs2ypF0mCCmC8b
         CD9fTsnjEsguJCk3Q9zQjaW1YCvp58Yze97bInIwJZMOJ0GaERqY1arYvW6wMH0ZKg8F
         YDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FAKMpIpHFvQp3zgS4QFpXD2KONnNwtUil2UzoSlI21A=;
        b=av4uXQByDs3ZMPcKbSwkyCuJVBpbyRDaoe4IDzLznYo1gTp6diZ3dIOTukaVstLFIS
         ccwATHvmK0wNjtiw40KZOLYnJc9vn9j2Twt+z6rtY1eiqCxSLTyEw/rytllZK2oCdzxH
         P+thsjUvip8MzH0HAY6JwkhAzs4srhlrZw7v13h1pdZPtsz4qsVOow1ETUkh4zfwW/ey
         cWDQF6+1bRKbkk1EfRBuoF1hOBXpppxZyyoUqDvVc+aGJ3tj5d4VToePTgVaGe+zEqR4
         UYv+P5nzrgm9s2utIXF1irmHFiWZSBv+GZvA5K5VexazUUqVgk39RWrwuYLFi1cIXNZR
         k5VQ==
X-Gm-Message-State: AOAM5306KV05OxvAPq4Ry1hh8+B+I5As5AbKVwsShg0oPA/As1sHEPv2
        zm3JVZfu+5Pn0h4wPN4TvVrEUQ==
X-Google-Smtp-Source: ABdhPJyRjr/Zfbd/hgqYFOOW/jxNx/VurioZJczFgBl70Yx543UZuZYycdSjMuZqA06bFw+AYaNEiw==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr22034719wmj.137.1590996288218;
        Mon, 01 Jun 2020 00:24:48 -0700 (PDT)
Received: from trex (108.red-83-34-185.dynamicip.rima-tde.net. [83.34.185.108])
        by smtp.gmail.com with ESMTPSA id a3sm3906885wrp.91.2020.06.01.00.24.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Jun 2020 00:24:47 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Mon, 1 Jun 2020 09:24:46 +0200
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        ricardo@foundries.io, mike@foundries.io,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Tee-dev] [PATCH v2] drivers: optee: allow op-tee to access
 devices on the i2c bus
Message-ID: <20200601072446.GA28120@trex>
References: <20200531231135.12670-1-jorge@foundries.io>
 <CAFA6WYNKSgkGzuz47MBzdYzKd3__zPP2HNaOv7P-KR8RFea9fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNKSgkGzuz47MBzdYzKd3__zPP2HNaOv7P-KR8RFea9fg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/20, Sumit Garg wrote:
> Hi Jorge,

hey

> 
> On Mon, 1 Jun 2020 at 04:41, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
> >
> > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > control this type of cryptographic devices it needs coordinated access
> > to the bus, so collisions and RUNTIME_PM dont get in the way.
> >
> > This trampoline driver allow OP-TEE to access them.
> >
> 
> This sounds like an interesting use-case but I would like to
> understand how secure is this communication interface with the secure
> element? Like in the case of RPMB, secure world data is encrypted
> which flows via tee-supplicant to RPMB device.

right, the data in the buffer should be encrypted in both directions
(in the case of the SE050 [1] we have the option to operate with or
without encryption which is what I am doing during development
[2]).

But ultimately -before any product can be shipped- all comms must be
encrypted: this means that when OP-TEE uses the SE050 for crypto, it
must encrypt the data on write and decrypt what is comming from the
SE050 on read. I am now looking into how to enable this.

[1] https://www.nxp.com/docs/en/data-sheet/SE050-DATASHEET.pdf
[2] https://github.com/ldts/optee_os/commits/se050

> 
> -Sumit
> 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> >  drivers/tee/optee/optee_msg.h | 18 +++++++++++
> >  drivers/tee/optee/rpc.c       | 57 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 75 insertions(+)
> >
> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > index 795bc19ae17a..b6cc964fdeea 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -419,4 +419,22 @@ struct optee_msg_arg {
> >   */
> >  #define OPTEE_MSG_RPC_CMD_SHM_FREE     7
> >
> > +/*
> > + * Access a device on an i2c bus
> > + *
> > + * [in]  param[0].u.value.a            mode: RD(0), WR(1)
> > + * [in]  param[0].u.value.b            i2c adapter
> > + * [in]  param[0].u.value.c            i2c chip
> > + *
> > + * [io]  param[1].u.tmem.buf_ptr       physical address
> > + * [io]  param[1].u.tmem.size          transfer size in bytes
> > + * [io]  param[1].u.tmem.shm_ref       shared memory reference
> > + *
> > + * [out]  param[0].u.value.a           bytes transferred
> > + *
> > + */
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 8
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> > +#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> > +
> >  #endif /* _OPTEE_MSG_H */
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index b4ade54d1f28..21d452805c6f 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/device.h>
> >  #include <linux/slab.h>
> >  #include <linux/tee_drv.h>
> > +#include <linux/i2c.h>
> >  #include "optee_private.h"
> >  #include "optee_smc.h"
> >
> > @@ -48,6 +49,59 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
> >  bad:
> >         arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> >  }
> > +static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
> > +                                            struct optee_msg_arg *arg)
> > +{
> > +       struct i2c_client client;
> > +       struct tee_shm *shm;
> > +       int i, ret;
> > +       char *buf;
> > +       uint32_t attr[] = {
> > +               OPTEE_MSG_ATTR_TYPE_VALUE_INPUT,
> > +               OPTEE_MSG_ATTR_TYPE_TMEM_INOUT,
> > +               OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT,
> > +       };
> > +
> > +       if (arg->num_params != ARRAY_SIZE(attr))
> > +               goto bad;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(attr); i++)
> > +               if ((arg->params[i].attr & OPTEE_MSG_ATTR_TYPE_MASK) != attr[i])
> > +                       goto bad;
> > +
> > +       shm = (struct tee_shm *)(unsigned long)arg->params[1].u.tmem.shm_ref;
> > +       buf = (char *)shm->kaddr;
> > +
> > +       client.addr = arg->params[0].u.value.c;
> > +       client.adapter = i2c_get_adapter(arg->params[0].u.value.b);
> > +       if (!client.adapter)
> > +               goto bad;
> > +
> > +       snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
> > +
> > +       switch (arg->params[0].u.value.a) {
> > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> > +               ret = i2c_master_recv(&client, buf, arg->params[1].u.tmem.size);
> > +               break;
> > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> > +               ret = i2c_master_send(&client, buf, arg->params[1].u.tmem.size);
> > +               break;
> > +       default:
> > +               i2c_put_adapter(client.adapter);
> > +               goto bad;
> > +       }
> > +
> > +       if (ret >= 0) {
> > +               arg->params[2].u.value.a = ret;
> > +               arg->ret = TEEC_SUCCESS;
> > +       } else
> > +               arg->ret = TEEC_ERROR_COMMUNICATION;
> > +
> > +       i2c_put_adapter(client.adapter);
> > +       return;
> > +bad:
> > +       arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> > +}
> >
> >  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
> >  {
> > @@ -382,6 +436,9 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> >         case OPTEE_MSG_RPC_CMD_SHM_FREE:
> >                 handle_rpc_func_cmd_shm_free(ctx, arg);
> >                 break;
> > +       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> > +               handle_rpc_func_cmd_i2c_transfer(ctx, arg);
> > +               break;
> >         default:
> >                 handle_rpc_supp_cmd(ctx, arg);
> >         }
> > --
> > 2.17.1
> >
> > _______________________________________________
> > Tee-dev mailing list
> > Tee-dev@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/tee-dev
