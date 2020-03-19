Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E59C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB39A2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="H3mDhUz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCSUbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:31:02 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:65002 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727023AbgCSUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:31:01 -0400
X-Greylist: delayed 1631 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Mar 2020 16:31:00 EDT
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 02JJxfgF004755;
        Thu, 19 Mar 2020 20:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=mUn3O9VmAsOwEKC1EoFw6DJt4hCpb0XLTybtGwOerzo=;
 b=H3mDhUz8fe+A9e9ktPUSPTDtcrbu+SEidGulMs4udhqLWYBaJFOd/ezi5WXrygFqyZ8t
 2QnYbAM+u5wT1rVqSJcpNPW1JKeduQ9oGfdY5bMpZUAX4MMrFgzYp/7/k8c1KZCKillL
 HxbY+ao8DdqhU4bSYmlhhSr+FjrelLEjjuF1PjgrslCiIN7mA+tXRkTVaxBn7s9hwtlH
 zF6kFSn0tsQS8is/VKSMpuZb4cvTQFEwvUzo7A6MBNc1Pr/xdvEV6K0bQ4HcmTZxDxn2
 lUgAeXm8hnf6lwHG1WlFUy5q5Ip2HXUJNrB1WBeAUJBQUPoJuWqFD7ePLQcBcPA5WMsj SQ== 
Received: from prod-mail-ppoint3 (prod-mail-ppoint3.akamai.com [96.6.114.86] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2yrqduruqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 20:03:45 +0000
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.16.0.27/8.16.0.27) with SMTP id 02JK3Z4Y001211;
        Thu, 19 Mar 2020 16:03:44 -0400
Received: from prod-mail-relay14.akamai.com ([172.27.17.39])
        by prod-mail-ppoint3.akamai.com with ESMTP id 2yrtm0f8u2-1;
        Thu, 19 Mar 2020 16:03:42 -0400
Received: from [0.0.0.0] (prod-ssh-gw01.bos01.corp.akamai.com [172.27.119.138])
        by prod-mail-relay14.akamai.com (Postfix) with ESMTP id C2BDF85C23;
        Thu, 19 Mar 2020 20:03:39 +0000 (GMT)
Subject: Re: [PATCH v2] dynamic_debug: Use address-of operator on section
 symbols
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200220051320.10739-1-natechancellor@gmail.com>
 <20200319015909.GA8292@ubuntu-m2-xlarge-x86>
From:   Jason Baron <jbaron@akamai.com>
Message-ID: <4b766edb-73e2-c295-22eb-b501405baa9f@akamai.com>
Date:   Thu, 19 Mar 2020 16:03:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200319015909.GA8292@ubuntu-m2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_08:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-2002250000 definitions=main-2003190083
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_07:2020-03-19,2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/20 9:59 PM, Nathan Chancellor wrote:
> On Wed, Feb 19, 2020 at 10:13:20PM -0700, Nathan Chancellor wrote:
>> Clang warns:
>>
>> ../lib/dynamic_debug.c:1034:24: warning: array comparison always
>> evaluates to false [-Wtautological-compare]
>>         if (__start___verbose == __stop___verbose) {
>>                               ^
>> 1 warning generated.
>>
>> These are not true arrays, they are linker defined symbols, which are
>> just addresses. Using the address of operator silences the warning and
>> does not change the resulting assembly with either clang/ld.lld or
>> gcc/ld (tested with diff + objdump -Dr).
>>
>> Link: https://github.com/ClangBuiltLinux/linux/issues/894
>> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> ---
>> v1 -> v2: https://lore.kernel.org/lkml/20200219045423.54190-5-natechancellor@gmail.com/
>>
>> * No longer a series because there is no prerequisite patch.
>> * Use address-of operator instead of casting to unsigned long.
>>
>>  lib/dynamic_debug.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
>> index aae17d9522e5..8f199f403ab5 100644
>> --- a/lib/dynamic_debug.c
>> +++ b/lib/dynamic_debug.c
>> @@ -1031,7 +1031,7 @@ static int __init dynamic_debug_init(void)
>>  	int n = 0, entries = 0, modct = 0;
>>  	int verbose_bytes = 0;
>>  
>> -	if (__start___verbose == __stop___verbose) {
>> +	if (&__start___verbose == &__stop___verbose) {
>>  		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
>>  		return 1;
>>  	}
>> -- 
>> 2.25.1
>>
> 
> Gentle ping for review/acceptance.
> 
> Cheers,
> Nathan

Works for me.

Acked-by: Jason Baron <jbaron@akamai.com>
