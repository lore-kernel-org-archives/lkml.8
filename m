Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015D0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D110620658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgCXOoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:44:24 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:55821 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgCXOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:44:23 -0400
Received: from [192.168.42.210] ([93.22.39.100])
        by mwinf5d18 with ME
        id JEkD2200M29f5LV03EkD63; Tue, 24 Mar 2020 15:44:21 +0100
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 24 Mar 2020 15:44:21 +0100
X-ME-IP: 93.22.39.100
Subject: Re: [PATCH V2] perf cpumap: Fix snprintf overflow check
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        zhe.he@windriver.com, dzickus@redhat.com, jstancek@redhat.com,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200324070319.10901-1-christophe.jaillet@wanadoo.fr>
 <20200324125001.GA21569@kernel.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <75a8e792-dc9e-6169-4dd2-8758967c50e2@wanadoo.fr>
Date:   Tue, 24 Mar 2020 15:44:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324125001.GA21569@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/03/2020 à 13:50, Arnaldo Carvalho de Melo a écrit :
> Em Tue, Mar 24, 2020 at 08:03:19AM +0100, Christophe JAILLET escreveu:
>> 'snprintf' returns the number of characters which would be generated for
>> the given input.
>>
>> If the returned value is *greater than* or equal to the buffer size, it
>> means that the output has been truncated.
>>
>> Fix the overflow test accordingling.
>                                    y
>
> You forgot to CC David and add this to your patch, which I did:
>
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
>
> Ok?

No problem for me.

The to: and cc: list are (at least should be :)) the ones given by 
get_maintainer, and I was not aware of the 'Suggested-by' tag.

BTW, thanks for fixing the typo in the description.

CJ


> - Arnaldo
>   
>> Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
>> Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> V2: keep snprintf
>>      modifiy the tests for truncated output
>>      Update subject and description
>> ---
>>   tools/perf/util/cpumap.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
>> index 983b7388f22b..dc5c5e6fc502 100644
>> --- a/tools/perf/util/cpumap.c
>> +++ b/tools/perf/util/cpumap.c
>> @@ -317,7 +317,7 @@ static void set_max_cpu_num(void)
>>   
>>   	/* get the highest possible cpu number for a sparse allocation */
>>   	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
>> -	if (ret == PATH_MAX) {
>> +	if (ret >= PATH_MAX) {
>>   		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>>   		goto out;
>>   	}
>> @@ -328,7 +328,7 @@ static void set_max_cpu_num(void)
>>   
>>   	/* get the highest present cpu number for a sparse allocation */
>>   	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
>> -	if (ret == PATH_MAX) {
>> +	if (ret >= PATH_MAX) {
>>   		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>>   		goto out;
>>   	}
>> @@ -356,7 +356,7 @@ static void set_max_node_num(void)
>>   
>>   	/* get the highest possible cpu number for a sparse allocation */
>>   	ret = snprintf(path, PATH_MAX, "%s/devices/system/node/possible", mnt);
>> -	if (ret == PATH_MAX) {
>> +	if (ret >= PATH_MAX) {
>>   		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>>   		goto out;
>>   	}
>> @@ -441,7 +441,7 @@ int cpu__setup_cpunode_map(void)
>>   		return 0;
>>   
>>   	n = snprintf(path, PATH_MAX, "%s/devices/system/node", mnt);
>> -	if (n == PATH_MAX) {
>> +	if (n >= PATH_MAX) {
>>   		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>>   		return -1;
>>   	}
>> @@ -456,7 +456,7 @@ int cpu__setup_cpunode_map(void)
>>   			continue;
>>   
>>   		n = snprintf(buf, PATH_MAX, "%s/%s", path, dent1->d_name);
>> -		if (n == PATH_MAX) {
>> +		if (n >= PATH_MAX) {
>>   			pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>>   			continue;
>>   		}
>> -- 
>> 2.20.1
>>

