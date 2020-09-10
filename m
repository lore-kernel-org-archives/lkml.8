Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C866C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14610221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zxsh27oB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yqjeWYzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgIJVNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbgIJOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:30:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17222C061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:30:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599748224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWWy0CgZ+y9ZmhTEZ7A/4Ms1nsKBvSf88fffnFC72wI=;
        b=Zxsh27oB+MOp6Tvfq3WtfCosflXzlmzZSHLEcQXeFgnypnx/eHgmeEQAn4iUX9JbMukAN0
        6vbjy+yjcEuJqVE1B+Z/tFWUJoMhKH9FV3j61ROqdMde8tdDfqNqnVyHkgvVfs9W/imMcE
        zY3qcnPqWYVUmy0tCCH22WDhuQMN98N1W4xIwkRuO5xEcQKTKCRV5S8CaU51pmm+InxisG
        TnyGocEzdnaD8CAwo8W4XxofGsDe6Pc3UpQpJ4qXSIED+XRPzO1iCmVCaCqDIuF61sP2mG
        DIIgKTeYTqtiDR1XQUsyzzezE9gRlLhrwkTRocN2bn1tf7J3HNJCMheLZx+MBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599748224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AWWy0CgZ+y9ZmhTEZ7A/4Ms1nsKBvSf88fffnFC72wI=;
        b=yqjeWYzfBigZS6gv6nuElfgexkBTbuvqcXTTiwzW2btRd9XS+zLF7PdSdhVWJwXaA7KHl1
        w54gqUWXEVh6fPAA==
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, anna-maria@linutronix.de,
        vbabka@suse.cz, mgorman@techsingularity.net, mhocko@suse.com,
        linux-mm@kvack.org
Subject: Re: kcompactd hotplug fail
In-Reply-To: <20200910141006.GA1362448@hirez.programming.kicks-ass.net>
References: <20200910141006.GA1362448@hirez.programming.kicks-ass.net>
Date:   Thu, 10 Sep 2020 16:30:24 +0200
Message-ID: <87ft7pk8lb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10 2020 at 16:10, peterz wrote:
> While playing with hotplug, I ran into the below:
>
> [ 2305.676384] ------------[ cut here ]------------
> [ 2305.681543] WARNING: CPU: 1 PID: 15 at kernel/sched/core.c:1924 __set_cpus_allowed_ptr+0x1bd/0x230
> [ 2305.821454]  kcompactd_cpu_online+0xa1/0xb0
>
> Given:
>
> static int __init kcompactd_init(void)
> {
> 	...
> 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
> 					"mm/compaction:online",
> 					kcompactd_cpu_online, NULL);
>
> and:
>
>
> 	CPUHP_AP_ONLINE_DYN,
> 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
> 	CPUHP_AP_X86_HPET_ONLINE,
> 	CPUHP_AP_X86_KVM_CLK_ONLINE,
> 	CPUHP_AP_ACTIVE,
>
> this is somewhat expected behaviour.
>
> It tries and set the compaction affinity to include the newly onlined
> CPU before it is marked active and that's a no-no.
>
> Ideally the kcompactd notifier is ran after AP_ACTIVE, not before.

Indeed. So we need steps post ACTIVE which we did not want to have in
the first place :)

Thanks,

        tglx


