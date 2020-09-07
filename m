Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B3EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8B20738
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgIGKpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:45:46 -0400
Received: from foss.arm.com ([217.140.110.172]:60658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgIGKpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:45:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64D1106F;
        Mon,  7 Sep 2020 03:45:30 -0700 (PDT)
Received: from [10.57.6.175] (unknown [10.57.6.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D63093F66E;
        Mon,  7 Sep 2020 03:45:27 -0700 (PDT)
Subject: Re: [PATCH v6] perf test: Introduce script for Arm CoreSight testing
To:     leo.yan@linaro.org, acme@kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, linux-kernel@vger.kernel.org
References: <20200907072902.28068-1-leo.yan@linaro.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c64a489d-b151-b015-5806-a8daec34b429@arm.com>
Date:   Mon, 7 Sep 2020 11:50:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200907072902.28068-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2020 08:29 AM, Leo Yan wrote:
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
>    and the script will check if perf can output the percentage value
>    successfully based on the instruction samples.
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
>    # cd $linux/tools/perf  -> This is important so can use shell script
>    # perf test list
>      [...]
>      70: probe libc's inet_pton & backtrace it with ping
>      71: Check Arm CoreSight trace data recording and synthesized samples
>      72: Check open filename arg using perf trace + vfs_getname
>      73: Zstd perf.data compression/decompression
>      74: Add vfs_getname probe to get syscall args filenames
>      75: Use vfs_getname probe to get syscall args filenames
> 
>    # perf test 71
>      66: Check Arm CoreSight trace data recording and branch samples: Ok
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
> 
> Changes in v6:
> - Fixed indentation for arm_cs_iterate_devices() (Mathieu);
> - Changed to remove ${perfdata} and ${file} for failure cases (Mathieu);
> - Changed test name from "... branch samples" to "... synthesized samples".

minor nit: Instead of spilling the cleanup of the files allover the
tests, could we use trap ... exit to cleanup ?

i.e,

cleanup_files()
{
	# Cleanups here
	# rm -f ....
}

trap cleanup_files exit

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

Couldn't this be :
		device_name=$(basename $path) ?


> +
> +

  --- Cut here ---
> +		# If the node of "enable_sink" is existed under the device path, this
> +		# means the device is a sink device.  Need to exclude 'tpiu' since it
> +		# cannot support perf PMU.
> +		echo $device_name | egrep -q -v "tpiu"
> +		if [ $? -eq 0 -a -e "$path/enable_sink" ]; then
> +
> +			pmu_dev="/sys/bus/event_source/devices/cs_etm/sinks/$device_name"
> +
> +			# Exit if the sink device is supported by PMU or not
> +			if ! [ -f $pmu_dev ]; then
> +				echo "PMU doesn't support $pmu_dev"
> +				exit 1

This may not be fatal to the testing. Could be a warning and continue on
to the next device ?

> +			fi

---- Cut end ---

minor nit: Could this be moved into a function ? say, is_device_sink() ?

Rest looks fine to me.

Cheers
Suzuki
