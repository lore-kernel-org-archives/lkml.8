Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544ABC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DDB206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgDHUTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:19:25 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:19921 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgDHUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:19:24 -0400
Received: from [192.168.42.210] ([93.22.134.86])
        by mwinf5d68 with ME
        id QLKH220081s0W2503LKHT1; Wed, 08 Apr 2020 22:19:18 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 08 Apr 2020 22:19:18 +0200
X-ME-IP: 93.22.134.86
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
To:     Joe Perches <joe@perches.com>, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <437746b14735ecef311720ad41d5b237209e9674.camel@perches.com>
From:   Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <48f32229-068d-cc62-b6df-03cdc11b99a4@wanadoo.fr>
Date:   Wed, 8 Apr 2020 22:19:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <437746b14735ecef311720ad41d5b237209e9674.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 08/04/2020 à 02:33, Joe Perches a écrit :
> On Tue, 2020-04-07 at 22:49 +0200, Christophe JAILLET wrote:
>> Strings logged with pr_xxx and dev_xxx often lack a trailing '\n'.
>> Introduce new tests to try to catch them early.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> This is more a PoC for now.
>>
>> Regex could be improved, merged, ...
>> We could also check for surrounding pr_cont...
>>
>> This patch is based on idea from [1]. coccinelle spots too many places
>> where \n are missing (~ 2800 with the heuristic I've used).
>> Fixing them would be painful.
>> I instead propose to teach checkpatch.pl about it to try to spot cases
>> early and avoid introducing new cases.
>>
>> [1]: https://marc.info/?l=kernel-janitors&m=158619533629657&w=4
>> ---
>>   scripts/checkpatch.pl | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index c392ab8ea12e..792804bd6ad9 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -5676,6 +5676,16 @@ sub process {
>>   			}
>>   		}
>>   
>> +# check for missing \n at the end of logging function
>> +		if ($line =~ /\bpr_(emerg|alert|crit|err|warning|warn|notice|info|debug|dbg)\s*\("([^"]*(?<!\\n))"/) {
>> +			WARN("MISSING NL",
>> +			     "Possible missing '\\n' at the end of a log message\n" . $hereprev);
>> +		}
>> +		if ($line =~ /\bdev_(emerg|alert|crit|err|warning|warn|notice|info|debug|dbg)\s*\([^,]*,\s*"([^"]*(?<!\\n))"/) {
>> +			WARN("MISSING NL",
>> +			     "Possible missing '\\n' at the end of a log message\n" . $hereprev);
>> +		}
> This can't work as string is masked to "XXX"

Ok. I wasn't aware of that.

I tested the regex with regex101.org and only tested with patches that 
trigger the checkpatch.pl test, and it worked fine for me.
I didn't test with string with trailing \n, that should NOT trigger the 
test. I should have! :(

> This is probably better using $stat and checking if a "XX" format
> string exists as 1st or 2nd arg and adding an extraction
> from the $rawline equivalent and checking that.
>
> Also this test should probably using $logFunctions and check
> if the initial block is one of the known functions that
> use a newline termination (pr_|dev_|netdev_|wiphy_)

Agreed but your perl and regex is much more fluent than mine. ;-)

CJ
