Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE67AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59D8207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732880AbgGASbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:31:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8169 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732542AbgGASbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:31:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 061I2fRO187193;
        Wed, 1 Jul 2020 14:31:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 320s4qwymw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:31:42 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 061IPXpF112121;
        Wed, 1 Jul 2020 14:31:41 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 320s4qwyk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 14:31:41 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 061IGAR5032175;
        Wed, 1 Jul 2020 18:31:39 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 31wwr7tevc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Jul 2020 18:31:39 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 061IVZnl12976606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jul 2020 18:31:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EFBF4203F;
        Wed,  1 Jul 2020 18:31:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95FD342045;
        Wed,  1 Jul 2020 18:31:32 +0000 (GMT)
Received: from [9.102.31.46] (unknown [9.102.31.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jul 2020 18:31:32 +0000 (GMT)
Subject: Re: [PATCH 01/11] kexec_file: allow archs to handle special regions
 while locating memory hole
To:     Dave Young <dyoung@redhat.com>
Cc:     Pingfan Liu <piliu@redhat.com>, Petr Tesarik <ptesarik@suse.cz>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <159319825403.16351.7253978047621755765.stgit@hbathini.in.ibm.com>
 <159319828304.16351.6990340111766605842.stgit@hbathini.in.ibm.com>
 <20200629133933.0787f562@ezekiel.suse.cz>
 <7981ae61-26c6-000c-9ee4-382dab3eecab@linux.ibm.com>
 <20200701074659.GA3878@dhcp-128-65.nay.redhat.com>
From:   Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <0e145e84-a6cf-4da3-1a1a-331a7e1ac1fa@linux.ibm.com>
Date:   Thu, 2 Jul 2020 00:01:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701074659.GA3878@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-01_09:2020-07-01,2020-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 cotscore=-2147483648 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007010124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/20 1:16 pm, Dave Young wrote:
> On 06/29/20 at 05:26pm, Hari Bathini wrote:
>> Hi Petr,
>>
>> On 29/06/20 5:09 pm, Petr Tesarik wrote:
>>> Hi Hari,
>>>
>>> is there any good reason to add two more functions with a very similar
>>> name to an existing function? AFAICS all you need is a way to call a
>>> PPC64-specific function from within kexec_add_buffer (PATCH 4/11), so
>>> you could add something like this:
>>>
>>> int __weak arch_kexec_locate_mem_hole(struct kexec_buf *kbuf)
>>> {
>>> 	return 0;
>>> }
>>>
>>> Call this function from kexec_add_buffer where appropriate and then
>>> override it for PPC64 (it roughly corresponds to your
>>> kexec_locate_mem_hole_ppc64() from PATCH 4/11).
>>>
>>> FWIW it would make it easier for me to follow the resulting code.
>>
>> Right, Petr.
>>
>> I was trying out a few things before I ended up with what I sent here.
>> Bu yeah.. I did realize arch_kexec_locate_mem_hole() would have been better
>> after sending out v1. Will take care of that in v2.
> 
> Another way is use arch private function to locate mem hole, then set
> kbuf->mem, and then call kexec_add_buf, it will skip the common locate
> hole function.

Dave, I did think about it. But there are a couple of places this can get
tricky. One is ima_add_kexec_buffer() and the other is kexec_elf_load().
These call sites could be updated to set kbuf->mem before kexec_add_buffer().
But the current approach seemed like the better option for it creates a
single point of control in setting up segment buffers and also, makes adding
any new segments simpler, arch-specific segments or otherwise.

Thanks
Hari
