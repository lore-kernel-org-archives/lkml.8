Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF5BC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B003A24670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="giHZI+Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBZQXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:23:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54444 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgBZQXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:23:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFwxZp113857;
        Wed, 26 Feb 2020 16:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=S3UwfGiP0JixI9qfZJspHVlcFTyNQ+p0Z7ywtbB6LDE=;
 b=giHZI+ZtH7nbjWH1GuoByBPkQ4Trgwth6GNSSlOVl79blco8iS/xoi74VpDp53k0gwvL
 DNwoQS/ijVEV5kklOGFgVrp6ZQFv3PAiFGAhHOsZDnye1z7moPSPztC6YpTjnPgQQTQ2
 1wjUIQ0JX15ZaM7tfej1adJKbtNayb5OHVmdCHBRbeBMEhd1IN+/6eYnajGg+V2pqQwC
 YlDvASzTA5rvKEe8HvcuoypIAXjnQ4dCAMbhi9PIaU9cFL9ILue06TEeo2UeYyg1oDuh
 k2iVtIUkY61uizUGS1fthOGHy7xOYmbqv4ykqXEOcmONWHkq9WKhHAjTpyFeLrXnWJJW zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2ydct34r2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:20 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QGMEtj164644;
        Wed, 26 Feb 2020 16:22:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2ydcs2g53c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:19 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QGM8lD028710;
        Wed, 26 Feb 2020 16:22:08 GMT
Received: from achartre-desktop.us.oracle.com (/10.39.232.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 08:22:08 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC PATCH v3 0/7] Kernel Address Space Isolation
Date:   Wed, 26 Feb 2020 17:21:53 +0100
Message-Id: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 1.7.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 3 of the "Kernel Address Space Isolation" (ASI) RFC
[1][2]. This version focus on providing the ASI infrastructure and
implementing PTI with ASI.

Compared to version 2, this RFC is much smaller with only 7 patches
(RFCv2 has 26 patches). This is because this RFC contains patches only
for the ASI infrastructure and for implementing PTI with ASI, but it
doesn't contain patches for using ASI with KVM and all related changes
regarding page-table creation and filling.

This patchset is based on the Linux 5.5 source code.

Background
==========
Kernel Address Space Isolation aims to use address spaces to isolate some
parts of the kernel (for example KVM) to prevent leaking sensitive data
between CPU hyper-threads under speculative execution attacks.

Over the past years, various speculative attacks (like L1TF or MDS) have
highlighted that data can leak between CPU threads through the CPU (micro)
architecture. In particular, a malicious virtual machine running on a CPU
thread can target data used by a sibling CPU thread from the same CPU core.
Thus, a malicious VM can potentially access data from another VM or from
the host system if they are running on sibling CPU threads.

Core Scheduling [3] can prevent a malicious VM from attacking another VM
by running the same VM on all CPU threads of a CPU core. However a
malicious VM can still target the host system when the sibling CPU thread
exits the VM and returns to the host.

Address Space Isolation can be applied to KVM to mitigate this VM-to-host
attack by removing secrets from the kernel address space used when running
KVM, thus preventing a malicious VM from collecting any sensitive data
from host.

Address Space Isolation can also be used to implement Page Table Isolation
(PTI [4]) which reduces kernel mappings present in user address spaces to
prevent the Meltdown attack.

Details
=======

ASI
---
An ASI is created by calling asi_create() with a specified ASI type. The
ASI type manages data common to all ASI of the same type. It is used, in
particular, to manage per-ASI type TLB/PCID information.

Then the ASI can be entered with asi_enter() and exited with asi_exit().
When an ASI is in used, any interrupt/exception/NMI will cause the ASI to
be interrupted (ASI_INTERRUPT) and the ASI will be resumed (ASI_RESUME)
when the interrupt/exception/NMI returns.

asi_enter()/asi_exit() and ASI_INTERRUPT/ASI_RESUME switch between the
ASI and the full kernel page-table by updating the CR3 register.

If a task using ASI is scheduled out then its ASI state is saved and it
will be restored when the task is scheduled back.

Page fault occurring while ASI is used will either cause the ASI to be
aborted (switch back to the full kernel pagetable) or to be preserved.
The behavior depends on the ASI type. For example, for PTI the ASI is
preserved and the kernel page fault handler handles the fault on behalf
of the ASI. But for KVM ASI, the ASI will be aborted and the fault will
be retried with the full kernel page-table.

PTI
---
PTI is now implemented with ASI (user ASI) if both CONFIG_ADDRESS_SPACE_ISOLATION
and CONFIG_PAGE_TABLE_ISOLATION are set. The behavior of PTI is unchanged
but it is now using the ASI infrastructure. 

For each user process, a user ASI is defined with the PTI pagetable. The
user ASI is used when running userland code, and it is exited when entering
a syscall. The user ASI is re-entered when the syscall returns to userland.

KVM
---
As already mentioned, KVM ASI is not present in this patchset. KVM ASI
will be implemented ontop of this infrastructure. Basically, the KVM ASI
patchset will:
  - define a KVM ASI type (DEFINE_ASI_TYPE)
  - create and fill a page-table to be used by the KVM ASI
  - create a KVM ASI (asi_create_kvm())
  - enter the KVM ASI (asi_enter()) on KVM_RUN ioctl
  - exit the KVM ASI (asi_exit())

Fault occuring when KVM ASI is in used will cause the ASI to be aborted,
and the code will continue running with the full kernel page-table,
until KVM ASI is explicitly reentered.

Status
======
The code looks stable and it supports running a full kernel build and
also ltp tests. Performance impact is expected to be limited as the new
code only adds a small number of assembly instructions on syscall and
interrupts. There's probably also room for reducing this number of
instructions.

Changes 
=======
Summary of changes compared to RFCv2:

- Add ASI Type

- Add generic TLB flushing mechanism for ASI. This mechanism is similar
  to the context tracking done when switching mm.

- When ASI is in used, it is interrupted on interrupt/exception/NMI and
  resumed when the interrupt/exception/NMI returns.

- If a task using ASI is scheduled in/out then save/restore the corresponding
  ASI and update the cpu ASI session.

- Implement PTI with ASI.

- Remove KVM ASI from the patchset. KVM ASI will be provided in a separated
  patchset ontop of the ASI infrastructure.

- Remove functions to manage, populate and clear page-tables. These functions
  were only used to build to the KVM ASI page-table. Also such functions should
  be generic page-table functions and not specific to ASI. Mike Rapoport is also
  looking at making these functions generic.


References
==========
[1] ASI RFCv1 - https://lkml.org/lkml/2019/5/13/515
[2] ASI RFCv2 - https://lore.kernel.org/lkml/1562855138-19507-1-git-send-email-alexandre.chartre@oracle.com
[3] Core Scheduling - https://lwn.net/Articles/803652
[4] Page Table Isolation (PTI) - https://www.kernel.org/doc/html/latest/x86/pti.html

---


Alexandre Chartre (7):
  mm/x86: Introduce kernel Address Space Isolation (ASI)
  mm/asi: ASI entry/exit interface
  mm/asi: Improve TLB flushing when switching to an ASI pagetable
  mm/asi: Interrupt ASI on interrupt/exception/NMI
  mm/asi: Switch ASI on task switch
  mm/asi: ASI fault handler
  mm/asi: Implement PTI with ASI

 arch/x86/entry/calling.h           |   31 +++-
 arch/x86/entry/common.c            |   29 +++-
 arch/x86/entry/entry_64.S          |   28 +++
 arch/x86/include/asm/asi.h         |  289 ++++++++++++++++++++++++++
 arch/x86/include/asm/asi_session.h |   24 +++
 arch/x86/include/asm/mmu_context.h |   20 ++-
 arch/x86/include/asm/tlbflush.h    |   23 ++-
 arch/x86/kernel/asm-offsets.c      |    5 +
 arch/x86/mm/Makefile               |    1 +
 arch/x86/mm/asi.c                  |  402 ++++++++++++++++++++++++++++++++++++
 arch/x86/mm/fault.c                |   20 ++
 arch/x86/mm/pti.c                  |   28 ++-
 include/linux/mm_types.h           |    5 +
 include/linux/sched.h              |    9 +
 kernel/fork.c                      |   17 ++
 kernel/sched/core.c                |    8 +
 security/Kconfig                   |   10 +
 17 files changed, 931 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/asi.h
 create mode 100644 arch/x86/include/asm/asi_session.h
 create mode 100644 arch/x86/mm/asi.c

