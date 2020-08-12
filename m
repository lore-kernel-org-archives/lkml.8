Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADD2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5287E2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLQzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:55:01 -0400
Received: from foss.arm.com ([217.140.110.172]:46988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLQy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:54:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C2E831B;
        Wed, 12 Aug 2020 09:54:58 -0700 (PDT)
Received: from [10.37.8.11] (unknown [10.37.8.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7493F22E;
        Wed, 12 Aug 2020 09:54:53 -0700 (PDT)
Subject: Re: [PATCH v4] perf test: Introduce script for Arm CoreSight testing
To:     leo.yan@linaro.org, acme@kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
References: <20200806070213.7386-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <cf57e876-3645-53f0-6333-ecb6ce3597d5@arm.com>
Date:   Wed, 12 Aug 2020 17:59:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200806070213.7386-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 08/06/2020 08:02 AM, Leo Yan wrote:
> We need a simple method to test Perf with Arm CoreSight drivers, this
> could be used for smoke testing when new patch is coming for perf or
> CoreSight drivers, and we also can use the test to confirm if the
> CoreSight has been enabled successfully on new platforms.
> 
> This patch introduces the shell script test_arm_coresight.sh which is
> under the 'pert test' framework.  This script provides three testing
> scenarios:

Thank you for this testcase. It is a very good tool for people
check their system for CoreSight driver functionality.

> 
> Test scenario 1: traverse all possible paths between source and sink
> 
> For traversing possible paths, simply to say, the testing rationale
> is source oriented testing, it traverses every source (now only refers
> to ETM device) and test its all possible sinks.  To search the complete
> paths from one specific source to its sinks, this patch relies on the
> sysfs '/sys/bus/coresight/devices/devX/out:Y' for depth-first search
> (DFS) for iteration connected device nodes, if the output device is
> detected as one of ETR, ETF, or ETB types then it will test trace data


Please see my suggestion below, to use "enable_sink" as an indicator
for a sink device.

> recording and decoding for this PMU device.
> 
> The script runs three output testings for every trace data:
> - Test branch samples dumping with 'perf script' command;
> - Test branch samples reporting with 'perf report' command;
> - Use option '--itrace=i1000i' to insert synthesized instructions events
>    and the script will check if perf can output the percentage value
>    successfully based on the instruction samples.
> 
> Test scenario 2: CPU wide mode test
>  > For CPU wide mode testing, it passes option '-a' to perf tool to enable
> tracing on all CPUs, so it's hard to say which program will be traced.

Isn't this system-wide, when you trace all CPUs ? In CPU wide mode,
you specify a list of CPUs (-C ?). I always get confused here.

> But perf tool itself contributes much overload in this case, so it will
> parse trace data and check if process 'perf' can be detected or not.
> 
> diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> new file mode 100755
> index 000000000000..73b973bada26
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> @@ -0,0 +1,172 @@
> +#!/bin/sh
> +# Check Arm CoreSight trace data recording and branch samples
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
> +record_touch_file() {
> +	echo "Recording trace (only user mode) with path: CPU$2 => $1"
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
> +		device_name=`echo $path | awk -F/ '{print $(NF)}'`
> +
> +		echo $device_name | egrep -q "etr|etb|etf"

Could we check for the existence of "enable_sink" instead, for detecting
if this is a sink device ? That way, we are covered for future cases of
a new sink type, and is more reliable.


> +
> +		# Only test if the output device is ETR/ETB/ETF
> +		if [ $? -eq 0 ]; then
> +
> +			pmu_dev="/sys/bus/event_source/devices/cs_etm/sinks/$device_name"
> +
> +			# Exit if PMU device node doesn't exist
> +			if ! [ -f $pmu_dev ]; then
> +				echo "PMU device $pmu_dev doesn't exist"

Misleading output. $pmu_dev is not a PMU device. Instead, it is one of
the supported sinks by the PMU.

> +				exit 1
> +			fi
> +
> +			record_touch_file $device_name $2 &&
> +				perf_script_branch_samples touch &&
> +				perf_report_branch_samples touch &&
> +				perf_report_instruction_samples touch
> +
> +			err=$?
> +
> +			# Exit when find failure
> +			[ $err != 0 ] && exit $err
> +
> +			rm -f ${perfdata}
> +			rm -f ${file}
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
> +arm_cs_etm_cpu_wide_test() {
> +	echo "Recording trace with CPU wide mode"
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
> +
> +	rm -f ${perfdata}
> +	rm -f ${file}
> +}
> +
> +arm_cs_etm_snapshot_test() {
> +	echo "Recording trace with snapshot mode"
> +	perf record -o ${perfdata} -e cs_etm// -S --per-thread \
> +		-- dd if=/dev/zero of=/dev/null &

As far as I understand, --per-thread option is not needed anymore
for normal tracing (irrespective of whether your application is
multi-threaded or not)

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
> +
> +	rm -f ${perfdata}
> +	rm -f ${file}
> +}
> +
> +arm_cs_etm_traverse_path_test
> +arm_cs_etm_cpu_wide_test
> +arm_cs_etm_snapshot_test
> +exit 0
> 


Rest looks OK to me.

Cheers
Suzuki
