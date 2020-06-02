Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5501BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276992086A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 13:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591105382;
	bh=hhMZhOjYa1IjqTSmpKsYB/QGeIboewsrBhSzT+3FAws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=laC0auG2NnCylA1WEj+eVSiYuMTDb8Gv4Q8TMlUn9MpahvdGMwzE+Rj22og0yDhqc
	 NvkH63m3iH6yoia7Mp/eQxJ+9AV/AXIyMK1CwZJVZXh/AnwK3BMFWdhTOa1AcdouTp
	 RinOw/wHvUBWRQNCFLtha7Sx4O5QPdNaa8hCP3Y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFBNnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 09:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgFBNnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 09:43:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B19F206A2;
        Tue,  2 Jun 2020 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591105379;
        bh=hhMZhOjYa1IjqTSmpKsYB/QGeIboewsrBhSzT+3FAws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3/Mt5Y61hT5cCT5fdWBA031S28fIwyYFeStyEGKG01bMQhMVBzcXNB0bNqLvRv/n
         XgvAQk/V/1X9na3Cj6Bu0TGXw9qLGp67cRV0yfdP+00mjefSYZUcTHcKkEwgAeDiRI
         hCfj6HK9dDCXcV9jZkMU5xOawcJx3Tw727jP2nyI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD97E40AFD; Tue,  2 Jun 2020 10:42:56 -0300 (-03)
Date:   Tue, 2 Jun 2020 10:42:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCHv3] perf stat: Ensure group is defined on top of the same
 cpu mask
Message-ID: <20200602134256.GO31795@kernel.org>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava>
 <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
 <20200602101736.GE1112120@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602101736.GE1112120@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 02, 2020 at 12:17:36PM +0200, Jiri Olsa escreveu:
> Jin Yao reported the issue (and posted first versions of this change)
> with groups being defined over events with different cpu mask.
 
> This causes assert aborts in get_group_fd, like:
 
>   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
>   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
>   Aborted
 
> All the events in the group have to be defined over the same
> cpus so the group_fd can be found for every leader/member pair.
 
> Adding check to ensure this condition is met and removing the
> group (with warning) if we detect mixed cpus, like:
 
>   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
>   WARNING: event cpu maps do not match, disabling group:
>     anon group { power/energy-cores/, cycles }
>     anon group { instructions, power/energy-cores/ }

So it doesn't disable the 'group', it disables the 'grouping' of those
events, right? I.e. reading the WARNING, I thought that it would count
nothing, since it lists both groups as being disabled, but when I tested
I noticed that:

  [root@seventh ~]# perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
  WARNING: grouped events cpus do not match, disabling group:
    anon group { power/energy-cores/, cycles }
    anon group { instructions, power/energy-cores/ }
  ^C
   Performance counter stats for 'system wide':
  
               12.62 Joules power/energy-cores/
         106,920,637        cycles
          80,228,899        instructions              #    0.75  insn per cycle
               12.62 Joules power/energy-cores/
  
        14.514476987 seconds time elapsed
  
  
  [root@seventh ~]#

  I.e. it counted the events, ungrouped, or am I missing something?

If I do:

  [root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' -a sleep 2
  
   Performance counter stats for 'system wide':
  
                1.73 Joules power/energy-cores/                                         
                0.92 Joules power/energy-ram/                                           
          12,191,658        instructions              #    0.67  insn per cycle         
          18,275,233        cycles                                                      
  
         2.001272492 seconds time elapsed
  
  [root@seventh ~]# 

It works, grouped. One observation, shouldn't we somehow show in the
output that the first two were indeed grouped, ditto for the second two?

Also, this needs improvement:

  [root@seventh ~]# perf stat -e '{power/energy-cores/,power/energy-ram/},{instructions,cycles}' sleep 2
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (power/energy-cores/).
  /bin/dmesg | grep -i perf may provide additional information.
  
  [root@seventh ~]#

Probably stating that the power/ events can only be done on a system
wide mode or per-cpu?

I'm applying the patch now, with the above observations as committer
notes, we can improve this in follow on patch,

- Arnaldo
 
> Ian asked also for cpu maps details, it's displayed in verbose mode:
> 
>   $ sudo perf stat -e '{cycles,power/energy-cores/}' -v
>   WARNING: group events cpu maps do not match, disabling group:
>     anon group { power/energy-cores/, cycles }
>        power/energy-cores/: 0
>        cycles: 0-7
>     anon group { instructions, power/energy-cores/ }
>        instructions: 0-7
>        power/energy-cores/: 0
> 
> Fixes: 6a4bb04caacc8 ("perf tools: Enable grouping logic for parsed events")
> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 55 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
>  v3 changes:
>    - reword the warning with Ian's suggestion
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b2b79aa161dd..9be020e0098a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -190,6 +190,59 @@ static struct perf_stat_config stat_config = {
>  	.big_num		= true,
>  };
>  
> +static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> +{
> +	if (!a->core.cpus && !b->core.cpus)
> +		return true;
> +
> +	if (!a->core.cpus || !b->core.cpus)
> +		return false;
> +
> +	if (a->core.cpus->nr != b->core.cpus->nr)
> +		return false;
> +
> +	for (int i = 0; i < a->core.cpus->nr; i++) {
> +		if (a->core.cpus->map[i] != b->core.cpus->map[i])
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void evlist__check_cpu_maps(struct evlist *evlist)
> +{
> +	struct evsel *evsel, *pos, *leader;
> +	char buf[1024];
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		leader = evsel->leader;
> +
> +		/* Check that leader matches cpus with each member. */
> +		if (leader == evsel)
> +			continue;
> +		if (cpus_map_matched(leader, evsel))
> +			continue;
> +
> +		/* If there's mismatch disable the group and warn user. */
> +		WARN_ONCE(1, "WARNING: grouped events cpus do not match, disabling group:\n");
> +		evsel__group_desc(leader, buf, sizeof(buf));
> +		pr_warning("  %s\n", buf);
> +
> +		if (verbose) {
> +			cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
> +			pr_warning("     %s: %s\n", leader->name, buf);
> +			cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
> +			pr_warning("     %s: %s\n", evsel->name, buf);
> +		}
> +
> +		for_each_group_evsel(pos, leader) {
> +			pos->leader = pos;
> +			pos->core.nr_members = 0;
> +		}
> +		evsel->leader->core.nr_members = 0;
> +	}
> +}
> +
>  static inline void diff_timespec(struct timespec *r, struct timespec *a,
>  				 struct timespec *b)
>  {
> @@ -2113,6 +2166,8 @@ int cmd_stat(int argc, const char **argv)
>  		goto out;
>  	}
>  
> +	evlist__check_cpu_maps(evsel_list);
> +
>  	/*
>  	 * Initialize thread_map with comm names,
>  	 * so we could print it out on output.
> -- 
> 2.25.4
> 

-- 

- Arnaldo
