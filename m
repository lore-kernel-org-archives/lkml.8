Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C098CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42F020759
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 00:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgGYAdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 20:33:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbgGYAdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 20:33:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06P0VF2K007882;
        Fri, 24 Jul 2020 20:33:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fsbmmkn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 20:33:07 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06P0X5YC011232;
        Fri, 24 Jul 2020 20:33:06 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fsbmmkn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 20:33:06 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06P0LA8s001214;
        Sat, 25 Jul 2020 00:33:05 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 32brqa096d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jul 2020 00:33:05 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06P0X2la64553358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jul 2020 00:33:02 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9335C78060;
        Sat, 25 Jul 2020 00:33:04 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9AA47805C;
        Sat, 25 Jul 2020 00:33:01 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.38.252])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat, 25 Jul 2020 00:33:01 +0000 (GMT)
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com> <159524954805.20855.1164928096364700614.stgit@hbathini.in.ibm.com> <875zad6ajx.fsf@morokweng.localdomain> <77c606da-8eb2-d831-147b-a204b498c7d7@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
Cc:     Pingfan Liu <piliu@redhat.com>, Nayna Jain <nayna@linux.ibm.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v4 06/12] ppc64/kexec_file: restrict memory usage of kdump kernel
In-reply-to: <77c606da-8eb2-d831-147b-a204b498c7d7@linux.ibm.com>
Date:   Fri, 24 Jul 2020 21:32:59 -0300
Message-ID: <874kpwsabo.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_10:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> On 24/07/20 5:36 am, Thiago Jung Bauermann wrote:
>>
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>>
>>> Kdump kernel, used for capturing the kernel core image, is supposed
>>> to use only specific memory regions to avoid corrupting the image to
>>> be captured. The regions are crashkernel range - the memory reserved
>>> explicitly for kdump kernel, memory used for the tce-table, the OPAL
>>> region and RTAS region as applicable. Restrict kdump kernel memory
>>> to use only these regions by setting up usable-memory DT property.
>>> Also, tell the kdump kernel to run at the loaded address by setting
>>> the magic word at 0x5c.
>>>
>>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>>> Tested-by: Pingfan Liu <piliu@redhat.com>
>>> ---
>>>
>>> v3 -> v4:
>>> * Updated get_node_path() to be an iterative function instead of a
>>>   recursive one.
>>> * Added comment explaining why low memory is added to kdump kernel's
>>>   usable memory ranges though it doesn't fall in crashkernel region.
>>> * For correctness, added fdt_add_mem_rsv() for the low memory being
>>>   added to kdump kernel's usable memory ranges.
>>
>> Good idea.
>>
>>> * Fixed prop pointer update in add_usable_mem_property() and changed
>>>   duple to tuple as suggested by Thiago.
>>
>> <snip>
>>
>>> +/**
>>> + * get_node_pathlen - Get the full path length of the given node.
>>> + * @dn:               Node.
>>> + *
>>> + * Also, counts '/' at the end of the path.
>>> + * For example, /memory@0 will be "/memory@0/\0" => 11 bytes.
>>
>> Wouldn't this function return 10 in the case of /memory@0?
>
> Actually, it does return 11. +1 while returning is for counting %NUL.
> On top of that we count an extra '/' for root node.. so, it ends up as 11.
> ('/'memory@0'/''\0'). Note the extra '/' before '\0'. Let me handle root node
> separately. That should avoid the confusion.

Ah, that is true. I forgot to count the iteration for the root node.
Sorry about that.

--
Thiago Jung Bauermann
IBM Linux Technology Center
