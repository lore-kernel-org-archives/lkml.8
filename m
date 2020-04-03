Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69D3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE57206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgDCU1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:27:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:27:23 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jKSuL-0003Vy-J3; Fri, 03 Apr 2020 22:27:17 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 0ED07103A01; Fri,  3 Apr 2020 22:27:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH v2] sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters
In-Reply-To: <20200403011559.GH103677@xz-x1>
References: <20200402145929.102587-1-peterx@redhat.com> <20200403011559.GH103677@xz-x1>
Date:   Fri, 03 Apr 2020 22:27:17 +0200
Message-ID: <87d08ol3h6.fsf@nanos.tec.linutronix.de>
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
> On Thu, Apr 02, 2020 at 10:59:29AM -0400, Peter Xu wrote:
>> -		pr_warn("isolcpus: Error, unknown flag\n");
>> -		return 0;
>> +		/*
>> +		 * Skip unknown sub-parameter and validate that it is not
>> +		 * containing an invalid character.
>> +		 */
>> +		for (par = str, len = 0; *str && *str != ','; str++, len++)

lacks {


>> +			if (!isalpha(*str))
>> +				illegal = true;

lacks }

>> +
>> +		if (illegal) {
>> +			pr_warn("isolcpus: Invalid flag %.*s\n", len, par);
>> +			return 0;
>> +		}
>> +
>> +		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
>> +		str++;
>>  	}
>
> I just noticed this is still problematic if we want to mark this as
> stable, because "managed_irq" violate the "isalpha()" rule already...
> It means even if we apply this patch to the stable trees it'll still
> think managed_irq as illegal and ignore the whole isolcpus=.

		if (!isalpha(*str) && *str != '_')

which is what I told you a couple of days ago already.

Thanks,

        tglx
