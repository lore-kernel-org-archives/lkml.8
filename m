Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE25C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D467207CD
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 13:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JF+al2Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgH0NoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 09:44:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbgH0NiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:38:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RCXfeg084305;
        Thu, 27 Aug 2020 09:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CAFv2blrdNVkba2GOU5DWldysApaKSbTk/ljao+durg=;
 b=JF+al2ZvL3YkBcPuoxv+nADJ2fqTrMsGBQAjK/9dNocfEyyUTISFGggha3CYPYSVVb4d
 6SsdAu5oIYml1C9hSQICq1PHXeAI6Q000rW+1wT4/512mKV9Cw/B3govQ568XkwTBohQ
 +81kA6fHCniAcbMp0xCd+JS8ispbT2Iqvx7pn2v/K+Z5APf70CqBltOTh9FgKY6UGXtm
 yHDedugRMwbYisBa0pbbu8fIGXVcK0ms0bWpjNZNcyfosHg/mpsRHt97R3XMTALxy+YO
 /YBAXlGOg98wMn/e1tIF7Rxv5IUd7mV4haOnRigWIhKsIEPx7zzVpREEihiUb4EgbfE+ 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336cddj1d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:02:54 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07RCacri094991;
        Thu, 27 Aug 2020 09:02:53 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336cddj1ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 09:02:53 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07RD1kTL007144;
        Thu, 27 Aug 2020 13:02:52 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 332utu4jav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 13:02:52 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07RD2pdc52494676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 13:02:52 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D88CCAE05F;
        Thu, 27 Aug 2020 13:02:51 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6897AAE060;
        Thu, 27 Aug 2020 13:02:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.210.202])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Aug 2020 13:02:46 +0000 (GMT)
Subject: Re: [perf/core] 16fb162e78:
 WARNING:at_kernel/events/core.c:#list_add_event
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com,
        0day robot <lkp@intel.com>, lkp@lists.01.org
References: <20200827083757.GQ4299@shao2-debian>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <bd699fba-7227-c18f-3d05-919b7876ae6f@linux.ibm.com>
Date:   Thu, 27 Aug 2020 18:32:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200827083757.GQ4299@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_07:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/20 2:07 PM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 16fb162e7868b8f3c1fc09ef0d683c9554cb6404 ("[RFC] perf/core: Fixes hung issue on perf stat command during cpu hotplug")
> url: https://github.com/0day-ci/linux/commits/Kajol-Jain/perf-core-Fixes-hung-issue-on-perf-stat-command-during-cpu-hotplug/20200826-173643
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 2cb5383b30d47c446ec7d884cd80f93ffcc31817
> 

Hi Rong Chen,
	Thanks for checking. Actually this is old patch, I recently send new updated patch.
Please let me know if in this patch also you are seeing same issue.

Link to the patch: https://lkml.org/lkml/2020/8/27/101

Thanks,
Kajol Jain

> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-------------------------------------------------+------------+------------+
> |                                                 | 2cb5383b30 | 16fb162e78 |
> +-------------------------------------------------+------------+------------+
> | boot_successes                                  | 4          | 0          |
> | boot_failures                                   | 0          | 8          |
> | WARNING:at_kernel/events/core.c:#list_add_event | 0          | 8          |
> | EIP:list_add_event                              | 0          | 8          |
> | kernel_BUG_at_lib/list_debug.c                  | 0          | 8          |
> | invalid_opcode:#[##]                            | 0          | 8          |
> | EIP:__list_add_valid                            | 0          | 8          |
> | Kernel_panic-not_syncing:Fatal_exception        | 0          | 8          |
> +-------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   97.084211] WARNING: CPU: 0 PID: 593 at kernel/events/core.c:1807 list_add_event+0x29e/0x4b0
> [   97.086779] Modules linked in:
> [   97.087756] CPU: 0 PID: 593 Comm: trinity-main Not tainted 5.9.0-rc1-00012-g16fb162e7868b #1
> [   97.089783] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   97.091980] EIP: list_add_event+0x29e/0x4b0
> [   97.093322] Code: ef c2 c4 01 83 15 44 ef c2 c4 00 8b 43 60 a8 01 0f 84 9a fd ff ff 8d b6 00 00 00 00 83 05 48 ef c2 c4 01 83 15 4c ef c2 c4 00 <0f> 0b 83 05 50 ef c2 c4 01 83 15 54 ef c2 c4 00 e9 71 fd ff ff 8d
> [   97.097789] EAX: 00000007 EBX: eee48000 ECX: 00000001 EDX: ee125280
> [   97.099297] ESI: eeebe200 EDI: 00000001 EBP: eee67dfc ESP: eee67dec
> [   97.101008] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010046
> [   97.106936] CR0: 80050033 CR2: 08dfc000 CR3: 2e0bb000 CR4: 00040690
> [   97.108599] Call Trace:
> [   97.109457]  __perf_install_in_context+0x286/0x3e0
> [   97.110759]  remote_function+0x79/0x90
> [   97.111897]  generic_exec_single+0xc3/0x190
> [   97.113101]  smp_call_function_single+0x1a3/0x2d0
> [   97.114364]  ? bpf_fd_reuseport_array_update_elem+0x300/0x300
> [   97.115866]  task_function_call+0x87/0xc0
> [   97.117025]  ? __perf_event_enable+0x740/0x740
> [   97.118248]  perf_install_in_context+0x110/0x450
> [   97.119540]  __do_sys_perf_event_open+0x13cb/0x1ed0
> [   97.120833]  __ia32_sys_perf_event_open+0x24/0x40
> [   97.122097]  __do_fast_syscall_32+0x99/0x110
> [   97.123213]  do_fast_syscall_32+0x37/0x130
> [   97.124409]  do_SYSENTER_32+0x23/0x40
> [   97.125470]  entry_SYSENTER_32+0xb0/0x10d
> [   97.126592] EIP: 0xb7f11549
> [   97.127449] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> [   97.131832] EAX: ffffffda EBX: 08e38318 ECX: 00000000 EDX: ffffffff
> [   97.137556] ESI: ffffffff EDI: 00000002 EBP: 6d656d83 ESP: bfa804ec
> [   97.139119] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000286
> [   97.140732] ---[ end trace 57d55e687e8b0e41 ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.9.0-rc1-00012-g16fb162e7868b .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 
