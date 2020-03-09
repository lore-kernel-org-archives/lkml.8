Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F9C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58120828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCII6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:58:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725796AbgCII6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:58:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0298oaa4123920
        for <linux-kernel@vger.kernel.org>; Mon, 9 Mar 2020 04:58:48 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8g2wshf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:58:48 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 9 Mar 2020 08:58:47 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Mar 2020 08:58:42 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0298wfRW35193008
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Mar 2020 08:58:41 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 062A7A4053;
        Mon,  9 Mar 2020 08:58:41 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89BE9A4040;
        Mon,  9 Mar 2020 08:58:38 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.44])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Mar 2020 08:58:38 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 00/15] powerpc/watchpoint: Preparation for more than one watchpoint
Date:   Mon,  9 Mar 2020 14:27:51 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030908-0028-0000-0000-000003E234F0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030908-0029-0000-0000-000024A771A8
Message-Id: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_02:2020-03-06,2020-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=334 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003090066
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
And I've build tested for 8xx.

Note: kvm or PowerVM geust is not enabled yet.

The series applies fine to powerpc/next plus one more dependency patch:
https://git.kernel.org/powerpc/c/e08658a657f974590809290c62e889f0fd420200

Ravi Bangoria (15):
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
  powerpc/watchpoint: Prepare handler to handle more than one
    watcnhpoint
  powerpc/watchpoint: Don't allow concurrent perf and ptrace events
  powerpc/watchpoint/xmon: Don't allow breakpoint overwriting
  powerpc/watchpoint/xmon: Support 2nd dawr

 arch/powerpc/include/asm/cputable.h      |   6 +-
 arch/powerpc/include/asm/debug.h         |   2 +-
 arch/powerpc/include/asm/hw_breakpoint.h |  23 +-
 arch/powerpc/include/asm/processor.h     |   6 +-
 arch/powerpc/include/asm/reg.h           |   6 +-
 arch/powerpc/include/asm/sstep.h         |   2 +
 arch/powerpc/kernel/dawr.c               |  23 +-
 arch/powerpc/kernel/hw_breakpoint.c      | 628 +++++++++++++++++++----
 arch/powerpc/kernel/process.c            |  66 ++-
 arch/powerpc/kernel/ptrace.c             |  72 ++-
 arch/powerpc/kernel/ptrace32.c           |   4 +-
 arch/powerpc/kernel/signal.c             |   9 +-
 arch/powerpc/kvm/book3s_hv.c             |  12 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  18 +-
 arch/powerpc/xmon/xmon.c                 |  99 ++--
 kernel/events/hw_breakpoint.c            |  16 +
 16 files changed, 793 insertions(+), 199 deletions(-)

-- 
2.21.1

