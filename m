Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF490C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B65124655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LeYeH8PJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgAVTkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:40:11 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40497 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAVTkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:40:11 -0500
Received: by mail-pj1-f65.google.com with SMTP id bg7so402852pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 11:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HtkbmR8fmtnktqo3yHC3XtDswDNTkwK2QM7gBaKydjo=;
        b=LeYeH8PJOdf0UULN0/CxInW7FJi07Sm9Up0Ar6Q60ZzC2HZAIMmrlzUhhT49ZV4HhR
         uHk+Rhe04vMUWG4wKoDXHqHfvHYhuSkur3fvP9ubsuO7qrTOroxwHjtZ2gtI08bYl1+e
         RfCnHgW20nX0aRlZYfzwOZcGnpWo83M5+lS82TrsmEoGqv6koy/K3QgZIZ7PqPib4weT
         MVY0zuhLIqcehSAkwrBcjtGCfeecyudS5Ae6UkO6DfnkUrznAiCTJ+InoYHt7MLXQySb
         cQKPgu8cE9uivRq5C1dm6MGOHSmr8lMw+zRLs3mK7QaWn0mItWF3h426tUKW65vXygO0
         JZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HtkbmR8fmtnktqo3yHC3XtDswDNTkwK2QM7gBaKydjo=;
        b=l6Z3g4IoD8X4kU2M+UK01Cl0U+73H9XOA4xuUjnFyi7Q6GPM8t6r6X3RNf/fQXg6BS
         V76P8tVxXsTVQNf7e/kLybGM3JRQxh/GuuIciYOOk9dHKVGCBhh1o18k4isjL/Fm7rxe
         IqbnawgEsnkKI3pYTgGNCbT9EVVgII0GL4XP/iTMUzL1GVMDu6yaV0O9UUThd00tejvR
         Xy6hx1dNuMnTApk+vGyuMottpllRud/2giVLrGQDCNyoxjso1p6sE8QNiPqTeSGjNqFU
         AB6vEkkBrL2rimDN3TxVSSd1kSEsvJVqRncNb/bz0kKd9Vw954Smdu8dFFTmO+OyOX9g
         GVYg==
X-Gm-Message-State: APjAAAX1jQ7Jce1CIj70hfP8V6Xsu+7tpQhmTkTC4fvzvxD4JxFemaih
        uVNbf2qWPj7yqqRHUBlQa6+pag==
X-Google-Smtp-Source: APXvYqy6Xx25rSNmn3eFN/R4xRV4MH8bPvbJcz7qvBnLurst5BIrH6pj/V2mfhcUMR5YRqEXSf7fOQ==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr12495147plz.269.1579722009787;
        Wed, 22 Jan 2020 11:40:09 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w8sm45848542pfn.186.2020.01.22.11.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 11:40:09 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:39:36 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v2 7/8] remoteproc: qcom: q6v5: Add common panic handler
Message-ID: <20200122193936.GB3261042@ripper>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
 <20191227053215.423811-8-bjorn.andersson@linaro.org>
 <20200110212806.GD11555@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110212806.GD11555@xps15>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10 Jan 13:28 PST 2020, Mathieu Poirier wrote:

> On Thu, Dec 26, 2019 at 09:32:14PM -0800, Bjorn Andersson wrote:
> > Add a common panic handler that invokes a stop request and sleep enough
> > to let the remoteproc flush it's caches etc in order to aid post mortem
> > debugging.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - None
> > 
> >  drivers/remoteproc/qcom_q6v5.c | 19 +++++++++++++++++++
> >  drivers/remoteproc/qcom_q6v5.h |  1 +
> >  2 files changed, 20 insertions(+)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
> > index cb0f4a0be032..17167c980e02 100644
> > --- a/drivers/remoteproc/qcom_q6v5.c
> > +++ b/drivers/remoteproc/qcom_q6v5.c
> > @@ -6,6 +6,7 @@
> >   * Copyright (C) 2014 Sony Mobile Communications AB
> >   * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
> >   */
> > +#include <linux/delay.h>
> >  #include <linux/kernel.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/interrupt.h>
> > @@ -15,6 +16,8 @@
> >  #include <linux/remoteproc.h>
> >  #include "qcom_q6v5.h"
> >  
> > +#define Q6V5_PANIC_DELAY_MS	200
> > +
> >  /**
> >   * qcom_q6v5_prepare() - reinitialize the qcom_q6v5 context before start
> >   * @q6v5:	reference to qcom_q6v5 context to be reinitialized
> > @@ -162,6 +165,22 @@ int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5)
> >  }
> >  EXPORT_SYMBOL_GPL(qcom_q6v5_request_stop);
> >  
> > +/**
> > + * qcom_q6v5_panic() - panic handler to invoke a stop on the remote
> > + * @q6v5:	reference to qcom_q6v5 context
> > + *
> > + * Set the stop bit and sleep in order to allow the remote processor to flush
> > + * its caches etc for post mortem debugging.
> > + */
> > +void qcom_q6v5_panic(struct qcom_q6v5 *q6v5)
> > +{
> > +	qcom_smem_state_update_bits(q6v5->state,
> > +				    BIT(q6v5->stop_bit), BIT(q6v5->stop_bit));
> > +
> > +	mdelay(Q6V5_PANIC_DELAY_MS);
> 
> I really wonder if the delay should be part of the remoteproc core and
> configurable via device tree.  Wanting the remote processor to flush its caches
> is likely something other vendors will want when dealing with a kernel panic.
> It would be nice to see if other people have an opinion on this topic.  If not
> then we can keep the delay here and move it to the core if need be.
> 

I gave this some more thought and what we're trying to achieve is to
signal the remote processors about the panic and then give them time to
react, but per the proposal (and Qualcomm downstream iirc) we will do
this for each remote processor, one by one.

So in the typical case of a Qualcomm platform with 4-5 remoteprocs we'll
end up giving the first one a whole second to react and the last one
"only" 200ms.

Moving the delay to the core by iterating over rproc_list calling
panic() and then delaying would be cleaner imo.

It might be nice to make this configurable in DT, but I agree that it
would be nice to hear from others if this would be useful.

Regards,
Bjorn

> Thanks,
> Mathieu
> 
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_q6v5_panic);
> > +
> >  /**
> >   * qcom_q6v5_init() - initializer of the q6v5 common struct
> >   * @q6v5:	handle to be initialized
> > diff --git a/drivers/remoteproc/qcom_q6v5.h b/drivers/remoteproc/qcom_q6v5.h
> > index 7ac92c1e0f49..c37e6fd063e4 100644
> > --- a/drivers/remoteproc/qcom_q6v5.h
> > +++ b/drivers/remoteproc/qcom_q6v5.h
> > @@ -42,5 +42,6 @@ int qcom_q6v5_prepare(struct qcom_q6v5 *q6v5);
> >  int qcom_q6v5_unprepare(struct qcom_q6v5 *q6v5);
> >  int qcom_q6v5_request_stop(struct qcom_q6v5 *q6v5);
> >  int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout);
> > +void qcom_q6v5_panic(struct qcom_q6v5 *q6v5);
> >  
> >  #endif
> > -- 
> > 2.24.0
> > 
