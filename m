Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1FCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C798D206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oPKUFavM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgF3DNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:13:36 -0400
Received: from mail.efficios.com ([167.114.26.124]:47622 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgF3DNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:13:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E9E3326EAD9;
        Mon, 29 Jun 2020 23:13:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5vkUxi20-G2Z; Mon, 29 Jun 2020 23:13:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F1E5326EAD8;
        Mon, 29 Jun 2020 23:13:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F1E5326EAD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593486813;
        bh=R5ZlUL7/vQ6MoBzTCY3SkTYUTUire+o4YUZLpl6JiNo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oPKUFavM6yDgZZM38NknHHFN5dH7VvZrboEypT1jLRD9VWhnh8hkQUU33zcR21mAT
         tx3D6w1z/TGQ5X3Qxqa2O184qZqycO7BkKRZNU8dW3VU+iWpbc+EHSjTpdMI9q5Bm/
         U7qLQuYOoIEcmyKWYDpOh3OtpLWYTGM4gTWFgtmd1jzsZMnOW4xDPilswkGb/HoVVj
         A4zpLHTFseT0qAZUQE+t6//YkrkIdD/xa0IObAddCT0tcFFiIrK9sBGrynZHOdxuoh
         gGVyWaFNcaPM+2Cp11+WpzbnYj9y4NDQEZANcrLmoqFjcfDSSBIwVK+XZCuOKMc7oN
         /JPi+U1cbXdzQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id imwnYF2YNCP7; Mon, 29 Jun 2020 23:13:32 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D10F526EAD7;
        Mon, 29 Jun 2020 23:13:32 -0400 (EDT)
Date:   Mon, 29 Jun 2020 23:13:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        bristot <bristot@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Message-ID: <650783164.16607.1593486812734.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200629202146.29520925@oasis.local.home>
References: <20200625094454.732790f7@oasis.local.home> <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com> <20200625143525.2f3a2902@oasis.local.home> <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com> <20200629202146.29520925@oasis.local.home>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: ring-buffer: Have nested events still record running time stamp
Thread-Index: L5tol2GRMWoVeIOv3wWpkJC/KUQO3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 29, 2020, at 8:21 PM, rostedt rostedt@goodmis.org wrote:

> On Thu, 25 Jun 2020 15:35:02 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> >> So the reservation is not "just" an add instruction, it's actually an
>> >> xadd on x86. Is that really faster than a cmpxchg ?
>> > 
>> > I believe the answer is still yes. But I can run some benchmarks to
>> > make sure.
>> 
>> This would be interesting to see, because if xadd and cmpxchg have
>> similar overhead, then going for a cmpxchg-loop for the space
>> reservation could vastly decrease the overall complexity of this
>> timestamp+space reservation algorithm.
> 
> So I tested this on three different machines to see how it compared. I
> applied this patch:
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c2c0d25ea004..8a7d62375eb3 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3161,7 +3161,19 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
> 
>  /*B*/	rb_time_set(&cpu_buffer->before_stamp, info->ts);
> 
> +#if 0
>  /*C*/	write = local_add_return(info->length, &tail_page->write);
> +#else
> +	{
> +		unsigned long expect, result;
> +
> +		do {
> +			expect = local_read(&tail_page->write);
> +			write = expect + info->length;
> +			result = local_cmpxchg(&tail_page->write, expect, write);
> +		} while (expect != result);
> +	}
> +#endif
> 
> 	/* set write to only the index of the write */
> 	write &= RB_WRITE_MASK;
> 
> 
> And tested before and after the results.

[...]
> 
> Not that big of a difference, but there is a difference. And the
> standard deviation appears to be better, which would make sense as an
> local_add_return() needs no repeat on collision.

I tried running your recommended test on my machine many times with the same
configuration. It appears that the avg and std dev results vary a lot between
runs of the exact same configuration:

Model name:          Intel(R) Xeon(R) CPU E5-2630 v3 @ 2.40GHz

* With xadd (existing code):

 event_benchmark-1828  [016]    71.309475: benchmark_event:      last=190 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309476: benchmark_event:      last=192 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309476: benchmark_event:      last=195 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309477: benchmark_event:      last=193 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309478: benchmark_event:      last=190 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309479: benchmark_event:      last=190 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309479: benchmark_event:      last=192 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309480: benchmark_event:      last=192 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309481: benchmark_event:      last=195 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437
 event_benchmark-1828  [016]    71.309481: benchmark_event:      last=193 first=4200 max=234226 min=185 avg=256 std=333 std^2=111437


 event_benchmark-1865  [003]   162.955546: benchmark_event:      last=489 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955546: benchmark_event:      last=205 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955547: benchmark_event:      last=204 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955548: benchmark_event:      last=204 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955549: benchmark_event:      last=203 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955549: benchmark_event:      last=206 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955550: benchmark_event:      last=203 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955551: benchmark_event:      last=205 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955552: benchmark_event:      last=205 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057
 event_benchmark-1865  [003]   162.955552: benchmark_event:      last=205 first=4386 max=29000 min=185 avg=243 std=161 std^2=26057

 event_benchmark-1904  [003]   202.847955: benchmark_event:      last=205 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847956: benchmark_event:      last=500 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847957: benchmark_event:      last=355 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847958: benchmark_event:      last=340 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847959: benchmark_event:      last=462 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847960: benchmark_event:      last=278 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847961: benchmark_event:      last=243 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847962: benchmark_event:      last=205 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847963: benchmark_event:      last=470 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605
 event_benchmark-1904  [003]   202.847964: benchmark_event:      last=364 first=5230 max=27647 min=185 avg=239 std=150 std^2=22605

 event_benchmark-1941  [003]   234.577797: benchmark_event:      last=204 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577798: benchmark_event:      last=445 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577799: benchmark_event:      last=693 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577800: benchmark_event:      last=293 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577801: benchmark_event:      last=205 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577802: benchmark_event:      last=202 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577802: benchmark_event:      last=203 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577803: benchmark_event:      last=204 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577804: benchmark_event:      last=204 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989
 event_benchmark-1941  [003]   234.577805: benchmark_event:      last=205 first=5117 max=17387 min=185 avg=233 std=141 std^2=19989


 event_benchmark-1978  [003]   279.276351: benchmark_event:      last=205 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276352: benchmark_event:      last=203 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276353: benchmark_event:      last=207 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276354: benchmark_event:      last=207 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276355: benchmark_event:      last=205 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276355: benchmark_event:      last=205 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276356: benchmark_event:      last=204 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276357: benchmark_event:      last=206 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276358: benchmark_event:      last=286 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885
 event_benchmark-1978  [003]   279.276359: benchmark_event:      last=202 first=4583 max=17638 min=185 avg=241 std=163 std^2=26885


 event_benchmark-2015  [003]   309.974432: benchmark_event:      last=202 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974433: benchmark_event:      last=204 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974434: benchmark_event:      last=205 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974435: benchmark_event:      last=206 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974435: benchmark_event:      last=205 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974436: benchmark_event:      last=203 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974437: benchmark_event:      last=205 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974438: benchmark_event:      last=275 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974439: benchmark_event:      last=205 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323
 event_benchmark-2015  [003]   309.974440: benchmark_event:      last=600 first=5090 max=22623 min=185 avg=241 std=152 std^2=23323

-> This configuration's avg varies between 233 and 256 ns based on your benchmark methodology. The std. dev. varies between
141 and 333 ns.


* With your cmpxchg modification:

 event_benchmark-1256  [010]    56.943734: benchmark_event:      last=210 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943736: benchmark_event:      last=208 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943737: benchmark_event:      last=1223 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943738: benchmark_event:      last=676 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943739: benchmark_event:      last=337 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943740: benchmark_event:      last=455 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943741: benchmark_event:      last=280 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943742: benchmark_event:      last=246 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943743: benchmark_event:      last=205 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524
 event_benchmark-1256  [010]    56.943743: benchmark_event:      last=207 first=5210 max=83243 min=187 avg=265 std=201 std^2=40524

 event_benchmark-1293  [025]    84.352468: benchmark_event:      last=198 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352469: benchmark_event:      last=198 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352470: benchmark_event:      last=338 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352471: benchmark_event:      last=197 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352471: benchmark_event:      last=196 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352472: benchmark_event:      last=197 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352473: benchmark_event:      last=198 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352474: benchmark_event:      last=197 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352474: benchmark_event:      last=197 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469
 event_benchmark-1293  [025]    84.352475: benchmark_event:      last=196 first=5446 max=25969 min=188 avg=241 std=168 std^2=28469


 event_benchmark-1330  [014]   111.729937: benchmark_event:      last=473 first=3724 max=31525 min=187 avg=245 std=160 std^2=25626
 event_benchmark-1330  [014]   111.729939: benchmark_event:      last=1085 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627
 event_benchmark-1330  [014]   111.729940: benchmark_event:      last=602 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627
 event_benchmark-1330  [014]   111.729942: benchmark_event:      last=602 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627
 event_benchmark-1330  [014]   111.729943: benchmark_event:      last=393 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627
 event_benchmark-1330  [014]   111.729944: benchmark_event:      last=558 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627
 event_benchmark-1330  [014]   111.729946: benchmark_event:      last=410 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627
 event_benchmark-1330  [014]   111.729947: benchmark_event:      last=408 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627
 event_benchmark-1330  [014]   111.729949: benchmark_event:      last=428 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627
 event_benchmark-1330  [014]   111.729950: benchmark_event:      last=717 first=3724 max=31525 min=187 avg=245 std=160 std^2=25627

 event_benchmark-1367  [025]   143.251162: benchmark_event:      last=209 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251163: benchmark_event:      last=420 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251164: benchmark_event:      last=413 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251165: benchmark_event:      last=209 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251165: benchmark_event:      last=205 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251166: benchmark_event:      last=209 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251167: benchmark_event:      last=208 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251168: benchmark_event:      last=207 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251169: benchmark_event:      last=208 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567
 event_benchmark-1367  [025]   143.251169: benchmark_event:      last=210 first=3706 max=19397 min=187 avg=244 std=146 std^2=21567

 event_benchmark-1404  [025]   182.750612: benchmark_event:      last=207 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750612: benchmark_event:      last=207 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750613: benchmark_event:      last=207 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750614: benchmark_event:      last=210 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750615: benchmark_event:      last=209 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750616: benchmark_event:      last=208 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750616: benchmark_event:      last=206 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750617: benchmark_event:      last=207 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750618: benchmark_event:      last=206 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319
 event_benchmark-1404  [025]   182.750619: benchmark_event:      last=209 first=3727 max=18550 min=187 avg=239 std=138 std^2=19319

-> This configuration's avg varies between 239 and 256 ns based on your benchmark methodology. The std. dev. varies between
138 and 201 ns.

In the benchmark results you collected, config #1 appeared to have little delta between xadd and cmpxchg, whereas
config #2 and #3 had some avg difference. Did you try running this test many times on each machine to see if the
result was indeed stable ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
