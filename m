Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C77DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CDA20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaiOKwHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgHCIQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgHCIQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:16:30 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48E9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 01:16:29 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so15794757edy.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4qTJzawZWr/GYgMTAZPcjdD001ZkWWxlqWy1GHK3QMU=;
        b=qaiOKwHY2tdrATNky9nY/huprxhOtNjUnGVAHtUBBPXemKUvk6vSSPnIA9ea6CVRLz
         rBgHfJcPWKOGVGHXCbQQg/kNVsTQES16PNUiP17sstXVdsJ5+vfWVdlBKQ+9Xl2f3UTJ
         8bwBRjlFFGDmi3S1/OJ6BGNNkwhCrK34U7MRkeukn9QqL/rDMwiJUuJJ0hjguR8d1+li
         6OC/70qGo8IcZvV2SODjSmnKogJUZm7pR6uAL09AtEyvFjz3An19mipz5Jdea5pr3FjV
         VJK9gfRD7805xnZwg90G74iV4kuDWvny8qAwE+5GAHl/9Ah6J1hehCszL8KB/t/bNk+a
         q69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4qTJzawZWr/GYgMTAZPcjdD001ZkWWxlqWy1GHK3QMU=;
        b=YbEu6hHIdsexC2JDlj4Cg7vF6RO593Ycu+olRoPx6MrbfDWfHCsb2d9j7tRmUHpCYD
         P/nqBGs/NdLQnaQCYfO2lHTfy8rHmAUTPAvdCT7TuyjVKh2dUj3Rx6XsLjmfA2fFn2Vp
         jZyAqBf0wB/M9vLh1M2wViakB+OdHQ/cijvUVq9FAFxPLzR0eWUntn7Z3Dtn3iJO9ZmO
         W6LcESt3ZO0I50VWCrUvI+7bR0V3sJzRq+PKXZe2121VpK5i8bcfEsX4ztUmTVlpjvvy
         JRGrUtubw6U6hQWa/mKwyqD0WHaB/i+9KiMrzpUDM0EWPHg2n3Roo7AGZPV6fehiQOKx
         nbmg==
X-Gm-Message-State: AOAM530MbtwGOTnIwYVgDMdeOvqB7rJ1NgYGabrLX5LUGbV7BFeOmcBj
        rAXLXM1dfal/9KF6QZ933nQ=
X-Google-Smtp-Source: ABdhPJyVvkviCmhQkH88IrHHj+FJhlYFI2ERFSXwRzw3NQGTYcVF77Hgblp/FUhWIxR4mD7wTxH6mg==
X-Received: by 2002:aa7:d596:: with SMTP id r22mr14929527edq.204.1596442588557;
        Mon, 03 Aug 2020 01:16:28 -0700 (PDT)
Received: from skbuf ([188.26.57.97])
        by smtp.gmail.com with ESMTPSA id m12sm14212100edv.94.2020.08.03.01.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 01:16:27 -0700 (PDT)
Date:   Mon, 3 Aug 2020 11:16:25 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200803081625.czdfwcpw5emcd4ls@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com>
 <877dumbtoi.fsf@kurt>
 <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
 <87mu3ho48v.fsf@kurt>
 <20200730082228.r24zgdeiofvwxijm@skbuf>
 <873654m9zi.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873654m9zi.fsf@kurt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 10:04:01AM +0200, Kurt Kanzenbach wrote:
> On Thu Jul 30 2020, Vladimir Oltean wrote:
> > On Thu, Jul 30, 2020 at 09:23:44AM +0200, Kurt Kanzenbach wrote:
> >> On Wed Jul 29 2020, Vladimir Oltean wrote:
> >> > For more context, here is my original report of the issue:
> >> > https://lkml.org/lkml/2020/6/4/1062
> >> >
> >> > Just like you, I could not reproduce the RCU stalls and system hang on a
> >> > 5.6-rt kernel, just on mainline and derivatives, using the plain
> >> > defconfig.
> >> >
> >> > The issue is not specific to Layerscape or i.MX8, but rather I was able
> >> > to see the same behavior on Marvell Armada 37xx as well as Qualcomm
> >> > MSM8976.
> >> >
> >> > So, while of course I agree that disabling IRQ time accounting for arm64
> >> > isn't a real solution, it isn't by far an exaggerated proposal either.
> >> > Nonetheless, the patch is just a RFC and should be treated as such. We
> >> > are at a loss when it comes to debugging this any further and we would
> >> > appreciate some pointers.
> >> 
> >> Yeah, sure. I'll try to reproduce this issue first. So it triggers with:
> >> 
> >>  * arm64
> >>  * mainline, not -rt kernel
> >>  * opened serial console
> >>  * irq accounting enabled
> >> 
> >> Anything else?
> >> 
> >> Thanks,
> >> Kurt
> >
> > Thanks for giving a helping hand, Kurt. The defconfig should be enough.
> > In the interest of full disclosure, the only arm64 device on which we
> > didn't reproduce this was the 16-core LX2160A. But we did reproduce on
> > that with maxcpus=1 though. And also on msm8976 with all 8 cores booted.
> > Just mentioning this in case you're testing on a 16-core system, you
> > might want to reduce the number a bit.
> 
> OK. I've reproduced it on a Marvell Armada SoC with v5.6 mainline. See
> splats below. Running with irq time accounting enabled, kills the
> machine immediately. However, I'm not getting the possible deadlock
> warnings in 8250 as you did. So that might be unrelated.
> 

Yes, the console lockdep warnings are unrelated. They are discussed
here:
https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/

> Unfortunately I have no idea what to debug here.
> 
> Thanks,
> Kurt

So, this means we could submit a formal version of this patch? :)

Thanks,
-Vladimir
