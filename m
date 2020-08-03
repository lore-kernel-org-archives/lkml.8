Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26901C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A56207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LBURf5Ja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DC0RPbpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHCPNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgHCPNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:13:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A00C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:13:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596467599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXGEztBjn4giLdEcSrD148UX+XKQGnk+zqs22R94Q+0=;
        b=LBURf5Ja6M9Lac4WOtiuJ6bxV3P29YalLePHR73LPtA0WqbI3DEP5PI50sGfEKLrOxsHxk
        SpZq/CrnkcSwoR5GhLAuMFCxRFIuwknKHC+j2k1XLlJy2dfbZCwoq4hpTrV8+rWguLLEus
        6Cb0ASJC/yoHQrrJw5p3WETehitAxGJlOldFGFjwFnKPs+HbOx+h/iROd2tFeWUZ7EsBhG
        VDwFIAonfMaIKyOmK5k8bevRY5d83pdzgieQQSzIVG+POWhTMuUsspi4MdsrfIgpH7v4pV
        Ql0+pNsiIgi39OmQmKNAHz48/jKQCCg1HESutm3gcqlHSCNFCdw3ltBQ0/JLoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596467599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXGEztBjn4giLdEcSrD148UX+XKQGnk+zqs22R94Q+0=;
        b=DC0RPbpCWyjFYqilNHjgTKCW8agE9XURW0gniTmMsNl7HWZ5w0tXO+jy2OVEX4siXKFtfx
        HVmiyqaI1kWcTFCQ==
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <20200803114112.mrcuupz4ir5uqlp6@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt> <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt> <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf>
Date:   Mon, 03 Aug 2020 17:13:18 +0200
Message-ID: <87d047n4oh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Oltean <olteanv@gmail.com> writes:
>>  1) When irq accounting is disabled, RT throttling kicks in as
>>     expected.
>> 
>>  2) With irq accounting the RT throttler does not kick in and the RCU
>>     stall/lockups happen.
>> 
>> Not much, but there is clearly interaction between irq time accounting
>> and scheduler accounting.
>> 
>> Can you please reduce /proc/sys/kernel/sched_rt_runtime_us in steps of
>> 50000? At least in theory, reduction should bring the throttling back.
>
> We already know from my original report that reducing
> sched_rt_runtime_us to 80% (800000) gives us a stable system.
> https://lkml.org/lkml/2020/6/4/1062

Oh. Somehow missed that. Btw, can you please use links in the form of:

    https://lore.kernel.org/r/$MSGID

lkml.org is spotty and having the message id allows to search in the
mail client as well.

> What is this telling us?

It seems that the fine grained irq time accounting affects the runtime
accounting in some way which I haven't figured out yet.

Thanks,

        tglx
