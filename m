Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECF2C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FF620679
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgDUOCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:02:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgDUOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:02:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03LDZ3TO083329
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:02:17 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmuynwfc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:02:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Tue, 21 Apr 2020 15:01:30 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 Apr 2020 15:01:21 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03LE24dv53608476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 14:02:04 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFD5A4057;
        Tue, 21 Apr 2020 14:02:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FEB3A405B;
        Tue, 21 Apr 2020 14:02:03 +0000 (GMT)
Received: from thinkpad (unknown [9.145.65.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Apr 2020 14:02:03 +0000 (GMT)
Date:   Tue, 21 Apr 2020 16:02:01 +0200
From:   Gerald Schaefer <gerald.schaefer@de.ibm.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v3 0/4] Clean up hugetlb boot command line processing
In-Reply-To: <20200417185049.275845-1-mike.kravetz@oracle.com>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042114-4275-0000-0000-000003C3FB90
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042114-4276-0000-0000-000038D9805D
Message-Id: <20200421160201.0ddb9763@thinkpad>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-21_05:2020-04-20,2020-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 11:50:45 -0700
Mike Kravetz <mike.kravetz@oracle.com> wrote:

> v3 -
>    Used weak attribute method of defining arch_hugetlb_valid_size.
>      This eliminates changes to arch specific hugetlb.h files (Peter)
>    Updated documentation (Peter, Randy)
>    Fixed handling of implicitly specified gigantic page preallocation
>      in existing code and removed documentation of such.  There is now
>      no difference between handling of gigantic and non-gigantic pages.
>      (Peter, Nitesh).
>      This requires the most review as there is a small change to
>      undocumented behavior.  See patch 4 commit message for details.
>    Added Acks and Reviews (Mina, Peter)
> 
> v2 -
>    Fix build errors with patch 1 (Will)
>    Change arch_hugetlb_valid_size arg to unsigned long and remove
>      irrelevant 'extern' keyword (Christophe)
>    Documentation and other misc changes (Randy, Christophe, Mina)
>    Do not process command line options if !hugepages_supported()
>      (Dave, but it sounds like we may want to additional changes to
>       hugepages_supported() for x86?  If that is needed I would prefer
>       a separate patch.)
> 
> Longpeng(Mike) reported a weird message from hugetlb command line processing
> and proposed a solution [1].  While the proposed patch does address the
> specific issue, there are other related issues in command line processing.
> As hugetlbfs evolved, updates to command line processing have been made to
> meet immediate needs and not necessarily in a coordinated manner.  The result
> is that some processing is done in arch specific code, some is done in arch
> independent code and coordination is problematic.  Semantics can vary between
> architectures.
> 
> The patch series does the following:
> - Define arch specific arch_hugetlb_valid_size routine used to validate
>   passed huge page sizes.
> - Move hugepagesz= command line parsing out of arch specific code and into
>   an arch independent routine.
> - Clean up command line processing to follow desired semantics and
>   document those semantics.
> 
> [1] https://lore.kernel.org/linux-mm/20200305033014.1152-1-longpeng2@huawei.com
> 
> Mike Kravetz (4):
>   hugetlbfs: add arch_hugetlb_valid_size
>   hugetlbfs: move hugepagesz= parsing to arch independent code
>   hugetlbfs: remove hugetlb_add_hstate() warning for existing hstate
>   hugetlbfs: clean up command line processing
> 
>  .../admin-guide/kernel-parameters.txt         |  40 ++--
>  Documentation/admin-guide/mm/hugetlbpage.rst  |  35 ++++
>  arch/arm64/mm/hugetlbpage.c                   |  30 +--
>  arch/powerpc/mm/hugetlbpage.c                 |  30 +--
>  arch/riscv/mm/hugetlbpage.c                   |  24 +--
>  arch/s390/mm/hugetlbpage.c                    |  24 +--
>  arch/sparc/mm/init_64.c                       |  43 +---
>  arch/x86/mm/hugetlbpage.c                     |  23 +--
>  include/linux/hugetlb.h                       |   2 +-
>  mm/hugetlb.c                                  | 190 +++++++++++++++---
>  10 files changed, 271 insertions(+), 170 deletions(-)
> 

Looks good and works fine for s390, thanks for cleaning up!

Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> # s390

