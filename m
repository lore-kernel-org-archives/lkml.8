Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D8AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7B720730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bQMMj2ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDGQ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:57:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46922 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDGQ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:57:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037GrwMN104165;
        Tue, 7 Apr 2020 16:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Nrqiw6PVutT0nmUPIO8Z4xdWOEVBfSK+9lm/8i+m2ZA=;
 b=bQMMj2niT3feQnQPmbUAdrbjXYMyvEZGcYLXVdLQ0H9mrTfw9MjT9TPFl38IJeWr3UYc
 3y1H3x391ts+0L4wrU+PwB1mausr0m9jzFnSrEvWIjovc5xN9jX4QgytxKFsJSG373Ng
 gHGJhWdyBHTY+lfudZN6Md+IdxVa30z1O7xcwO3eEC7M6KMJCDPiZB7mi8FQhot54Zvf
 N6Tq6o3qQx782Jqf1dG9fw1tfTXmd9UoKtjPEYq87fPVMEhCwo15LNe2nvi/JpTwZjur
 nwxej5cf5hmrL9cDGNyXyLyD63rif5oXT/yF2fqZ9Wb421CslJDsCBOWXim8hAtqZjAF aA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 308ffdc996-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 16:57:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037GvIp0050066;
        Tue, 7 Apr 2020 16:57:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3073qgmb3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 16:57:21 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037GvIue029049;
        Tue, 7 Apr 2020 16:57:18 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 09:57:18 -0700
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
 <20200407162838.5hlh6oom4oa45ugt@treble>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <06605b1c-c9ae-fd18-bcb1-e4a48f2cb60e@oracle.com>
Date:   Tue, 7 Apr 2020 19:01:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200407162838.5hlh6oom4oa45ugt@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/20 6:28 PM, Josh Poimboeuf wrote:
> On Tue, Apr 07, 2020 at 06:18:51PM +0200, Alexandre Chartre wrote:
>>
>> On 4/7/20 4:32 PM, Alexandre Chartre wrote:
>>>
>>> On 4/7/20 3:34 PM, Josh Poimboeuf wrote:
>>>> On Tue, Apr 07, 2020 at 03:28:37PM +0200, Peter Zijlstra wrote:
>>>>> Josh, we should probably have objtool verify it doesn't emit ORC entries
>>>>> in alternative ranges.
>>>>
>>>> Agreed, it might be as simple as checking for insn->alt_group in the
>>>> INSN_STACK check or in update_insn_state().
>>>>
>>>
>>> We could do that only for the "objtool orc generate" command. That way
>>> "objtool check" would still check the alternative, but "objtool orc generate"
>>> will just use the first half of the alternative (like it does today with
>>> ANNOTATE_NOSPEC_ALTERNATIVE). We can even keep all ANNOTATE_NOSPEC_ALTERNATIVE
>>> but only use them for "objtool orc generate".
>>>
>>
>> I have checked and objtool doesn't emit ORC entries for alternative:
>> decode_instructions() doesn't mark such section with sec->text = true
>> so create_orc_sections() doesn't emit corresponding ORC entries.
>>
>> So I think we can remove the ANNOTATE_NOSPEC_ALTERNATIVE directives,
>> this will allow objtool to check the instructions but it still won't
>> emit ORC entries (same behavior as today). In the future, if ORC
>> eventually supports alternative we will be ready to have objtool emit
>> ORC entries.
> 
> What's the benefit of removing ANNOTATE_NOSPEC_ALTERNATIVE if there's no
> ORC support to go along with it?

To have the code validated by objtool like any other alternative code
(which is not tagged with ANNOTATE_NOSPEC_ALTERNATIVE).

> Also I want to avoid adding "ORC alternatives".  ORC is nice and simple
> and we should keep it that way as much as possible.
> 
> Again, we should warn on stack changes inside alternatives, and then
> look at converting RSB and retpolines to use static branches so they
> have deterministic stacks.
> 
objtool doesn't currently warn on stack changes inside alternatives.
The RSB/retpoline alternatives have warning because objtool doesn't
support retpoline ret and intra-function calls. If you have an alternative
doing stack changes that objtool understand (like push/pop, add/remove
to sp) then you won't have a warning.

I think that's the case with smap_save:

static __always_inline unsigned long smap_save(void)
{
         unsigned long flags;

         asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
                                   X86_FEATURE_SMAP)
                       : "=rm" (flags) : : "memory", "cc");

         return flags;
}

The alternative does change the stack but objtool won't complain
because it handles the pushf and pop instruction.

alex.
