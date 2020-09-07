Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD4DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 459AB20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdml0E1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgIGHdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgIGHdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:33:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69BC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:33:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id n3so7116524pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 00:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5VCG27M6274h/1+joz9qyrt3KMHxew2mVHwgVex1fUc=;
        b=tdml0E1UZcTVH3UfO+B+zO6eXIq0c7FtgNSYTTOUOEt6a8Df1Xbw1cvLOqf+ZuyiLa
         0QuNQbGOJHHxdI24diposPp+RP554+03o1nFNzwjqbZc6Zd9hAk9j35so+tZJQ7Tc9M9
         BlT43t0b0Tr/FYTpzOWBDK+KWelAcPPP7nvHx9KRPOLD/UWt+E32bQqriPMc0sDM2O96
         EVVg8eUXzBXmL+E3Kpity9rNvDeca/0B0VbYQJioTHcjPD2puk3aDF8y0sls+knO9B5W
         7ncXfcvZUh05e3ZyU4CfBtWVRtiAFPQQkE12YK5XkIQARH7594FG7SENwF2f5czRqW5+
         7dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5VCG27M6274h/1+joz9qyrt3KMHxew2mVHwgVex1fUc=;
        b=pHE20iNULYO5IRtkZZoIHeCvZFIsTjpIyruAcGF/vZC+BCvR3a7xl5mc/6NSVARPlD
         jCw97P2wx4kBQZklC2VD2MSVccAG5P7nLRc9spXMIbZiztJTmL4myEDCpx04P+vmRXjO
         tUjeYfn7q0+cQbxDvmWy5xL4zBvA9K0hdVHr0k8jGPdjsVFFWqzOm502c/hikyWqKPkL
         knlmQZW/ToKrq/JwtsYYE3ADzjNTHDJEl/cN3FAgkwrUbseCc0dfRqPvMdZBvJP/AMJ2
         2gLVW35rXnhELQLXqVd6ns7GjzkEB8B7GKocWq+1BfrgDVHL3Xn/cGuGKcDCSPYM8SLj
         veNQ==
X-Gm-Message-State: AOAM5333h06IC19nJ8CxHScUK5nYPF1iX6TLvz0gp8/TPC/5w4N/ER8P
        ytgA4MjGuS2pks+FoiaOHgFWQQ==
X-Google-Smtp-Source: ABdhPJyedvU+ejyyOWRlUdXX781Y+ILx4YbbulUZZbMHE+hnH0h8UqcttFuDvwpRVYEvcFTRQ48Odg==
X-Received: by 2002:a17:902:a414:: with SMTP id p20mr12208333plq.173.1599463979959;
        Mon, 07 Sep 2020 00:32:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id d15sm14002681pfh.151.2020.09.07.00.32.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 00:32:59 -0700 (PDT)
Date:   Mon, 7 Sep 2020 15:32:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Subject: Re: [PATCH v5] perf test: Introduce script for Arm CoreSight testing
Message-ID: <20200907073248.GB25511@leoy-ThinkPad-X240s>
References: <20200818054927.8253-1-leo.yan@linaro.org>
 <20200904213332.GA361006@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904213332.GA361006@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Fri, Sep 04, 2020 at 03:33:32PM -0600, Mathieu Poirier wrote:

[...]

> > diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
> > new file mode 100755
> > index 000000000000..8696bb5df45a
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/test_arm_coresight.sh
> > @@ -0,0 +1,175 @@
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
> > +	rm -f $file
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
> > +
> > +		# If the node of "enable_sink" is existed under the device path, this
> > +		# means the device is a sink device.  Need to exclude 'tpiu' since it
> > +		# cannot support perf PMU.
> > +		echo $device_name | egrep -q -v "tpiu"
> > +		if [ $? -eq 0 -a -e "$path/enable_sink" ]; then
> > +
> > +			pmu_dev="/sys/bus/event_source/devices/cs_etm/sinks/$device_name"
> > +
> > +			# Exit if the sink device is supported by PMU or not
> > +			if ! [ -f $pmu_dev ]; then
> > +				echo "PMU doesn't support $pmu_dev"
> > +				exit 1
> > +			fi
> > +
> > +			record_touch_file $device_name $2 &&
> > +				perf_script_branch_samples touch &&
> > +				perf_report_branch_samples touch &&
> > +				perf_report_instruction_samples touch
> 
> Did you want to have an extra tab after the first line?  I think it makes the
> code harder to read, but that's a personal opinion. 

Thanks for the reviewing!  Have removed the extra tab in patch v6.

> > +
> > +			err=$?
> > +
> > +			# Exit when find failure
> > +			[ $err != 0 ] && exit $err
> 
> If a problem occurs ${perfdata} and ${file} are not removed.  The same is true
> in several instances below.

Have fixed to remove ${perfdata} and ${file} for failure cases in
patch v6.

Thanks,
Leo
