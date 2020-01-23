Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEBBC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7612467F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFnGo1ao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAWNmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:42:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40801 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgAWNmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579786929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmBW3f8TyoLwTSIM/+PNUzRqVEHkMdoufacPfKN/cck=;
        b=KFnGo1aoDMIQVbofnYTsGomqKIQhZe6a6fs0QBhCuQM73ArW4kDtBQEOZBiiDfkyQrPPtS
        zO4j6v8LuR3LLaO2VWFr5Y5soEEmEN1oJyDACsZKetu/+boof675UFHWGtkvkd3pjGSD/F
        ZaeAqlT83XaFsaO9EiNqhv9szYFmW5Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-L2MoBIgQP0a7zR6i2-4k3Q-1; Thu, 23 Jan 2020 08:42:08 -0500
X-MC-Unique: L2MoBIgQP0a7zR6i2-4k3Q-1
Received: by mail-wr1-f70.google.com with SMTP id t3so1697706wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 05:42:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tmBW3f8TyoLwTSIM/+PNUzRqVEHkMdoufacPfKN/cck=;
        b=AhFdH9MBTnNv2YxWBwEkChWNcLz424NUGd56JRo/2/OohyYQ0ls2t1WS33aClHoMxj
         5obg3Z1E3XwGg6R0L8RIih/C1D3yfm0jm8gAU41TUlEl+Hb+snLK3TLSVruhGhg0b4h8
         1o/ns1ZOAFHvICNhBqtrNdtwWVTWvpp/qnTrV+46pxiw5Es5jBgloJXBGDoV5wSOwFqX
         kiIMKFnm5vJT7X7VqRlkB0HvGfawKvE+ZnHVJG/ihuUHZJN1toW4pOKbeLXJitmdilcC
         3185KDOl29L/z1EyqFy7tfH+izoIdXeNlJ/K0U/CEHlo1V6sJVcwv4B0FVVUhC0Xq1ok
         ondA==
X-Gm-Message-State: APjAAAUY0H5qMNNlV4n+ImYb6ef5eB2L59M3Zwgh5n8XDDsShCqQw3P1
        DVQOTOhMDGguNIotToxvXEEcT7l0i9qA9B17PsnzLYs8Le0IKeRqr+yf1oPI4odxh27nYB8bUgT
        rjUkn74JqYosjIJOlPXwe6qTm
X-Received: by 2002:adf:dd46:: with SMTP id u6mr17073810wrm.13.1579786926934;
        Thu, 23 Jan 2020 05:42:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwUbQx3hjI5twu/eFRZDeK/mX9ClB3LVjfr7g8X3OfTEi4yxEjHCcdyKi+gN3mf4omGeSTWlA==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr17073791wrm.13.1579786926745;
        Thu, 23 Jan 2020 05:42:06 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id n189sm2881039wme.33.2020.01.23.05.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:42:06 -0800 (PST)
Subject: Re: [RFC v5 12/57] objtool: check: Allow jumps from an alternative
 group to itself
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-13-jthierry@redhat.com>
 <20200121173305.urv77ral76su26cs@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <37aaea62-4737-d7e7-8107-4e8b05fc849c@redhat.com>
Date:   Thu, 23 Jan 2020 13:42:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121173305.urv77ral76su26cs@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/20 5:33 PM, Josh Poimboeuf wrote:
> On Thu, Jan 09, 2020 at 04:02:15PM +0000, Julien Thierry wrote:
>> Alternatives can contain instructions that jump to another instruction
>> in the same alternative group. This is actually a common pattern on
>> arm64.
>>
>> Keep track of instructions jumping within their own alternative group
>> and carry on validating such branches.
>>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   tools/objtool/check.c | 48 ++++++++++++++++++++++++++++++++++---------
>>   tools/objtool/check.h |  1 +
>>   2 files changed, 39 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 8f2ff030936d..c7b3f1e2a628 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -722,6 +722,14 @@ static int handle_group_alt(struct objtool_file *file,
>>   	sec_for_each_insn_from(file, insn) {
>>   		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
>>   			break;
>> +		/* Is insn a jump to an instruction within the alt_group */
>> +		if (insn->jump_dest && insn->sec == insn->jump_dest->sec &&
>> +		    (insn->type == INSN_JUMP_CONDITIONAL ||
>> +		     insn->type == INSN_JUMP_UNCONDITIONAL)) {
>> +			dest_off = insn->jump_dest->offset;
>> +			insn->intra_group_jump = special_alt->orig_off <= dest_off &&
>> +				dest_off < special_alt->orig_off + special_alt->orig_len;
>> +		}
> 
> This patch adds some complexity, just so we can keep the
> 
>    "don't know how to handle branch to middle of alternative instruction group"
> 
> warning for the case where code from outside an alternative insn group
> is branching to inside the group.  But I've never actually seen that
> case in practice, and I get the feeling that warning isn't very useful
> or realistic.
> 
> How about we just remove the warning?
> 

I'm happy to remove it.

I was trying to look for a less intrusive place to only check for 
instructions jumping into alternatives. add_jump_destinations() could be 
an option, but it would require to duplicate some stuff done in 
add_special_section_alts(). So maybe just ignoring for now can be fine.

Thanks,

-- 
Julien Thierry

