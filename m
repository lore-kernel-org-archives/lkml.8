Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C37C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3FD207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a3QZniOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406451AbgE1TZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:25:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406229AbgE1TZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:25:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SJ28ce108867;
        Thu, 28 May 2020 15:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=JA0rH5xJR6r+pQyEyY/QRuP6P8EeneHRb5BX3Gz2Bhk=;
 b=a3QZniOpxUue/SLMFToIHssEKgXk1HkymkiiLbVVlyXZ4lIiK8NjXjZZHW8Q+ExYkw8E
 JKgQWHO3O/AY22uFySzNK0iFC+C/em4ga9C3sTzu98WejnVp0zoBSoLM9viT+QH9iTMW
 oGjO08xYCZy/LuyDV5cxAps6LGI4a1FJsmfuxjxSg3SWAtv49zCgc8mRIkDy0/nU9gny
 Yq832Gny373LF1tpKqwO9jKRWt4vs/itIyqmBT5vJX7YK7fHi29wZC5FRG6C5XgiD69Y
 fFn6opAnCWEegyWhAdyK936OTXKwXN3OxU4PGmpTgxtdmU5h1lHg8bPMOivSzX4VY8eZ 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 319t3jtwsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 15:25:08 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04SJ3RdU116858;
        Thu, 28 May 2020 15:25:08 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 319t3jtwrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 15:25:08 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SJ5liZ013680;
        Thu, 28 May 2020 19:25:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 316uf92gg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 19:25:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04SJP3Tw62587254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 19:25:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65CB511C05B;
        Thu, 28 May 2020 19:25:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A55C611C04C;
        Thu, 28 May 2020 19:24:57 +0000 (GMT)
Received: from vajain21-in-ibm-com (unknown [9.85.68.59])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Thu, 28 May 2020 19:24:57 +0000 (GMT)
Received: by vajain21-in-ibm-com (sSMTP sendmail emulation); Fri, 29 May 2020 00:54:55 +0530
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v8 1/5] powerpc: Document details on H_SCM_HEALTH hcall
In-Reply-To: <CAPcyv4jXp1FocSe-fFBA_00TnsjPudrBCuHBfv+zwHA_R0353A@mail.gmail.com>
References: <20200527041244.37821-1-vaibhav@linux.ibm.com> <20200527041244.37821-2-vaibhav@linux.ibm.com> <CAPcyv4jXp1FocSe-fFBA_00TnsjPudrBCuHBfv+zwHA_R0353A@mail.gmail.com>
Date:   Fri, 29 May 2020 00:54:55 +0530
Message-ID: <87o8q7lv5k.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_04:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 spamscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looking into this patchset Dan,


Dan Williams <dan.j.williams@intel.com> writes:

> On Tue, May 26, 2020 at 9:13 PM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>>
>> Add documentation to 'papr_hcalls.rst' describing the bitmap flags
>> that are returned from H_SCM_HEALTH hcall as per the PAPR-SCM
>> specification.
>>
>
> Please do a global s/SCM/PMEM/ or s/SCM/NVDIMM/. It's unfortunate that
> we already have 2 ways to describe persistent memory devices, let's
> not perpetuate a third so that "grep" has a chance to find
> interrelated code across architectures. Other than that this looks
> good to me.

Sure, will use PAPR_NVDIMM instead of PAPR_SCM for new code being
introduced. However certain identifiers like H_SCM_HEALTH are taken from
the papr specificiation hence need to use the same name.

>
>> Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
>> ---
>> Changelog:
>> v7..v8:
>> * Added a clarification on bit-ordering of Health Bitmap
>>
>> Resend:
>> * None
>>
>> v6..v7:
>> * None
>>
>> v5..v6:
>> * New patch in the series
>> ---
>>  Documentation/powerpc/papr_hcalls.rst | 45 ++++++++++++++++++++++++---
>>  1 file changed, 41 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/powerpc/papr_hcalls.rst b/Documentation/powerpc/papr_hcalls.rst
>> index 3493631a60f8..45063f305813 100644
>> --- a/Documentation/powerpc/papr_hcalls.rst
>> +++ b/Documentation/powerpc/papr_hcalls.rst
>> @@ -220,13 +220,50 @@ from the LPAR memory.
>>  **H_SCM_HEALTH**
>>
>>  | Input: drcIndex
>> -| Out: *health-bitmap, health-bit-valid-bitmap*
>> +| Out: *health-bitmap (r4), health-bit-valid-bitmap (r5)*
>>  | Return Value: *H_Success, H_Parameter, H_Hardware*
>>
>>  Given a DRC Index return the info on predictive failure and overall health of
>> -the NVDIMM. The asserted bits in the health-bitmap indicate a single predictive
>> -failure and health-bit-valid-bitmap indicate which bits in health-bitmap are
>> -valid.
>> +the NVDIMM. The asserted bits in the health-bitmap indicate one or more states
>> +(described in table below) of the NVDIMM and health-bit-valid-bitmap indicate
>> +which bits in health-bitmap are valid. The bits are reported in
>> +reverse bit ordering for example a value of 0xC400000000000000
>> +indicates bits 0, 1, and 5 are valid.
>> +
>> +Health Bitmap Flags:
>> +
>> ++------+-----------------------------------------------------------------------+
>> +|  Bit |               Definition                                              |
>> ++======+=======================================================================+
>> +|  00  | SCM device is unable to persist memory contents.                      |
>> +|      | If the system is powered down, nothing will be saved.                 |
>> ++------+-----------------------------------------------------------------------+
>> +|  01  | SCM device failed to persist memory contents. Either contents were not|
>> +|      | saved successfully on power down or were not restored properly on     |
>> +|      | power up.                                                             |
>> ++------+-----------------------------------------------------------------------+
>> +|  02  | SCM device contents are persisted from previous IPL. The data from    |
>> +|      | the last boot were successfully restored.                             |
>> ++------+-----------------------------------------------------------------------+
>> +|  03  | SCM device contents are not persisted from previous IPL. There was no |
>> +|      | data to restore from the last boot.                                   |
>> ++------+-----------------------------------------------------------------------+
>> +|  04  | SCM device memory life remaining is critically low                    |
>> ++------+-----------------------------------------------------------------------+
>> +|  05  | SCM device will be garded off next IPL due to failure                 |
>> ++------+-----------------------------------------------------------------------+
>> +|  06  | SCM contents cannot persist due to current platform health status. A  |
>> +|      | hardware failure may prevent data from being saved or restored.       |
>> ++------+-----------------------------------------------------------------------+
>> +|  07  | SCM device is unable to persist memory contents in certain conditions |
>> ++------+-----------------------------------------------------------------------+
>> +|  08  | SCM device is encrypted                                               |
>> ++------+-----------------------------------------------------------------------+
>> +|  09  | SCM device has successfully completed a requested erase or secure     |
>> +|      | erase procedure.                                                      |
>> ++------+-----------------------------------------------------------------------+
>> +|10:63 | Reserved / Unused                                                     |
>> ++------+-----------------------------------------------------------------------+
>>
>>  **H_SCM_PERFORMANCE_STATS**
>>
>> --
>> 2.26.2
>>

-- 
Cheers
~ Vaibhav
