Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABA4C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C590E20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="G66hxWE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbgDBMeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:34:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46406 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387866AbgDBMeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:34:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032CWgBl062989;
        Thu, 2 Apr 2020 12:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=FUx8aszrN4C315i/ZX2S0P6CNuyjM5fDzhdzVL0wFF0=;
 b=G66hxWE0THjIVMHoWnMfPaSOgysiCbasphyI2kf2djeFyly2uomhekgLoAaJoPd02O0Z
 UJLjlzwA6G2k7T06x01/6VjO11J60z2m9WWC+EzQz0NJIPEpOLK9HMSvuXtJw8KAeDpa
 6E7Ebt3DBVNtty6IXDQVBW/5tBwH1sZmpO7nejGzev7Gs/0Z3ufZQ7betFsEsZ/ZLDow
 Bxud3CliWKsVtAan4QkvdfAs49vskOcExgAqWC4ycJ4BNb81R3LloowKxUpCTnTPrOt/
 1m0Q0lGxQXOyH0pwhhpmP43Z7cEXnvOC5/252oeUIGAv6WXZqmtbbolg/jIdzOGVqMMR tw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 303aqhuhwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 12:34:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032CWwfn067590;
        Thu, 2 Apr 2020 12:34:02 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 302g2jggrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 12:34:02 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 032CXxTa001912;
        Thu, 2 Apr 2020 12:33:59 GMT
Received: from linux-1.home (/10.175.46.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 05:33:59 -0700
Subject: Re: [PATCH 2/7] objtool: Allow branches within the same alternative.
To:     Julien Thierry <jthierry@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-3-alexandre.chartre@oracle.com>
 <50e8a5d8-7cb4-f25c-9657-eb11038bd0b5@redhat.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <0824494b-15a9-f810-e81e-003d3d3b85cd@oracle.com>
Date:   Thu, 2 Apr 2020 14:38:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <50e8a5d8-7cb4-f25c-9657-eb11038bd0b5@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/2/20 2:03 PM, Julien Thierry wrote:
> Hi Alexandre,
> 
> I ran into the same issue for the arm64 work:
> https://lkml.org/lkml/2020/1/9/656

Thanks for the reference, I didn't notice that change, but I saw a more
recent one where you were just removing the branch to alternative check
(https://lkml.org/lkml/2020/3/25/151).

> Your solution seems nicer however.
> 
> On 4/2/20 9:22 AM, Alexandre Chartre wrote:
>> Currently objtool prevents any branch to an alternative. While preventing
>> branching from the outside to the middle of an alternative makes perfect
>> sense, branching within the same alternative should be allowed. To do so,
>> identify each alternative and check that a branch to an alternative comes
>> from the same alternative.
>>
>> Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
>> ---
>>   tools/objtool/check.c | 19 +++++++++++++------
>>   tools/objtool/check.h |  3 ++-
>>   2 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
>> index 708562fb89e1..214809ac2776 100644
>> --- a/tools/objtool/check.c
>> +++ b/tools/objtool/check.c
>> @@ -712,7 +712,9 @@ static int handle_group_alt(struct objtool_file *file,
>>                   struct instruction *orig_insn,
>>                   struct instruction **new_insn)
>>   {
>> +    static unsigned int alt_group_next_index = 1;
>>       struct instruction *last_orig_insn, *last_new_insn, *insn, *fake_jump = NULL;
>> +    unsigned int alt_group = alt_group_next_index++;
>>       unsigned long dest_off;
>>       last_orig_insn = NULL;
>> @@ -721,7 +723,7 @@ static int handle_group_alt(struct objtool_file *file,
>>           if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
>>               break;
>> -        insn->alt_group = true;
>> +        insn->alt_group = alt_group;
>>           last_orig_insn = insn;
>>       }
>> @@ -1942,6 +1944,7 @@ static int validate_sibling_call(struct instruction *insn, struct insn_state *st
>>    * tools/objtool/Documentation/stack-validation.txt.
>>    */
>>   static int validate_branch(struct objtool_file *file, struct symbol *func,
>> +               struct instruction *from,
> 
> Maybe instead of passing a new instruction pointer, just the
> alt_group could be passed? 0 Meaning it was not in an alt group> 
>>                  struct instruction *first, struct insn_state state)
>>   {
>>       struct alternative *alt;
>> @@ -1953,7 +1956,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>>       insn = first;
>>       sec = insn->sec;
>> -    if (insn->alt_group && list_empty(&insn->alts)) {
>> +    if (insn->alt_group &&
>> +        (!from || from->alt_group != insn->alt_group) &&
>> +        list_empty(&insn->alts)) {
> 
> This would become
> 
>      if (insn->alt_group != alt_group && list_empty(&insn->alts))
> 
> And the recursive validate_branch() calls would just take
> insn->alt_group as parameter (and the calls in validate_functions()
> and validate_unwind_hints() would take 0).
> 
> Any opinions on that?

Yes, that would work too. I choose to pass the instruction pointer because
I was thinking that having the "from" instruction might be useful in the
future if there's a need to do additional check about the origin of the
branch.

alex.


>>           WARN_FUNC("don't know how to handle branch to middle of alternative instruction group",
>>                 sec, insn->offset);
>>           return 1;
>> @@ -2035,7 +2040,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>>                   if (alt->skip_orig)
>>                       skip_orig = true;
>> -                ret = validate_branch(file, func, alt->insn, state);
>> +                ret = validate_branch(file, func,
>> +                              NULL, alt->insn, state);
>>                   if (ret) {
>>                       if (backtrace)
>>                           BT_FUNC("(alt)", insn);
>> @@ -2105,7 +2111,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>>                       return ret;
>>               } else if (insn->jump_dest) {
>> -                ret = validate_branch(file, func,
>> +                ret = validate_branch(file, func, insn,
>>                                 insn->jump_dest, state);
>>                   if (ret) {
>>                       if (backtrace)
>> @@ -2236,7 +2242,8 @@ static int validate_unwind_hints(struct objtool_file *file)
>>       for_each_insn(file, insn) {
>>           if (insn->hint && !insn->visited) {
>> -            ret = validate_branch(file, insn->func, insn, state);
>> +            ret = validate_branch(file, insn->func,
>> +                          NULL, insn, state);
>>               if (ret && backtrace)
>>                   BT_FUNC("<=== (hint)", insn);
>>               warnings += ret;
>> @@ -2377,7 +2384,7 @@ static int validate_functions(struct objtool_file *file)
>>               state.uaccess = func->uaccess_safe;
>> -            ret = validate_branch(file, func, insn, state);
>> +            ret = validate_branch(file, func, NULL, insn, state);
>>               if (ret && backtrace)
>>                   BT_FUNC("<=== (func)", insn);
>>               warnings += ret;
>> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
>> index 6d875ca6fce0..cffb23d81782 100644
>> --- a/tools/objtool/check.h
>> +++ b/tools/objtool/check.h
>> @@ -33,7 +33,8 @@ struct instruction {
>>       unsigned int len;
>>       enum insn_type type;
>>       unsigned long immediate;
>> -    bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
>> +    unsigned int alt_group;
>> +    bool dead_end, ignore, hint, save, restore, ignore_alts;
>>       bool retpoline_safe;
>>       u8 visited;
>>       struct symbol *call_dest;
>>
> 
> Cheers,
> 
