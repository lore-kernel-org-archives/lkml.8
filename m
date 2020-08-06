Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC37C433E5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E29B422CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZWHgZTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgHFHC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbgHFHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:02:41 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86001C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 00:02:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id l60so6153905pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8GDk4wvC7PK9uLDNwic4bnqKP6GMmNE8vLOoCruFRtc=;
        b=nZWHgZTEYfWMCUBn1a1rbiCNJPmRgW1eJuPMJZPUzMPuq6EIGzuOvE8q/Ex/Ms65PT
         HoF/2s0G1MnvSuXkXTwZHOvqObwqeH0K6lBDdbYCziSTxRtBa5Tzn0u6w0hPZvopphWu
         CJzA/KqX27kPLJ+u+a/80la8tnzuihvNlqUu8UJAbsEF3cXm/znlM+sqAv3uRo5szEss
         tCjvPj7TI312PphfEP/gMcD7VTj6PbpG3X/X/qHWvsviCnQLq65CB4OEZAC8gi//qJ3p
         8axZF6RBA7Y68GAuY3jkCQuOtBRlvGQjUnElLmBJIda1/015mAV0lx1yg5kYsf1NriIL
         s1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8GDk4wvC7PK9uLDNwic4bnqKP6GMmNE8vLOoCruFRtc=;
        b=rjKQ3BJ8PRhEKpYwMf/VVaO1vLfhp9a8RQTzFiVw6P7Ga7DrU5oQG2QhmnzRfVGErr
         iJQ+0108eaKW5D+btMXfrqZ5ynogbLWQeylwmJOZ0TPDBdfereUMeXFlKmQ0DxaBA6Jz
         QuVzYiGi0qjtQmzdzhks6kF3Egs+87+fS7wBzLhtG6xa6Xc6SlA0obJLnRI3AADu0k4s
         fcXzDAeUEXhrMZJRgtO9nxVsAYMwlMa1V0giiHBApFxYqteACR+5IYD124Zjm4RbnrJ+
         Bq7Ih2v6Z51K72Pqx39u8fQxF0DPt7ZwNUBbH9yuly7l6zWlYyE5gD96PovRKKiVVWWU
         VFMA==
X-Gm-Message-State: AOAM532/7zkootfsKPEB/Os55hkAyzl0+Occo3TuX+CZC2OUzzcZHWL7
        ZLHjhAVhETuMjgli28tOITS0og==
X-Google-Smtp-Source: ABdhPJyM39Yq+P8A/I/OtYOSHwTrd8v5jB/8ym+P2oHUwf0qoMAKpIyLNj/yGYOa0jLIcU1mVPqO8Q==
X-Received: by 2002:a17:90a:a65:: with SMTP id o92mr3362678pjo.104.1596697356910;
        Thu, 06 Aug 2020 00:02:36 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id q7sm6336907pfl.156.2020.08.06.00.02.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 00:02:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4] perf test: Introduce script for Arm CoreSight testing
Date:   Thu,  6 Aug 2020 15:02:13 +0800
Message-Id: <20200806070213.7386-1-leo.yan@linaro.org>
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
detected as one of ETR, ETF, or ETB types then it will test trace data
recording and decoding for this PMU device.

The script runs three output testings for every trace data:
- Test branch samples dumping with 'perf script' command;
- Test branch samples reporting with 'perf report' command;
- Use option '--itrace=i1000i' to insert synthesized instructions events
  and the script will check if perf can output the percentage value
  successfully based on the instruction samples.

Test scenario 2: CPU wide mode test

For CPU wide mode testing, it passes option '-a' to perf tool to enable
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
    65: probe libc's inet_pton & backtrace it with ping
    66: Check Arm CoreSight trace data recording and branch samples
    67: Check open filename arg using perf trace + vfs_getname
    68: Zstd perf.data compression/decompression
    69: Add vfs_getname probe to get syscall args filenames
    70: Use vfs_getname probe to get syscall args filenames

  # perf test 66
    66: Check Arm CoreSight trace data recording and branch samples: Ok

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/tests/shell/test_arm_coresight.sh | 172 +++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight.sh

diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
new file mode 100755
index 000000000000..73b973bada26
--- /dev/null
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -0,0 +1,172 @@
+#!/bin/sh
+# Check Arm CoreSight trace data recording and branch samples
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
+		echo $device_name | egrep -q "etr|etb|etf"
+
+		# Only test if the output device is ETR/ETB/ETF
+		if [ $? -eq 0 ]; then
+
+			pmu_dev="/sys/bus/event_source/devices/cs_etm/sinks/$device_name"
+
+			# Exit if PMU device node doesn't exist
+			if ! [ -f $pmu_dev ]; then
+				echo "PMU device $pmu_dev doesn't exist"
+				exit 1
+			fi
+
+			record_touch_file $device_name $2 &&
+				perf_script_branch_samples touch &&
+				perf_report_branch_samples touch &&
+				perf_report_instruction_samples touch
+
+			err=$?
+
+			# Exit when find failure
+			[ $err != 0 ] && exit $err
+
+			rm -f ${perfdata}
+			rm -f ${file}
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
+arm_cs_etm_cpu_wide_test() {
+	echo "Recording trace with CPU wide mode"
+	perf record -o ${perfdata} -e cs_etm// -a -- ls
+
+	perf_script_branch_samples perf &&
+	perf_report_branch_samples perf &&
+	perf_report_instruction_samples perf
+
+	err=$?
+
+	# Exit when find failure
+	[ $err != 0 ] && exit $err
+
+	rm -f ${perfdata}
+	rm -f ${file}
+}
+
+arm_cs_etm_snapshot_test() {
+	echo "Recording trace with snapshot mode"
+	perf record -o ${perfdata} -e cs_etm// -S --per-thread \
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
+	# Exit when find failure
+	[ $err != 0 ] && exit $err
+
+	rm -f ${perfdata}
+	rm -f ${file}
+}
+
+arm_cs_etm_traverse_path_test
+arm_cs_etm_cpu_wide_test
+arm_cs_etm_snapshot_test
+exit 0
-- 
2.17.1

