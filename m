Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF482CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB8620675
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388909AbgEMOQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388896AbgEMOQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:16:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B40C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:16:27 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYsBF-0004rs-6l; Wed, 13 May 2020 16:16:17 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9CBB1100605; Wed, 13 May 2020 16:16:16 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, tony.luck@intel.com, keescook@chromium.org,
        benh@kernel.crashing.org, x86@kernel.org, dave.hansen@intel.com,
        thomas.lendacky@amd.com, Balbir Singh <sblbir@amazon.com>
Subject: Re: [PATCH v6 3/6] arch/x86/mm: Refactor cond_ibpb() to support other use cases
In-Reply-To: <20200510014803.12190-4-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com> <20200510014803.12190-4-sblbir@amazon.com>
Date:   Wed, 13 May 2020 16:16:16 +0200
Message-ID: <87h7wj3opb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:
> @@ -550,8 +549,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  		 * Avoid user/user BTB poisoning by flushing the branch
>  		 * predictor when switching between processes. This stops
>  		 * one process from doing Spectre-v2 attacks on another.
> +		 * The hook can also be used for mitigations that rely
> +		 * on switch_mm for hooks.

The new function name has absolutely nothing to do with IBPB and is
clearly talking about mitigations. So the IBPB comment wants to move and
that extra sentence you bolted on can go away. It's nonsensical word
salad anyway.
>  
>  	/* Reinitialize tlbstate. */
> -	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
> +	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_IBPB);

There is still no comment why this only needs MM_IBPB. I'll change this
to LAST_USER_MM_INIT and put that define close to the others.

Thanks,

        tglx
