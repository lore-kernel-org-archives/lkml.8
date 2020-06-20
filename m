Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF00DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A60C222BEB
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgFTBAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:00:09 -0400
Received: from mta-out1.inet.fi ([62.71.2.226]:58842 "EHLO julia1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731172AbgFTBAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:00:05 -0400
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduhedrudejjedgfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuuffpveftnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefklhhkkhgrucfrrhhushhiuceoihhlkhhkrgdrphhruhhsihesphhprdhinhgvthdrfhhiqeenucggtffrrghtthgvrhhnpeekgfehudetffevteelffevheefvdetveefjeffkeegveeijedutefgudduveetleenucfkphepkeegrddvhedurdduleegrdduieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdehngdpihhnvghtpeekgedrvdehuddrudelgedrudeigedpmhgrihhlfhhrohhmpeeophhruhhsihhlqddusehmsghogidrihhnvghtrdhfihequceuqfffjgepkeeukffvoffkoffgpdhrtghpthhtohepoehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgheqpdhrtghpthhtohepoehluhhtoheskhgvrhhnvghlrdhorhhgqedprhgtphhtthhopeeophgvthgvrhiisehinhhfrhgruggvrggurdhorhhgqedprhgtphhtthhopeeorhhivghlsehsuhhrrhhivghlrdgtohhmqedprhgtphhtthhopeeogiekieeskhgvrhhnvghlrdhorhhgqe
Received: from [192.168.1.105] (84.251.194.164) by julia1.inet.fi (9.0.019.26-1) (authenticated as prusil-1)
        id 5EEA260E000BCAB2; Sat, 20 Jun 2020 03:59:44 +0300
Subject: Re: WARNING at switch_mm_irqs_off, followed by frozen machine
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, riel@surriel.com, luto@kernel.org,
        x86@kernel.org
References: <c060d969-beb1-f99b-ab56-d2e9fd85c5dc@pp.inet.fi>
 <20200618102135.GA616959@hirez.programming.kicks-ass.net>
From:   Ilkka Prusi <ilkka.prusi@pp.inet.fi>
Message-ID: <b532d1be-221c-865a-c400-0b8b6273b489@pp.inet.fi>
Date:   Sat, 20 Jun 2020 03:59:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200618102135.GA616959@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18.6.2020 13.21, Peter Zijlstra wrote:
> On Wed, Jun 17, 2020 at 02:32:39AM +0300, Ilkka Prusi wrote:
>> Hi,
>>
>> Yesterday my computer with kernel version 5.7.2 was frozen badly enough that
>> hard reset was necessary (did not react to SysRq keys). Upon checking logs I
>> found following warning and information from the time just before resetting
>> it.
>>
>> Computer has AMD Ryzen 7 2700, Asus B450 motherboard.
>>
>> 5.8-rc1 encountered BUG() and did not boot (iommu and smp_processor_id()
>> called from wrong context, I'll see if I can catch log somehow).
> Since you're building your own kernels, can you make sure to always
> have:
>
>   - CONFIG_DEBUG_BUGVERBOSE=y
>   - CONFIG_DEBUG_INFO=y
>
> and then when reporting, run the thing through:
>
>    ./scripts/decode_stacktrace.sh

Ok, thanks for letting me know, I'll try that.


> And then pattern match that against my local defconfig build of
> arch/x86/mm/tlb.o and pray my compiler did anyting like your
> (unspecified) compiler.

Forgot to mention that, currently it is:

gcc (Debian 9.3.0-13) 9.3.0

I'll try your suggestions, sorry for not replying sooner.

--

  - Ilkka Prusi


