Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C38C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE8F2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUEQFe9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgIHTMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgIHTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:12:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD06DC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:12:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id q4so86045pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pBDmVICqZA3vyYknmpeS/3RLEkvYnyCcMzmfY9rBWgw=;
        b=WUEQFe9zXmXtVlPWsj1RRTzS1HNhq1dktT37xLDrstISqFH7x4s4sf5jmZhXNe5jWh
         Co3pZlGBq6s0Tb2j0PU8MU2wb9WlZ40oDcsT3yqL/hAVK+UfuW5z1I6JtDQT+zsAaUJz
         yMCzSaliO6kSC4UHrmBIOJXVET1kq1GB6K+EvTUm+kDsV8yWs7iHo+mtvTd2ZkESnDQ8
         AIe/q8X0SpJp3ZGjzt8yRrIFNhJDC681GQ1qnMK5jPtvVD1/bd4Cbu+mngAjjhyg6fNL
         9T/k2kOXySS+Nyz1yYRrMV+MEJcO3h+jHTDAfdad4r8zedD8TLuUmEGg4fn9n8R+E/G5
         xKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pBDmVICqZA3vyYknmpeS/3RLEkvYnyCcMzmfY9rBWgw=;
        b=JOmMjES97NTVpyivKWhEoRipQxObax8ceHyOQ18shLsA9nBRowuA6KqX8JjW5G4X1o
         EVjF3qp3stEvGzfxeuC5eDRs46nIuzBPRMBmO0LpYYP0e+vlIGZOadRQp70Re6tKCvfQ
         ANeD6kOpK7V55WJX6YJnMTPRznSrSI5GNdR8LWslBDUJxfpNU5z8sFJ9tvW3tTlMbhTH
         DVpgR2uVbKVI387GCIY8ntp+IDf645aT7cfuhaYizvsFk0VpBkWPxt+WwNzksXJl43nd
         u/Hqw6TJTDPbzd2VNMEc0bTRyb41YJADHgZSjo9iRgk7S/Rir8GZjd2IkO14zBfcAlcT
         X5qw==
X-Gm-Message-State: AOAM533zRy3+H9xbygq5gpDBxpt0WEWMS2t5jlz9fcA8KBKKQ/Z28Ug4
        vQuFZ4rSC19D2F7Av4FmsQHiCA==
X-Google-Smtp-Source: ABdhPJzxoJvZkuN1jjjc0xLxBKSwJicYRUtBOlDoFLPpPQ/wQU3mckpQFl7SPQRLtAeIyiZhim+x0A==
X-Received: by 2002:a17:90b:4b03:: with SMTP id lx3mr257470pjb.143.1599592330206;
        Tue, 08 Sep 2020 12:12:10 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k4sm62701pjl.10.2020.09.08.12.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:12:09 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:12:07 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] perf test: Introduce script for Arm CoreSight testing
Message-ID: <20200908191207.GB506647@xps15>
References: <20200907130154.9601-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907130154.9601-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:01:54PM +0800, Leo Yan wrote:
> We need a simple method to test Perf with Arm CoreSight drivers, this
> could be used for smoke testing when new patch is coming for perf or
> CoreSight drivers, and we also can use the test to confirm if the
> CoreSight has been enabled successfully on new platforms.
> 
> This patch introduces the shell script test_arm_coresight.sh which is
> under the 'pert test' framework.  This script provides three testing
> scenarios:
> 
> Test scenario 1: traverse all possible paths between source and sink
> 
> For traversing possible paths, simply to say, the testing rationale
> is source oriented testing, it traverses every source (now only refers
> to ETM device) and test its all possible sinks.  To search the complete
> paths from one specific source to its sinks, this patch relies on the
> sysfs '/sys/bus/coresight/devices/devX/out:Y' for depth-first search
> (DFS) for iteration connected device nodes, if the output device is
> detected as a sink device (the script will exclude TPIU device which can
> not be supported for perf PMU), then it will test trace data recording
> and decoding for it.
> 
> The script runs three output testings for every trace data:
> - Test branch samples dumping with 'perf script' command;
> - Test branch samples reporting with 'perf report' command;
> - Use option '--itrace=i1000i' to insert synthesized instructions events
>   and the script will check if perf can output the percentage value
>   successfully based on the instruction samples.
> 
> Test scenario 2: system-wide test
> 
> For system-wide testing, it passes option '-a' to perf tool to enable
> tracing on all CPUs, so it's hard to say which program will be traced.
> But perf tool itself contributes much overload in this case, so it will
> parse trace data and check if process 'perf' can be detected or not.
> 
> Test scenario 3: snapshot mode test.
> 
> For snapshot mode testing, it uses 'dd' command to launch a long running
> program, so this can give chance to send signal -USR2; it will check the
> captured trace data contains 'dd' related thread info or not.
> 
> If any test fails, it will report failure and directly exit with error.
> This test will be only applied on a platform with PMU event 'cs_etm//',
> otherwise will skip the testing.
> 
> Below is detailed usage for it:
> 
>   # cd $linux/tools/perf  -> This is important so can use shell script
>   # perf test list
>     [...]
>     70: probe libc's inet_pton & backtrace it with ping
>     71: Check Arm CoreSight trace data recording and synthesized samples
>     72: Check open filename arg using perf trace + vfs_getname
>     73: Zstd perf.data compression/decompression
>     74: Add vfs_getname probe to get syscall args filenames
>     75: Use vfs_getname probe to get syscall args filenames
> 
>   # perf test 71
>     71: Check Arm CoreSight trace data recording and branch samples: Ok
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
> 
> Changes in v7:
> - Changed to use "trap cleanup_files exit" to clean up files (Suzuki);
> - Changed to use "basename" to retrieve the device name (Suzuki);
> - Added new function is_device_sink() (Suzuki).
> 
> Changes in v6:
> - Fixed indentation for arm_cs_iterate_devices() (Mathieu);
> - Changed to remove ${perfdata} and ${file} for failure cases (Mathieu);
> - Changed test name from "... branch samples" to "... synthesized samples".
> 
> Changes in v5:
> - Fixed testing name to system-wide testing (Suzuki);
> - Used 'enable_sink' existence to check if the device is a sink (Suzuki);
> - Excluded TPIU from sink devices;
> - Fixed Misleading output (Suzuki);
> - Removed '--per-thread' option from snapshot testing (Suzuki).
> 
> 
>  tools/perf/tests/shell/test_arm_coresight.sh | 183 +++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_arm_coresight.sh
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> new file mode 100755
> index 000000000000..8d84fdbed6a6
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -0,0 +1,183 @@
> +#!/bin/sh
> +# Check Arm CoreSight trace data recording and synthesized samples
> +
> +# Uses the 'perf record' to record trace data with Arm CoreSight sinks;
> +# then verify if there have any branch samples and instruction samples
> +# are generated by CoreSight with 'perf script' and 'perf report'
> +# commands.
> +
> +# SPDX-License-Identifier: GPL-2.0
> +# Leo Yan <leo.yan@linaro.org>, 2020
> +
> +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> +file=$(mktemp /tmp/temporary_file.XXXXX)
> +
> +skip_if_no_cs_etm_event() {
> +	perf list | grep -q 'cs_etm//' && return 0
> +
> +	# cs_etm event doesn't exist
> +	return 2
> +}
> +
> +skip_if_no_cs_etm_event || exit 2
> +
> +cleanup_files()
> +{
> +	rm -f ${perfdata}
> +	rm -f ${file}
> +}
> +
> +trap cleanup_files exit
> +
> +record_touch_file() {
> +	echo "Recording trace (only user mode) with path: CPU$2 => $1"
> +	rm -f $file
> +	perf record -o ${perfdata} -e cs_etm/@$1/u --per-thread \
> +		-- taskset -c $2 touch $file
> +}
> +
> +perf_script_branch_samples() {
> +	echo "Looking at perf.data file for dumping branch samples:"
> +
> +	# Below is an example of the branch samples dumping:
> +	#   touch  6512          1         branches:u:      ffffb220824c strcmp+0xc (/lib/aarch64-linux-gnu/ld-2.27.so)
> +	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> +	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> +	perf script -F,-time -i ${perfdata} | \
> +		egrep " +$1 +[0-9]+ .* +branches:([u|k]:)? +"
> +}
> +
> +perf_report_branch_samples() {
> +	echo "Looking at perf.data file for reporting branch samples:"
> +
> +	# Below is an example of the branch samples reporting:
> +	#   73.04%    73.04%  touch    libc-2.27.so      [.] _dl_addr
> +	#    7.71%     7.71%  touch    libc-2.27.so      [.] getenv
> +	#    2.59%     2.59%  touch    ld-2.27.so        [.] strcmp
> +	perf report --stdio -i ${perfdata} | \
> +		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 "
> +}
> +
> +perf_report_instruction_samples() {
> +	echo "Looking at perf.data file for instruction samples:"
> +
> +	# Below is an example of the instruction samples reporting:
> +	#   68.12%  touch    libc-2.27.so   [.] _dl_addr
> +	#    5.80%  touch    libc-2.27.so   [.] getenv
> +	#    4.35%  touch    ld-2.27.so     [.] _dl_fixup
> +	perf report --itrace=i1000i --stdio -i ${perfdata} | \
> +		egrep " +[0-9]+\.[0-9]+% +$1"
> +}
> +
> +is_device_sink() {
> +	# If the node of "enable_sink" is existed under the device path, this
> +	# means the device is a sink device.  Need to exclude 'tpiu' since it
> +	# cannot support perf PMU.
> +	echo "$1" | egrep -q -v "tpiu"
> +
> +	if [ $? -eq 0 -a -e "$1/enable_sink" ]; then
> +
> +		pmu_dev="/sys/bus/event_source/devices/cs_etm/sinks/$2"
> +
> +		# Warn if the device is not supported by PMU
> +		if ! [ -f $pmu_dev ]; then
> +			echo "PMU doesn't support $pmu_dev"
> +		fi
> +
> +		return 0
> +	fi
> +
> +	# Otherwise, it's not a sink device
> +	return 1
> +}
> +
> +arm_cs_iterate_devices() {
> +	for dev in $1/connections/out\:*; do
> +
> +		# Skip testing if it's not a directory
> +		! [ -d $dev ] && continue;
> +
> +		# Read out its symbol link file name
> +		path=`readlink -f $dev`
> +
> +		# Extract device name from path, e.g.
> +		#   path = '/sys/devices/platform/20010000.etf/tmc_etf0'
> +		#     `> device_name = 'tmc_etf0'
> +		device_name=$(basename $path)
> +
> +		if is_device_sink $path $devce_name; then
> +
> +			record_touch_file $device_name $2 &&
> +			perf_script_branch_samples touch &&
> +			perf_report_branch_samples touch &&
> +			perf_report_instruction_samples touch
> +
> +			err=$?
> +
> +			# Exit when find failure
> +			[ $err != 0 ] && exit $err
> +		fi
> +
> +		arm_cs_iterate_devices $dev $2
> +	done
> +}
> +
> +arm_cs_etm_traverse_path_test() {
> +	# Iterate for every ETM device
> +	for dev in /sys/bus/coresight/devices/etm*; do
> +
> +		# Find the ETM device belonging to which CPU
> +		cpu=`cat $dev/cpu`
> +
> +		echo $dev
> +		echo $cpu
> +
> +		# Use depth-first search (DFS) to iterate outputs
> +		arm_cs_iterate_devices $dev $cpu
> +	done
> +}
> +
> +arm_cs_etm_system_wide_test() {
> +	echo "Recording trace with system wide mode"
> +	perf record -o ${perfdata} -e cs_etm// -a -- ls
> +
> +	perf_script_branch_samples perf &&
> +	perf_report_branch_samples perf &&
> +	perf_report_instruction_samples perf
> +
> +	err=$?
> +
> +	# Exit when find failure
> +	[ $err != 0 ] && exit $err
> +}
> +
> +arm_cs_etm_snapshot_test() {
> +	echo "Recording trace with snapshot mode"
> +	perf record -o ${perfdata} -e cs_etm// -S \
> +		-- dd if=/dev/zero of=/dev/null &
> +	PERFPID=$!
> +
> +	# Wait for perf program
> +	sleep 1
> +
> +	# Send signal to snapshot trace data
> +	kill -USR2 $PERFPID
> +
> +	# Stop perf program
> +	kill $PERFPID
> +	wait $PERFPID
> +
> +	perf_script_branch_samples dd &&
> +	perf_report_branch_samples dd &&
> +	perf_report_instruction_samples dd
> +
> +	err=$?
> +
> +	# Exit when find failure
> +	[ $err != 0 ] && exit $err
> +}
> +
> +arm_cs_etm_traverse_path_test
> +arm_cs_etm_system_wide_test
> +arm_cs_etm_snapshot_test
> +exit 0
> -- 
> 2.17.1
> 
