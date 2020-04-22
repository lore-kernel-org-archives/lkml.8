Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6B5C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0078B2071C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hydbrada"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgDVBI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726039AbgDVBI5 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:08:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707EC0610D5
        for <Linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 18:08:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n143so823710qkn.8
        for <Linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=WoDvIgrBb0QoRItKlJPO1BJJmfA65qhLHz7ytOyf7Wo=;
        b=hydbradagoiGZaYpX9JdWw8H6A4s8EPhUpt7wYP1trsAJFd7/if3EY4xpGTEBauRMX
         kadfkkpZl6M5WXfk9+e5gXj5jYy0VjqRge+CdgJLjBknh5E0GYu59Gw/OjLlrBNJPWdi
         xOF9L8Bp1sJiGdGh4q01PqXzMPUMVjYA2ATshSTG+Xgw4LpfRoCPqKJ0owpXWlG9IKoN
         cGoZ/ed0Rko9YlcI73mFWH6A8Zku1tt+THZRGBAirY7wTl1EhHLzKlA8sJVtE+W++YFZ
         jFG8LtPG975Rf/qEzi6TnSpaNhMl4rLYHQSMKztrkLHxZv96LKNZF8sLX9MIZtSJJqYK
         f1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=WoDvIgrBb0QoRItKlJPO1BJJmfA65qhLHz7ytOyf7Wo=;
        b=c6EvWyi2Y3FZS6AizN3gfD1rAsSPFQ/bsYd0g7qB+d0+4ZWY8HsJYvY+64qv6UZP5v
         NZ9HObWXcRFqdIo1xZaontY5fpLICvvJm9yeKbMlAtEtgAUnDeGegY9Q8v0m8RUIq8q+
         L9hleICxCkADkXWdJ3fs0HqU0MgCzq0cE6M1w3CGbrwtOM5/hr0ffNsKveuCheFY/CjI
         pKvwQ+EFs7j5zC/yn3WL5jL79bwFKka6nY/XNASeNzXNtouHZkdaDP5pcnUJNRUtNXHC
         qzI3lVrCCTqhiITioKUbzdsaewS+1qCWtlqeYsw7loVyr5K0oD90KGPIejSrX3s2PFJT
         TC4A==
X-Gm-Message-State: AGi0PuZ4bjxvNvgtzaC/edcGez4RlMO6bxp1JIOeaSijBsFUkPaAx2tg
        o0xB0bz7nrQ1cNcnX85E8z8=
X-Google-Smtp-Source: APiQypKg807tLFJLeLHMWFMwK7cFJd05myo5sKgZNe9T+XVDcM582mzkfX2wMP3P/JvcVTFZs7nGIw==
X-Received: by 2002:ae9:e8c2:: with SMTP id a185mr23485234qkg.72.1587517736342;
        Tue, 21 Apr 2020 18:08:56 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n67sm2933935qke.88.2020.04.21.18.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 18:08:55 -0700 (PDT)
Date:   Tue, 21 Apr 2020 22:08:43 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <b5724589-f653-f125-a227-b374ec575688@linux.intel.com>
References: <20200420145417.6864-1-yao.jin@linux.intel.com> <20200421135329.GA9110@kernel.org> <b5724589-f653-f125-a227-b374ec575688@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] perf stat: Improve runtime stat for interval mode
To:     "Jin, Yao" <yao.jin@linux.intel.com>
CC:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
From:   Arnaldo Melo <arnaldo.melo@gmail.com>
Message-ID: <1CBA1092-64D6-460B-8F60-8D249DFE3440@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On April 21, 2020 9:53:41 PM GMT-03:00, "Jin, Yao" <yao=2Ejin@linux=2Einte=
l=2Ecom> wrote:
>Hi Arnaldo,
>
>On 4/21/2020 9:53 PM, Arnaldo Carvalho de Melo wrote:
>> Em Mon, Apr 20, 2020 at 10:54:17PM +0800, Jin Yao escreveu:
>>> For interval mode, the metric is printed after # if it exists=2E But
>>> it's not calculated by the counts generated in this interval=2E See
>>> following examples,
>>>
>>>   root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>>>   #           time             counts unit events
>>>        1=2E000422803            764,809      inst_retired=2Eany       =
 =20
>#      2=2E9 CPI
>>>        1=2E000422803          2,234,932      cycles
>>>        2=2E001464585          1,960,061      inst_retired=2Eany       =
 =20
>#      1=2E6 CPI
>>>        2=2E001464585          4,022,591      cycles
>>>
>>> The second CPI should not be 1=2E6 (4,022,591/1,960,061 is 2=2E1)
>>>
>>>   root@kbl-ppc:~# perf stat -e cycles,instructions -I1000
>--interval-count 2
>>>   #           time             counts unit events
>>>        1=2E000429493          2,869,311      cycles
>>>        1=2E000429493            816,875      instructions            =
=20
>#    0=2E28  insn per cycle
>>>        2=2E001516426          9,260,973      cycles
>>>        2=2E001516426          5,250,634      instructions            =
=20
>#    0=2E87  insn per cycle
>>>
>>> The second 'insn per cycle' should not be 0=2E87 (5,250,634/9,260,973
>is 0=2E57)=2E
>>>
>>> The current code uses a global variable rt_stat for tracking and
>>> updating the std dev of runtime stat=2E Unlike the counts, rt_stat is
>>> not reset for interval=2E While the counts are reset for interval=2E
>>>
>>> perf_stat_process_counter()
>>> {
>>>          if (config->interval)
>>>                  init_stats(ps->res_stats);
>>> }
>>>
>>> So for interval, the rt_stat should be reset either=2E
>>=20
>>                                s/either/too/g right?
>>=20
>
>Yes, should use "too" here=2E :)

Ok

>
>> And please try and find what was the cset that introduced the
>problem,
>> so that we can have a Fixes: line and the stable series can pick it,
>ok?
> >
>> - Arnaldo
>>
>
>I have tried to find the patch which introduced this issue=2E
>
>51fd2df1e882 ("perf stat: Fix interval output values")=2E
>
>This patch zeros stats for interval mode=2E I just think it should reset=
=20
>rt_stat too=2E
>
>But I really don't know if it's fair to this patch so I don't add it in
>
>my patch description=2E

That's ok, this just speeds up the process, I'll check it :-)

- Arnaldo
>
>Thanks
>Jin Yao
>
>>> This patch resets rt_stat before read_counters, so the runtime
>>> stat is only calculated by the counts generated in this interval=2E
>>>
>>> With this patch,
>>>
>>>   root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>>>   #           time             counts unit events
>>>        1=2E000420924          2,408,818      inst_retired=2Eany       =
 =20
>#      2=2E1 CPI
>>>        1=2E000420924          5,010,111      cycles
>>>        2=2E001448579          2,798,407      inst_retired=2Eany       =
 =20
>#      1=2E6 CPI
>>>        2=2E001448579          4,599,861      cycles
>>>
>>>   root@kbl-ppc:~# perf stat -e cycles,instructions -I1000
>--interval-count 2
>>>   #           time             counts unit events
>>>        1=2E000428555          2,769,714      cycles
>>>        1=2E000428555            774,462      instructions            =
=20
>#    0=2E28  insn per cycle
>>>        2=2E001471562          3,595,904      cycles
>>>        2=2E001471562          1,243,703      instructions            =
=20
>#    0=2E35  insn per cycle
>>>
>>> Now the second 'insn per cycle' and CPI are calculated by the counts
>>> generated in this interval=2E
>>>
>>>   v2:
>>>   ---
>>>   Use just existing perf_stat__reset_shadow_per_stat(&rt_stat)=2E
>>>   We don't need to define new function perf_stat__reset_rt_stat=2E
>>>
>>> Signed-off-by: Jin Yao <yao=2Ejin@linux=2Eintel=2Ecom>
>>> ---
>>>   tools/perf/Documentation/perf-stat=2Etxt | 2 ++
>>>   tools/perf/builtin-stat=2Ec              | 1 +
>>>   2 files changed, 3 insertions(+)
>>>
>>> diff --git a/tools/perf/Documentation/perf-stat=2Etxt
>b/tools/perf/Documentation/perf-stat=2Etxt
>>> index 4d56586b2fb9=2E=2E3fb5028aef08 100644
>>> --- a/tools/perf/Documentation/perf-stat=2Etxt
>>> +++ b/tools/perf/Documentation/perf-stat=2Etxt
>>> @@ -176,6 +176,8 @@ Print count deltas every N milliseconds
>(minimum: 1ms)
>>>   The overhead percentage could be high in some cases, for instance
>with small, sub 100ms intervals=2E  Use with caution=2E
>>>   	example: 'perf stat -I 1000 -e cycles -a sleep 5'
>>>  =20
>>> +If the metric exists, it is calculated by the counts generated in
>this interval and the metric is printed after #=2E
>>> +
>>>   --interval-count times::
>>>   Print count deltas for fixed number of times=2E
>>>   This option should be used together with "-I" option=2E
>>> diff --git a/tools/perf/builtin-stat=2Ec b/tools/perf/builtin-stat=2Ec
>>> index 9207b6c45475=2E=2E3f050d85c277 100644
>>> --- a/tools/perf/builtin-stat=2Ec
>>> +++ b/tools/perf/builtin-stat=2Ec
>>> @@ -359,6 +359,7 @@ static void process_interval(void)
>>>   	clock_gettime(CLOCK_MONOTONIC, &ts);
>>>   	diff_timespec(&rs, &ts, &ref_time);
>>>  =20
>>> +	perf_stat__reset_shadow_per_stat(&rt_stat);
>>>   	read_counters(&rs);
>>>  =20
>>>   	if (STAT_RECORD) {
>>> --=20
>>> 2=2E17=2E1
>>>
>>=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
