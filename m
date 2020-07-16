Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8107BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5843E207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 20:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="PalmykHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGPUax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPUax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 16:30:53 -0400
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [IPv6:2620:100:9005:57f::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE67C061755;
        Thu, 16 Jul 2020 13:30:52 -0700 (PDT)
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
        by m0050102.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 06GKQLd0022592;
        Thu, 16 Jul 2020 21:30:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=8if/gsNzoLCt1qMRxVg8w97CoWVdj9s9ivye3M5aJnM=;
 b=PalmykHeZkiqbXyg+N/aRzZr0DmLbA3aDlHBHSMRcRKxXmNa6/dJzmbJs2c4JImzSgW0
 91ZZQy0/hBBUL+S3LV7QsCEV0adNSe22cPsOxDd55VDRZVM7HE24LIfYV8CYPnOY7231
 Js9MDTAhDoVJ+pcFGUss31xTqgnmVHo3VKw1YFFOiaMCVIQZdLSt0f5BH0XsO4mRHGG6
 2QaPno/sqxtWWW36/agSEddo1tYJJNOgba4xNVCvCee/rnRYdl9TO4V9HdE+dAryWGPC
 fMukJ2HPV/8OZdC6uqBHY1yv5VHGaLQA18xpVZzJodKTDEPWIaVq75bIB2uW0NfXRj6o tg== 
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
        by m0050102.ppops.net-00190b01. with ESMTP id 3280935x5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 21:30:36 +0100
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
        by prod-mail-ppoint6.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 06GJnUr4029814;
        Thu, 16 Jul 2020 16:30:36 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint6.akamai.com with ESMTP id 3278rx76tu-1;
        Thu, 16 Jul 2020 16:30:35 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id AACBD3B6F1;
        Thu, 16 Jul 2020 20:30:35 +0000 (GMT)
Subject: Re: [PATCH v4 13/17] dyndbg: accept 'file foo.c:func1' and 'file
 foo.c:10-100'
To:     jim.cromie@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Will Deacon <will@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
References: <20200620180643.887546-1-jim.cromie@gmail.com>
 <20200620180643.887546-14-jim.cromie@gmail.com>
 <30de6359-e56b-0915-5742-a360ef1b2814@akamai.com>
 <CAJfuBxww0VhwBymScJP-eyag0JB=jEa4v5ch14TiZZybq7EOsA@mail.gmail.com>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <6ff6223e-da0a-7ea1-bb8d-057207946061@akamai.com>
Date:   Thu, 16 Jul 2020 16:30:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJfuBxww0VhwBymScJP-eyag0JB=jEa4v5ch14TiZZybq7EOsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=858 phishscore=0 bulkscore=0 suspectscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160135
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=1 adultscore=0 spamscore=0
 mlxlogscore=813 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/20 12:49 PM, jim.cromie@gmail.com wrote:
>>> @@ -321,6 +321,8 @@ static int parse_linerange(struct ddebug_query *query, const char *first)
>>>       } else {
>>>               query->last_lineno = query->first_lineno;
>>>       }
>>> +     vpr_info("parsed line %d-%d\n", query->first_lineno,
>>> +              query->last_lineno);
>>>       return 0;
>>>  }
>>
>> This bit seems like its unrelated to this patch and makes more sense in the
>> previous patch, or as separate patch...
>>
>> Thanks,
>>
>> -Jason
>>
> 
> ok, I'll split it out, maybe merge with prior.
> 
> Any other tweaks ?
> maybe move export last in series ?

sure.

> how do you feel about changing the pr_fmt
> to just mod-name "dynamic_debug" or "dyndbg"
> 

So removing the function name? I'm fine either way.
Feel free to add Ack-by: Jason Baron <jbaron@akamai.com> to the
series.

Thanks,

-Jason
