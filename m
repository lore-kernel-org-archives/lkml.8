Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E189C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 281A1206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VwkKvSTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEDOvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:51:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41742 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgEDOvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:51:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElrZR117068;
        Mon, 4 May 2020 14:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=kAb0uKQlR0Mu5YgZ88ZFRxUKRNMHumU/kWcfRlU4hVA=;
 b=VwkKvSTnB7Pp0d88IMcqodpJ/j3UU3S+dYxwvdBW6ynq25bKnss4dIsHHQiqdehpEXEE
 t9ZyeHCNrANhaYziMdCvDz6CHuRaonA8MH5bZyBEmnO86uthwa8swHux2YMj7fwL9pn9
 ATuewE0By0TAGf3XvFI9ZHyNcz0jmiLrI1TlK6un62WLuLRns1KrjQ/mLwzIW80I5Lyj
 MTpgSiYHIQZvivRMjWyeMMaFk7eV/fEBC4xsCWyFQtsYp304L4q+ElwCWZaEYyoyRHmz
 /HFxl31Wror3bjchXf9dv0XjMmt80nvKed8wlgBah6BcBgfkbemBXP1jw+8LwPBXBv2i 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09qyds6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElM0F033808;
        Mon, 4 May 2020 14:51:03 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjnav30d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:03 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044Ep0uN017233;
        Mon, 4 May 2020 14:51:00 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:51:00 -0700
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
Subject: [RFC v4][PATCH part-1 0/7] ASI - Part I (ASI Infrastructure and PTI)
Date:   Mon,  4 May 2020 16:49:32 +0200
Message-Id: <20200504144939.11318-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=921 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=946 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version 4 of the kernel Address Space Isolation (ASI) RFC. I have
broken it down into three distinct parts:

 - Part I: ASI Infrastructure and PTI (this part)
 - Part II: Decorated Page-Table
 - Part III: ASI Test Driver and CLI

Part I is similar to RFCv3 [3] with some small bug fixes. Parts II and III
extend the initial patchset: part II introduces decorated page-table in
order to provide convenient page-table management functions, and part III
provides a driver and CLI for testing ASI (using parts I and II).

KVM ASI will come later and will rely on the ASI infrastructure (part I)
and decorated page-table (part II).

Patches are based on v5.7-rc4.

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

Core Scheduling [4] can prevent a malicious VM from attacking another VM
by running the same VM on all CPU threads of a CPU core. However a
malicious VM can still target the host system when the sibling CPU thread
exits the VM and returns to the host.

Address Space Isolation can be applied to KVM to mitigate this VM-to-host
attack by removing secrets from the kernel address space used when running
KVM, thus preventing a malicious VM from collecting any sensitive data
from host.

Address Space Isolation can also be used to implement Page Table Isolation
(PTI [5]) which reduces kernel mappings present in user address spaces to
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
RFCv4:

- Fix crash when booting with PTI disabled
- Fix issue when task using ASI is scheduled-in

RFCv3:

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
[3] ASI RFCv3 - https://lore.kernel.org/lkml/1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com
[4] Core Scheduling - https://lwn.net/Articles/803652
[5] Page Table Isolation (PTI) - https://www.kernel.org/doc/html/latest/x86/pti.html


Thanks,

alex.

-----

Alexandre Chartre (7):
  mm/x86: Introduce kernel Address Space Isolation (ASI)
  mm/asi: ASI entry/exit interface
  mm/asi: Improve TLB flushing when switching to an ASI pagetable
  mm/asi: Interrupt ASI on interrupt/exception/NMI
  mm/asi: Exit/enter ASI when task enters/exits scheduler
  mm/asi: ASI fault handler
  mm/asi: Implement PTI with ASI

 arch/x86/entry/calling.h           |  37 ++-
 arch/x86/entry/common.c            |  29 ++-
 arch/x86/entry/entry_64.S          |  28 ++
 arch/x86/include/asm/asi.h         | 289 +++++++++++++++++++++
 arch/x86/include/asm/asi_session.h |  24 ++
 arch/x86/include/asm/mmu_context.h |  20 +-
 arch/x86/include/asm/tlbflush.h    |  23 +-
 arch/x86/kernel/asm-offsets.c      |   5 +
 arch/x86/mm/Makefile               |   1 +
 arch/x86/mm/asi.c                  | 402 +++++++++++++++++++++++++++++
 arch/x86/mm/fault.c                |  20 ++
 arch/x86/mm/pti.c                  |  28 +-
 include/linux/mm_types.h           |   5 +
 include/linux/sched.h              |   9 +
 kernel/fork.c                      |  17 ++
 kernel/sched/core.c                |  17 ++
 security/Kconfig                   |  10 +
 17 files changed, 946 insertions(+), 18 deletions(-)
 create mode 100644 arch/x86/include/asm/asi.h
 create mode 100644 arch/x86/include/asm/asi_session.h
 create mode 100644 arch/x86/mm/asi.c

-- 
2.18.2

