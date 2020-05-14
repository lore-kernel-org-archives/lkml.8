Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45713C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2322065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAsoCW4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgENX2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgENX2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:28:40 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B96C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:28:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a136so737537qkg.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:user-agent:mime-version:content-transfer-encoding;
        bh=I/FTFu3Esb5NA/l5xL7ux/92tkQ2JvycVABxeQURrbo=;
        b=pAsoCW4twMPuMB+CSRxUc0zI1h1/vtfog4+l7wXkwYtyLwBFT2gAmZGs6GulY5TvDJ
         ovjrxjtG+IlKRkoTqxxV2x0VQLbNK52e+UIYRx9VfbNY9YIdKLb/mqXe1caBEo+oSDu2
         oJKVVDQHPf5T9keTXAJEacNAMJoZLnGjxzGfX1+TfgDGict68GRGXksj71lkVfne+NdQ
         FCaynLyTYju2qp23k25nDo6XyshMaxOBptuyaZb0i3yBQj4X6Aqjn7s1eJM5v5+p8AHC
         hh9cDQ4A3PI9jPF9rp3aAbUoQnjXO99lNrm11rK3WwvlqMRBEfc7ey//pYGSd+Dayw0R
         3SBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=I/FTFu3Esb5NA/l5xL7ux/92tkQ2JvycVABxeQURrbo=;
        b=FzdYOUY3ol0y/tIBUabhWn0Za+xJhToekZWPQTTvAPEfSuOnrx2TcZYt6oUUUAQhRO
         GLwH7Ve2l9yG84Agns68gkTcFqO3UWaxVbD189JgWue115pCujoJMEcZ7UmXfBicxU0H
         ShGa3zh+aJ3nB+iSNBfThZX/5LI+7fqZ0Fea+JNF8bPNshVXsHDsura7JfFPvO7z2MW4
         2zLC66QEwI24GPoBfPiR/EqthIhbAF3aURo0LatIVRmtPvwiFqsrhZUvMInPCpUs1z7a
         E05NrS9/9gbcC2ekt/MQc9sWFAkcE8vCK3n04XZqa30cBZruvCjyyYFe9Mce4AyLV3Ij
         j5Mw==
X-Gm-Message-State: AOAM532PHem8BQpioQK6T/Q1TRd/l2ZWH2zBURcPnEmcV9SRZmG4wpcO
        zN+ioejPAeyDuns8sxw2s70Kprfg
X-Google-Smtp-Source: ABdhPJz4jcoS7U+Fo0E8WD2tpzZFNH7JRT/QQnnFFJl6Mcw1x1jIY+ShCqeS4tZnEf3kXzfE8BXfPQ==
X-Received: by 2002:a37:8187:: with SMTP id c129mr806073qkd.211.1589498918382;
        Thu, 14 May 2020 16:28:38 -0700 (PDT)
Received: from LeoBras (179-125-143-209.dynamic.desktop.com.br. [179.125.143.209])
        by smtp.gmail.com with ESMTPSA id n20sm290110qkk.53.2020.05.14.16.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 16:28:37 -0700 (PDT)
Message-ID: <fc13b26ff3d2ea2e84049eabda0c60a60d851b40.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/rtas: Implement reentrant rtas call
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nadav Amit <namit@vmware.com>
Date:   Thu, 14 May 2020 20:28:15 -0300
In-Reply-To: <878shu2vjp.fsf@linux.ibm.com>
References: <20200514011245.127174-1-leobras.c@gmail.com>
         <20200514011245.127174-3-leobras.c@gmail.com>
         <878shu2vjp.fsf@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nathan,

On Thu, 2020-05-14 at 13:58 -0500, Nathan Lynch wrote:
> Hi,
> 
> Leonardo Bras <leobras.c@gmail.com> writes:
> > +/**
> > + * rtas_call_reentrant() - Used for reentrant rtas calls
> > + * @token:	Token for desired reentrant RTAS call
> > + * @nargs:	Number of Input Parameters
> > + * @nret:	Number of Output Parameters
> > + * @outputs:	Array of outputs
> > + * @...:	Inputs for desired RTAS call
> > + *
> > + * According to LoPAR documentation, only "ibm,int-on", "ibm,int-off",
> > + * "ibm,get-xive" and "ibm,set-xive" are currently reentrant.
> > + * Reentrant calls need their own rtas_args buffer, so not using rtas.args, but
> > + * PACA one instead.
> > + *
> > + * Return:	-1 on error,
> > + *		First output value of RTAS call if (nret > 0),
> > + *		0 otherwise,
> > + */
> > +
> > +int rtas_call_reentrant(int token, int nargs, int nret, int *outputs, ...)
> > +{
> > +	va_list list;
> > +	struct rtas_args *args;
> > +	int i;
> > +
> > +	if (!rtas.entry || token == RTAS_UNKNOWN_SERVICE)
> > +		return -1;
> > +
> > +	/* We use the per-cpu (PACA) rtas args buffer */
> > +	args = &local_paca->reentrant_args;
> > +
> > +	va_start(list, outputs);
> > +	va_rtas_call_unlocked(args, token, nargs, nret, list);
> > +	va_end(list);
> > +
> > +	if (nret > 1 && outputs)
> > +		for (i = 0; i < nret - 1; ++i)
> > +			outputs[i] = be32_to_cpu(args->rets[i + 1]);
> 
> Doesn't this need to be more careful about preemption and exceptions?
> I.e. the args structure in the paca needs to be protected from
> concurrent use somehow, like any per-cpu data structure.
> 
> local_irq_save/restore while accessing local_paca->reentrant_args here
> would be sufficient I think?

Yes, you are right.
I will also add preempt_{dis,en}able, which in most kernels will
compile out, but it will be kind of 'ready' if we ever decide to
support PREEMPT.

Thanks for the feedback!

