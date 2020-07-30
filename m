Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A47C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 695632084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgG3GFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:05:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725892AbgG3GFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:05:31 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06U5Wafr139489;
        Thu, 30 Jul 2020 02:05:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32k9qv9guh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 02:05:18 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06U5j1N9025907;
        Thu, 30 Jul 2020 02:05:18 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32k9qv9gt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 02:05:17 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06U65Fdq005152;
        Thu, 30 Jul 2020 06:05:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 32gcy4nupm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 06:05:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06U65CPF31064358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 06:05:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05A31A406F;
        Thu, 30 Jul 2020 06:05:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 499B2A4065;
        Thu, 30 Jul 2020 06:05:08 +0000 (GMT)
Received: from [9.102.24.129] (unknown [9.102.24.129])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jul 2020 06:05:08 +0000 (GMT)
Subject: Re: [RESEND PATCH v5 00/11] ppc64: enable kdump support for
 kexec_file_load syscall
To:     piliu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <23911b9d-7534-031c-6f98-80f90439c834@redhat.com>
From:   Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <df8f1d6f-d85b-f2fb-548b-ecdaddec311c@linux.ibm.com>
Date:   Thu, 30 Jul 2020 11:35:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <23911b9d-7534-031c-6f98-80f90439c834@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_03:2020-07-29,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/20 8:02 am, piliu wrote:
> 
> 
> On 07/27/2020 03:36 AM, Hari Bathini wrote:
>> Sorry! There was a gateway issue on my system while posting v5, due to
>> which some patches did not make it through. Resending...
>>
>> This patch series enables kdump support for kexec_file_load system
>> call (kexec -s -p) on PPC64. The changes are inspired from kexec-tools
>> code but heavily modified for kernel consumption.
>>
>> The first patch adds a weak arch_kexec_locate_mem_hole() function to
>> override locate memory hole logic suiting arch needs. There are some
>> special regions in ppc64 which should be avoided while loading buffer
>> & there are multiple callers to kexec_add_buffer making it complicated
>> to maintain range sanity and using generic lookup at the same time.
>>
>> The second patch marks ppc64 specific code within arch/powerpc/kexec
>> and arch/powerpc/purgatory to make the subsequent code changes easy
>> to understand.
>>
>> The next patch adds helper function to setup different memory ranges
>> needed for loading kdump kernel, booting into it and exporting the
>> crashing kernel's elfcore.
>>
>> The fourth patch overrides arch_kexec_locate_mem_hole() function to
>> locate memory hole for kdump segments by accounting for the special
>> memory regions, referred to as excluded memory ranges, and sets
>> kbuf->mem when a suitable memory region is found.
>>
>> The fifth patch moves walk_drmem_lmbs() out of .init section with
>> a few changes to reuse it for setting up kdump kernel's usable memory
>> ranges. The next patch uses walk_drmem_lmbs() to look up the LMBs
>> and set linux,drconf-usable-memory & linux,usable-memory properties
>> in order to restrict kdump kernel's memory usage.
>>
>> The seventh patch updates purgatory to setup r8 & r9 with opal base
>> and opal entry addresses respectively to aid kernels built with
>> CONFIG_PPC_EARLY_DEBUG_OPAL enabled. The next patch setups up backup
>> region as a kexec segment while loading kdump kernel and teaches
>> purgatory to copy data from source to destination.
>>
>> Patch 09 builds the elfcore header for the running kernel & passes
>> the info to kdump kernel via "elfcorehdr=" parameter to export as
>> /proc/vmcore file. The next patch sets up the memory reserve map
>> for the kexec kernel and also claims kdump support for kdump as
>> all the necessary changes are added.
>>
>> The last patch fixes a lookup issue for `kexec -l -s` case when
>> memory is reserved for crashkernel.
>>
>> Tested the changes successfully on P8, P9 lpars, couple of OpenPOWER
>> boxes, one with secureboot enabled, KVM guest and a simulator.
>>
>> v4 -> v5:
>> * Dropped patches 07/12 & 08/12 and updated purgatory to do everything
>>    in assembly.

Hello Pingfan,

Sorry, I missed out on responding to this.


> I guess you achieve this by carefully selecting instruction to avoid
> relocation issue, right?

Yes. No far branching or reference to data from elsewhere.

Thanks
Hari
