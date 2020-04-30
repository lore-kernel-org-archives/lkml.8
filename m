Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE489C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EF121974
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgD3EfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 00:35:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46888 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726391AbgD3EfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:35:06 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U4XtBA146719;
        Thu, 30 Apr 2020 00:34:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q803axue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:34:39 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03U4YJ4a147417;
        Thu, 30 Apr 2020 00:34:37 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q803axrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:34:37 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03U4OmQ0004545;
        Thu, 30 Apr 2020 04:34:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 30mcu52bat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:34:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03U4YQPI65404952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 04:34:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF11C42047;
        Thu, 30 Apr 2020 04:34:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81BD042041;
        Thu, 30 Apr 2020 04:34:23 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.59.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 04:34:23 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.ibm.com
Subject: [PATCH v4 00/16] powerpc/watchpoint: Preparation for more than one watchpoint
Date:   Thu, 30 Apr 2020 10:04:01 +0530
Message-Id: <20200430043417.30948-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_01:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=824
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far, powerpc Book3S code has been written with an assumption of only
one watchpoint. But future power architecture is introducing second
watchpoint register (DAWR). Even though this patchset does not enable
2nd DAWR, it make the infrastructure ready so that enabling 2nd DAWR
should just be a matter of changing count.

Existing functionality works fine with the patchset. I've tested it with
perf, ptrace(gdb), xmon. All hw-breakpoint selftests are passing as well.
And I've build tested for 8xx and 'AMCC 44x, 46x or 47x'.

Note: kvm or PowerVM guest is not enabled yet.

v3: https://lore.kernel.org/linuxppc-dev/20200414031659.58875-1-ravi.bangoria@linux.ibm.com

v3->v4:
 - Reduce the scope of local variables to increase readability at some
   places, suggested by Christophe.
 - Added Michael Neuling's Reviewed by for the series.
 - Rebased to powerpc/next

Ravi Bangoria (16):
  powerpc/watchpoint: Rename current DAWR macros
  powerpc/watchpoint: Add SPRN macros for second DAWR
  powerpc/watchpoint: Introduce function to get nr watchpoints
    dynamically
  powerpc/watchpoint/ptrace: Return actual num of available watchpoints
  powerpc/watchpoint: Provide DAWR number to set_dawr
  powerpc/watchpoint: Provide DAWR number to __set_breakpoint
  powerpc/watchpoint: Get watchpoint count dynamically while disabling
    them
  powerpc/watchpoint: Disable all available watchpoints when
    !dawr_force_enable
  powerpc/watchpoint: Convert thread_struct->hw_brk to an array
  powerpc/watchpoint: Use loop for thread_struct->ptrace_bps
  powerpc/watchpoint: Introduce is_ptrace_bp() function
  powerpc/watchpoint: Use builtin ALIGN*() macros
  powerpc/watchpoint: Prepare handler to handle more than one
    watcnhpoint
  powerpc/watchpoint: Don't allow concurrent perf and ptrace events
  powerpc/watchpoint/xmon: Don't allow breakpoint overwriting
  powerpc/watchpoint/xmon: Support 2nd dawr

 arch/powerpc/include/asm/cputable.h       |   6 +-
 arch/powerpc/include/asm/debug.h          |   2 +-
 arch/powerpc/include/asm/hw_breakpoint.h  |  32 +-
 arch/powerpc/include/asm/processor.h      |   6 +-
 arch/powerpc/include/asm/reg.h            |   6 +-
 arch/powerpc/include/asm/sstep.h          |   2 +
 arch/powerpc/kernel/dawr.c                |  23 +-
 arch/powerpc/kernel/hw_breakpoint.c       | 645 ++++++++++++++++++----
 arch/powerpc/kernel/process.c             |  85 +--
 arch/powerpc/kernel/ptrace/ptrace-noadv.c |  72 ++-
 arch/powerpc/kernel/ptrace/ptrace32.c     |   4 +-
 arch/powerpc/kernel/signal.c              |  13 +-
 arch/powerpc/kvm/book3s_hv.c              |  12 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  18 +-
 arch/powerpc/xmon/xmon.c                  |  99 +++-
 kernel/events/hw_breakpoint.c             |  16 +
 16 files changed, 814 insertions(+), 227 deletions(-)

-- 
2.21.1

