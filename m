Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8496C54E49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A520731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="diw/IWbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgEJILr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 04:11:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52044 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgEJILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 04:11:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04A845mj075357;
        Sun, 10 May 2020 08:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/edeKJ5X/n1yAWdHh0wNsgof8vQrxThL+vY2z/T8gNo=;
 b=diw/IWbYJje1a7DPWh3Ic/Zvw9EysteSuitNqUe+wBc6SFoE/1v+ZU/zubFjbvf8FhvT
 /fv6neeMKem7wmD3sKEhWS8lCYR+yQXdePyR8uhB3V1tC4TzweOGa33zQxWFoC2uzyHe
 rlppmJxcqUnhsIImFszoAgOzoiziS0FfknrdVr2GFuRJNx8fC0kP0rBXstksWzOORgxY
 7vZi7AfxDiGh3Y7IZmA/2B11GZbw+Wdt1QHdOG/+S7Lnj9VEJqGmGljVxZ0aQPcMnmTQ
 ATdvEs2oJsIJqZCZNgweSo8W6//1NZ2PtfMstPdwse7/2GmJxXQuNnmCVMg9E0jpjBvI pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30x3mbgxag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 08:11:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04A89NF1050200;
        Sun, 10 May 2020 08:09:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30x63ja6qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 08:09:23 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04A89H2u025622;
        Sun, 10 May 2020 08:09:17 GMT
Received: from [10.175.202.229] (/10.175.202.229)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 May 2020 01:09:17 -0700
Subject: Re: [PATCH v10 00/18] Enable FSGSBASE instructions
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, luto@kernel.org
Cc:     tony.luck@intel.com, ak@linux.intel.com, chang.seok.bae@intel.com
References: <20200423232207.5797-1-sashal@kernel.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <5a6a0ef5-4dfc-d0b1-9181-5df4211cfcd9@oracle.com>
Date:   Sun, 10 May 2020 10:09:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200423232207.5797-1-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9616 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9616 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/20 1:21 AM, Sasha Levin wrote:
> Benefits:
> Currently a user process that wishes to read or write the FS/GS base must
> make a system call. But recent X86 processors have added new instructions
> for use in 64-bit mode that allow direct access to the FS and GS segment
> base addresses.  The operating system controls whether applications can
> use these instructions with a %cr4 control bit.
> 
> In addition to benefits to applications, performance improvements to the
> OS context switch code are possible by making use of these instructions. A
> third party reported out promising performance numbers out of their
> initial benchmarking of the previous version of this patch series [9].
> 
> Enablement check:
> The kernel provides information about the enabled state of FSGSBASE to
> applications using the ELF_AUX vector. If the HWCAP2_FSGSBASE bit is set in
> the AUX vector, the kernel has FSGSBASE instructions enabled and
> applications can use them.
> 
> Kernel changes:
> Major changes made in the kernel are in context switch, paranoid path, and
> ptrace. In a context switch, a task's FS/GS base will be secured regardless
> of its selector. In the paranoid path, GS base is unconditionally
> overwritten to the kernel GS base on entry and the original GS base is
> restored on exit. Ptrace includes divergence of FS/GS index and base
> values.
> 
> Security:
> For mitigating the Spectre v1 SWAPGS issue, LFENCE instructions were added
> on most kernel entries. Those patches are dependent on previous behaviors
> that users couldn't load a kernel address into the GS base. These patches
> change that assumption since the user can load any address into GS base.
> The changes to the kernel entry path in this patch series take account of
> the SWAPGS issue.
> 
> Changes from v9:
> 
>   - Rebase on top of v5.7-rc1 and re-test.
>   - Work around changes in 2fff071d28b5 ("x86/process: Unify
>     copy_thread_tls()").
>   - Work around changes in c7ca0b614513 ("Revert "x86/ptrace: Prevent
>     ptrace from clearing the FS/GS selector" and fix the test").
> 
>   
> 
> Andi Kleen (2):
>    x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
>    x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
> 
> Andy Lutomirski (4):
>    x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
>    x86/entry/64: Clean up paranoid exit
>    x86/fsgsbase/64: Use FSGSBASE in switch_to() if available
>    x86/fsgsbase/64: Enable FSGSBASE on 64bit by default and add a chicken
>      bit
> 
> Chang S. Bae (9):
>    x86/ptrace: Prevent ptrace from clearing the FS/GS selector
>    selftests/x86/fsgsbase: Test GS selector on ptracer-induced GS base
>      write
>    x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
>    x86/entry/64: Introduce the FIND_PERCPU_BASE macro
>    x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit
>    x86/entry/64: Document GSBASE handling in the paranoid path
>    x86/fsgsbase/64: Enable FSGSBASE instructions in helper functions
>    x86/fsgsbase/64: Use FSGSBASE instructions on thread copy and ptrace
>    selftests/x86/fsgsbase: Test ptracer-induced GS base write with
>      FSGSBASE
> 
> Sasha Levin (1):
>    x86/fsgsbase/64: move save_fsgs to header file
> 
> Thomas Gleixner (1):
>    Documentation/x86/64: Add documentation for GS/FS addressing mode
> 
> Tony Luck (1):
>    x86/speculation/swapgs: Check FSGSBASE in enabling SWAPGS mitigation
> 
>   .../admin-guide/kernel-parameters.txt         |   2 +
>   Documentation/x86/entry_64.rst                |   9 +
>   Documentation/x86/x86_64/fsgs.rst             | 199 ++++++++++++++++++
>   Documentation/x86/x86_64/index.rst            |   1 +
>   arch/x86/entry/calling.h                      |  40 ++++
>   arch/x86/entry/entry_64.S                     | 131 +++++++++---
>   arch/x86/include/asm/fsgsbase.h               |  45 +++-
>   arch/x86/include/asm/inst.h                   |  15 ++
>   arch/x86/include/uapi/asm/hwcap2.h            |   3 +
>   arch/x86/kernel/cpu/bugs.c                    |   6 +-
>   arch/x86/kernel/cpu/common.c                  |  22 ++
>   arch/x86/kernel/process.c                     |  10 +-
>   arch/x86/kernel/process.h                     |  69 ++++++
>   arch/x86/kernel/process_64.c                  | 142 +++++++------
>   arch/x86/kernel/ptrace.c                      |  17 +-
>   tools/testing/selftests/x86/fsgsbase.c        |  24 ++-
>   16 files changed, 606 insertions(+), 129 deletions(-)
>   create mode 100644 Documentation/x86/x86_64/fsgs.rst

So FWIW I've done some overnight fuzz testing of this patch set and
haven't seen any problems. Will try a couple of other kernel configs too.


Vegard
