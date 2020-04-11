Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A99C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4924E2083E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 06:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDKGsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 02:48:14 -0400
Received: from ciao.gmane.io ([159.69.161.202]:58640 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgDKGsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 02:48:13 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1jN9w4-000Izf-H6
        for linux-kernel@vger.kernel.org; Sat, 11 Apr 2020 08:48:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
Date:   Sat, 11 Apr 2020 08:48:07 +0200
Message-ID: <215f2a43-6677-04cd-f376-bd7cd051b626@wanadoo.fr>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
 <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
 <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
 <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
 <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
Content-Language: en-US
Cc:     kernel-janitors@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200411064807.J29Wz5awQT1aUl4M5oAYey9wouctPAL7aRjAlE2xDVQ@z>

Le 10/04/2020 à 21:53, Joe Perches a écrit :
> On Fri, 2020-04-10 at 12:46 -0700, Joe Perches wrote:
>> On Fri, 2020-04-10 at 19:35 +0200, Christophe JAILLET wrote:
>>> Le 08/04/2020 à 04:14, Joe Perches a écrit :
>>>> This works rather better:
>>>> Perhaps you could test?
>> []
>>> I'm looking at some modification done in the last month that could have
>>> been spotted by the above script.
>>>
>>>       ./scripts/checkpatch.pl -f drivers/usb/phy/phy-jz4770.c
>>>
>>> correctly spots the 3 first cases, but the 3 last (line 202, 210 and
>>> 217) are missed.
>>> I don't understand why.
>> It has to do with checkpatch's single statement parsing.
>>
>> This case:
>>
>> 	if (foo)
>> 		dev_warn(...);
>>
>> is parsed as a single statement but
>>
>> 	if (foo) {
>> 		dev_warn(...);
>> 	};
>>
>> is parsed as multiple statements so for the
>> second case
>>
>> 		dev_warn(...);
>>
>> is analyzed as a separate statement.
>>
>> The regex match for this missing newline test expects
>> that each printk is a separate statement so the first
>> case doesn't match.
>>
>> Clearly the regex can be improved here.
> So on top of the original patch:
> ---
>   scripts/checkpatch.pl | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f00a6c8..54eaa7 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5675,8 +5675,8 @@ sub process {
>   
>   # check for possible missing newlines at the end of common logging functions
>   		if (defined($stat) &&
> -		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
> -		    $1 !~ /_cont$/ && $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
> +		    $stat =~ /^\+\s*(?:if\s*$balanced_parens\s*)?($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
> +		    $2 !~ /_cont$/ && $2 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
>   			my $cnt = statement_rawlines($stat);
>   			my $extracted_string = "";
>   			for (my $i = 0; $i < $cnt; $i++) {

Hi Joe,

This fixes the use case for  drivers/usb/phy/phy-jz4770.c

     ./scripts/checkpatch.pl -f drivers/usb/gadget/udc/tegra-xudc.c

is missing line 691.

CJ


