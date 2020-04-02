Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D8CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160FB20857
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgDBIk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:40:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36427 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDBIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:40:56 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJvP8-0007bS-JR; Thu, 02 Apr 2020 10:40:50 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CB67C100D52; Thu,  2 Apr 2020 10:40:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters
In-Reply-To: <20200402005003.GF7174@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com> <87d08rosof.fsf@nanos.tec.linutronix.de> <20200401230105.GF648829@xz-x1> <87wo6yokdx.fsf@nanos.tec.linutronix.de> <20200402005003.GF7174@xz-x1>
Date:   Thu, 02 Apr 2020 10:40:49 +0200
Message-ID: <87pncqnuum.fsf@nanos.tec.linutronix.de>
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
> On Thu, Apr 02, 2020 at 01:29:14AM +0200, Thomas Gleixner wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> >> +		/*
>> >> +		 * Skip unknown sub-parameter and validate that it is not
>> >> +		 * containing an invalid character.
>> >> +		 */
>> >> +		for (par = str, len = 0; isalpha(*str); str++, len++);
>> >> +		if (*str != ',') {
>> >> +			pr_warn("isolcpus: Invalid flag %*s\n", len, par);
>> >
>> > ... this will dump "isolcpus: Invalid flag domain1,3,5", is this what
>> > we wanted?  Maybe only dumps "domain1"?
>> 
>> No, it will dump: "domain1" at least if my understanding of is_alpha()
>> and the '%*s' format option is halfways correct
>
> It will dump "isolcpus: Invalid flag domain1,3,5". Do you mean "%.*s"
> instead?

Obviously.

> Another issue is even if to use "%.*s" it'll only dump "domain".  How
> about something like (declare "illegal" as bool):
>
> 		/*
> 		 * Skip unknown sub-parameter and validate that it is not
> 		 * containing an invalid character.
> 		 */
> 		for (par = str, len = 0; *str && *str != ','; str++, len++)
> 			if (!isalpha(*str))
> 				illegal = true;
>
> 		if (illegal) {
> 			pr_warn("isolcpus: Invalid flag %.*s\n", len, par);

You can achieve the same thing without the illegal indirection with

	pr_warn("....", len + 1, par);

Thanks,

        tglx
