Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472A7C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230CC2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgAOOal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:30:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726472AbgAOOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:30:41 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FER4Sx110917;
        Wed, 15 Jan 2020 09:30:05 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xhgs6npvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jan 2020 09:30:05 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00FESoBW014686;
        Wed, 15 Jan 2020 14:30:05 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 2xf751x35c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jan 2020 14:30:05 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00FEU4uB43647418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 14:30:04 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECC0B7805F;
        Wed, 15 Jan 2020 14:30:03 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3620378060;
        Wed, 15 Jan 2020 14:30:03 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.80.230.130])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jan 2020 14:30:02 +0000 (GMT)
Subject: Re: [PATCH] Fix display of Maximum Memory
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Gustavo Walbon <gwalbon@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>
References: <55f25626-20ca-0acb-3571-ff636ca4632c@linux.ibm.com>
 <41380afd-05f5-f36f-c857-041243c73ee3@c-s.fr>
From:   Michael Bringmann <mwb@linux.ibm.com>
Openpgp: preference=signencrypt
Organization: IBM Linux Technology Center
Message-ID: <eb6c4171-09b3-b8f0-6219-38757da6fc3b@linux.ibm.com>
Date:   Wed, 15 Jan 2020 08:30:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <41380afd-05f5-f36f-c857-041243c73ee3@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 11:41 PM, Christophe Leroy wrote:
> 
> 
> Le 14/01/2020 à 22:07, Michael Bringmann a écrit :
>> Correct overflow problem in calculation+display of Maximum Memory
>> value to syscfg where 32bits is insufficient.
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/lparcfg.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
>> index 4ee2594..183aeb7 100644
>> --- a/arch/powerpc/platforms/pseries/lparcfg.c
>> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
>> @@ -435,12 +435,12 @@ static void parse_em_data(struct seq_file *m)
>>
>>   static void maxmem_data(struct seq_file *m)
>>   {
>> -       unsigned long maxmem = 0;
>> +       unsigned long long maxmem = 0;
> 
> What about using u64 instead, for readability ?

Okay.
> 
>>
>> -       maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
>> -       maxmem += hugetlb_total_pages() * PAGE_SIZE;
>> +       maxmem += (unsigned long long)drmem_info->n_lmbs * (unsigned long long)drmem_info->lmb_size;
> 
> This line is likely too long. You only need to cast one of the two operants to force a 64 bits multiply. And using u64 would shorten the line.
> 
> Can both multiplications overflow ?

Yes.

> 
> Christophe
> 
>> +       maxmem += (unsigned long long)hugetlb_total_pages() * (unsigned long long)PAGE_SIZE;
>>
>> -       seq_printf(m, "MaxMem=%ld\n", maxmem);
>> +       seq_printf(m, "MaxMem=%llu\n", maxmem);
>>   }
>>
>>   static int pseries_lparcfg_data(struct seq_file *m, void *v)
>>
> 

Thanks.
-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.ibm.com
