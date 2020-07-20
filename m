Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBBEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039FC22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgGTNBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:01:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43396 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbgGTNBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:01:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KD14Jx037254;
        Mon, 20 Jul 2020 09:01:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5jyum5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 09:01:08 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06KD18u9037401;
        Mon, 20 Jul 2020 09:01:08 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5jyuktg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 09:01:08 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KCudgv022695;
        Mon, 20 Jul 2020 13:00:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7tqs3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 13:00:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06KCxJnF50462950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 12:59:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 818964C050;
        Mon, 20 Jul 2020 12:59:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 205854C040;
        Mon, 20 Jul 2020 12:59:16 +0000 (GMT)
Received: from [9.85.112.199] (unknown [9.85.112.199])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 12:59:15 +0000 (GMT)
Subject: Re: [PATCH v4 03/12] powerpc/kexec_file: add helper functions for
 getting memory ranges
From:   Hari Bathini <hbathini@linux.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com>
 <159524946347.20855.15784642736087777919.stgit@hbathini.in.ibm.com>
Message-ID: <d6b0b134-f681-cc56-d0c1-dd581d518263@linux.ibm.com>
Date:   Mon, 20 Jul 2020 18:29:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159524946347.20855.15784642736087777919.stgit@hbathini.in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_07:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/07/20 6:21 pm, Hari Bathini wrote:
> In kexec case, the kernel to be loaded uses the same memory layout as
> the running kernel. So, passing on the DT of the running kernel would
> be good enough.
> 
> But in case of kdump, different memory ranges are needed to manage
> loading the kdump kernel, booting into it and exporting the elfcore
> of the crashing kernel. The ranges are exclude memory ranges, usable
> memory ranges, reserved memory ranges and crash memory ranges.
> 
> Exclude memory ranges specify the list of memory ranges to avoid while
> loading kdump segments. Usable memory ranges list the memory ranges
> that could be used for booting kdump kernel. Reserved memory ranges
> list the memory regions for the loading kernel's reserve map. Crash
> memory ranges list the memory ranges to be exported as the crashing
> kernel's elfcore.
> 
> Add helper functions for setting up the above mentioned memory ranges.
> This helpers facilitate in understanding the subsequent changes better
> and make it easy to setup the different memory ranges listed above, as
> and when appropriate.
> 
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>
> ---

> 
> v3 -> v4:
> * Unchanged. Added Reviewed-by tag from Thiago.
> 
> v2 -> v3:
> * Unchanged. Added Acked-by & Tested-by tags from Dave & Pingfan.
> 
> v1 -> v2:
> * Introduced arch_kexec_locate_mem_hole() for override and dropped
>   weak arch_kexec_add_buffer().
> * Dropped __weak identifier for arch overridable functions.
> * Fixed the missing declaration for arch_kimage_file_post_load_cleanup()
>   reported by lkp. lkp report for reference:
>     - https://lore.kernel.org/patchwork/patch/1264418/

Sorry, copy-paste error. The patch version changelog is as follows:

v3 -> v4:
* Updated sort_memory_ranges() function to reuse sort() from lib/sort.c
  and addressed other review comments from Thiago.

v2 -> v3:
* Unchanged. Added Tested-by tag from Pingfan.

v1 -> v2:
* Added an option to merge ranges while sorting to minimize reallocations
  for memory ranges list.
* Dropped within_crashkernel option for add_opal_mem_range() &
  add_rtas_mem_range() as it is not really needed.


Thanks
Hari
