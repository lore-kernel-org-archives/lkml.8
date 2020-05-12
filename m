Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91181C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79936207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgELGRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:17:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6028 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgELGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:17:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04C68aZL046838;
        Tue, 12 May 2020 02:16:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ws5b2ma9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 02:16:59 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04C6E9XA053090;
        Tue, 12 May 2020 02:16:59 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ws5b2m9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 02:16:59 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04C6Ffbl029383;
        Tue, 12 May 2020 06:16:57 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 30wm55jbtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 May 2020 06:16:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04C6GsnL56492162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 06:16:54 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76AD24C04E;
        Tue, 12 May 2020 06:16:54 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 309CF4C04A;
        Tue, 12 May 2020 06:16:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 12 May 2020 06:16:54 +0000 (GMT)
Date:   Tue, 12 May 2020 08:16:54 +0200
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Joe Perches <joe@perches.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] s390: Remove two unused inline functions
Message-ID: <20200512061653.GA33732@tuxmaker.boeblingen.de.ibm.com>
References: <20200508140724.11324-1-yuehaibing@huawei.com>
 <20200511060750.GA93884@tuxmaker.boeblingen.de.ibm.com>
 <20200511161756.7586afe6@gandalf.local.home>
 <cf344230-27b1-7302-36bb-55c25c6b5de4@de.ibm.com>
 <02b965de57774f393bb16d669164e0cef2497f2f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b965de57774f393bb16d669164e0cef2497f2f.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_01:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, May 11, 2020 at 01:38:57PM -0700, Joe Perches wrote:

> Awhile back, I posted a list of apparently unused static inline
> functions in .h files treewide found by a script:
> 
> https://lore.kernel.org/lkml/4603e761a5f39f4d97375e1e08d20d720c526341.camel@perches.com/
> 
> Here are the s390 entries:
> 
> arch/s390/include/asm/atomic_ops.h:138:static inline long __atomic64_cmpxchg_bool(long *ptr, long old, long new)
> arch/s390/include/asm/bitops.h:278:static inline void __set_bit_inv(unsigned long nr, volatile unsigned long *ptr)
> arch/s390/include/asm/bitops.h:283:static inline void __clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
> arch/s390/include/asm/cpu_mcf.h:106:static inline int kernel_cpumcf_begin(void)
> arch/s390/include/asm/cpu_mcf.h:114:static inline void kernel_cpumcf_end(void)
> arch/s390/include/asm/ftrace.h:64:static inline int is_ftrace_nop(struct ftrace_insn *insn)
> arch/s390/include/asm/kvm_para.h:146:static inline long kvm_hypercall5(unsigned long nr, unsigned long p1,
> arch/s390/include/asm/kvm_para.h:175:static inline long kvm_hypercall6(unsigned long nr, unsigned long p1,
> arch/s390/include/asm/pci_dma.h:134:static inline void invalidate_table_entry(unsigned long *entry)
> arch/s390/include/asm/pci_dma.h:176:static inline int entry_isprotected(unsigned long entry)
> arch/s390/include/asm/timex.h:52:static inline void store_clock_comparator(__u64 *time)

Thanks, i take a look and prepare a patch.

Regards
Sven
