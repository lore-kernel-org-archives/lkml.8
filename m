Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5653BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 00:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273DB20774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 00:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIJallBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHMAL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHMAL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 20:11:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6966C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 17:11:28 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so1903304pgb.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 17:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ZSpDsjubOiBkkOQ9eS3CYhctg8r1GfBee84kS+qmng=;
        b=SIJallBysGyfZ7n0GHovzdGj+ek1aOP7s/lvFc94+KQIWLuXIPQfT8slVouDNk1JGW
         953UCzRfduzYNq+bGrNGmj4M3beqM7xm3hbus2/Bqi6WAxX4prmdOg6pg4X8abg2Fvy1
         wlRhVrcilxzv2aTj00whhjAXbkgmuL5khZCQjnSfdstnIn/3MU3eveZloWlNxmFlgS7/
         tIN9lKmNgRzFrYq/mNdGPlKS/acnePkgN2HEWPy2qISkcf3dUJhXKmwzNXuX6/pL6itb
         U2lr07Tl5GSMh0uVYBpliQa6z7hENZRv/5ydmkTJ6niZD9zY6hKAd7Qs03Ot63kvNAqB
         gJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ZSpDsjubOiBkkOQ9eS3CYhctg8r1GfBee84kS+qmng=;
        b=JbhTqW60384VJGBFscgxKmd9WYVDYdOdv2sk1XrON8sPfSigYHGuTGC9r7Vz0L3y6m
         aDetr+FXs+7WPYcloW2o6e7HRSFVF0YzHl+mP1UGOOzurEolwmz4X8y8VjJa0/9tvtaB
         szfOh8QPQL9Z05r/vcbKfG6PC8IL8EzmKYHh25Og8qb849maHKmmaQNwlJnY0S/JCBn/
         r1Cp6iV01een/HKhkz0bOTIS84UzyHip5FZTFSTYYi0x+CV/VKjb9cGNTjYSMi1Q352P
         qu1kmFS4/OoWhQt6PwQBAOjsZEZvLSUW0Gv+/znaDl7Ziv5euRwdJeLjVzmvtF/UzQou
         +htQ==
X-Gm-Message-State: AOAM531Mt9XJ/6WWR2BCiV1vCmwBVWKHDp34r+3fHViEQY51+YipxcxP
        fTHpn40llqxJtkpMhvhlKaFVpg==
X-Google-Smtp-Source: ABdhPJwcAhbH3HWpE9v4PGGbjXySJNWXJ7SlSSLlQYMmW/hrGQjYhOvimGNzwvtRAEXDr+ixOiAiNQ==
X-Received: by 2002:aa7:84d4:: with SMTP id x20mr1842223pfn.96.1597277488005;
        Wed, 12 Aug 2020 17:11:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id ez7sm3139142pjb.10.2020.08.12.17.11.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 17:11:27 -0700 (PDT)
Date:   Thu, 13 Aug 2020 08:11:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf test: Introduce script for Arm CoreSight testing
Message-ID: <20200813001121.GB16667@leoy-ThinkPad-X240s>
References: <20200806070213.7386-1-leo.yan@linaro.org>
 <cf57e876-3645-53f0-6333-ecb6ce3597d5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf57e876-3645-53f0-6333-ecb6ce3597d5@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Aug 12, 2020 at 05:59:55PM +0100, Suzuki Kuruppassery Poulose wrote:
> Hi Leo,
> 
> On 08/06/2020 08:02 AM, Leo Yan wrote:
> > We need a simple method to test Perf with Arm CoreSight drivers, this
> > could be used for smoke testing when new patch is coming for perf or
> > CoreSight drivers, and we also can use the test to confirm if the
> > CoreSight has been enabled successfully on new platforms.
> > 
> > This patch introduces the shell script test_arm_coresight.sh which is
> > under the 'pert test' framework.  This script provides three testing
> > scenarios:
> 
> Thank you for this testcase. It is a very good tool for people
> check their system for CoreSight driver functionality.

My pleasure!  This patch is except for ourselves testing, one main
purpose is to integrate Perf testing with LKFT [1] for Arm related
PMU events.

[1] https://lkft.linaro.org/tests/

> > Test scenario 1: traverse all possible paths between source and sink
> > 
> > For traversing possible paths, simply to say, the testing rationale
> > is source oriented testing, it traverses every source (now only refers
> > to ETM device) and test its all possible sinks.  To search the complete
> > paths from one specific source to its sinks, this patch relies on the
> > sysfs '/sys/bus/coresight/devices/devX/out:Y' for depth-first search
> > (DFS) for iteration connected device nodes, if the output device is
> > detected as one of ETR, ETF, or ETB types then it will test trace data
> 
> Please see my suggestion below, to use "enable_sink" as an indicator
> for a sink device.
> 
> > recording and decoding for this PMU device.
> > 
> > The script runs three output testings for every trace data:
> > - Test branch samples dumping with 'perf script' command;
> > - Test branch samples reporting with 'perf report' command;
> > - Use option '--itrace=i1000i' to insert synthesized instructions events
> >    and the script will check if perf can output the percentage value
> >    successfully based on the instruction samples.
> > 
> > Test scenario 2: CPU wide mode test
> >  > For CPU wide mode testing, it passes option '-a' to perf tool to enable
> > tracing on all CPUs, so it's hard to say which program will be traced.
> 
> Isn't this system-wide, when you trace all CPUs ? In CPU wide mode,
> you specify a list of CPUs (-C ?). I always get confused here.

Agree, it is system-wide tracing.  Will fix.

> > But perf tool itself contributes much overload in this case, so it will
> > parse trace data and check if process 'perf' can be detected or not.
> > 
> > diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> > new file mode 100755
> > index 000000000000..73b973bada26
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> > @@ -0,0 +1,172 @@
> > +#!/bin/sh
> > +# Check Arm CoreSight trace data recording and branch samples
> > +
> > +# Uses the 'perf record' to record trace data with Arm CoreSight sinks;
> > +# then verify if there have any branch samples and instruction samples
> > +# are generated by CoreSight with 'perf script' and 'perf report'
> > +# commands.
> > +
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Leo Yan <leo.yan@linaro.org>, 2020
> > +
> > +perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
> > +file=$(mktemp /tmp/temporary_file.XXXXX)
> > +
> > +skip_if_no_cs_etm_event() {
> > +	perf list | grep -q 'cs_etm//' && return 0
> > +
> > +	# cs_etm event doesn't exist
> > +	return 2
> > +}
> > +
> > +skip_if_no_cs_etm_event || exit 2
> > +
> > +record_touch_file() {
> > +	echo "Recording trace (only user mode) with path: CPU$2 => $1"
> > +	perf record -o ${perfdata} -e cs_etm/@$1/u --per-thread \
> > +		-- taskset -c $2 touch $file
> > +}
> > +
> > +perf_script_branch_samples() {
> > +	echo "Looking at perf.data file for dumping branch samples:"
> > +
> > +	# Below is an example of the branch samples dumping:
> > +	#   touch  6512          1         branches:u:      ffffb220824c strcmp+0xc (/lib/aarch64-linux-gnu/ld-2.27.so)
> > +	#   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> > +	#   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> > +	perf script -F,-time -i ${perfdata} | \
> > +		egrep " +$1 +[0-9]+ .* +branches:([u|k]:)? +"
> > +}
> > +
> > +perf_report_branch_samples() {
> > +	echo "Looking at perf.data file for reporting branch samples:"
> > +
> > +	# Below is an example of the branch samples reporting:
> > +	#   73.04%    73.04%  touch    libc-2.27.so      [.] _dl_addr
> > +	#    7.71%     7.71%  touch    libc-2.27.so      [.] getenv
> > +	#    2.59%     2.59%  touch    ld-2.27.so        [.] strcmp
> > +	perf report --stdio -i ${perfdata} | \
> > +		egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 "
> > +}
> > +
> > +perf_report_instruction_samples() {
> > +	echo "Looking at perf.data file for instruction samples:"
> > +
> > +	# Below is an example of the instruction samples reporting:
> > +	#   68.12%  touch    libc-2.27.so   [.] _dl_addr
> > +	#    5.80%  touch    libc-2.27.so   [.] getenv
> > +	#    4.35%  touch    ld-2.27.so     [.] _dl_fixup
> > +	perf report --itrace=i1000i --stdio -i ${perfdata} | \
> > +		egrep " +[0-9]+\.[0-9]+% +$1"
> > +}
> > +
> > +arm_cs_iterate_devices() {
> > +	for dev in $1/connections/out\:*; do
> > +
> > +		# Skip testing if it's not a directory
> > +		! [ -d $dev ] && continue;
> > +
> > +		# Read out its symbol link file name
> > +		path=`readlink -f $dev`
> > +
> > +		# Extract device name from path, e.g.
> > +		#   path = '/sys/devices/platform/20010000.etf/tmc_etf0'
> > +		#     `> device_name = 'tmc_etf0'
> > +		device_name=`echo $path | awk -F/ '{print $(NF)}'`
> > +
> > +		echo $device_name | egrep -q "etr|etb|etf"
> 
> Could we check for the existence of "enable_sink" instead, for detecting
> if this is a sink device ? That way, we are covered for future cases of
> a new sink type, and is more reliable.

Good suggestion, will fix.

> > +
> > +		# Only test if the output device is ETR/ETB/ETF
> > +		if [ $? -eq 0 ]; then
> > +
> > +			pmu_dev="/sys/bus/event_source/devices/cs_etm/sinks/$device_name"
> > +
> > +			# Exit if PMU device node doesn't exist
> > +			if ! [ -f $pmu_dev ]; then
> > +				echo "PMU device $pmu_dev doesn't exist"
> 
> Misleading output. $pmu_dev is not a PMU device. Instead, it is one of
> the supported sinks by the PMU.

Will fix.

> > +				exit 1
> > +			fi
> > +
> > +			record_touch_file $device_name $2 &&
> > +				perf_script_branch_samples touch &&
> > +				perf_report_branch_samples touch &&
> > +				perf_report_instruction_samples touch
> > +
> > +			err=$?
> > +
> > +			# Exit when find failure
> > +			[ $err != 0 ] && exit $err
> > +
> > +			rm -f ${perfdata}
> > +			rm -f ${file}
> > +		fi
> > +
> > +		arm_cs_iterate_devices $dev $2
> > +	done
> > +}
> > +
> > +arm_cs_etm_traverse_path_test() {
> > +	# Iterate for every ETM device
> > +	for dev in /sys/bus/coresight/devices/etm*; do
> > +
> > +		# Find the ETM device belonging to which CPU
> > +		cpu=`cat $dev/cpu`
> > +
> > +		echo $dev
> > +		echo $cpu
> > +
> > +		# Use depth-first search (DFS) to iterate outputs
> > +		arm_cs_iterate_devices $dev $cpu
> > +	done
> > +}
> > +
> > +arm_cs_etm_cpu_wide_test() {
> > +	echo "Recording trace with CPU wide mode"
> > +	perf record -o ${perfdata} -e cs_etm// -a -- ls
> > +
> > +	perf_script_branch_samples perf &&
> > +	perf_report_branch_samples perf &&
> > +	perf_report_instruction_samples perf
> > +
> > +	err=$?
> > +
> > +	# Exit when find failure
> > +	[ $err != 0 ] && exit $err
> > +
> > +	rm -f ${perfdata}
> > +	rm -f ${file}
> > +}
> > +
> > +arm_cs_etm_snapshot_test() {
> > +	echo "Recording trace with snapshot mode"
> > +	perf record -o ${perfdata} -e cs_etm// -S --per-thread \
> > +		-- dd if=/dev/zero of=/dev/null &
> 
> As far as I understand, --per-thread option is not needed anymore
> for normal tracing (irrespective of whether your application is
> multi-threaded or not)

I noted before you had some discussion with Mathieu for AUX buffer :)
will remove --per-thread option.

> > +	PERFPID=$!
> > +
> > +	# Wait for perf program
> > +	sleep 1
> > +
> > +	# Send signal to snapshot trace data
> > +	kill -USR2 $PERFPID
> > +
> > +	# Stop perf program
> > +	kill $PERFPID
> > +	wait $PERFPID
> > +
> > +	perf_script_branch_samples dd &&
> > +	perf_report_branch_samples dd &&
> > +	perf_report_instruction_samples dd
> > +
> > +	err=$?
> > +
> > +	# Exit when find failure
> > +	[ $err != 0 ] && exit $err
> > +
> > +	rm -f ${perfdata}
> > +	rm -f ${file}
> > +}
> > +
> > +arm_cs_etm_traverse_path_test
> > +arm_cs_etm_cpu_wide_test
> > +arm_cs_etm_snapshot_test
> > +exit 0
> > 
> 
> 
> Rest looks OK to me.

Thanks a lot for your reviewing.

Leo
