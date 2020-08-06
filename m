Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D5CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFA9230FF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596730859;
	bh=LToSf9qiFfcTFFkO5/+RnwE73rgrNVOOXFCuz8bkIZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k07UMCoseWsAPuUD3rUdUyRC/ZNo7lqr0NHAMs2npzqnIKMHRMs4xyqTZhGiROvvF
	 FxJRL0zfiBgflyJtuy0wTmhvPimEPKY7Exz15BImuBUlvOzipZu3u4U/nQbowYTbvr
	 /VQZ3L1im1yPwJ+pLYhmjtju8ZtBUyDMTzR0CvfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgHFQUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:20:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbgHFQRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:23 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.129.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F70323107;
        Thu,  6 Aug 2020 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596717728;
        bh=LToSf9qiFfcTFFkO5/+RnwE73rgrNVOOXFCuz8bkIZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S1+5mX2bU/0rMTqkWBQLOK/cXVGnW3qRmge/+BmJBQYHzqah5ARosH9up1eQjVjkl
         zHdE2T7vF5o9voFcyVCixcd5a7SJAb24v/4S3+cvb9pFuYZy4d8m4o+MLoBaJUss8F
         mNyu711Oo/LBN+TxJbkk86kKMBPk+EwsdZ/9Gtns=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 088C640524; Thu,  6 Aug 2020 09:42:05 -0300 (-03)
Date:   Thu, 6 Aug 2020 09:42:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     David Ahern <dsahern@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        =?iso-8859-1?Q?Genevi=E8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH v2 3/7] perf tools: Store clock references for
 -k/--clockid option
Message-ID: <20200806124204.GE71359@kernel.org>
References: <20200805093444.314999-1-jolsa@kernel.org>
 <20200805093444.314999-4-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805093444.314999-4-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 05, 2020 at 11:34:40AM +0200, Jiri Olsa escreveu:
> Adding new CLOCK_DATA feature that stores reference times
> when -k/--clockid option is specified.
> 
> It contains clock id and its reference time together with
> wall clock time taken at the 'same time', both values are
> in nanoseconds.
> 
> The format of data is as below:
> 
>   struct {
>        u32 version;  /* version = 1 */
>        u32 clockid;
>        u64 wall_clock_ns;
>        u64 clockid_time_ns;
>   };
> 
> This clock reference times will be used in following changes
> to display wall clock for perf events.
> 
> It's available only for recording with clockid specified,
> because it's the only case where we can get reference time
> to wallclock time. It's can't do that with perf clock yet.

Thanks, applied and added this committer testing section:


    Committer testing:

      $ perf record -h -k

       Usage: perf record [<options>] [<command>]
          or: perf record [<options>] -- <command> [<options>]

          -k, --clockid <clockid>
                                clockid to use for events, see clock_gettime()

      $ perf record -k monotonic sleep 1
      [ perf record: Woken up 1 times to write data ]
      [ perf record: Captured and wrote 0.017 MB perf.data (8 samples) ]
      $ perf report --header-only | grep clockid -A1
      # event : name = cycles:u, , id = { 88815, 88816, 88817, 88818, 88819, 88820, 88821, 88822 }, size = 120, { sample_period, sample_freq } = 4000, sample_type = IP|TID|TIME|PERIOD, read_format = ID, disabled = 1, inherit = 1, exclude_kernel = 1, mmap = 1, comm = 1, freq = 1, enable_on_exec = 1, task = 1, precise_ip = 3, sample_id_all = 1, exclude_guest = 1, mmap2 = 1, comm_exec = 1, use_clockid = 1, ksymbol = 1, bpf_event = 1, clockid = 1
      # CPU_TOPOLOGY info available, use -I to display
      --
      # clockid frequency: 1000 MHz
      # cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
      # clockid: monotonic (1)
      # reference time: 2020-08-06 09:40:21.619290 = 1596717621.619290 (TOD) = 21931.077673635 (monotonic)
      $

