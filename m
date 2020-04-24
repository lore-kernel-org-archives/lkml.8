Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6806C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E035720700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sq0gSodZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDXHCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:02:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50064 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgDXHCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:02:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03O6wX2N017329;
        Fri, 24 Apr 2020 07:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=+sOTv9sUimAWqYhtidHP7XHEciFx1X2PhEIWEaF656g=;
 b=Sq0gSodZHmhMH2yYrpEUgyuoaEWmD/K38DLBsnZ7SdDVGfulU2VIMokOtd5cPkMPhfoN
 71UujBujmlHFvlKzjc0Yqq5TZjVXKFs5tmi7JeJzsqoKJhxpavoqUsDU93CsIbXFQ2Nv
 bsbYHCGUB9EXYAdEqGuPRDxHjgx037JBae94JZxeFTydTHKvHpWR+Xz/liwcY5/v2y+8
 BZHUptrcspvgcoqfcA7QsjpLvInqRjH47BeFY6Yr7i7zwaLyY3gfut2+O7PqbmDpJC7J
 8aek4VJL3653BG9OQWd3dUwCBmXPeYTfgkfHjw+8SdK73zdsAKBnaJ8SrgHimhjXiycQ kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 30jvq4yc6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 07:01:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03O6ufhi058293;
        Fri, 24 Apr 2020 07:01:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 30gbbpbcaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Apr 2020 07:01:45 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03O71gKu026354;
        Fri, 24 Apr 2020 07:01:42 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Apr 2020 00:01:41 -0700
Subject: Re: [PATCH 3/8] objtool: Rework allocating stack_ops on decode
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        jthierry@redhat.com, tglx@linutronix.de, x86@kernel.org,
        mbenes@suse.cz
References: <20200423125013.452964352@infradead.org>
 <20200423125042.713052240@infradead.org>
 <7df9ec97-dc14-c4b6-fb26-f163e9afb1cd@oracle.com>
 <20200423155425.GW20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <cc303a83-58eb-2b61-ddf1-672f2c8644e1@oracle.com>
Date:   Fri, 24 Apr 2020 09:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423155425.GW20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004240051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9600 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004240051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/23/20 5:54 PM, Peter Zijlstra wrote:
> On Thu, Apr 23, 2020 at 05:40:38PM +0200, Alexandre Chartre wrote:
> 
>>> @@ -77,6 +77,17 @@ unsigned long arch_jump_destination(stru
>>>    	return insn->offset + insn->len + insn->immediate;
>>>    }
>>> +#define PUSH_OP(op) \
>>> +({ \
>>> +	list_add_tail(&op->list, ops_list); \
>>> +	NULL; \
>>> +})
>>> +
>>> +#define ADD_OP(op) \
>>> +	if (!(op = calloc(1, sizeof(*op)))) \
>>> +		return -1; \
>>> +	else for (; op; op = PUSH_OP(op))
>>> +
>>
>> I would better have a function to alloc+add op instead of weird macros,
>> for example:
>>
>> static struct stack_op *add_op(void)
>> {
>>          struct stack *op;
>>
>>          op = calloc(1, sizeof(*op));
>>          if (!op)
>>                  return NULL;
>>          list_add_tail(&op->list, ops_list);
>> }
>>
>> Then it requires two more lines when using it but I think the code is much
>> cleaner and clearer, e.g.:
>>
>>                          op = add_op();
>>                          if (!op)
>>                                  return -1;
>>                          op->src.type = OP_SRC_ADD;
>>                          op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
>>                          op->dest.type = OP_DEST_REG;
>>                          op->dest.reg = CFI_SP;
> 
> The 'problem' which this is that it doesn't NULL op again, so any later
> use will do 'funny' things instead of crashing sensibly.

Then you can use a local variable:

                 {
                         struct stack_op *op = add_op();
                         if (!op)
                                 return -1;
                         op->src.type = OP_SRC_ADD;
                         op->src.reg = op_to_cfi_reg[modrm_reg][rex_r];
                         op->dest.type = OP_DEST_REG;
                         op->dest.reg = CFI_SP;
                 }

> Also, I'm mightly lazy, I don't like endlessly repeating the same things.

Me too, I often try to use macros to avoid repeating the same thing, and usually
spend a lot of time trying fancy macros and eventually realize that this is
usually not worth it.

So here, we are down to a two line differences:

    ADD_OP(op) {
            ...
    }

vs.

    {
             struct stack *op = add_op();
             if (!op)
                     return -1;
             ...
    }

Anyway, I leave it up to you, that's just coding preferences.

In any case:

Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>


Thanks,

alex.
