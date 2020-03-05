Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763A6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE45C208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCENAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:00:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:64641 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgCENAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:00:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 05:00:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="xz'?yaml'?scan'208";a="232936755"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga007.fm.intel.com with ESMTP; 05 Mar 2020 05:00:30 -0800
Date:   Thu, 5 Mar 2020 21:00:19 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Brian Gerst <brgerst@gmail.com>, lkp@lists.01.org
Subject: [x86, syscalls] dadb1ee70c:
 perf-sanity-tests.Read_samples_using_the_mmap_interface.fail
Message-ID: <20200305130019.GK5972@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="D6z0c4W1rkZNF4Vu"
Content-Disposition: inline
In-Reply-To: <20200227132826.195669-3-brgerst@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

FYI, we noticed the following commit (built with gcc-7):

commit: dadb1ee70cb88e0f211dade207fa639a9e66ba27 ("[PATCH v3 2/8] x86, syscalls: Refactor SYSCALL_DEFINE0 macros")
url: https://github.com/0day-ci/linux/commits/Brian-Gerst/Enable-pt_regs-based-syscalls-for-x86-32-native/20200228-151724


in testcase: perf-sanity-tests
with following parameters:

	perf_compiler: gcc
	ucode: 0x27



on test machine: 8 threads Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz with 6G memory

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <rong.a.chen@intel.com>



2020-03-05 10:16:12 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 1
 1: vmlinux symtab matches kallsyms                       : Ok
2020-03-05 10:16:12 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 2
 2: Detect openat syscall event                           : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 3
 3: Detect openat syscall event on all cpus               : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 4
 4: Read samples using the mmap interface                 : FAILED!
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 5
 5: Test data source output                               : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 6
 6: Parse event definition strings                        : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 7
 7: Simple expression parser                              : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 8
 8: PERF_RECORD_* events & perf_sample fields             : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 9
 9: Parse perf pmu format                                 : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 10
10: DSO data read                                         : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 11
11: DSO data cache                                        : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 12
12: DSO data reopen                                       : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 13
13: Roundtrip evsel->name                                 : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 14
14: Parse sched tracepoints fields                        : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 15
15: syscalls:sys_enter_openat event fields                : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 16
16: Setup struct perf_event_attr                          : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 17
17: Match and link multiple hists                         : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 18
18: 'import perf' in python                               : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 19
19: Breakpoint overflow signal handler                    : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 20
20: Breakpoint overflow sampling                          : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 21
21: Breakpoint accounting                                 : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 22
22: Watchpoint                                            :
22.1: Read Only Watchpoint                                : Skip
22.2: Write Only Watchpoint                               : Ok
22.3: Read / Write Watchpoint                             : Ok
22.4: Modify Watchpoint                                   : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 23
23: Number of exit events of a simple workload            : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 24
24: Software clock events period values                   : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 25
25: Object code reading                                   : Ok
2020-03-05 10:16:20 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 26
26: Sample parsing                                        : Ok
2020-03-05 10:16:20 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 27
27: Use a dummy software event to keep tracking           : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 28
28: Parse with no sample_id_all bit set                   : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 29
29: Filter hist entries                                   : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 30
30: Lookup mmap thread                                    : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 31
31: Share thread maps                                     : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 32
32: Sort output of hist entries                           : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 33
33: Cumulate child hist entries                           : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 34
34: Track with sched_switch                               : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 35
35: Filter fds with revents mask in a fdarray             : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 36
36: Add fd to a fdarray, making it autogrow               : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 37
37: kmod_path__parse                                      : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 38
38: Thread map                                            : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 40
40: Session topology                                      : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 42
42: Synthesize thread map                                 : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 43
43: Remove thread map                                     : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 44
44: Synthesize cpu map                                    : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 45
45: Synthesize stat config                                : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 46
46: Synthesize stat                                       : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 47
47: Synthesize stat round                                 : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 48
48: Synthesize attr update                                : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 49
49: Event times                                           : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 50
50: Read backward ring buffer                             : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 51
51: Print cpu map                                         : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 52
52: Merge cpu map                                         : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 53
53: Probe SDT events                                      : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 54
54: is_printable_array                                    : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 55
55: Print bitmap                                          : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 56
56: perf hooks                                            : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 58
58: unit_number__scnprintf                                : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 59
59: mem2node                                              : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 60
60: time utils                                            : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 61
61: Test jit_write_elf                                    : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 62
62: maps__merge_in                                        : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 63
63: x86 rdpmc                                             : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 64
64: Convert perf time to TSC                              : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 65
65: DWARF unwind                                          : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 66
66: x86 instruction decoder - new instructions            : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 67
67: Intel PT packet decoder                               : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 68
68: x86 bp modify                                         : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 69
69: probe libc's inet_pton & backtrace it with ping       : Ok
2020-03-05 10:16:23 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 73
73: Zstd perf.data compression/decompression              : Ok



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Rong Chen


--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.6.0-rc3-00277-gdadb1ee70cb88"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.6.0-rc3 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70500
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_MPTCP_IPV6=y
# CONFIG_MPTCP_HMAC_TEST is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_CT is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_SFP is not set
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM84881_PHY is not set
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
CONFIG_SPI_PXA2XX=m
CONFIG_SPI_PXA2XX_PCI=m
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_SPIN_REQUEST=5
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
# CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH is not set
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
# CONFIG_STAGING_EXFAT_FS is not set
CONFIG_QLGE=m
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_SYSTEM76_ACPI is not set
CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_INTEL_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=m
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_FS=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KCSAN=y
# CONFIG_KCSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='perf-sanity-tests'
	export testcase='perf-sanity-tests'
	export category='functional'
	export need_memory='2G'
	export job_origin='/lkp/lkp/.src-20200229-230846/allot/cyclic:p2:linux-devel:devel-hourly/lkp-hsw-d02/perf-sanity-tests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-hsw-d02'
	export tbox_group='lkp-hsw-d02'
	export submit_id='5e60c881b369ab1c446f5c4f'
	export job_file='/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-gcc-ucode=0x27-debian-x86_64-20191114.cgz-dadb1ee70cb88e0f211dade207fa639a9e66ba27-20200305-7236-1jxex80-8.yaml'
	export id='d453b892db7944428bf596824a4651fdad34072c'
	export queuer_version='/lkp-src'
	export model='Haswell'
	export nr_node=1
	export nr_cpu=8
	export memory='6G'
	export ssd_partitions=
	export swap_partitions='LABEL=SWAP'
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export brand='Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz'
	export LKP_SERVER='10.239.97.5'
	export avoid_nfs=1
	export result_service='tmpfs'
	export need_linux_perf=true
	export commit='dadb1ee70cb88e0f211dade207fa639a9e66ba27'
	export ucode='0x27'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export enqueue_time='2020-03-05 17:38:12 +0800'
	export _id='5e60c884b369ab1c446f5c56'
	export _rt='/result/perf-sanity-tests/gcc-ucode=0x27/lkp-hsw-d02/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27'
	export user='lkp'
	export head_commit='0a2eb89fc4c694dc70ad3ef879c102d8a3b03c84'
	export base_commit='f8788d86ab28f61f7b46eb6be375f8a726783636'
	export branch='linux-devel/devel-hourly-2020030115'
	export rootfs='debian-x86_64-20191114.cgz'
	export result_root='/result/perf-sanity-tests/gcc-ucode=0x27/lkp-hsw-d02/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/8'
	export scheduler_version='/lkp/lkp/.src-20200305-143804'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-x86_64-20191114.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-gcc-ucode=0x27-debian-x86_64-20191114.cgz-dadb1ee70cb88e0f211dade207fa639a9e66ba27-20200305-7236-1jxex80-8.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2020030115
commit=dadb1ee70cb88e0f211dade207fa639a9e66ba27
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/vmlinuz-5.6.0-rc3-00277-gdadb1ee70cb88
max_uptime=3600
RESULT_ROOT=/result/perf-sanity-tests/gcc-ucode=0x27/lkp-hsw-d02/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/8
LKP_SERVER=10.239.97.5
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf-sanity-tests_2019-12-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-98d54f81e36b-1_20200302.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rootfs_2019-08-20.cgz'
	export linux_perf_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/linux-perf.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.6.0-rc3-06959-g0a2eb89fc4c69'
	export repeat_to=14
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/vmlinuz-5.6.0-rc3-00277-gdadb1ee70cb88'
	export dequeue_time='2020-03-05 17:54:19 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-gcc-ucode=0x27-debian-x86_64-20191114.cgz-dadb1ee70cb88e0f211dade207fa639a9e66ba27-20200305-7236-1jxex80-8.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test perf_compiler='gcc' $LKP_SRC/tests/wrapper perf-sanity-tests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper perf-sanity-tests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time perf-sanity-tests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--D6z0c4W1rkZNF4Vu
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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
AAGH8gHH9wvSumcSscRn+wIAAAAABFla

--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=perf-sanity-tests
Content-Transfer-Encoding: quoted-printable

2020-03-05 10:15:47 make ARCH=3D -C /usr/src/perf_selftests-x86_64-rhel-7.6=
-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70=
cb88e0f211dade207fa639a9e66ba27/tools/perf'
  BUILD:   Doing 'make =1B[33m-j8=1B[m' parallel build
  HOSTCC   fixdep.o
  HOSTLD   fixdep-in.o
  LINK     fixdep
diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event=
=2Eh
diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufe=
atures.h
diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-ind=
ex.h
diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm=
=2Eh

Auto-detecting system features:
=2E..                         dwarf: [ =1B[32mon=1B[m  ]
=2E..            dwarf_getlocations: [ =1B[32mon=1B[m  ]
=2E..                         glibc: [ =1B[32mon=1B[m  ]
=2E..                          gtk2: [ =1B[32mon=1B[m  ]
=2E..                      libaudit: [ =1B[32mon=1B[m  ]
=2E..                        libbfd: [ =1B[32mon=1B[m  ]
=2E..                        libcap: [ =1B[32mon=1B[m  ]
=2E..                        libelf: [ =1B[32mon=1B[m  ]
=2E..                       libnuma: [ =1B[32mon=1B[m  ]
=2E..        numa_num_possible_cpus: [ =1B[32mon=1B[m  ]
=2E..                       libperl: [ =1B[32mon=1B[m  ]
=2E..                     libpython: [ =1B[32mon=1B[m  ]
=2E..                     libcrypto: [ =1B[32mon=1B[m  ]
=2E..                     libunwind: [ =1B[32mon=1B[m  ]
=2E..            libdw-dwarf-unwind: [ =1B[32mon=1B[m  ]
=2E..                          zlib: [ =1B[32mon=1B[m  ]
=2E..                          lzma: [ =1B[32mon=1B[m  ]
=2E..                     get_cpuid: [ =1B[32mon=1B[m  ]
=2E..                           bpf: [ =1B[32mon=1B[m  ]
=2E..                        libaio: [ =1B[32mon=1B[m  ]
=2E..                       libzstd: [ =1B[32mon=1B[m  ]
=2E..        disassembler-four-args: [ =1B[31mOFF=1B[m ]

  GEN      common-cmds.h
  CC       exec-cmd.o
  CC       fd/array.o
  CC       event-parse.o
  GEN      bpf_helper_defs.h
  CC       core.o
  CC       fs/fs.o
  LD       fd/libapi-in.o
  CC       help.o
  MKDIR    staticobjs/
  CC       staticobjs/libbpf.o
  CC       cpumap.o
  CC       pager.o
  CC       fs/tracing_path.o
  LD       fs/libapi-in.o
  CC       cpu.o
  CC       debug.o
  CC       parse-options.o
  CC       str_error_r.o
  CC       run-command.o
  LD       libapi-in.o
  AR       libapi.a
  CC       threadmap.o
  CC       event-plugin.o
  CC       sigchain.o
  MKDIR    staticobjs/
  CC       staticobjs/bpf.o
  CC       trace-seq.o
  CC       subcmd-config.o
  CC       evsel.o
  CC       staticobjs/nlattr.o
  CC       parse-filter.o
  CC       staticobjs/btf.o
  CC       parse-utils.o
  CC       staticobjs/libbpf_errno.o
  CC       evlist.o
  CC       mmap.o
  LD       libsubcmd-in.o
  CC       kbuffer-parse.o
  AR       libsubcmd.a
  CC       staticobjs/str_error.o
  CC       staticobjs/netlink.o
  CC       tep_strerror.o
  CC       staticobjs/bpf_prog_linfo.o
  CC       staticobjs/libbpf_probes.o
  CC       event-parse-api.o
  CC       staticobjs/xsk.o
  CC       staticobjs/hashmap.o
  LD       libtraceevent-in.o
  CC       staticobjs/btf_dump.o
  CC       zalloc.o
  LINK     libtraceevent.a
  CC       xyarray.o
  HOSTCC   pmu-events/json.o
  GEN      perf-archive
  CC       lib.o
  HOSTCC   pmu-events/jsmn.o
  DESCEND  plugins
  CC       plugin_jbd2.o
  HOSTCC   pmu-events/jevents.o
  GEN      perf-with-kcore
  CC       plugin_hrtimer.o
  CC       plugin_kmem.o
  LD       staticobjs/libbpf-in.o
  LINK     libbpf.a
  LD       plugin_jbd2-in.o
  CC       plugin_kvm.o
  CC       ui/gtk/browser.o
  CC       plugin_mac80211.o
  LD       libperf-in.o
  AR       libperf.a
  LD       plugin_mac80211-in.o
  CC       ui/gtk/hists.o
  LD       plugin_kmem-in.o
  LD       plugin_hrtimer-in.o
  CC       plugin_sched_switch.o
  CC       plugin_function.o
  CC       plugin_xen.o
  LD       plugin_kvm-in.o
  HOSTLD   pmu-events/jevents-in.o
  CC       plugin_cfg80211.o
  CC       plugin_scsi.o
  LD       plugin_sched_switch-in.o
  LINK     plugin_jbd2.so
  LINK     plugin_hrtimer.so
  LD       plugin_cfg80211-in.o
  LD       plugin_xen-in.o
  LD       plugin_function-in.o
  LINK     plugin_mac80211.so
  LINK     plugin_kvm.so
  LINK     plugin_kmem.so
  LINK     plugin_sched_switch.so
  LINK     plugin_function.so
  LINK     plugin_xen.so
  LINK     plugin_cfg80211.so
  LD       plugin_scsi-in.o
  LINK     pmu-events/jevents
  LINK     plugin_scsi.so
  CC       ui/gtk/util.o
  CC       ui/gtk/setup.o
  CC       ui/gtk/helpline.o
  GEN      libtraceevent-dynamic-list
  GEN      pmu-events/pmu-events.c
make[3]: Nothing to be done for 'plugins/libtraceevent-dynamic-list'.
  GEN      python/perf.so
  CC       pmu-events/pmu-events.o
  CC       ui/gtk/progress.o
  CC       builtin-bench.o
  CC       ui/gtk/annotate.o
  CC       ui/gtk/zalloc.o
  CC       builtin-annotate.o
  CC       builtin-config.o
  CC       builtin-diff.o
  CC       builtin-evlist.o
  LD       pmu-events/pmu-events-in.o
  CC       builtin-help.o
  CC       builtin-ftrace.o
  CC       builtin-buildid-list.o
  CC       builtin-sched.o
  CC       builtin-buildid-cache.o
  LD       ui/gtk/gtk-in.o
  LD       gtk-in.o
  CC       builtin-kallsyms.o
  CC       builtin-list.o
  LINK     libperf-gtk.so
  CC       builtin-record.o
  CC       builtin-report.o
  CC       builtin-stat.o
  CC       builtin-timechart.o
  CC       builtin-top.o
  CC       builtin-script.o
  CC       builtin-kmem.o
  CC       builtin-lock.o
  CC       builtin-kvm.o
  CC       builtin-inject.o
  CC       builtin-mem.o
  CC       builtin-data.o
  CC       builtin-version.o
  CC       builtin-c2c.o
  CC       builtin-trace.o
  CC       builtin-probe.o
  CC       bench/sched-messaging.o
  CC       bench/sched-pipe.o
  CC       bench/mem-functions.o
  CC       bench/futex-hash.o
  CC       tests/builtin-test.o
  CC       bench/futex-wake.o
  CC       tests/parse-events.o
  CC       util/annotate.o
  CC       bench/futex-wake-parallel.o
  CC       tests/dso-data.o
  CC       bench/futex-requeue.o
  CC       util/block-info.o
  CC       bench/futex-lock-pi.o
  CC       tests/attr.o
  CC       tests/vmlinux-kallsyms.o
  CC       bench/epoll-wait.o
  CC       tests/openat-syscall.o
  CC       util/block-range.o
  CC       tests/openat-syscall-all-cpus.o
  CC       bench/epoll-ctl.o
  CC       arch/common.o
  CC       tests/openat-syscall-tp-fields.o
  CC       tests/mmap-basic.o
  CC       bench/mem-memcpy-x86-64-lib.o
  CC       util/build-id.o
  CC       tests/perf-record.o
  CC       arch/x86/util/header.o
  CC       bench/mem-memcpy-x86-64-asm.o
  CC       bench/mem-memset-x86-64-asm.o
  CC       bench/numa.o
  CC       tests/evsel-roundtrip-name.o
  CC       arch/x86/util/tsc.o
  CC       tests/evsel-tp-sched.o
  CC       arch/x86/util/pmu.o
  CC       tests/fdarray.o
  CC       arch/x86/util/kvm-stat.o
  CC       tests/pmu.o
  CC       tests/hists_common.o
  CC       arch/x86/util/perf_regs.o
  CC       tests/hists_link.o
  CC       arch/x86/util/group.o
  CC       util/cacheline.o
  CC       tests/hists_filter.o
  CC       util/config.o
  CC       arch/x86/util/machine.o
  CC       arch/x86/tests/regs_load.o
  CC       tests/hists_output.o
  CC       arch/x86/tests/dwarf-unwind.o
  CC       arch/x86/util/event.o
  CC       ui/setup.o
  CC       tests/hists_cumulate.o
  CC       arch/x86/tests/arch-tests.o
  LD       bench/perf-in.o
  CC       arch/x86/util/dwarf-regs.o
  CC       arch/x86/tests/rdpmc.o
  CC       scripts/perl/Perf-Trace-Util/Context.o
  CC       ui/helpline.o
  CC       arch/x86/util/unwind-libunwind.o
  CC       arch/x86/util/auxtrace.o
  CC       ui/progress.o
  CC       arch/x86/tests/perf-time-to-tsc.o
  CC       util/copyfile.o
  CC       ui/util.o
  CC       arch/x86/util/archinsn.o
  CC       tests/python-use.o
  CC       util/ctype.o
  CC       ui/hist.o
  CC       util/db-export.o
  CC       tests/bp_signal.o
  CC       arch/x86/tests/insn-x86.o
  CC       arch/x86/util/intel-pt.o
  CC       trace/beauty/clone.o
  LD       scripts/perl/Perf-Trace-Util/perf-in.o
  CC       scripts/python/Perf-Trace-Util/Context.o
  CC       tests/bp_signal_overflow.o
  CC       trace/beauty/fcntl.o
  CC       arch/x86/tests/intel-pt-pkt-decoder-test.o
  CC       trace/beauty/flock.o
  LD       scripts/python/Perf-Trace-Util/perf-in.o
  LD       scripts/perf-in.o
  CC       arch/x86/tests/bp-modify.o
  CC       perf.o
  CC       util/env.o
  CC       trace/beauty/fsmount.o
  CC       tests/bp_account.o
  CC       trace/beauty/fspick.o
  LD       arch/x86/tests/perf-in.o
  CC       trace/beauty/ioctl.o
  CC       arch/x86/util/intel-bts.o
  CC       tests/wp.o
  CC       trace/beauty/kcmp.o
  CC       ui/stdio/hist.o
  CC       util/event.o
  CC       tests/task-exit.o
  CC       tests/sw-clock.o
  CC       trace/beauty/mount_flags.o
  LD       arch/x86/util/perf-in.o
  LD       arch/x86/perf-in.o
  CC       tests/mmap-thread-lookup.o
  LD       arch/perf-in.o
  CC       util/evlist.o
  CC       trace/beauty/move_mount.o
  CC       tests/thread-maps-share.o
  CC       trace/beauty/pkey_alloc.o
  CC       tests/switch-tracking.o
  CC       trace/beauty/arch_prctl.o
  CC       tests/keep-tracking.o
  CC       trace/beauty/prctl.o
  CC       util/evsel.o
  CC       ui/browser.o
  CC       util/evsel_fprintf.o
  CC       trace/beauty/renameat.o
  CC       tests/code-reading.o
  CC       ui/browsers/annotate.o
  CC       trace/beauty/sockaddr.o
  CC       ui/tui/setup.o
  CC       tests/sample-parsing.o
  CC       trace/beauty/socket.o
  CC       ui/tui/util.o
  CC       trace/beauty/statx.o
  CC       ui/browsers/hists.o
  CC       trace/beauty/sync_file_range.o
  CC       util/perf_event_attr_fprintf.o
  CC       tests/parse-no-sample-id-all.o
  CC       util/evswitch.o
  CC       ui/tui/helpline.o
  CC       ui/browsers/map.o
  CC       trace/beauty/tracepoints/x86_irq_vectors.o
  CC       util/find_bit.o
  CC       tests/kmod-path.o
  CC       trace/beauty/tracepoints/x86_msr.o
  CC       ui/tui/progress.o
  LD       trace/beauty/tracepoints/perf-in.o
  CC       ui/browsers/scripts.o
  LD       trace/beauty/perf-in.o
  CC       tests/thread-map.o
  LD       ui/tui/perf-in.o
  CC       ui/browsers/header.o
  CC       util/get_current_dir_name.o
  CC       util/kallsyms.o
  CC       util/levenshtein.o
  CC       tests/llvm.o
  CC       tests/bpf.o
  CC       ui/browsers/res_sample.o
  CC       util/llvm-utils.o
  CC       util/mmap.o
  CC       tests/topology.o
  CC       tests/mem.o
  CC       tests/cpumap.o
  CC       tests/stat.o
  CC       util/memswap.o
  BISON    util/parse-events-bison.c
  CC       tests/event_update.o
  CC       tests/event-times.o
  CC       tests/expr.o
  CC       util/perf_regs.o
  CC       util/path.o
  CC       tests/backward-ring-buffer.o
  CC       tests/sdt.o
  CC       tests/is_printable_array.o
  CC       util/print_binary.o
  CC       util/rlimit.o
  CC       tests/perf-hooks.o
  CC       util/argv_split.o
  CC       tests/bitmap.o
  CC       tests/clang.o
  CC       tests/unit_number__scnprintf.o
  CC       util/rbtree.o
  CC       tests/mem2node.o
  CC       util/bitmap.o
  CC       util/libstring.o
  CC       tests/maps.o
  CC       util/hweight.o
  CC       tests/time-utils-test.o
  CC       util/smt.o
  CC       tests/genelf.o
  CC       util/strbuf.o
  CC       util/string.o
  CC       tests/dwarf-unwind.o
  CC       util/strlist.o
  CC       tests/llvm-src-base.o
  CC       util/strfilter.o
  CC       util/top.o
  CC       util/usage.o
  CC       tests/llvm-src-kbuild.o
  CC       tests/llvm-src-prologue.o
  CC       util/dso.o
  CC       tests/llvm-src-relocation.o
  CC       util/dsos.o
  CC       util/symbol.o
  CC       util/symbol_fprintf.o
  LD       tests/perf-in.o
  CC       util/color.o
  CC       util/color_config.o
  CC       util/metricgroup.o
  CC       util/header.o
  CC       util/callchain.o
  CC       util/values.o
  CC       util/debug.o
  CC       util/fncache.o
  CC       util/machine.o
  CC       util/map.o
  CC       util/pstack.o
  CC       util/session.o
  CC       util/sample-raw.o
  CC       util/s390-sample-raw.o
  CC       util/syscalltbl.o
  CC       util/ordered-events.o
  CC       util/namespaces.o
  CC       util/comm.o
  CC       util/thread.o
  CC       util/thread_map.o
  LD       ui/browsers/perf-in.o
  LD       ui/perf-in.o
  CC       util/trace-event-parse.o
  CC       util/parse-events-bison.o
  BISON    util/pmu-bison.c
  CC       util/trace-event-read.o
  CC       util/trace-event-info.o
  CC       util/trace-event-scripting.o
  CC       util/trace-event.o
  CC       util/svghelper.o
  CC       util/sort.o
  CC       util/hist.o
  CC       util/util.o
  CC       util/cpumap.o
  CC       util/affinity.o
  CC       util/cputopo.o
  CC       util/cgroup.o
  CC       util/target.o
  CC       util/rblist.o
  CC       util/intlist.o
  CC       util/vdso.o
  CC       util/counts.o
  CC       util/stat.o
  CC       util/stat-shadow.o
  CC       util/stat-display.o
  CC       util/record.o
  CC       util/srcline.o
  CC       util/srccode.o
  CC       util/synthetic-events.o
  CC       util/data.o
  CC       util/tsc.o
  CC       util/cloexec.o
  CC       util/call-path.o
  CC       util/rwsem.o
  CC       util/thread-stack.o
  CC       util/spark.o
  CC       util/auxtrace.o
  CC       util/intel-pt-decoder/intel-pt-pkt-decoder.o
  GEN      util/intel-pt-decoder/inat-tables.c
  CC       util/intel-pt-decoder/intel-pt-log.o
  CC       util/intel-pt-decoder/intel-pt-decoder.o
  CC       util/intel-pt-decoder/intel-pt-insn-decoder.o
  CC       util/intel-pt.o
  CC       util/scripting-engines/trace-event-perl.o
  CC       util/intel-bts.o
  CC       util/arm-spe.o
  CC       util/arm-spe-pkt-decoder.o
  CC       util/s390-cpumsf.o
  CC       util/parse-branch-options.o
  CC       util/dump-insn.o
  CC       util/parse-regs-options.o
  CC       util/term.o
  CC       util/scripting-engines/trace-event-python.o
  CC       util/help-unknown-cmd.o
  CC       util/mem-events.o
  CC       util/vsprintf.o
  CC       util/units.o
  CC       util/time-utils.o
  BISON    util/expr-bison.c
  CC       util/branch.o
  CC       util/mem2node.o
  LD       util/intel-pt-decoder/perf-in.o
  CC       util/bpf-loader.o
  CC       util/bpf_map.o
  CC       util/bpf-prologue.o
  CC       util/symbol-elf.o
  CC       util/probe-file.o
  CC       util/probe-event.o
  CC       util/probe-finder.o
  CC       util/dwarf-aux.o
  CC       util/dwarf-regs.o
  CC       util/unwind-libunwind-local.o
  LD       util/scripting-engines/perf-in.o
  CC       util/data-convert-bt.o
  CC       util/unwind-libunwind.o
  CC       util/zlib.o
  CC       util/lzma.o
  CC       util/zstd.o
  CC       util/cap.o
  CC       util/demangle-java.o
  CC       util/demangle-rust.o
  CC       util/jitdump.o
  CC       util/genelf.o
  CC       util/genelf_debug.o
  CC       util/perf-hooks.o
  CC       util/bpf-event.o
  FLEX     util/parse-events-flex.c
  FLEX     util/pmu-flex.c
  CC       util/pmu-bison.o
  CC       util/expr-bison.o
  CC       util/parse-events.o
  CC       util/parse-events-flex.o
  CC       util/pmu.o
  CC       util/pmu-flex.o
  LD       util/perf-in.o
  LD       perf-in.o
  LINK     perf
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf'
2020-03-05 10:16:08 cd /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb8=
8e0f211dade207fa639a9e66ba27/tools/perf
2020-03-05 10:16:08 mkdir -p /pkg
2020-03-05 10:16:08 mkdir -p /kbuild/obj/consumer/x86_64-rhel-7.6
2020-03-05 10:16:09 cp /pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211=
dade207fa639a9e66ba27/vmlinux.xz /tmp
2020-03-05 10:16:09 unxz -k /tmp/vmlinux.xz
2020-03-05 10:16:12 cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-7.6
ignored_by_lkp: BPF filter
ignored_by_lkp: LLVM search and compile
ignored_by_lkp: Add vfs_getname probe to get syscall args filenames
ignored_by_lkp: Use vfs_getname probe to get syscall args filenames
ignored_by_lkp: Check open filename arg using perf trace + vfs_getname
ignored_by_lkp: builtin clang support
2020-03-05 10:16:12 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 1
 1: vmlinux symtab matches kallsyms                       : Ok
2020-03-05 10:16:12 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 2
 2: Detect openat syscall event                           : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 3
 3: Detect openat syscall event on all cpus               : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 4
 4: Read samples using the mmap interface                 : FAILED!
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 5
 5: Test data source output                               : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 6
 6: Parse event definition strings                        : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 7
 7: Simple expression parser                              : Ok
2020-03-05 10:16:13 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 8
 8: PERF_RECORD_* events & perf_sample fields             : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 9
 9: Parse perf pmu format                                 : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 10
10: DSO data read                                         : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 11
11: DSO data cache                                        : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 12
12: DSO data reopen                                       : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 13
13: Roundtrip evsel->name                                 : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 14
14: Parse sched tracepoints fields                        : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 15
15: syscalls:sys_enter_openat event fields                : Ok
2020-03-05 10:16:15 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 16
16: Setup struct perf_event_attr                          : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 17
17: Match and link multiple hists                         : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 18
18: 'import perf' in python                               : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 19
19: Breakpoint overflow signal handler                    : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 20
20: Breakpoint overflow sampling                          : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 21
21: Breakpoint accounting                                 : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 22
22: Watchpoint                                            :
22.1: Read Only Watchpoint                                : Skip
22.2: Write Only Watchpoint                               : Ok
22.3: Read / Write Watchpoint                             : Ok
22.4: Modify Watchpoint                                   : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 23
23: Number of exit events of a simple workload            : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 24
24: Software clock events period values                   : Ok
2020-03-05 10:16:19 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 25
25: Object code reading                                   : Ok
2020-03-05 10:16:20 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 26
26: Sample parsing                                        : Ok
2020-03-05 10:16:20 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 27
27: Use a dummy software event to keep tracking           : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 28
28: Parse with no sample_id_all bit set                   : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 29
29: Filter hist entries                                   : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 30
30: Lookup mmap thread                                    : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 31
31: Share thread maps                                     : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 32
32: Sort output of hist entries                           : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 33
33: Cumulate child hist entries                           : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 34
34: Track with sched_switch                               : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 35
35: Filter fds with revents mask in a fdarray             : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 36
36: Add fd to a fdarray, making it autogrow               : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 37
37: kmod_path__parse                                      : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 38
38: Thread map                                            : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 40
40: Session topology                                      : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 42
42: Synthesize thread map                                 : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 43
43: Remove thread map                                     : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 44
44: Synthesize cpu map                                    : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 45
45: Synthesize stat config                                : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 46
46: Synthesize stat                                       : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 47
47: Synthesize stat round                                 : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 48
48: Synthesize attr update                                : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 49
49: Event times                                           : Ok
2020-03-05 10:16:21 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 50
50: Read backward ring buffer                             : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 51
51: Print cpu map                                         : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 52
52: Merge cpu map                                         : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 53
53: Probe SDT events                                      : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 54
54: is_printable_array                                    : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 55
55: Print bitmap                                          : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 56
56: perf hooks                                            : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 58
58: unit_number__scnprintf                                : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 59
59: mem2node                                              : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 60
60: time utils                                            : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 61
61: Test jit_write_elf                                    : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 62
62: maps__merge_in                                        : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 63
63: x86 rdpmc                                             : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 64
64: Convert perf time to TSC                              : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 65
65: DWARF unwind                                          : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 66
66: x86 instruction decoder - new instructions            : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 67
67: Intel PT packet decoder                               : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 68
68: x86 bp modify                                         : Ok
2020-03-05 10:16:22 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 69
69: probe libc's inet_pton & backtrace it with ping       : Ok
2020-03-05 10:16:23 sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70c=
b88e0f211dade207fa639a9e66ba27/tools/perf/perf test 73
73: Zstd perf.data compression/decompression              : Ok

--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/perf-sanity-tests.yaml
suite: perf-sanity-tests
testcase: perf-sanity-tests
category: functional
need_memory: 2G
perf-sanity-tests:
  perf_compiler: gcc
job_origin: "/lkp/lkp/.src-20200229-230846/allot/cyclic:p2:linux-devel:devel-hourly/lkp-hsw-d02/perf-sanity-tests.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-hsw-d02
tbox_group: lkp-hsw-d02
submit_id: 5e60bb8eb369ab1b3f3a258d
job_file: "/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-gcc-ucode=0x27-debian-x86_64-20191114.cgz-dadb1ee70cb88e0f211dade207fa639a9e66ba27-20200305-6975-1uilwf8-0.yaml"
id: 7e6216d7d6e69dc6d271fbeb317ea8092be2a507
queuer_version: "/lkp-src"

#! hosts/lkp-hsw-d02
model: Haswell
nr_node: 1
nr_cpu: 8
memory: 6G
ssd_partitions: 
swap_partitions: LABEL=SWAP
rootfs_partition: LABEL=LKP-ROOTFS
brand: Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz
LKP_SERVER: 10.239.97.5
avoid_nfs: 1
result_service: tmpfs

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/perf-sanity-tests
need_linux_perf: true

#! include/queue/cyclic
commit: dadb1ee70cb88e0f211dade207fa639a9e66ba27

#! include/testbox/lkp-hsw-d02
ucode: '0x27'
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI

#! default params
kconfig: x86_64-rhel-7.6
compiler: gcc-7
enqueue_time: 2020-03-05 16:42:57.304610958 +08:00
_id: 5e60bb8eb369ab1b3f3a258d
_rt: "/result/perf-sanity-tests/gcc-ucode=0x27/lkp-hsw-d02/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27"

#! schedule options
user: lkp
head_commit: 0a2eb89fc4c694dc70ad3ef879c102d8a3b03c84
base_commit: f8788d86ab28f61f7b46eb6be375f8a726783636
branch: linux-devel/devel-hourly-2020030115
rootfs: debian-x86_64-20191114.cgz
result_root: "/result/perf-sanity-tests/gcc-ucode=0x27/lkp-hsw-d02/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/0"
scheduler_version: "/lkp/lkp/.src-20200305-143804"
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-x86_64-20191114.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-hsw-d02/perf-sanity-tests-gcc-ucode=0x27-debian-x86_64-20191114.cgz-dadb1ee70cb88e0f211dade207fa639a9e66ba27-20200305-6975-1uilwf8-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2020030115
- commit=dadb1ee70cb88e0f211dade207fa639a9e66ba27
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/vmlinuz-5.6.0-rc3-00277-gdadb1ee70cb88
- max_uptime=3600
- RESULT_ROOT=/result/perf-sanity-tests/gcc-ucode=0x27/lkp-hsw-d02/debian-x86_64-20191114.cgz/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/0
- LKP_SERVER=10.239.97.5
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-20180403.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-20180403.cgz/perf-sanity-tests_2019-12-02.cgz,/osimage/pkg/debian-x86_64-20180403.cgz/perf-x86_64-98d54f81e36b-1_20200302.cgz,/osimage/deps/debian-x86_64-20180403.cgz/hw_2020-01-02.cgz,/osimage/deps/debian-x86_64-20180403.cgz/rootfs_2019-08-20.cgz"
linux_perf_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/linux-perf.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20200229-230846/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 4.9.0-8-amd64
schedule_notify_address: 

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/vmlinuz-5.6.0-rc3-00277-gdadb1ee70cb88"
dequeue_time: 2020-03-05 17:29:59.730706229 +08:00

#! /lkp/lkp/.src-20200305-143804/include/site/inn
job_state: finished
loadavg: 2.07 0.73 0.26 1/180 7340
start_time: '1583373095'
end_time: '1583373131'
version: "/lkp/lkp/.src-20200305-143838:f8c6862e:bf71be97a"

--D6z0c4W1rkZNF4Vu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

make ARCH= -C /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf
cd /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf
mkdir -p /pkg
mkdir -p /kbuild/obj/consumer/x86_64-rhel-7.6
cp /pkg/linux/x86_64-rhel-7.6/gcc-7/dadb1ee70cb88e0f211dade207fa639a9e66ba27/vmlinux.xz /tmp
unxz -k /tmp/vmlinux.xz
cp /tmp/vmlinux /kbuild/obj/consumer/x86_64-rhel-7.6
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 1
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 2
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 3
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 4
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 5
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 6
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 7
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 8
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 9
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 10
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 11
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 12
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 13
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 14
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 15
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 16
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 17
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 18
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 19
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 20
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 21
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 22
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 23
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 24
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 25
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 26
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 27
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 28
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 29
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 30
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 31
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 32
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 33
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 34
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 35
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 36
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 37
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 38
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 40
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 42
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 43
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 44
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 45
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 46
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 47
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 48
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 49
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 50
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 51
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 52
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 53
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 54
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 55
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 56
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 58
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 59
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 60
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 61
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 62
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 63
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 64
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 65
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 66
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 67
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 68
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 69
sudo /usr/src/perf_selftests-x86_64-rhel-7.6-dadb1ee70cb88e0f211dade207fa639a9e66ba27/tools/perf/perf test 73

--D6z0c4W1rkZNF4Vu--
