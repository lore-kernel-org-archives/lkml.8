Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F9C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167F6214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="e3jCTUqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgEINMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgEINMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:12:13 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F66CC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 06:12:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s186so2932557qkd.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uZNHLh4ji2HiGvtUwXeMXbue0p7OE33Ogu+s/y62Rjs=;
        b=e3jCTUqeHQ8ldBUQC1e+KDyk1kwtFBQIPG1wuTBtjpOZnD/Tp5ayjwp1p58WpoE0A9
         uL3xigHSDtO5/d6kq4eQS6BVDgQhd1zV8z+hMhwjLUODzu9OB71yTuk3vr30q3aJcY5w
         Bo3LczS3gpIikq8t1zKClP3DdLfMSHeb1+T+j/vJSh6iW/sNOsv5jtWDI8Fq3EdXFjL2
         okh2iZWE2U8q9vTHAIOBRDyPYdg9vuOsdR0ZZAE5U7drU0QdzkcualIrHe4PhDaPLf2/
         ScFZpWzwUtA+47p3VFn6ogDyvlur9dth4zCnH7W1Dh/VCBSGD9ioJizdZ1M3qve+vcEn
         vjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uZNHLh4ji2HiGvtUwXeMXbue0p7OE33Ogu+s/y62Rjs=;
        b=VeVps/EgfOWpXi/C3sxtqCMl5DypRAR5fDyNI3zsDTJArzzkehc8AdWesyufjg7sy4
         HmuhGoH6LdwAvdt2GT6V3C9b373dXPe/hgsUZKA1nES8iHXTos52AQvtvidAhqHY30Bd
         VVNafZZ4BGmpt83FI6f8typHA3nxig+E++Hc5NdplWH/6aiKg0UqbxAAyJoTxjrWlDC0
         MCloOYaF3xRnrWbExoq4S7wJoj43ohz12p9hSBAEFdYZcbhOqpD+XOT5nX8JXFl3EvFG
         /QffWTU7OqLxqOR5OmlneXL1mj5DQL3jwN2kpOI6KEgRZeXZyy9s2FI8wXODvgPojpkP
         KDIQ==
X-Gm-Message-State: AGi0PuaLUQqwzVxHo/xAHo1fb1rpl1ezoeDD2/clvJ9tAwBPPYijRbX3
        B3DIiqz7cKwV4Ry/+oZHb/8jrg==
X-Google-Smtp-Source: APiQypKV294SlsFqXKts2w2oeiforaUknW+vbd6TojoXshc+5Kmz2XFjJyxBBo+MHJGoFZN7tvmAvg==
X-Received: by 2002:a37:9fd5:: with SMTP id i204mr7598243qke.191.1589029932374;
        Sat, 09 May 2020 06:12:12 -0700 (PDT)
Received: from qians-mbp.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m59sm4028164qtd.46.2020.05.09.06.12.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 May 2020 06:12:11 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] sched/cputime: silence a -Wunused-function warning
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
Date:   Sat, 9 May 2020 09:12:10 -0400
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        bsegall@google.com, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8FFFB10-A619-480C-8828-DCD471B13F91@lca.pw>
References: <1583509304-28508-1-git-send-email-cai@lca.pw>
 <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 6, 2020, at 12:13 PM, Nick Desaulniers =
<ndesaulniers@google.com> wrote:
>=20
> On Fri, Mar 6, 2020 at 7:42 AM Qian Cai <cai@lca.pw> wrote:
>>=20
>> account_other_time() is only used when CONFIG_IRQ_TIME_ACCOUNTING=3Dy =
(in
>> irqtime_account_process_tick()) or CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy =
(in
>> get_vtime_delta()). When both are off, it will generate a compilation
>> warning from Clang,
>>=20
>> kernel/sched/cputime.c:255:19: warning: unused function
>> 'account_other_time' [-Wunused-function]
>> static inline u64 account_other_time(u64 max)
>>=20
>> Rather than wrapping around this function with a macro expression,
>>=20
>> if defined(CONFIG_IRQ_TIME_ACCOUNTING) || \
>>    defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
>>=20
>> just use __maybe_unused for this small function which seems like a =
good
>> trade-off.
>>=20
>> Signed-off-by: Qian Cai <cai@lca.pw>
>=20
> Hi Qian, thanks for the patch!
>=20
> Generally, I'm not a fan of __maybe_unused.  It is a tool in the
> toolbox for solving this issue, but it's my least favorite.  Should
> the call sites be eliminated, this may mask an unused and entirely
> dead function from being removed.  Preprocessor guards based on config
> give more context into *why* a particular function may be unused.
>=20
> So let's take a look at the call sites of account_other_time().  Looks
> like irqtime_account_process_tick() (guarded by
> CONFIG_IRQ_TIME_ACCOUNTING) and get_vtime_delta() (guarded by
> CONFIG_VIRT_CPU_ACCOUNTING_GEN).  If it were one config guard, then I
> would prefer to move the definition to be within the same guard, just
> before the function definition that calls it, but we have a more
> complicated case here.
>=20
> The next thing I'd check to see is if there's a dependency between
> configs.  In this case, both CONFIG_IRQ_TIME_ACCOUNTING and
> CONFIG_VIRT_CPU_ACCOUNTING_GEN are defined in init/Kconfig.  In this
> case there's also no dependency between configs, so specifying one
> doesn't imply the other; so guarding on one of the two configs is also
> not an option.
>=20
> So, as much as I'm not a fan of __maybe_unused, it is indeed the
> simplest option.  Though, I'd still prefer the ifdef you describe
> instead, maybe the maintainers can provide guidance/preference?
> Otherwise,
>=20
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Peter, can you take a look at this patch when you have a chance? Having =
Clang to complain this every time is a bit annoying.

>=20
>> ---
>> kernel/sched/cputime.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
>> index cff3e656566d..85da4d6dee24 100644
>> --- a/kernel/sched/cputime.c
>> +++ b/kernel/sched/cputime.c
>> @@ -252,7 +252,7 @@ static __always_inline u64 =
steal_account_process_time(u64 maxtime)
>> /*
>>  * Account how much elapsed time was spent in steal, irq, or softirq =
time.
>>  */
>> -static inline u64 account_other_time(u64 max)
>> +static inline __maybe_unused u64 account_other_time(u64 max)
>> {
>>        u64 accounted;
>>=20
>> --
>=20
> --=20
> Thanks,
> ~Nick Desaulniers

