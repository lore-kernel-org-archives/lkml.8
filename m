Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C84DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63ED21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+a5VjJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgIGNJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgIGNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:06:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4301DC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:06:34 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so1561645pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0/V3fLMj9lYwLanInBcHznys9zh1j8sV7DalHVV0pRY=;
        b=Z+a5VjJS0u0VEfssYl4+eUN0B+V/zdQhKPQTPacR7BAf8ET2R+K37UD10tVZgRi19Z
         XHadsEJ+QoodGQW5zfQ+SPXo+cyeLUbzgRCF1wkmGCWvVY8WTUCEed8hAEXM/lc6hVbk
         sN7wuuuaGj261/c92BUgwwDYzecCN7QAM9WDDzv1GG1KuHVfOZjdASWXWOzmtDM8lrg+
         gzD5Pm9dbLqIcSOmPP/XLMOS76hlGPNT73Uj1GoVWGciyt6dSw29yUYzUeKeb02DUJLB
         hQtzRJjjzDY4122DN919m+gEn+VtuJkzzbixeMivZxZ1rmsa9HIUJ0qz43IpFIIeVzhz
         IfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0/V3fLMj9lYwLanInBcHznys9zh1j8sV7DalHVV0pRY=;
        b=VkimUhOcSp1v+eduL/3p15TKPDoITF+I4QKo3V09DzCraktp3u31dp84XqxOMDnNmg
         bvdeUUalacYbi/TSoheM/ICYmS9W4fVBi3Id7qaGurSQeDAwoNUQ3QUVpM7OVzZkKyx3
         /e2Q2ims20HB+xSSWXDMrJ3m1I6knnbhnpSbZmCRGCJNVohKX1FF/ClTjeks8Um6/R3L
         GMyXEH4JNWqX1T7+pJDXgI3Bfu2W9uysvm6kyIpCPInQqcUr+bDojGLXCSg6Bts5OfYs
         lzGOw0NKyZJ5hNfPNcxzH9LLHnPxb46Nmy9Jcfq3TXd5dHy/XrTeUHhZUjVuxsGpp2Mw
         7vTQ==
X-Gm-Message-State: AOAM531vzvSRe+5tLIJ1VIdAkj3O4kSPgq9xitP0lNCULXCpTLvGt5g+
        U/JBcBbL/zxGgly2VyHm9Nfw9Q==
X-Google-Smtp-Source: ABdhPJwR75lPV8O2N+BbGx11paeE70ejFujSD//Ej8TWUfJlTCHna/svEUCcekOTbQJ307wZOjmb2w==
X-Received: by 2002:a05:6a00:174c:: with SMTP id j12mr21213191pfc.181.1599483993612;
        Mon, 07 Sep 2020 06:06:33 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 8sm13012053pjx.14.2020.09.07.06.06.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Sep 2020 06:06:33 -0700 (PDT)
Date:   Mon, 7 Sep 2020 21:06:24 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org, mike.leach@linaro.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] perf test: Introduce script for Arm CoreSight testing
Message-ID: <20200907130624.GD25511@leoy-ThinkPad-X240s>
References: <20200907072902.28068-1-leo.yan@linaro.org>
 <c64a489d-b151-b015-5806-a8daec34b429@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c64a489d-b151-b015-5806-a8daec34b429@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Sep 07, 2020 at 11:50:10AM +0100, Suzuki Kuruppassery Poulose wrote:
> On 09/07/2020 08:29 AM, Leo Yan wrote:
> > We need a simple method to test Perf with Arm CoreSight drivers, this
> > could be used for smoke testing when new patch is coming for perf or
> > CoreSight drivers, and we also can use the test to confirm if the
> > CoreSight has been enabled successfully on new platforms.
> > 
> > This patch introduces the shell script test_arm_coresight.sh which is
> > under the 'pert test' framework.  This script provides three testing
> > scenarios:
> > 
> > Test scenario 1: traverse all possible paths between source and sink
> > 
> > For traversing possible paths, simply to say, the testing rationale
> > is source oriented testing, it traverses every source (now only refers
> > to ETM device) and test its all possible sinks.  To search the complete
> > paths from one specific source to its sinks, this patch relies on the
> > sysfs '/sys/bus/coresight/devices/devX/out:Y' for depth-first search
> > (DFS) for iteration connected device nodes, if the output device is
> > detected as a sink device (the script will exclude TPIU device which can
> > not be supported for perf PMU), then it will test trace data recording
> > and decoding for it.
> > 
> > The script runs three output testings for every trace data:
> > - Test branch samples dumping with 'perf script' command;
> > - Test branch samples reporting with 'perf report' command;
> > - Use option '--itrace=i1000i' to insert synthesized instructions events
> >    and the script will check if perf can output the percentage value
> >    successfully based on the instruction samples.
> > 
> > Test scenario 2: system-wide test
> > 
> > For system-wide testing, it passes option '-a' to perf tool to enable
> > tracing on all CPUs, so it's hard to say which program will be traced.
> > But perf tool itself contributes much overload in this case, so it will
> > parse trace data and check if process 'perf' can be detected or not.
> > 
> > Test scenario 3: snapshot mode test.
> > 
> > For snapshot mode testing, it uses 'dd' command to launch a long running
> > program, so this can give chance to send signal -USR2; it will check the
> > captured trace data contains 'dd' related thread info or not.
> > 
> > If any test fails, it will report failure and directly exit with error.
> > This test will be only applied on a platform with PMU event 'cs_etm//',
> > otherwise will skip the testing.
> > 
> > Below is detailed usage for it:
> > 
> >    # cd $linux/tools/perf  -> This is important so can use shell script
> >    # perf test list
> >      [...]
> >      70: probe libc's inet_pton & backtrace it with ping
> >      71: Check Arm CoreSight trace data recording and synthesized samples
> >      72: Check open filename arg using perf trace + vfs_getname
> >      73: Zstd perf.data compression/decompression
> >      74: Add vfs_getname probe to get syscall args filenames
> >      75: Use vfs_getname probe to get syscall args filenames
> > 
> >    # perf test 71
> >      66: Check Arm CoreSight trace data recording and branch samples: Ok
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> > 
> > Changes in v6:
> > - Fixed indentation for arm_cs_iterate_devices() (Mathieu);
> > - Changed to remove ${perfdata} and ${file} for failure cases (Mathieu);
> > - Changed test name from "... branch samples" to "... synthesized samples".
> 
> minor nit: Instead of spilling the cleanup of the files allover the
> tests, could we use trap ... exit to cleanup ?
> 
> i.e,
> 
> cleanup_files()
> {
> 	# Cleanups here
> 	# rm -f ....
> }
> 
> trap cleanup_files exit

This and below suggestions are good for me, have followed them to respin
patch v7 and sent out for review.

Thanks a lot for reviewing and suggestions!

Leo

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
> 
> Couldn't this be :
> 		device_name=$(basename $path) ?
> 
> 
> > +
> > +
> 
>  --- Cut here ---
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
> 
> This may not be fatal to the testing. Could be a warning and continue on
> to the next device ?
> 
> > +			fi
> 
> ---- Cut end ---
> 
> minor nit: Could this be moved into a function ? say, is_device_sink() ?
> 
> Rest looks fine to me.
> 
> Cheers
> Suzuki
