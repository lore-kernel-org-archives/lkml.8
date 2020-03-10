Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F92C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBEE21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCJQiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:38:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34313 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgCJQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:38:15 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBhtK-000791-Ez; Tue, 10 Mar 2020 17:38:02 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D9EFB1040A5; Tue, 10 Mar 2020 17:38:01 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch part-II V2 11/13] x86/speculation/mds: Mark mds_user_clear_cpu_buffers() __always_inline
In-Reply-To: <c9847c45-32b0-e5e6-1eb9-5f9e10814276@oracle.com>
References: <20200308222359.370649591@linutronix.de> <20200308222610.040107039@linutronix.de> <c9847c45-32b0-e5e6-1eb9-5f9e10814276@oracle.com>
Date:   Tue, 10 Mar 2020 17:38:01 +0100
Message-ID: <87lfo85fo6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Chartre <alexandre.chartre@oracle.com> writes:
> On 3/8/20 11:24 PM, Thomas Gleixner wrote:
>> -static inline void mds_user_clear_cpu_buffers(void)
>> +static __always_inline void mds_user_clear_cpu_buffers(void)
>>   {
>>   	if (static_branch_likely(&mds_user_clear))
>>   		mds_clear_cpu_buffers();
>> 
>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>
> I am just wondering if it would be worth defining a new function attribute to
> identify functions which shouldn't be trace/probe more clearly. For example:
>
> #define no_trace_and_probe __always_inline
>
> static no_trace_and_probe void mds_user_clear_cpu_buffers(void)
> {
>          ...
> }
>
> I am just concerned that overtime we might forgot that a function is defined
> __always_inline just because it shouldn't be traced/probed.

True, for exactly that reason we are reconsidering the whole annotation
business by putting stuff into a separate section so we get tools
support for finding things which escape. See the discussion at:

  https://lore.kernel.org/lkml/87mu8p797b.fsf@nanos.tec.linutronix.de/

Peter and I are working on this right now, so you might end up reviewing
this pile in different form yet another time :(

Thanks,

        tglx
