Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195D9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D064B246BE
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCBFAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:00:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725446AbgCBFAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:00:52 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0224xR6D012100;
        Mon, 2 Mar 2020 00:00:44 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfmwusjga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 00:00:44 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0224xwCE030708;
        Mon, 2 Mar 2020 05:00:43 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 2yffk6txn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 05:00:43 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02250fvD49217824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 05:00:41 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF5B3C605B;
        Mon,  2 Mar 2020 05:00:41 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFC0EC605A;
        Mon,  2 Mar 2020 05:00:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.31.186])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 05:00:37 +0000 (GMT)
Subject: Re: [tools/perf/metricgroup] 5dd4f4ab07:
 stderr.mv:cannot_stat'util/.metricgroup.o.tmp':No_such_file_or_directory
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>, lkp@lists.01.org
References: <20200302011726.GS6548@shao2-debian>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <1a1cb7e9-a47f-a77b-d758-ac077dfa7cf0@linux.ibm.com>
Date:   Mon, 2 Mar 2020 10:30:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200302011726.GS6548@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-01_09:2020-02-28,2020-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/20 6:47 AM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 5dd4f4ab07f8257f1d113cc2b9ee95f43d576b9d ("[PATCH v4] tools/perf/metricgroup: Fix printing event names of metric group with multiple events incase of overlapping events")
> url: https://github.com/0day-ci/linux/commits/Kajol-Jain/tools-perf-metricgroup-Fix-printing-event-names-of-metric-group-with-multiple-events-incase-of-overlapping-events/20200215-093220
> 
> 
> in testcase: perf-sanity-tests
> with following parameters:
> 
> 	perf_compiler: gcc
> 	ucode: 0x27
> 
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-4790 v3 @ 3.60GHz with 6G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> user  :notice: [   58.688905]   LD       trace/beauty/perf-in.o
> 
> user  :err   : [   58.694839] util/metricgroup.c: In function 'metricgroup__setup_events':
> 
> user  :notice: [   58.696757]   CC       util/evlist.o
> 
> user  :err   : [   58.705739] util/metricgroup.c:170:3: error: break statement not within loop or switch
> 
> user  :notice: [   58.710154]   LD       arch/x86/tests/perf-in.o
> 
> user  :err   : [   58.720491]    break;
> 
> user  :notice: [   58.722367]   LD       arch/x86/perf-in.o
> 
> user  :err   : [   58.727486]    ^~~~~
> 
> user  :notice: [   58.729854]   LD       arch/perf-in.o
> 
> user  :err   : [   58.734440] mv: cannot stat 'util/.metricgroup.o.tmp': No such file or directory
> 
> user  :notice: [   58.738730]   CC       ui/tui/util.o
> 
> user  :err   : [   58.741991] make[4]: *** [util/metricgroup.o] Error 1
> 
> user  :notice: [   58.743544]   CC       tests/hists_link.o
> 
> user  :err   : [   58.746796] make[4]: *** Waiting for unfinished jobs....
> 
> user  :notice: [   58.749865]   CC       ui/browsers/map.o
> 
> user  :notice: [   58.796537]   CC       util/evsel.o
> 
> user  :notice: [   58.803941]   CC       ui/tui/helpline.o
> 
> user  :notice: [   58.811723]   CC       ui/tui/progress.o
> 
> user  :notice: [   58.819597]   CC       ui/browsers/scripts.o
> 
> user  :notice: [   58.827810]   CC       tests/hists_filter.o
> 
> user  :notice: [   58.835934]   CC       ui/browsers/header.o
> 
> user  :notice: [   58.843797]   LD       ui/tui/perf-in.o
> 
> user  :notice: [   58.851633]   CC       tests/hists_output.o
> 
> user  :notice: [   58.859662]   CC       ui/browsers/res_sample.o
> 
> user  :notice: [   58.868059]   CC       tests/hists_cumulate.o
> 
> user  :notice: [   58.876298]   CC       util/evsel_fprintf.o
> 
> user  :notice: [   58.884794]   CC       util/perf_event_attr_fprintf.o
> 
> user  :notice: [   58.893616]   CC       util/evswitch.o
> 
> user  :notice: [   58.901051]   CC       util/find_bit.o
> 
> user  :notice: [   58.908790]   CC       util/get_current_dir_name.o
> 
> user  :notice: [   58.917030]   CC       util/kallsyms.o
> 
> user  :notice: [   58.924272]   CC       tests/python-use.o
> 
> user  :notice: [   58.931786]   CC       util/levenshtein.o
> 
> user  :notice: [   58.939306]   CC       util/llvm-utils.o
> 
> user  :notice: [   58.946793]   CC       util/mmap.o
> 
> user  :notice: [   58.953880]   CC       util/memswap.o
> 
> user  :notice: [   58.961527]   BISON    util/parse-events-bison.c
> 
> user  :notice: [   58.969835]   CC       util/perf_regs.o
> 
> user  :notice: [   58.977405]   CC       tests/bp_signal.o
> 
> user  :notice: [   58.984747]   CC       util/path.o
> 
> user  :notice: [   58.991911]   CC       tests/bp_signal_overflow.o
> 
> user  :notice: [   59.000134]   CC       util/print_binary.o
> 
> user  :notice: [   59.007613]   CC       util/rlimit.o
> 
> user  :notice: [   59.014591]   CC       util/argv_split.o
> 
> user  :notice: [   59.021979]   CC       util/rbtree.o
> 
> user  :notice: [   59.028985]   CC       tests/bp_account.o
> 
> user  :notice: [   59.036173]   CC       tests/wp.o
> 
> user  :notice: [   59.042871]   CC       util/libstring.o
> 
> user  :notice: [   59.050011]   CC       util/bitmap.o
> 
> user  :notice: [   59.056858]   CC       util/hweight.o
> 
> user  :notice: [   59.063966]   CC       tests/task-exit.o
> 
> user  :notice: [   59.071298]   CC       tests/sw-clock.o
> 
> user  :notice: [   59.078342]   CC       util/smt.o
> 
> user  :notice: [   59.084981]   CC       util/strbuf.o
> 
> user  :notice: [   59.092311]   CC       tests/mmap-thread-lookup.o
> 
> user  :notice: [   59.100343]   CC       util/string.o
> 
> user  :notice: [   59.107456]   CC       tests/thread-maps-share.o
> 
> user  :notice: [   59.115581]   CC       tests/switch-tracking.o
> 
> user  :notice: [   59.123304]   CC       util/strlist.o
> 
> user  :notice: [   59.130429]   CC       tests/keep-tracking.o
> 
> user  :notice: [   59.138249]   CC       tests/code-reading.o
> 
> user  :notice: [   59.145689]   CC       util/strfilter.o
> 
> user  :notice: [   59.152629]   CC       util/top.o
> 
> user  :notice: [   59.159112]   CC       util/usage.o
> 
> user  :notice: [   59.165621]   CC       tests/sample-parsing.o
> 
> user  :notice: [   59.172446]   CC       util/dso.o
> 
> user  :notice: [   59.178526]   CC       tests/parse-no-sample-id-all.o
> 
> user  :notice: [   59.186126]   CC       tests/kmod-path.o
> 
> user  :notice: [   59.192493]   CC       util/dsos.o
> 
> user  :notice: [   59.198456]   CC       tests/thread-map.o
> 
> user  :notice: [   59.204913]   CC       util/symbol.o
> 
> user  :notice: [   59.210930]   CC       tests/llvm.o
> 
> user  :notice: [   59.217000]   CC       util/symbol_fprintf.o
> 
> user  :notice: [   59.223692]   CC       tests/bpf.o
> 
> user  :notice: [   59.229547]   CC       util/color.o
> 
> user  :notice: [   59.235563]   CC       tests/topology.o
> 
> user  :notice: [   59.241827]   CC       tests/mem.o
> 
> user  :notice: [   59.247704]   CC       tests/cpumap.o
> 
> user  :notice: [   59.253922]   CC       util/color_config.o
> 
> user  :notice: [   59.260604]   LD       ui/browsers/perf-in.o
> 
> user  :notice: [   59.267346]   CC       tests/stat.o
> 
> user  :notice: [   59.273288]   LD       ui/perf-in.o
> 
> user  :notice: [   59.279415]   CC       tests/event_update.o
> 
> user  :notice: [   59.286157]   CC       tests/event-times.o
> 
> user  :notice: [   59.292673]   CC       tests/expr.o
> 
> user  :notice: [   59.298749]   CC       util/metricgroup.o
> 
> user  :notice: [   59.305223]   CC       util/header.o
> 
> user  :notice: [   59.311512]   CC       tests/backward-ring-buffer.o
> 
> user  :notice: [   59.318814]   CC       tests/sdt.o
> 
> user  :notice: [   59.327108] /usr/src/perf_selftests-x86_64-rhel-7.6-5dd4f4ab07f8257f1d113cc2b9ee95f43d576b9d/tools/build/Makefile.build:96: recipe for target 'util/metricgroup.o' failed
> 
> user  :notice: [   59.344991]   CC       tests/is_printable_array.o
> 
> user  :notice: [   59.352277]   CC       tests/bitmap.o
> 
> user  :notice: [   59.358573]   CC       tests/perf-hooks.o
> 
> user  :notice: [   59.365109]   CC       tests/clang.o
> 
> user  :notice: [   59.371510]   CC       tests/unit_number__scnprintf.o
> 
> user  :notice: [   59.379158]   CC       tests/mem2node.o
> 
> user  :notice: [   59.385517]   CC       tests/maps.o
> 
> user  :notice: [   59.391769]   CC       tests/time-utils-test.o
> 
> user  :notice: [   59.398779]   CC       tests/genelf.o
> 
> user  :notice: [   59.405116]   CC       tests/dwarf-unwind.o
> 
> user  :notice: [   59.411975]   CC       tests/llvm-src-base.o
> 
> user  :notice: [   59.418975]   CC       tests/llvm-src-kbuild.o
> 
> user  :notice: [   59.426189]   CC       tests/llvm-src-prologue.o
> 
> user  :notice: [   59.433635]   CC       tests/llvm-src-relocation.o
> 
> user  :notice: [   59.441006]   LD       tests/perf-in.o
> 
> user  :err   : [   60.191397] make[3]: *** [util] Error 2
> 
> user  :notice: [   60.193667] /usr/src/perf_selftests-x86_64-rhel-7.6-5dd4f4ab07f8257f1d113cc2b9ee95f43d576b9d/tools/build/Makefile.build:139: recipe for target 'util' failed
> 
> user  :err   : [   60.196176] make[2]: *** [perf-in.o] Error 2
> 
> user  :notice: [   60.198386] Makefile.perf:616: recipe for target 'perf-in.o' failed
> 
> user  :err   : [   60.212393] make[1]: *** [sub-make] Error 2
> 
> user  :notice: [   60.214587] Makefile.perf:224: recipe for target 'sub-make' failed
> 
> user  :err   : [   60.218764] make: *** [all] Error 2
> 
> user  :notice: [   60.221026] Makefile:69: recipe for target 'all' failed
> 
> user  :err   : [   60.227253] make perf failed
> 
> user  :notice: [   60.230837] make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-5dd4f4ab07f8257f1d113cc2b9ee95f43d576b9d/tools/perf'
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
> 
> 

Hi Rong Chen,
   You are right, I got that issue in this patch. I already send fix for that. You can check v6 of this patch.
   Please let me know if still you found some issue.
Link to the patch: https://lkml.org/lkml/2020/2/21/1166

Thanks,
Kajol
> 
> Thanks,
> Rong Chen
> 
