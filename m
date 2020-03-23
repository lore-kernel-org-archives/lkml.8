Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5D1C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D94A20784
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCWMNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:13:55 -0400
Received: from ciao.gmane.io ([159.69.161.202]:42424 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgCWMNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:13:55 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2020 08:13:54 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1jGLsy-000BDo-Df
        for linux-kernel@vger.kernel.org; Mon, 23 Mar 2020 13:08:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] perf cpumap: Use scnprintf instead of snprintf
Date:   Mon, 23 Mar 2020 13:08:47 +0100
Message-ID: <9f8351f9-7664-8c96-9c37-a6e86efc9643@wanadoo.fr>
References: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
 <20200323110334.GC26299@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200323110334.GC26299@kadam>
Content-Language: en-US
Cc:     kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200323120847.YASkE6xPJFEd2SSKyHzi5jsqAUqKdTwzbYMwaWPlt8Y@z>

Le 23/03/2020 à 12:03, Dan Carpenter a écrit :
> On Sun, Mar 22, 2020 at 06:25:23PM +0100, Christophe JAILLET wrote:
>> 'scnprintf' returns the number of characters written in the output buffer
>> excluding the trailing '\0', instead of the number of characters which
>> would be generated for the given input.
>>
>> Both function return a number of characters, excluding the trailing '\0'.
>> So comparaison to check if it overflows, should be done against max_size-1.
>> Comparaison against max_size can never match.
>>
>> Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
>> Fixes: a24020e6b7cf6 ("perf tools: Change cpu_map__fprintf output")
>> Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   tools/perf/util/cpumap.c | 39 ++++++++++++++++++++-------------------
>>   1 file changed, 20 insertions(+), 19 deletions(-)
>>
>> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
>> index 983b7388f22b..b87e7ef4d130 100644
>> --- a/tools/perf/util/cpumap.c
>> +++ b/tools/perf/util/cpumap.c
>> @@ -316,8 +316,8 @@ static void set_max_cpu_num(void)
>>   		goto out;
>>   
>>   	/* get the highest possible cpu number for a sparse allocation */
>> -	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
>> -	if (ret == PATH_MAX) {
>> +	ret = scnprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
>> +	if (ret == PATH_MAX-1) {
> This should be a static analysis warning.
>
> But isn't this stuff userspace?  I can't figure out how to compile it on
> Debian so I'm not sure.  There is no scnprintf() in user space.
>
> regards,
> dan carpenter

I compiled it with:

     make tools/perf

the cpumap.o is generated and if I introduce an error, 
'scn<SPACE>printf' for example, gcc triggers a built error.

I though it was enough to validate the patch, before sending it.


Anyway, keeping 'snprintf' could be better to check for the overflow, 
but 'if (ret == PATH_MAX)' should be turned in 'if (ret >= PATH_MAX)'.
If agreed, I can send a V2.

CJ


