Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C2BCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC5223126
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbgEMMYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMMYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:24:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:24:44 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYqRE-0002Bm-W7; Wed, 13 May 2020 14:24:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 68A72100605; Wed, 13 May 2020 14:24:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Wojciech Kudla <wk.kernel@gmail.com>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org
Subject: Re: x86/smp: adding new trace points
In-Reply-To: <b638ef03-04c2-94bf-f026-a01691888624@gmail.com>
References: <4d54953b-f968-63f5-569f-9e09bc0f361c@gmail.com> <b638ef03-04c2-94bf-f026-a01691888624@gmail.com>
Date:   Wed, 13 May 2020 14:24:40 +0200
Message-ID: <87y2pw2fav.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wojciech Kudla <wk.kernel@gmail.com> writes:
> I was trying to trace some IPIs (remote tlb shootdowns in this case) and noticed that:
>
> 1) irq_vectors:x86_platform_ipi_entry and irq_vectors:x86_platform_ipi_exit are not hit at all for my case. The backtrace on the receiving CPU:
>
> 0xffffffff81079535	flush_tlb_func_common.constprop.10+0x105/0x220 [kernel]
> 0xffffffff81079681	flush_tlb_func_remote+0x31/0x40 [kernel]
> 0xffffffff8111f76c	flush_smp_call_function_queue+0x4c/0xf0 [kernel]
> 0xffffffff81120253	generic_smp_call_function_single_interrupt+0x13/0x30 [kernel]
> 0xffffffff81a030c6	smp_call_function_single_interrupt+0x36/0xd0 [kernel]
> 0xffffffff81a02679	call_function_single_interrupt+0xa9/0xb0 [kernel]
>
> I would expect that we would hit those trace point somewhere around
> call_function_single_interrupt()

Why would the SMP call function single interrupt go through the
PLATFORM_IPI_VECTOR? It goes as the name says through the
CALL_FUNCTION_SINGLE_VECTOR.

Thanks,

        tglx

