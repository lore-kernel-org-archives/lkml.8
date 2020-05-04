Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2089C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A77206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fTWY/2CV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgEDPG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:06:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53046 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgEDPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:06:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044En9dc024660;
        Mon, 4 May 2020 15:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=uQjb5JGnLBJ/IzQq/diJ8g0hSMyLwx5kP4DzCTdsCIg=;
 b=fTWY/2CV+bmxfQTo7FJkDTOrCUyfhbtD5CyOVBxc6DpksWzXoWbllnTgZQgUbxAJqOfL
 RKBgHR/SRrfLXM1TnffDlmQxYKHZshRlrSUTPPH6HVtxStm9MvggiWXLDJ+69GCf1p5e
 ugqsfaA1NNZVX/6ENFCmZh9TKMgfWTcQjJAzajhPW5rK6tFJ/6lJv/tPKlG7bcacP092
 pr3yN9gi5gUYA8FrKbEjxLPxB9mEkBYy8LNSGI7yXrntp5V7wzcvHDGnT79/8sKpQqWn
 VaiGSWNCLyGFVAGboTSK6UKcqQDuuM78Kvk4HGzoc9xtB+X8s6all7Ka1yhur+2O/Gx0 eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30s0tm7f5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:06:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Ekejf094671;
        Mon, 4 May 2020 15:04:06 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30sjdqqmr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 15:04:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044F45hL028387;
        Mon, 4 May 2020 15:04:05 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 08:04:04 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-3 00/14] ASI - Part III (ASI Test Driver and CLI)
Date:   Mon,  4 May 2020 17:02:21 +0200
Message-Id: <20200504150235.12171-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part III of ASI RFC v4. Please refer to the cover letter of
part I for an overview the ASI RFC.

  https://lore.kernel.org/lkml/20200504144939.11318-1-alexandre.chartre@oracle.com/

This part provides a driver and a CLI for testing and introspecting an
ASI. The driver creates a test ASI and provide the ability to run some
test sequences on the test ASI such as:

 - a simple enter/exit ASI
 - using printk with ASI
 - access a map or unmapped buffer while in ASI
 - receive an interrupt or NMI while in ASI
 - scheduling in/out a task using ASI

The driver reports if the ASI remains active or not at the end of the
test sequence. It also provides the ability to:

 - query the ASI fault (i.e. places where the ASI had a fault)
 - clear the ASI fault log
 - toggle the reporting of stack trace on an ASI fault
 - query ASI mappings (i.e. VA ranges mapped in the ASI)
 - add an ASI mapping
 - clear an ASI mapping

The asicmd user CLI is provided to interact with the ASI test driver.
More details and examples are provided below for using the asicmd CLI.

Thanks,

alex.

=====

ASI Test Driver and CLI Usage
-----------------------------
The ASI test driver is built as a loadable module (asi.ko) in the
drivers/staging/asi/ directory. You can load it with modprobe or insmod.

The ASI test CLI (asicmd) is built in the drivers/staging/asi/ directory.
The ASI test driver should be loaded before using the asicmd CLI.

Usage:
------
Running the asicmd without arguments will show the different commands
available:

# ./asicmd 
Usage: asicmd (<cmd>|<test>...)

Commands:
  all      - run all tests
  fault    - list ASI faults
  fltclr   - clear ASI faults
  stkon    - show stack on ASI fault
  stkoff   - do not show stack on ASI fault
  map      - list ASI mappings
  mapadd   - add ASI mappings
  mapclr   - clear ASI mapping

Tests:
  nop        - enter/exit ASI and nothing else
  mem        - enter ASI and accessed an unmapped buffer
  memmap     - enter ASI and accessed a mapped buffer
  intr       - receive an interruption while running with ASI
  nmi        - receive a NMI while running with ASI
  intrnmi    - receive a NMI in an interrupt received while running with ASI
  sched      - call schedule() while running with ASI
  printk     - call printk() while running with ASI

Running a Test Sequence:
------------------------
Just specify the test sequence to run. For example, to run the "nop"
test sequence, run "asicmd nop":

  # ./asicmd nop
  Test nop (sequence 0)
    - rv = 0 ; result = 0 ; asi active
    - expect = asi active
  TEST OK

The command reports that the ASI was active at the end of the test
sequence and that this was the expected result. So the test was
successful.

Another example with the "mem" test sequence:

  # ./asicmd mem
  Test mem (sequence 2)
    - rv = 0 ; result = 0 ; asi inactive
    - expect = asi inactive
  TEST OK

This tests sequence access a buffer which is not mapped in ASI so it
causes ASI to exit. The test effectively reports that the ASI was inactive
at the end of the test sequence, but this is the expected result so the
test is successful.

All test sequences can be run with the "all" command: asicmd all

Managing ASI Faults:
--------------------
The asicmd CLI has commands to manage ASI faults i.e. faults that occurred
while running ASI because ASI is accessing an unmapped address:

  - "asicmd fault" reports all ASI faults. It shows the address where the
     fault has occurred and the number of time the fault has occurred.

  - "asicmd fltclr" clears the ASI fault log.

For example, the "mem" will cause an ASI fault and we can see it with the
"fault" command:

  # ./asicmd fltclr

  # ./asicmd fault
  ASI has no fault

  # ./asicmd mem
  Test mem (sequence 2)
    - rv = 0 ; result = 0 ; asi inactive
    - expect = asi inactive
  TEST OK

  # ./asicmd fault
  ADDRESS             COUNT  SYMBOL
  0xffffffffc0515037      1  asidrv_mem_run+0x37/0x7f [asi]


Managing ASI Mappings:
----------------------
The asicmd CLI has commands to manage ASI mappings i.e. address ranges
which are mapped in the ASI page-table:

  - "asicmd map" reports all ASI mappings. It shows the address, size and
    page-table level of the mappings.

  - "asicmd mapadd" adds a mapping to the ASI page-table. The syntax is:

     asicmd mapadd [percpu:]<addr>:<size>[:<level>]

     . <addr> is the start address of the mapping and <size> is its size.
     . <level> is the page-table level of the mapping, either "pte", "pmd",
       "pud", "p4d" or "pgd". By default, the level is "pte".
     . "percpu" should be prepended when <addr> is the offset of a percpu
       buffer

  - "asicmd" mapclr" clears a mapping in the ASI page-table. The syntax is:

     asicmd mapclr [percpu:]<addr>

     . <addr> is the start address of the mapping. The system automatically
       figures out the size and page-table level of the mapping.
     . "percpu" should be prepended when <addr> is the offset of a percpu
       buffer

Example:

  # ./asicmd map
  ADDRESS                           SIZE  LEVEL
  0xffff88806946f000               0x838    PTE
  0xffff88806820a000                0x60    PTE
  0xffffffffc0515000              0x7000    PTE
  0xffff88807ddac4c0                0xa0    PTE
  0xffff88807dd2c4c0                0xa0    PTE
  0xffff88807dcac4c0                0xa0    PTE
  0xffff88807dc2c4c0                0xa0    PTE
  0xffff88807dd98bc0                 0x8    PTE
  0xffff88807dd18bc0                 0x8    PTE
  0xffff88807dc98bc0                 0x8    PTE
  0xffff88807dc18bc0                 0x8    PTE
  0xffff88807dd80000                0x30    PTE
  0xffff88807dd00000                0x30    PTE
  0xffff88807dc80000                0x30    PTE
  0xffff88807dc00000                0x30    PTE
  0xfffffe0000001000        0x8000000000    P4D
  0xffffffff80000000          0x40000000    PTE

This shows the default core mappings for ASI. These mappings shouldn't be
removed.

If the ASI faults then you can add the missing mapping. For example with
the "printk" test sequence:

  # ./asicmd fltclr

  # ./asicmd printk
  Test printk (sequence 1)
    - rv = 0 ; result = 0 ; asi inactive
    - expect = asi active
  TEST FAILED - unexpected ASI state

The "printk" test sequence failed because of an ASI fault:

  # ./asicmd fault
  ADDRESS             COUNT  SYMBOL
  0xffffffff8110b5a1      1  vprintk_func+0x11/0xbc

With the source code or debugger, we can figure out that the fault is due
to printk_context not being mapped in the ASI.

  0xffffffff8110b5a1 <+17>: mov %gs:0x7ef106f8(%rip),%eax  # 0x1bca0 <printk_context>

So we can add the missing mapping into the ASI with "mapadd"; note that
printk_context is a percpu buffer and that sizeof(printk_context) is 4:

  # ./asicmd mapadd percpu:0x1bca0:4
  mapadd 1bca0/4/0 percpu

If we re-run the "printk" test then we got:

  # ./asicmd fltclr

  # ./asicmd printk
  Test printk (sequence 1)
    - rv = 0 ; result = 0 ; asi inactive
    - expect = asi active
  TEST FAILED - unexpected ASI state

  # ./asicmd fault
  ADDRESS             COUNT  SYMBOL
  0xffffffff811081f3      1  log_store.constprop.27+0x1f3/0x280

We still see a new fault but at a difference address (this time because
cpu_number is not mapped).

-----

Alexandre Chartre (14):
  mm/asi: Define the test ASI type
  asidrv: Introduce the ASI driver
  asidrv: Introduce the ASIDRV_IOCTL_RUN_SEQUENCE ioctl
  asidrv: Sequence to test ASI access to mapped/unmapped memory
  asidrv: Sequence to test interrupt on ASI
  asidrv: Sequence to test NMI on ASI
  asidrv: Sequence to test interrupt+NMI on ASI
  asidrv: Sequence to test scheduling in/out with ASI
  asidrv: Add ioctls to manage ASI page faults
  asidrv: Add ioctls to manage ASI mapped VA ranges
  asidrv/asicmd: Introduce the asicmd command
  asidrv/asicmd: Add more test sequences for testing ASI
  asidrv/asicmd: Add options to manage ASI page faults
  asidrv/asicmd: Add options to manage ASI mapped VA ranges

 arch/x86/include/asm/asi.h   |    2 +
 arch/x86/mm/asi.c            |    1 +
 drivers/staging/Makefile     |    1 +
 drivers/staging/asi/Makefile |   13 +
 drivers/staging/asi/asicmd.c |  439 ++++++++++++++
 drivers/staging/asi/asidrv.c | 1077 ++++++++++++++++++++++++++++++++++
 drivers/staging/asi/asidrv.h |  102 ++++
 7 files changed, 1635 insertions(+)
 create mode 100644 drivers/staging/asi/Makefile
 create mode 100644 drivers/staging/asi/asicmd.c
 create mode 100644 drivers/staging/asi/asidrv.c
 create mode 100644 drivers/staging/asi/asidrv.h

-- 
2.18.2

