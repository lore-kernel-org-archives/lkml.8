Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C355BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9499F20719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 13:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QQ+bxHB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgDGNPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:15:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51716 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDGNPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 09:15:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037DDOlF069769;
        Tue, 7 Apr 2020 13:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eCPeCa0CmuEAaPGc4dtLgG70fJ6kPBo+OkpbEsJz0OI=;
 b=QQ+bxHB7b8YLgR3xvHAQV6mrjcZd2mbDrnce54Luq01o1Us8oEHmvaBDB/xyIVZREWtX
 4fZb4fcAdkzu7PivyO6zf5huPXh3ZUy1UXekNMIvFzkf1T2oVYt1tnnFadVPNlcSf/E5
 Vetz4q5QmlGgN0JHWMMAPgVfbds5nPcx4jPCWqIWPaod3P+j3Ft8hI4StuVIqLFEsRCH
 OA2yzd4fXBUyJg7Vn4kVB+z7XGmO8OMphovlwcWETN1wRG/LvRYV5dWEm8abMhScADSM
 CZsZukitcu7pTgSJu49syiw0xM7bPuvCrIHy5yXTy4++1ngF8sz9HjpNh+wRh6WUop5V pQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 306jvn4sga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 13:15:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037DCTxn152482;
        Tue, 7 Apr 2020 13:13:05 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30839taxak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 13:13:05 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 037DD3bd032093;
        Tue, 7 Apr 2020 13:13:04 GMT
Received: from linux-1.home (/10.175.58.13)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 06:13:03 -0700
Subject: Re: [PATCH V2 1/9] objtool: Introduce HINT_RET_OFFSET
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-2-alexandre.chartre@oracle.com>
 <20200407125323.GY20730@hirez.programming.kicks-ass.net>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <21e4ab99-fe75-ff0d-3c7e-cee0fbe95104@oracle.com>
Date:   Tue, 7 Apr 2020 15:17:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200407125323.GY20730@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/7/20 2:53 PM, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 09:31:34AM +0200, Alexandre Chartre wrote:
>> diff --git a/tools/objtool/check.h b/tools/objtool/check.h
>> index 6d875ca6fce0..7a91497fee7e 100644
>> --- a/tools/objtool/check.h
>> +++ b/tools/objtool/check.h
>> @@ -33,9 +33,12 @@ struct instruction {
>>   	unsigned int len;
>>   	enum insn_type type;
>>   	unsigned long immediate;
>> -	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
>> +	unsigned int alt_group;
> 
> ^^ that wants to be in a later patch I'm thinking

Correct, rebase error, should be in patch 4.

Thanks,

alex.

>> +	bool dead_end, ignore, ignore_alts;
>> +	bool hint, save, restore;
>>   	bool retpoline_safe;
>>   	u8 visited;
>> +	u8 ret_offset;
>>   	struct symbol *call_dest;
>>   	struct instruction *jump_dest;
>>   	struct instruction *first_jump_src;
>> -- 
>> 2.18.2
>>
