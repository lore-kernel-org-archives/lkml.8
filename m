Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AF6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D5F2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCRLpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:45:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgCRLpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:45:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02IBY1dY112179;
        Wed, 18 Mar 2020 07:44:43 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu861nwsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 07:44:43 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 02IBZ4IB117268;
        Wed, 18 Mar 2020 07:44:43 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu861nwrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 07:44:42 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02IBeQDb006194;
        Wed, 18 Mar 2020 11:44:41 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 2yrpw6r2u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Mar 2020 11:44:41 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02IBieVI57934204
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 11:44:40 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EFB4136055;
        Wed, 18 Mar 2020 11:44:40 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A90D313604F;
        Wed, 18 Mar 2020 11:44:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.107])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 Mar 2020 11:44:29 +0000 (GMT)
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com> <20200317150703.GB757893@krava>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <0844ce2d-ded7-de30-c1ef-6e4de79c556d@linux.ibm.com>
Date:   Wed, 18 Mar 2020 17:14:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200317150703.GB757893@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_05:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003180058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 8:37 PM, Jiri Olsa wrote:
> On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
>> index 3b4cdfc5efd6..dcc3c6ab2e67 100644
>> --- a/tools/perf/arch/powerpc/util/header.c
>> +++ b/tools/perf/arch/powerpc/util/header.c
>> @@ -7,6 +7,8 @@
>>  #include <string.h>
>>  #include <linux/stringify.h>
>>  #include "header.h"
>> +#include "metricgroup.h"
>> +#include <api/fs/fs.h>
>>  
>>  #define mfspr(rn)       ({unsigned long rval; \
>>  			 asm volatile("mfspr %0," __stringify(rn) \
>> @@ -16,6 +18,8 @@
>>  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
>>  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
>>  
>> +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/sockets"
>> +
>>  int
>>  get_cpuid(char *buffer, size_t sz)
>>  {
>> @@ -44,3 +48,9 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>>  
>>  	return bufp;
>>  }
>> +
>> +int arch_get_runtimeparam(void)
>> +{
>> +	int count;
>> +	return sysfs__read_int(SOCKETS_INFO_FILE_PATH, &count) < 0 ? 1 : count;
> 
> is that SOCKETS_INFO_FILE_PATH define used later? if not please
> put the path directly as an argument to sysfs__read_int
> 
Ok will do that.

Thanks,
Kajol
> jirka
> 
