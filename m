Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D90C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA672076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJ9fmbfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHLQMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHLQMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:12:54 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B52AC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:12:54 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s189so3385625iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjT/JF8m1m+YZ0EjSihaQ0RrTHM0ACFZ4T8ItHQNbfk=;
        b=XJ9fmbfcHiklhGFEDi/ajiFMlHJiPG60B1g/qd4B/aeTuAHmADdORHW+8hCo1ikS40
         xbh7ofzEE697gvnH2uyIknNLwj7ZlUnA19uBkT99Gp31ADr/LY/h/gdZH2DqDTmNu39D
         QKdNxLZVtTAUO7Zb5PxrhZNLjNpkGwbBlFxe5D10WoeJosooXNE0u3yLH4mq7DQbJwE/
         OPjoIoWKn1iNQbFEAVTYU+uo6lLcDc7iz/g1KqvD4ugpMqS1bajyQ+SbYD7uQYPkMNjm
         NtcIP94QKZVteeHwNGQXcSC1UlYRNlDVarprfV+xWrpBU9zpqFBIjwlSGJfjzvUQbxre
         HdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjT/JF8m1m+YZ0EjSihaQ0RrTHM0ACFZ4T8ItHQNbfk=;
        b=FGm63fiH/Z4OnkZzmzRLm7ArLBJcu+V9JGaI0OOcsWvMgVRuGCImIjEutE/4ZYRCsN
         80m77nLD4mov38lOq7HWi4tIjRKEY8hhMAr9xNCqCp4f+35DuvxvuBcciipj0YkmKXKf
         uh6znMOgNvS3Z2HYbm7Dl8pgRSaTDcLl+8PsvhHMsy6rg1lD7RQiwwAJDNowJIDZw6zM
         OEVFEeV6VNPFn0m40eNcqSiJ08otO71r+9QtWNNvAc+AveLWQVj2/8xd/ZeCAymIRGFt
         byZxOUj2Ok9w8pI+944a1nghLIHcKkwRLsP0uNYjmmJyt8rVCmpY+8sN1NyyyVtFJBlX
         o4Fw==
X-Gm-Message-State: AOAM533rRBh03XIrn0n0iciJIYhVAwfL/CZsmpqj4FNOllNopekzGVlB
        jOutsNgagAPnzULSlcrMbmfoTQvRG5YhzyxfRzeW0Q==
X-Google-Smtp-Source: ABdhPJxIY4D20Vk+S9IF373giS64pK7O4rT86I+rhl445bpN621yFR6lBQsbqo+h68K2f/N1liwRNOGJMyvXwpFqqAA=
X-Received: by 2002:a05:6602:2503:: with SMTP id i3mr486264ioe.165.1597248773520;
 Wed, 12 Aug 2020 09:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200806070213.7386-1-leo.yan@linaro.org>
In-Reply-To: <20200806070213.7386-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 12 Aug 2020 10:12:42 -0600
Message-ID: <CANLsYkyBGSS9dEWHt0nSeaa3KkxxGdPqRo-9m+XXGJEa2dpOEg@mail.gmail.com>
Subject: Re: [PATCH v4] perf test: Introduce script for Arm CoreSight testing
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leo and Arnaldo,

On Thu, 6 Aug 2020 at 01:02, Leo Yan <leo.yan@linaro.org> wrote:
>
> We need a simple method to test Perf with Arm CoreSight drivers, this
> could be used for smoke testing when new patch is coming for perf or
> CoreSight drivers, and we also can use the test to confirm if the
> CoreSight has been enabled successfully on new platforms.
>

I have a lot of patches to review - getting to this one will take a while.

Thanks for the patience,
Mathieu

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
> detected as one of ETR, ETF, or ETB types then it will test trace data
> recording and decoding for this PMU device.
>
> The script runs three output testings for every trace data:
> - Test branch samples dumping with 'perf script' command;
> - Test branch samples reporting with 'perf report' command;
> - Use option '--itrace=i1000i' to insert synthesized instructions events
>   and the script will check if perf can output the percentage value
>   successfully based on the instruction samples.
>
> Test scenario 2: CPU wide mode test
>
> For CPU wide mode testing, it passes option '-a' to perf tool to enable
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
>     65: probe libc's inet_pton & backtrace it with ping
>     66: Check Arm CoreSight trace data recording and branch samples
>     67: Check open filename arg using perf trace + vfs_getname
>     68: Zstd perf.data compression/decompression
>     69: Add vfs_getname probe to get syscall args filenames
>     70: Use vfs_getname probe to get syscall args filenames
>
>   # perf test 66
>     66: Check Arm CoreSight trace data recording and branch samples: Ok
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/tests/shell/test_arm_coresight.sh | 172 +++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_arm_coresight.sh
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
> +       perf list | grep -q 'cs_etm//' && return 0
> +
> +       # cs_etm event doesn't exist
> +       return 2
> +}
> +
> +skip_if_no_cs_etm_event || exit 2
> +
> +record_touch_file() {
> +       echo "Recording trace (only user mode) with path: CPU$2 => $1"
> +       perf record -o ${perfdata} -e cs_etm/@$1/u --per-thread \
> +               -- taskset -c $2 touch $file
> +}
> +
> +perf_script_branch_samples() {
> +       echo "Looking at perf.data file for dumping branch samples:"
> +
> +       # Below is an example of the branch samples dumping:
> +       #   touch  6512          1         branches:u:      ffffb220824c strcmp+0xc (/lib/aarch64-linux-gnu/ld-2.27.so)
> +       #   touch  6512          1         branches:u:      ffffb22082e0 strcmp+0xa0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> +       #   touch  6512          1         branches:u:      ffffb2208320 strcmp+0xe0 (/lib/aarch64-linux-gnu/ld-2.27.so)
> +       perf script -F,-time -i ${perfdata} | \
> +               egrep " +$1 +[0-9]+ .* +branches:([u|k]:)? +"
> +}
> +
> +perf_report_branch_samples() {
> +       echo "Looking at perf.data file for reporting branch samples:"
> +
> +       # Below is an example of the branch samples reporting:
> +       #   73.04%    73.04%  touch    libc-2.27.so      [.] _dl_addr
> +       #    7.71%     7.71%  touch    libc-2.27.so      [.] getenv
> +       #    2.59%     2.59%  touch    ld-2.27.so        [.] strcmp
> +       perf report --stdio -i ${perfdata} | \
> +               egrep " +[0-9]+\.[0-9]+% +[0-9]+\.[0-9]+% +$1 "
> +}
> +
> +perf_report_instruction_samples() {
> +       echo "Looking at perf.data file for instruction samples:"
> +
> +       # Below is an example of the instruction samples reporting:
> +       #   68.12%  touch    libc-2.27.so   [.] _dl_addr
> +       #    5.80%  touch    libc-2.27.so   [.] getenv
> +       #    4.35%  touch    ld-2.27.so     [.] _dl_fixup
> +       perf report --itrace=i1000i --stdio -i ${perfdata} | \
> +               egrep " +[0-9]+\.[0-9]+% +$1"
> +}
> +
> +arm_cs_iterate_devices() {
> +       for dev in $1/connections/out\:*; do
> +
> +               # Skip testing if it's not a directory
> +               ! [ -d $dev ] && continue;
> +
> +               # Read out its symbol link file name
> +               path=`readlink -f $dev`
> +
> +               # Extract device name from path, e.g.
> +               #   path = '/sys/devices/platform/20010000.etf/tmc_etf0'
> +               #     `> device_name = 'tmc_etf0'
> +               device_name=`echo $path | awk -F/ '{print $(NF)}'`
> +
> +               echo $device_name | egrep -q "etr|etb|etf"
> +
> +               # Only test if the output device is ETR/ETB/ETF
> +               if [ $? -eq 0 ]; then
> +
> +                       pmu_dev="/sys/bus/event_source/devices/cs_etm/sinks/$device_name"
> +
> +                       # Exit if PMU device node doesn't exist
> +                       if ! [ -f $pmu_dev ]; then
> +                               echo "PMU device $pmu_dev doesn't exist"
> +                               exit 1
> +                       fi
> +
> +                       record_touch_file $device_name $2 &&
> +                               perf_script_branch_samples touch &&
> +                               perf_report_branch_samples touch &&
> +                               perf_report_instruction_samples touch
> +
> +                       err=$?
> +
> +                       # Exit when find failure
> +                       [ $err != 0 ] && exit $err
> +
> +                       rm -f ${perfdata}
> +                       rm -f ${file}
> +               fi
> +
> +               arm_cs_iterate_devices $dev $2
> +       done
> +}
> +
> +arm_cs_etm_traverse_path_test() {
> +       # Iterate for every ETM device
> +       for dev in /sys/bus/coresight/devices/etm*; do
> +
> +               # Find the ETM device belonging to which CPU
> +               cpu=`cat $dev/cpu`
> +
> +               echo $dev
> +               echo $cpu
> +
> +               # Use depth-first search (DFS) to iterate outputs
> +               arm_cs_iterate_devices $dev $cpu
> +       done
> +}
> +
> +arm_cs_etm_cpu_wide_test() {
> +       echo "Recording trace with CPU wide mode"
> +       perf record -o ${perfdata} -e cs_etm// -a -- ls
> +
> +       perf_script_branch_samples perf &&
> +       perf_report_branch_samples perf &&
> +       perf_report_instruction_samples perf
> +
> +       err=$?
> +
> +       # Exit when find failure
> +       [ $err != 0 ] && exit $err
> +
> +       rm -f ${perfdata}
> +       rm -f ${file}
> +}
> +
> +arm_cs_etm_snapshot_test() {
> +       echo "Recording trace with snapshot mode"
> +       perf record -o ${perfdata} -e cs_etm// -S --per-thread \
> +               -- dd if=/dev/zero of=/dev/null &
> +       PERFPID=$!
> +
> +       # Wait for perf program
> +       sleep 1
> +
> +       # Send signal to snapshot trace data
> +       kill -USR2 $PERFPID
> +
> +       # Stop perf program
> +       kill $PERFPID
> +       wait $PERFPID
> +
> +       perf_script_branch_samples dd &&
> +       perf_report_branch_samples dd &&
> +       perf_report_instruction_samples dd
> +
> +       err=$?
> +
> +       # Exit when find failure
> +       [ $err != 0 ] && exit $err
> +
> +       rm -f ${perfdata}
> +       rm -f ${file}
> +}
> +
> +arm_cs_etm_traverse_path_test
> +arm_cs_etm_cpu_wide_test
> +arm_cs_etm_snapshot_test
> +exit 0
> --
> 2.17.1
>
