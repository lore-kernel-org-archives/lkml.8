Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4D6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E63922B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgGaL7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:59:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732689AbgGaL7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:59:15 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 400E1FFCCF478D1BCD9E;
        Fri, 31 Jul 2020 19:59:09 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.63) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 31 Jul 2020
 19:58:59 +0800
Subject: Re: [PATCH -next] tools build: Check return value of fwrite_unlocked
 in jvmti_agent.c
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     <cj.chengjian@huawei.com>, Li Bin <huawei.libin@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
References: <20200724100706.48330-1-bobo.shaobowang@huawei.com>
 <CAP-5=fX9YUucA-3QMxO_jV954104UPNg04=_JGstuLekNJHzJw@mail.gmail.com>
 <20200730100357.GD424218@kernel.org>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <c83e1354-29a8-82d5-8963-96c71f4de1de@huawei.com>
Date:   Fri, 31 Jul 2020 19:58:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200730100357.GD424218@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/30 18:03, Arnaldo Carvalho de Melo 写道:
> Em Wed, Jul 29, 2020 at 04:47:36PM -0700, Ian Rogers escreveu:
>> On Fri, Jul 24, 2020 at 3:07 AM Wang ShaoBo <bobo.shaobowang@huawei.com> wrote:
>>> Function jvmti_write_code called by compiled_method_load_cb may return
>>> error in using fwrite_unlocked, this failure should be captured and
>>> warned.
>>>
>>> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
>>> ---
>>>   tools/perf/jvmti/jvmti_agent.c | 23 +++++++++++++++--------
>>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
>>> index 88108598d6e9..a1fe6aa16b6d 100644
>>> --- a/tools/perf/jvmti/jvmti_agent.c
>>> +++ b/tools/perf/jvmti/jvmti_agent.c
>>> @@ -363,7 +363,7 @@ jvmti_write_code(void *agent, char const *sym,
>>>          struct jr_code_load rec;
>>>          size_t sym_len;
>>>          FILE *fp = agent;
>>> -       int ret = -1;
>>> +       int ret;
>>>
>>>          /* don't care about 0 length function, no samples */
>>>          if (size == 0)
>>> @@ -401,16 +401,23 @@ jvmti_write_code(void *agent, char const *sym,
>>>          rec.code_index = code_generation++;
>>>
>>>          ret = fwrite_unlocked(&rec, sizeof(rec), 1, fp);
>>> -       fwrite_unlocked(sym, sym_len, 1, fp);
>>> +       if (ret)
>>> +               goto error;
>> Sorry, it seems I lost a reply to this. Won't ret here be the number
>> of items written and not an error code? Consequently all writes will
>> immediately goto error?
> Yeah, I removed it from tmp.perf/core.
>
> Wang, please address Ian review, and consider having just one out exit
> label.
>
> - Arnaldo
>   

I am sorry I forgot what does fwrite_unlocked return, as same as fwrite 
error happens,

the return val is a short item count (or zero)  but not equals the items 
written. I have fixed

it and already sent v2 and address Ian review, thanks a lot.

... and i refer to the writing of function jvmti_write_debug_info() for 
giving out exit label,

thanks again,

- Wang ShaoBo

>> Thanks,
>> Ian
>>
>>> +       ret = fwrite_unlocked(sym, sym_len, 1, fp);
>>> +       if (ret)
>>> +               goto error;
>>>
>>> -       if (code)
>>> -               fwrite_unlocked(code, size, 1, fp);
>>> +       if (code) {
>>> +               ret = fwrite_unlocked(code, size, 1, fp);
>>> +               if (ret)
>>> +                       goto error;
>>> +       }
>>>
>>>          funlockfile(fp);
>>> -
>>> -       ret = 0;
>>> -
>>> -       return ret;
>>> +       return 0;
>>> +error:
>>> +       funlockfile(fp);
>>> +       return -1;
>>>   }
>>>
>>>   int
>>> --
>>> 2.17.1
>>>

