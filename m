Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D757C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5702074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tdc5kLHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633774AbgDNVUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:20:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33536 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633733AbgDNVUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:20:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EJI6ko177004;
        Tue, 14 Apr 2020 19:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=7lgVDR/YW74DxdzxSbUSp1h4pjd0h8lo/2Ec7yzE08U=;
 b=Tdc5kLHwUM+SD4iXJl9+i1tcpooxdQlsScCPsLRJeX4khR2F0sxjG5k5Im5Tit0WPW6E
 3RUuPDY4wWmKGWazYJ8MYVt66BAwa9+FwbC9v+p6bh5y3/kVx9iQGrW9KQmyZvhJf8Cw
 oiihEWxQEvqjARgxAbmYy+XLaXJQl+EHnNS8qFbXiVNDvI26bMvt04jzHPfdPCNXlKtc
 QfC+m1DWaapm1UQM/WYNuLKGxvHUwgWvbN6Hm14fZm/C5ZOim1bsNCR+VFnRE3NimF0h
 KzpcHereIyGskS/RG1NqxE8csNDvyDKtp45Qv5taD5KmeAQ2RAJX2IduAe43wQcz+YBt jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30b5um6vpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 19:22:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EJLkvY091101;
        Tue, 14 Apr 2020 19:22:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30bqcjkcdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 19:22:55 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03EJMrNn007724;
        Tue, 14 Apr 2020 19:22:53 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 12:22:53 -0700
Subject: Re: [PATCH V3 5/9] objtool: Add return address unwind hints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-6-alexandre.chartre@oracle.com>
 <20200414161636.GP20713@hirez.programming.kicks-ass.net>
 <546b2d81-39ca-00e1-4df2-d4eaa18496a4@oracle.com>
 <20200414175604.GD2483@worktop.programming.kicks-ass.net>
 <e9e1c4cd-193f-fd5e-65c4-cc9fb159d861@oracle.com>
 <20200414184233.GG2483@worktop.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <ed46281f-46e5-10a0-1b61-60a54ea9d84e@oracle.com>
Date:   Tue, 14 Apr 2020 21:27:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414184233.GG2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/14/20 8:42 PM, Peter Zijlstra wrote:
> On Tue, Apr 14, 2020 at 08:31:23PM +0200, Alexandre Chartre wrote:
>> On 4/14/20 7:56 PM, Peter Zijlstra wrote:
> 
>>> So what actual problem is it solving?
>>>
>>
>> The return stack stuff is here to correctly handle intra-function call so that
>> we can figure out where the ret of an intra-function call should return. We
>> don't have this challenge with regular functions because we know that a ret
>> inside such function just indicates the end of the function.
>>
>> But when there's an intra-function call, a ret instruction can either:
>>    - continue after the intra-function call (if the stack was unchanged)
>>    - jump somewhere else (if the return address was changed) and eventually
>>      return to the next return address
>>    - indicate the end of the function (if the return address was removed).
>>
>> So, all this is needed to correctly follow the flow of the code and properly
>> record stack changes.
> 
> But which intra-function calls are you worried about here? The RSB
> stuffing ones we have to explicitly forget and the retpoline ones we
> can't follow because they're indirect calls.
> 
> So again, who cares about that stack?
> 

This provides a generic code to handle any intra-function call. Currently we have
the RSB stuffing ones which are forgotten with the UNWIND_HINT_TYPE_RADDR_DELETE
directive. And for retpoline, they will not return if we have an indirect jump
(JMP_NOSPEC) but they will return if we have an indirect call (CALL_NOSPEC). The
code can handle both cases. For example, if we were to have a CALL_NOSPEC invocation
which is not in an alternative then objtool can now correctly handle it.

alex.
