Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21BBC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5D52081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMJvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:51:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMJvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:51:47 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00D9oOUU161827
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:51:46 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfavxk8n6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 04:51:45 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Mon, 13 Jan 2020 09:51:42 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 09:51:41 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00D9pdVw52232414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 09:51:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B013A42041;
        Mon, 13 Jan 2020 09:51:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6492542045;
        Mon, 13 Jan 2020 09:51:38 +0000 (GMT)
Received: from [9.124.31.88] (unknown [9.124.31.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jan 2020 09:51:38 +0000 (GMT)
Subject: Re: [RESEND PATCH v2 2/3] powerpc/powernv: Introduce Self save
 support
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        mpe@ellerman.id.au, svaidy@linux.ibm.com, ego@linux.vnet.ibm.com,
        pratik.sampat@in.ibm.com, pratik.r.sampat@gmail.com
References: <cover.1578886602.git.psampat@linux.ibm.com>
 <9cade84b37a910c96ec3d0a6b39b00e5082d59ab.1578886602.git.psampat@linux.ibm.com>
 <20200113075133.GD5419@oc0525413822.ibm.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Date:   Mon, 13 Jan 2020 15:21:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113075133.GD5419@oc0525413822.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20011309-0020-0000-0000-000003A02F4A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011309-0021-0000-0000-000021F79DA4
Message-Id: <dc58e7b4-e07d-523a-f6f5-3e8c62eb48db@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_02:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I made a mistake while arranging the patches in the series. I'll re-arrange it
correctly now. Sorry about that.

On 13/01/20 1:21 pm, Ram Pai wrote:
> On Mon, Jan 13, 2020 at 09:15:08AM +0530, Pratik Rajesh Sampat wrote:
>> This commit introduces and leverages the Self save API which OPAL now
>> supports.
>>
>> Add the new Self Save OPAL API call in the list of OPAL calls.
>> Implement the self saving of the SPRs based on the support populated
>> while respecting it's preferences.
>>
>> This implementation allows mixing of support for the SPRs, which
>> means that a SPR can be self restored while another SPR be self saved if
>> they support and prefer it to be so.
>>
>> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/opal-api.h        | 3 ++-
>>   arch/powerpc/include/asm/opal.h            | 1 +
>>   arch/powerpc/platforms/powernv/idle.c      | 2 ++
>>   arch/powerpc/platforms/powernv/opal-call.c | 1 +
>>   4 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>> index c1f25a760eb1..1b6e1a68d431 100644
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -214,7 +214,8 @@
>>   #define OPAL_SECVAR_GET				176
>>   #define OPAL_SECVAR_GET_NEXT			177
>>   #define OPAL_SECVAR_ENQUEUE_UPDATE		178
>> -#define OPAL_LAST				178
>> +#define OPAL_SLW_SELF_SAVE_REG			181
>> +#define OPAL_LAST				181
>>
>>   #define QUIESCE_HOLD			1 /* Spin all calls at entry */
>>   #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>> index 9986ac34b8e2..389a85b63805 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -203,6 +203,7 @@ int64_t opal_handle_hmi(void);
>>   int64_t opal_handle_hmi2(__be64 *out_flags);
>>   int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
>>   int64_t opal_unregister_dump_region(uint32_t id);
>> +int64_t opal_slw_self_save_reg(uint64_t cpu_pir, uint64_t sprn);
>>   int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
>>   int64_t opal_config_cpu_idle_state(uint64_t state, uint64_t flag);
>>   int64_t opal_pci_set_phb_cxl_mode(uint64_t phb_id, uint64_t mode, uint64_t pe_number);
>> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
>> index 2f328403b0dc..d67d4d0b169b 100644
>> --- a/arch/powerpc/platforms/powernv/idle.c
>> +++ b/arch/powerpc/platforms/powernv/idle.c
>> @@ -1172,6 +1172,8 @@ void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
>>   		if (!is_lpcr_self_save)
>>   			opal_slw_set_reg(pir, SPRN_LPCR,
>>   					 lpcr_val);
>> +		else
>> +			opal_slw_self_save_reg(pir, SPRN_LPCR);
> opal_slw_self_save_reg() was used in the prior patch too. How did it
> compile, if the definition is in this patch?
>
>
> Reviewed-by: Ram Pai <linuxram@us.ibm.com>
>
> RP

