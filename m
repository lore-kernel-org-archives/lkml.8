Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1424EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E438B207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEGRGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGRGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:06:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58C3C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:06:47 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jWjyw-00010V-5O; Thu, 07 May 2020 19:06:46 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 63354102652; Thu,  7 May 2020 19:06:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch V4 part 2 05/18] x86/entry: Move irq tracing on syscall entry to C-code
In-Reply-To: <87368bg528.fsf@nanos.tec.linutronix.de>
References: <20200505134112.272268764@linutronix.de> <20200505134340.611961721@linutronix.de> <207acd23-4acb-3fd1-7c92-9f48c79fa059@oracle.com> <87sggbj0ok.fsf@nanos.tec.linutronix.de> <87368bg528.fsf@nanos.tec.linutronix.de>
Date:   Thu, 07 May 2020 19:06:45 +0200
Message-ID: <87zhajekt6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> Alexandre Chartre <alexandre.chartre@oracle.com> writes:
>>> On 5/5/20 3:41 PM, Thomas Gleixner wrote:
>>>> -	/*
>>>> -	 * User mode is traced as though IRQs are on, and the interrupt
>>>> -	 * gate turned them off.
>>>> -	 */
>>>> -	TRACE_IRQS_OFF
>>>> -
>>>>   	movq	%rsp, %rdi
>>>>   	call	do_int80_syscall_32
>>>>   .Lsyscall_32_done:
>>>> 
>>>
>>> enter_from_user_mode() is also called with the CALL_enter_from_user_mode macro,
>>> which is used in interrupt_entry() and identry. Don't you need to also remove
>>> the TRACE_IRQS_OFF there now?
>>
>> Hrm. right. OTOH, it's just redundant and should be no harm, but let me have a
>> look at that again.
>
> Grr, no. It'll trigger the warnon when context tracking is enabled. /me
> scratches head and goes to fix.

Scratch that. After unfrying my brain by walking the dogs for an hour,
it's really just redundant calls into lockdep and tracing and both are
happy about it.

I could do a temporary function for that or just mention it in the
changelog.

Thanks,

        tglx
