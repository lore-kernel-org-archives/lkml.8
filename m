Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B471C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D02222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgBNU2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:28:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56210 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:28:31 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2hZa-0006Uc-4K; Fri, 14 Feb 2020 21:28:26 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 98825101304; Fri, 14 Feb 2020 21:28:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters
In-Reply-To: <20200214194008.GA1193332@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com> <20200214194008.GA1193332@xz-x1>
Date:   Fri, 14 Feb 2020 21:28:25 +0100
Message-ID: <877e0oud5i.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Tue, Feb 04, 2020 at 11:16:39AM -0500, Peter Xu wrote:
>> The "isolcpus=" parameter allows sub-parameters to exist before the
>> cpulist is specified, and if it sees unknown sub-parameters the whole
>> parameter will be ignored.  This design is incompatible with itself
>> when we add more sub-parameters to "isolcpus=", because the old
>> kernels will not recognize the new "isolcpus=" sub-parameters, then it
>> will invalidate the whole parameter so the CPU isolation will not
>> really take effect if we start to use the new sub-parameters while
>> later we reboot into an old kernel. Instead we will see this when
>> booting the old kernel:
>> 
>>     isolcpus: Error, unknown flag
>> 
>> The better and compatible way is to allow "isolcpus=" to skip unknown
>> sub-parameters, so that even if we add new sub-parameters to it the
>> old kernel will still be able to behave as usual even if with the new
>> sub-parameter is specified.
>> 
>> Ideally this patch should be there when we introduce the first
>> sub-parameter for "isolcpus=", so it's already a bit late.  However
>> late is better than nothing.
>
> Ping - Hi, Thomas, do you have any further comment on this patch?

Fine with me.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
