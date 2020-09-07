Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8916BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AFF20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyk8Aot8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIGH3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgIGH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:29:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0464C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:29:17 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s2so6063811pjr.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=vmZ35xxoreW7hFP3MiJvjSliYUUsUqSb6/SWiEdr8tg=;
        b=dyk8Aot83nQB2j2JHecaJM338t/q16v+tL5vS1MsEkZjGdORoF0agtDolGHApVMrRS
         JVVdaPe5GGDQe/+Zc+Z1LNEjKcmOE2mJikbuaWkmjMbKVZccQyvQ865XWTyVasy16Bke
         5Vvr9GJ3sIwaR7XZEoyWwCYI7g5jFf9MZ9T488vQxz2W33w+2yR/c27f8Pg6+UGtQ889
         ktm1MVjUTs49m4r1UsAMYFV+tcFNTwsA5qxGWiNNIjhdRpp4utnVOMEksAMHq3OyX3Wo
         OEU139OF9IDu45gKlJybgacO7wl7yRFRGV5HCWvXVRE3LNa3PeFjDdHjEwPw0HTyj2SC
         4U6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vmZ35xxoreW7hFP3MiJvjSliYUUsUqSb6/SWiEdr8tg=;
        b=cS5rqcrPQ+SfbPpka3vLh6duVxlqlOvnCLLqbPSVmi93Xp3bwaRN1tb5h/nrl7GNMY
         vspt19fm3+SYlz/HXGlvahp+NQEUR7pYKXuiMMIsJrYVYKZlpHdwwCn5vsjnIP5fq3Oa
         Jd2Yek4BHzjGpReW2dZyPKwLfFEv6/tuI3Bq3iCX+wSHQsVx209GbIix2wTmR5GU4NKg
         EZR6+elRHLvpYCEfKgqGV4//Zc7ruU53I9SUE6Me5UaIUq7J3iEI287c/R4PZjHwguFA
         IWr6+ULVqhssKc2fkUTY2xlkEYKevBc5Ove6yeAhf0edYAAFne72r14TUobEHS2zbHV/
         yLBA==
X-Gm-Message-State: AOAM530mti/1SUYt8A7CfuEBz9c1uHnGzaEE/4VfE4sbe1PKvidHUdI1
        kZutp2XeB91GJcqHjWsgX/aURA==
X-Google-Smtp-Source: ABdhPJxF9SLOigIRXQGKIQPbzpjNFJBXdBqMhRM0LY+XDBiEayWR/Fh1tJGhMecd6CbY05dxhjHcaA==
X-Received: by 2002:a17:902:d904:: with SMTP id c4mr18057951plz.115.1599463756170;
        Mon, 07 Sep 2020 00:29:16 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z7sm4354426pfj.75.2020.09.07.00.29.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 00:29:15 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6] perf test: Introduce script for Arm CoreSight testing
Date:   Mon,  7 Sep 2020 15:29:02 +0800
Message-Id: <20200907072902.28068-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need a simple method to test Perf with Arm CoreSight drivers, this
could be used for smoke testing when new patch is coming for perf or
CoreSight drivers, and we also can use the test to confirm if the
CoreSight has been enabled successfully on new platforms.

This patch introduces the shell script test_arm_coresight.sh which is
under the 'pert test' framework.  This script provides three testing
scenarios:

Test scenario 1: traverse all possible paths between source and sink

For traversing possible paths, simply to say, the testing rationale
is source oriented testing, it traverses every source (now only refers
to ETM device) and test its all possible sinks.  To search the complete
paths from one specific source to its sinks, this patch relies on the
sysfs '/sys/bus/coresight/devices/devX/out:Y' for depth-first search
(DFS) for iteration connected device nodes, if the output device is
detected as a sink device (the script will exclude TPIU device which can
not be supported for perf PMU), then it will test trace data recording
and decoding for it.

The script runs three output testings for every trace data:
- Test branch samples dumping with 'perf script' command;
- Test branch samples reporting with 'perf report' command;
- Use option '--itrace=i1000i' to insert synthesized instructions events
  and the script will check if perf can output the percentage value
  successfully based on the instruction samples.

Test scenario 2: system-wide test

For system-wide testing, it passes option '-a' to perf tool to enable
tracing on all CPUs, so it's hard to say which program will be traced.
But perf tool itself contributes much overload in this case, so it will
parse trace data and check if process 'perf' can be detected or not.

Test scenario 3: snapshot mode test.

For snapshot mode testing, it uses 'dd' command to launch a long running
program, so this can give chance to send signal -USR2; it will check the
captured trace data contains 'dd' related thread info or not.

If any test fails, it will report failure and directly exit with error.
This test will be only applied on a platform with PMU event 'cs_etm//',
otherwise will skip the testing.

Below is detailed usage for it:

  # cd $linux/tools/perf  -> This is important so can use shell script
  # perf test list
    [...]
    70: probe libc's inet_pton & backtrace it with ping
    71: Check Arm CoreSight trace data recording and synthesized samples
    72: Check open filename arg using perf trace + vfs_getname
    73: Zstd perf.data compression/decompression
    74: Add vfs_getname probe to get syscall args filenames
    75: Use vfs_getname probe to get syscall args filenames

  # perf test 71
    66: Check Arm CoreSight trace data recording and branch samples: Ok

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---

Changes in v6:
- Fixed indentation for arm_cs_iterate_devices() (Mathieu);
- Changed to remove ${perfdata} and ${file} for failure cases (Mathieu);
- Changed test name from "... branch samples" to "... synthesized samples".

Changes in v5:
- Fixed testing name to system-wide testing (Suzuki);
- Used 'enable_sink' existence to check if the device is a sink (Suzuki);
- Excluded TPIU from sink devices;
- Fixed Misleading output (Suzuki);
- Removed '--per-thread' option from snapshot testing (Suzuki).


 tools/perf/tests/shell/test_arm_coresight.sh | 175 +++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight.sh

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
new file mode 100755
index 000000000000..036e80c5c280
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -0,0 +1,175 @@
+#!/bin/sh
+# Check Arm CoreSight trace data recording and synthesized samples
+
+# Uses the 'perf record' to record trace data with Arm CoreSight sinks;
+# then verify if there have any branch samples and instruction samples
+# are generated by CoreSight with 'perf script' and 'perf report'
+# commands.
+
+# SPDX-License-Identifier: GPL-2.0
+# Leo Yan <leo.yan@linaro.org>, 2020
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+file=$(mktemp /tmp/temporary_file.XXXXX)
+
+skip_if_no_cs_etm_event() {
+	perf list | grep -q 'cs_etm//' && return 0
+
+	# cs_etm event doesn't exist
+	return 2
+}
+
+skip_if_no_cs_etm_event || exit 2
+
+record_touch_file() {
+	echo "Recording trace (only user mode) with path: CPU$2 => $1"
+	rm -f $file
+	perf record -o ${perfdata} -e cs_etm/@$1/u --per-thread \
+		-- taskset -c $2 touch $file
+}
+
+perf_script_branch_samples() {
+	echo "Looking at perf.data file for dumping branch samples:"
+
+	# Below is an example of the branch samples dumping:
+	#   touch  6512          1         branches:u:      ffffb220824c strcmp+0xc (/lib/aarch64-linux-gnu/ld-2.27.so)
+	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
+	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
+	perf script -F,-time -i ${perfdata} | \
+		egrep " +$1 +[0-9]+ .* +branches:([u|k]:)? +"
+}
+
+perf_report_branch_samples() {
+	echo "Looking at perf.data file for reporting branch samples:"
+
+	# Below is an example of the branch samples reporting:
+	#   73.04%    73.04%  touch    libc-2.27.so      [.] _dl_addr
+	#    7.71%     7.71%  touch    libc-2.27.so      [.] getenv
+	#    2.59%     2.59%  touch    ld-2.27.so        [.] strcmp
+	perf report --stdio -i ${perfdata} | \
+		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 "
+}
+
+perf_report_instruction_samples() {
+	echo "Looking at perf.data file for instruction samples:"
+
+	# Below is an example of the instruction samples reporting:
+	#   68.12%  touch    libc-2.27.so   [.] _dl_addr
+	#    5.80%  touch    libc-2.27.so   [.] getenv
+	#    4.35%  touch    ld-2.27.so     [.] _dl_fixup
+	perf report --itrace=i1000i --stdio -i ${perfdata} | \
+		egrep " +[0-9]+\.[0-9]+% +$1"
+}
+
+arm_cs_iterate_devices() {
+	for dev in $1/connections/out\:*; do
+
+		# Skip testing if it's not a directory
+		! [ -d $dev ] && continue;
+
+		# Read out its symbol link file name
+		path=`readlink -f $dev`
+
+		# Extract device name from path, e.g.
+		#   path = '/sys/devices/platform/20010000.etf/tmc_etf0'
+		#     `> device_name = 'tmc_etf0'
+		device_name=`echo $path | awk -F/ '{print $(NF)}'`
+
+
+		# If the node of "enable_sink" is existed under the device path, this
+		# means the device is a sink device.  Need to exclude 'tpiu' since it
+		# cannot support perf PMU.
+		echo $device_name | egrep -q -v "tpiu"
+		if [ $? -eq 0 -a -e "$path/enable_sink" ]; then
+
+			pmu_dev="/sys/bus/event_source/devices/cs_etm/sinks/$device_name"
+
+			# Exit if the sink device is supported by PMU or not
+			if ! [ -f $pmu_dev ]; then
+				echo "PMU doesn't support $pmu_dev"
+				exit 1
+			fi
+
+			record_touch_file $device_name $2 &&
+			perf_script_branch_samples touch &&
+			perf_report_branch_samples touch &&
+			perf_report_instruction_samples touch
+
+			err=$?
+
+			rm -f ${perfdata}
+			rm -f ${file}
+
+			# Exit when find failure
+			[ $err != 0 ] && exit $err
+		fi
+
+		arm_cs_iterate_devices $dev $2
+	done
+}
+
+arm_cs_etm_traverse_path_test() {
+	# Iterate for every ETM device
+	for dev in /sys/bus/coresight/devices/etm*; do
+
+		# Find the ETM device belonging to which CPU
+		cpu=`cat $dev/cpu`
+
+		echo $dev
+		echo $cpu
+
+		# Use depth-first search (DFS) to iterate outputs
+		arm_cs_iterate_devices $dev $cpu
+	done
+}
+
+arm_cs_etm_system_wide_test() {
+	echo "Recording trace with system wide mode"
+	perf record -o ${perfdata} -e cs_etm// -a -- ls
+
+	perf_script_branch_samples perf &&
+	perf_report_branch_samples perf &&
+	perf_report_instruction_samples perf
+
+	err=$?
+
+	rm -f ${perfdata}
+	rm -f ${file}
+
+	# Exit when find failure
+	[ $err != 0 ] && exit $err
+}
+
+arm_cs_etm_snapshot_test() {
+	echo "Recording trace with snapshot mode"
+	perf record -o ${perfdata} -e cs_etm// -S \
+		-- dd if=/dev/zero of=/dev/null &
+	PERFPID=$!
+
+	# Wait for perf program
+	sleep 1
+
+	# Send signal to snapshot trace data
+	kill -USR2 $PERFPID
+
+	# Stop perf program
+	kill $PERFPID
+	wait $PERFPID
+
+	perf_script_branch_samples dd &&
+	perf_report_branch_samples dd &&
+	perf_report_instruction_samples dd
+
+	err=$?
+
+	rm -f ${perfdata}
+	rm -f ${file}
+
+	# Exit when find failure
+	[ $err != 0 ] && exit $err
+}
+
+arm_cs_etm_traverse_path_test
+arm_cs_etm_system_wide_test
+arm_cs_etm_snapshot_test
+exit 0
-- 
2.17.1

