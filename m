Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C49C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2582087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgBDJOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:14:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33051 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBDJOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:14:08 -0500
Received: from [212.187.182.163] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iyuHT-0000TV-Eh; Tue, 04 Feb 2020 10:14:03 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 72864100720; Tue,  4 Feb 2020 09:13:55 +0000 (GMT)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH V4] sched/isolation: isolate from handling managed interrupt
In-Reply-To: <20200203235743.GH155875@xz-x1>
References: <20200120091625.17912-1-ming.lei@redhat.com> <87eevrei7h.fsf@nanos.tec.linutronix.de> <20200203192154.GG155875@xz-x1> <87a75zz2hl.fsf@nanos.tec.linutronix.de> <20200203235743.GH155875@xz-x1>
Date:   Tue, 04 Feb 2020 09:13:55 +0000
Message-ID: <875zgmzpd8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

Peter Xu <peterx@redhat.com> writes:
> On Mon, Feb 03, 2020 at 11:15:50PM +0000, Thomas Gleixner wrote:
>> No, really. The basic guarantee is that your new kernel is going to work
>> fine with the previous command line, but making a guarantee that new
>> command line options still work on an old kernel are just creating a
>> horrible mess. So if that command line interface was not designed to
>> handle unknown arguments in the first place, you better fix that.
>
> Hi, Thomas,
>
> Just to make sure I understand it right: are you suggesting that we
> fix up housekeeping_isolcpus_setup() to be able to skip unknown sub
> parameters?

Exactly.
