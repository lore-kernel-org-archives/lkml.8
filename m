Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A59C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9B02078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590693618;
	bh=09oDmvOPRdc9yFqYMrXb+8rgwczqoqW1l57ivUBL3eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YQnuytXin+PamqtnGHyLkorrqNtVcVD8Z0jFb3pBrv7sZZKmz1er3xurWpjhTeSDx
	 UKpKYnihOnAtYzVhpMbGPwRlnSyD30R+Iws53ORRfECeu/pv/jZvji/eJ2LjPrvTS0
	 wBReyhkaqN6gqjChiyRm4wvWJomzqAGGP23ruFYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406292AbgE1TUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:20:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41886 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406174AbgE1TUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:20:09 -0400
Received: by mail-io1-f67.google.com with SMTP id o5so31308019iow.8;
        Thu, 28 May 2020 12:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVeDlV6NVoD0UCrRZuL6pb5QLcWmItD89ccv8vXcKkk=;
        b=UYkvlBFljzvklaK77Xx5i11WTU2mbFqQZw8uQF6am8AEW4Hgx6Sab20XZ5jCuGp0VQ
         JO2kgBJntW6E3/pWW0ifj1VRC+cEVcADgNjWcgzkf74fx3IvgCgRPYuKWixz6y5f8L+i
         5voquT7TJh797IcLprkW+N5kRWXGnNY85/vJlJd1i+5Vj2Yu88ohUOXx1aPeXxXkdJw+
         FHsys4yEeymvu08Un67UZY1oqyXf+YCpA2g3lj8QMD7VAcygtbWO9cQLhL1Nrg6IQ/sr
         awsCz3UOu108tjaLpgCscPN+lnK5CVY0G0gtTe2a/uZlkFOhnGU3tvV2RL79Bijbqi+g
         6JfQ==
X-Gm-Message-State: AOAM532C0LPSLfPxn1qM2cqrFmU+LmS9qWxBVObzH2AsG/F9K95j7+S7
        AQJPe9xDD0E2xAb2NDfO5Q==
X-Google-Smtp-Source: ABdhPJzF8L1ZbZJieZLdPk1C1tH8PhgkvZo0aCDEh9YnWAnyDMjl9zwYPeJUQcYomxH+ZFHE9EUD4g==
X-Received: by 2002:a02:707:: with SMTP id f7mr3824681jaf.119.1590693607804;
        Thu, 28 May 2020 12:20:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h23sm2890867ioj.39.2020.05.28.12.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:20:07 -0700 (PDT)
Received: (nullmailer pid 530453 invoked by uid 1000);
        Thu, 28 May 2020 19:20:05 -0000
Date:   Thu, 28 May 2020 13:20:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200528192005.GA494874@bogus>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 10:47:38AM +0530, Viresh Kumar wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> 
> Hi Rob, Arnd and Jassi,
> 
> This stuff has been doing rounds on the mailing list since several years
> now with no agreed conclusion by all the parties. And here is another
> attempt to get some feedback from everyone involved to close this once
> and for ever. Your comments will very much be appreciated.
> 
> The ARM MHU is defined here in the TRM [1] for your reference, which
> states following:
> 
> 	"The MHU drives the signal using a 32-bit register, with all 32
> 	bits logically ORed together. The MHU provides a set of
> 	registers to enable software to set, clear, and check the status
> 	of each of the bits of this register independently.  The use of
> 	32 bits for each interrupt line enables software to provide more
> 	information about the source of the interrupt. For example, each
> 	bit of the register can be associated with a type of event that
> 	can contribute to raising the interrupt."
> 
> On few other platforms, like qcom, similar doorbell mechanism is present
> with separate interrupt for each of the bits (that's how I understood
> it), while in case of ARM MHU, there is a single interrupt line for all
> the 32 bits. Also in case of ARM MHU, these registers and interrupts
> have 3 copies for different priority levels, i.e. low priority
> non-secure, high priority non-secure and secure channels.
> 
> For ARM MHU, both the dt bindings and the Linux driver support 3
> channels for the different priorities right now and support sending a 32
> bit data on every transfer in a locked fashion, i.e. only one transfer
> can be done at once and the other have to wait for it to finish first.
> 
> Here are the point of view of the parties involved on this subject:
> 
> Jassi's viewpoint:
> 
> - Virtualization of channels should be discouraged in software based on
>   specific usecases of the application. This may invite other mailbox
>   driver authors to ask for doing virtualization in their drivers.
> 
> - In mailbox's terminology, every channel is equivalent to a signal,
>   since there is only one signal generated here by the MHU, there should
>   be only one channel per priority level.
> 
> - The clients should send data (of just setting 1 bit or many in the 32
>   bit word) using the existing mechanism as the delays due to
>   serialization shouldn't be significant anyway.
> 
> - The driver supports 90% of the users with the current implementation
>   and it shouldn't be extended to support doorbell and implement two
>   different modes by changing value of #mbox-cells field in bindings.
> 
> Sudeep (ARM) and myself as well to some extent:
> 
> - The hardware gives us the capability to write the register in
>   parallel, i.e. we can write 0x800 and 0x400 together without any
>   software locks, and so these 32 bits should be considered as separate
>   channel even if only one interrupt is issued by the hardware finally.
>   This shouldn't be called as virtualization of the channels, as the
>   hardware supports this (as clearly mentioned in the TRM) and it takes
>   care of handling the signal properly.
> 
> - With serialization, if we use only one channel as today at every
>   priority, if there are 5 requests to send signal to the receiver and
>   the dvfs request is the last one in queue (which may be called from
>   scheduler's hot path with fast switching), it unnecessarily needs to
>   wait for the first four transfers to finish due to the software
>   locking imposed by the mailbox framework. This adds additional delay,
>   maybe of few ms only, which isn't required by the hardware but just by
>   the software and few ms can be important in scheduler's hotpath.
> 
> - With the current approach it isn't possible to assign different bits
>   (or doorbell numbers) to clients from DT and the only way of doing
>   that without adding new bindings is by extending #mbox-cells to accept
>   a value of 2 as done in this patch.
> 
> Jassi and Sudeep, I hope I was able to represent both the view points
> properly here. Please correct me if I have made a mistake here.
> 
> This is it. It would be nice to get the views of everyone now on this
> and how should this be handled.

I am perfectly fine with adding another cell which seems appropriate 
here. You can have 5 cells for all I care if that makes sense for 
the h/w. That has nothing to do with the Linux design. Whether Linux 
requires serializing mailbox accesses is a separate issue. On that side, 
it seems silly to not allow driving the h/w in the most efficient way 
possible.

Rob
