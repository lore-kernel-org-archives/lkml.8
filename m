Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B684C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 11:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A077207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 11:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597231634;
	bh=014WS9rytNGQq7H8Yl5XjDfv6VMOqc3NiFeQUb5YyJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u6hu1OUbsEyq0fhr7DqZ4x99arJbVfUfyQMzzcbmZWbRhmZktpVm5mst+gWVtWYBW
	 LjvlXweMU1LvbDt2tAGVrBtgddzbjlpQ2H682x6Gl84BgTRciimHsyNDp5i5NvL/sQ
	 WuSQ94c9pwQXNXJPvVx+eA94jM7H6fzltRXn7jOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHLL1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 07:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgHLL1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 07:27:12 -0400
Received: from quaco.ghostprotocols.net (179.176.8.134.dynamic.adsl.gvt.net.br [179.176.8.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09756207F7;
        Wed, 12 Aug 2020 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597231631;
        bh=014WS9rytNGQq7H8Yl5XjDfv6VMOqc3NiFeQUb5YyJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVaqGAzGWrljkGytCQvrI3N6xOXfhBRHIrrTrlitTDF7AEHwL3Sssf5VSafMBBp9c
         KZLIPST+noIxIe7fNGytpqlNly5TLM7spfVcN3GKn8yF3X9/MFEJfeuVKoUeBIqi2V
         n0SNc01jTFjkO1TjIyM0i7EUP+B5B24ccFNGASms=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6CC22403C6; Wed, 12 Aug 2020 08:27:08 -0300 (-03)
Date:   Wed, 12 Aug 2020 08:27:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] Fix s390x compile error on F32 utils/stat-display.c
Message-ID: <20200812112708.GA13995@kernel.org>
References: <20200722092053.22345-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722092053.22345-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 22, 2020 at 11:20:53AM +0200, Thomas Richter escreveu:
> Fix a compile error on F32 and gcc version 10.1 on s390 in file
> utils/stat-display.c.  The error does not show up with make DEBUG=y.
> In fact the issue shows up when using both compiler options
> -O6 and -D_FORTIFY_SOURCE=2 (which are omitted with DEBUG=Y).
> 
> This is the offending call chain:
> print_counter_aggr()
>   printout(config, -1, 0, ...)  with 2nd parm id set to -1
>     aggr_printout(config, x, id --> -1, ...) which leads to this code:
> 		case AGGR_NONE:
>                 if (evsel->percore && !config->percore_show_thread) {
>                         ....
>                 } else {
>                         fprintf(config->output, "CPU%*d%s",
>                                 config->csv_output ? 0 : -7,
>                                 evsel__cpus(evsel)->map[id],
> 				                        ^^ id is -1 !!!!
>                                 config->csv_sep);
>                 }
> 
> This is a compiler inlining issue which is detected on s390 but not on
> other plattforms.

What is the sequence of events that gets to this? I.e. is it valid to
get a config->aggr_mode == AGGR_NONE, then have evsel not be percore and
config->percore_show_thread to be false?

I wonder if this won't be papering over some bug :-\

Jin?

This is where this came from:
commit 4fc4d8dfa056dfd48afe73b9ea3b7570ceb80b9c (tag: perf-core-for-mingo-5.2-20190517)
Author: Jin Yao <yao.jin@linux.intel.com>
Date:   Fri Apr 12 21:59:49 2019 +0800

    perf stat: Support 'percore' event qualifier

    With this patch, we can use the 'percore' event qualifier in perf-stat.

---

Also please add at least Jiri and Namhyung on the CC list, having the
person that added that array usage also helps.

[acme@quaco perf]$ scripts/get_maintainer.pl tools/perf | grep reviewer
Mark Rutland <mark.rutland@arm.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Jiri Olsa <jolsa@redhat.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Namhyung Kim <namhyung@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
[acme@quaco perf]$

Thanks,

- Arnaldo
 
> Output before:
>  # make util/stat-display.o
>     .....
> 
>   util/stat-display.c: In function ‘perf_evlist__print_counters’:
>   util/stat-display.c:121:4: error: array subscript -1 is below array
>       bounds of ‘int[]’ [-Werror=array-bounds]
>   121 |    fprintf(config->output, "CPU%*d%s",
>       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   122 |     config->csv_output ? 0 : -7,
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   123 |     evsel__cpus(evsel)->map[id],
>       |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   124 |     config->csv_sep);
>       |     ~~~~~~~~~~~~~~~~
>   In file included from util/evsel.h:13,
>                  from util/evlist.h:13,
>                  from util/stat-display.c:9:
>   /root/linux/tools/lib/perf/include/internal/cpumap.h:10:7:
>   note: while referencing ‘map’
>    10 |  int  map[];
>       |       ^~~
>   cc1: all warnings being treated as errors
>   mv: cannot stat 'util/.stat-display.o.tmp': No such file or directory
>   make[3]: *** [/root/linux/tools/build/Makefile.build:97: util/stat-display.o]
>   Error 1
>   make[2]: *** [Makefile.perf:716: util/stat-display.o] Error 2
>   make[1]: *** [Makefile.perf:231: sub-make] Error 2
>   make: *** [Makefile:110: util/stat-display.o] Error 2
>   [root@t35lp46 perf]#
> 
> Output after:
>   # make util/stat-display.o
>     .....
>   CC       util/stat-display.o
>   [root@t35lp46 perf]#
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/util/stat-display.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index 57d0706e1330..e49e544188e4 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -118,10 +118,11 @@ static void aggr_printout(struct perf_stat_config *config,
>  				config->csv_output ? 0 : -3,
>  				cpu_map__id_to_cpu(id), config->csv_sep);
>  		} else {
> -			fprintf(config->output, "CPU%*d%s",
> -				config->csv_output ? 0 : -7,
> -				evsel__cpus(evsel)->map[id],
> -				config->csv_sep);
> +			if (id > -1)
> +				fprintf(config->output, "CPU%*d%s",
> +					config->csv_output ? 0 : -7,
> +					evsel__cpus(evsel)->map[id],
> +					config->csv_sep);
>  		}
>  		break;
>  	case AGGR_THREAD:
> -- 
> 2.26.2
> 

-- 

- Arnaldo
