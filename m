Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6136AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3119A206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I3wLg5sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgDGRAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:00:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47602 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgDGRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:00:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037GvkwB027272;
        Tue, 7 Apr 2020 17:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Hlg73nRbyrrV1WN4ZUZYRwSiKj+xZKMutlaFiWJTe/Y=;
 b=I3wLg5sqN8L1NF/DocaKXBhK+f9E+8UsdHCtkT9S9ZY+0l01oaO2Yh1j8S9WolZWpzyC
 cgISZkKRjPIqonrnabRyrXcbvn5h8Cj6CUJwmUPMw0WICUNVE0464Qxey05t1WS7jntr
 9TVwOGVNGVBDcfKIDenN6+2imDCNW1DgJO8mJMRh9wBwvwRS7ekPSK5GrY14efaFrM0n
 ofJSXKRQPBzt96a08jheyxDHHP/wO6hzbMcev9p2I3HKtL7Z3lXo634/EzRA9THAmU42
 N2SzcrtTzA5Kt5o4P7kvdVSjqwfc/bhPlKwqBbrdbC3XnfcbWzZTkQfRnS4ueeWyRHtN Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 306j6me9mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 17:00:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037GuggI077449;
        Tue, 7 Apr 2020 17:00:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3073ssh8w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 17:00:05 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037H03RQ003046;
        Tue, 7 Apr 2020 17:00:03 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 10:00:03 -0700
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
 <20200407164143.GG20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <4e5572cc-a134-0a66-9b09-e0aa7ff5102a@oracle.com>
Date:   Tue, 7 Apr 2020 19:04:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200407164143.GG20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9584 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/20 6:41 PM, Peter Zijlstra wrote:
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
> I mean, we should make it warn for the case where you remove
> ANNOTATE_NOSPEC and it would like to generate ORC.

Okay, so check if an alternative is changing the stack and warn if it is.

alex.

> Also, what's the point of having objtool grok this code and then not
> doing anything with it?
> 
