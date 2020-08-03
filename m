Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0746C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3A02065C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzMX2BcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgHCLpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgHCLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:41:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF6C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:41:16 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so38254505ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0+NO3ztULAIrGvrz5D9Y/HzaMZX3dT9yOjYO20mJWFE=;
        b=jzMX2BcUcYomvDCitAj65HNQx2dB7wG/CeGganhYRU7W0Sm6ACLMm040YEkm9soXV1
         1wZ8ZjKgHe/uNZCoeb5D1nMODexXPlx3ohsylTZZqKqCMOgqmTPHxAEVaPUD7jpVI2Rm
         DV494Tp8SsExOoAqi+pMyjs8DfMl80Zz7HP42mLmIVmPhlLvSKayu00PtNZDUlvjNow0
         KPSfzWT3b9xSsI6Yy6vnyxR8xQ/eDGjC5ZYr2vWR+bNvPHluGZRiFzHuUnofI3u7dJyS
         1yJrkXF8Zalcf06YxzMaz91W1RGFU5uVfjmVsZAB+CmREqL88U4yfOS9PWq3QigUc4jl
         mZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0+NO3ztULAIrGvrz5D9Y/HzaMZX3dT9yOjYO20mJWFE=;
        b=sVVA1w52MjcM8BSkC+uc4S19vmp3LR2csgYT5OIOtsJUYk2UlI4TZuAzWreyNhMqV/
         +4u8/Uo7E/BpobYxqJFgcFSACBIicQaV7AJ3VGc5ZDHVbB5+hwT3SAs/FEp86Ny5NM3y
         4OLqmLm2DmD/CfhmMcxvq2RsnQqtXIlhHJRQuhOz+dGt3FWykJbr9y2L0S4gBUX9PT/L
         rCkbxqtbwC40ViF/m9A4w7nZggyD78c9dvlPpkgNj2k9+0Z0ZXV4seTtDgvP8VMA3myJ
         V6NoJITz4p6LhHsoPbCKDRjuKcV98ENY452HVZGaCIIfdVwvHmxJikI7L4k6yiC4LauN
         1RpQ==
X-Gm-Message-State: AOAM532YA/QPIXwNsjW4tEASIrEFV4jxlVpAOk1vONiDvjEYGZ8x3aNC
        P896v+Wv6G2mqScEgS+O76Y=
X-Google-Smtp-Source: ABdhPJzJkwmJEmCwN333UYXomgbiIRREmBIPLG34327fzVLIHjLggxQ94KTrrbw/uHE/S0NcN5chQg==
X-Received: by 2002:a17:906:a2c2:: with SMTP id by2mr15793481ejb.86.1596454875500;
        Mon, 03 Aug 2020 04:41:15 -0700 (PDT)
Received: from skbuf ([188.26.57.97])
        by smtp.gmail.com with ESMTPSA id d25sm15916774edr.78.2020.08.03.04.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:41:14 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:41:12 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200803114112.mrcuupz4ir5uqlp6@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com>
 <877dumbtoi.fsf@kurt>
 <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
 <87mu3ho48v.fsf@kurt>
 <20200730082228.r24zgdeiofvwxijm@skbuf>
 <873654m9zi.fsf@kurt>
 <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Aug 03, 2020 at 12:49:36PM +0200, Thomas Gleixner wrote:
> Kurt,
> 
> Kurt Kanzenbach <kurt.kanzenbach@linutronix.de> writes:
> > On Thu Jul 30 2020, Vladimir Oltean wrote:
> > OK. I've reproduced it on a Marvell Armada SoC with v5.6 mainline. See
> > splats below. Running with irq time accounting enabled, kills the
> > machine immediately. However, I'm not getting the possible deadlock
> > warnings in 8250 as you did. So that might be unrelated.
> >
> > Unfortunately I have no idea what to debug here.
> 
> lets look at the facts we have so far.
> 
>  1) When irq accounting is disabled, RT throttling kicks in as
>     expected.
> 
>  2) With irq accounting the RT throttler does not kick in and the RCU
>     stall/lockups happen.
> 
> Not much, but there is clearly interaction between irq time accounting
> and scheduler accounting.
> 
> Can you please reduce /proc/sys/kernel/sched_rt_runtime_us in steps of
> 50000? At least in theory, reduction should bring the throttling back.
> 
> Thanks,
> 
>         tglx
> 

We already know from my original report that reducing
sched_rt_runtime_us to 80% (800000) gives us a stable system.
https://lkml.org/lkml/2020/6/4/1062

What is this telling us?

Thanks,
-Vladimir
