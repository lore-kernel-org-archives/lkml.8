Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28200C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF92F2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qX6ePu6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgCRT3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:29:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38567 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCRT3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:29:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so40874609qke.5;
        Wed, 18 Mar 2020 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5/PSkkEPcp0kgIR/U6MsyRw+fQwBr1NpKOokneeOM/w=;
        b=qX6ePu6FfcMDUt94H4aYNUj57To3TWZq0ah3rsDyOAjD1hplFS6jlkEeyd5t69vVhQ
         U3rs1OGSXCGF97R8JJm2qt82R9dSOGUniLQGHnSg/sTwTFcjAea9jv+nurnGtN6Pi+4j
         2rPRaI+bdRvmwRmK5E55i3+Nr/uslYZtHnptnuPXHvoe9Bcsq9yZp0PnVwKdkYZuZTVm
         Ah/1HZDdXsgDqSAu2Erii7XXsQX8dZorOxhiUjIj5CZ8ylEuZS8tP5Pcgtg/IsJURm4E
         PuqmP+eFB/Qog6JJ9D/JKCQzI9Ve2+tHUzxNDBIkMwLb4Dymw6nevQFs+B2YGUpeXgUr
         PZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5/PSkkEPcp0kgIR/U6MsyRw+fQwBr1NpKOokneeOM/w=;
        b=iyCCcXPGOjauOFXuqcgdbw9fibxeOHz4yth49imuSD27xnejSyzvlMGctprCKM+i8W
         hTSUtHFp732FBZUhdn6Ecb6wg/ZZhcQoaBwa7woCalcDyoM1oZVovEm3wcQxAHokPqgU
         7FKj9QWmPnXwtewPaF/8XjfeO7KcbxIhdJ+1DPnMupOCBBSFbT9Mq1EbR1roNngPIwXt
         e3V51i58+HxZyMsQU4OQz05udVHJNHOSuudHwywb9WRLSVLbBsRCOtLPXXZxPt6XbMSy
         r/y72w5A9gcwVnni/2hLL/LSOhDwGdw73HA/ZlRDeW8SsjQxVPSerqvmxNg9fxx9x3Pi
         0rAA==
X-Gm-Message-State: ANhLgQ0KvvPvEn7npQmLcwpWL6gID0o8YdNb6Ip3NGYIR64LBF1PCWdN
        MFBfwZtWpC5olLX/C1G3XjD1/8w3QOQ=
X-Google-Smtp-Source: ADFU+vvoKXQS3oTxGwnR92rimxKakqT3rLxUir7TGw12iktCnnWPilzem4UzKQIV42Qq2yitk8y6zw==
X-Received: by 2002:a37:a1c9:: with SMTP id k192mr5392931qke.385.1584559740589;
        Wed, 18 Mar 2020 12:29:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m10sm5239012qte.71.2020.03.18.12.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:28:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CDC4C404E4; Wed, 18 Mar 2020 16:28:56 -0300 (-03)
Date:   Wed, 18 Mar 2020 16:28:56 -0300
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v6] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Message-ID: <20200318192856.GQ11531@kernel.org>
References: <20200221101121.28920-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221101121.28920-1-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 21, 2020 at 03:41:21PM +0530, Kajol Jain escreveu:
> Commit f01642e4912b ("perf metricgroup: Support multiple
> events for metricgroup") introduced support for multiple events
> in a metric group. But with the current upstream, metric events
> names are not printed properly incase we try to run multiple
> metric groups with overlapping event.
> 
> With current upstream version, incase of overlapping metric events
> issue is, we always start our comparision logic from start.
> So, the events which already matched with some metric group also
> take part in comparision logic. Because of that when we have overlapping
> events, we end up matching current metric group event with already matched
> one.
> 
> For example, in skylake machine we have metric event CoreIPC and
> Instructions. Both of them need 'inst_retired.any' event value.
> As events in Instructions is subset of events in CoreIPC, they
> endup in pointing to same 'inst_retired.any' value.
> 
> In skylake platform:
> 
> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>      1,254,992,790      inst_retired.any          # 1254992790.0
>                                                     Instructions
>                                                   #      1.3 CoreIPC
>        977,172,805      cycles
>      1,254,992,756      inst_retired.any
> 
>        1.000802596 seconds time elapsed
> 
> command:# sudo ./perf stat -M UPI,IPC sleep 1
> 
>    Performance counter stats for 'sleep 1':
>            948,650      uops_retired.retire_slots
>            866,182      inst_retired.any          #      0.7 IPC
>            866,182      inst_retired.any
>          1,175,671      cpu_clk_unhalted.thread
> 
> Patch fixes the issue by adding a new bool pointer 'evlist_used' to keep
> track of events which already matched with some group by setting it true.
> So, we skip all used events in list when we start comparision logic.
> Patch also make some changes in comparision logic, incase we get a match
> miss, we discard the whole match and start again with first event id in
> metric event.
> 
> With this patch:
> In skylake platform:
> 
> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
> 
>  Performance counter stats for 'CPU(s) 0':
> 
>          3,348,415      inst_retired.any          #      0.3 CoreIPC
>         11,779,026      cycles
>          3,348,381      inst_retired.any          # 3348381.0
>                                                     Instructions
> 
>        1.001649056 seconds time elapsed
> 
> command:# ./perf stat -M UPI,IPC sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>          1,023,148      uops_retired.retire_slots #      1.1 UPI
>            924,976      inst_retired.any
>            924,976      inst_retired.any          #      0.6 IPC
>          1,489,414      cpu_clk_unhalted.thread
> 
>        1.003064672 seconds time elapsed
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

This is an area I think needs some improvement, look how it ends up
setting up the inst_retired.any multiple times:

[root@seventh ~]# perf stat -vv -M CoreIPC,Instructions  -C 0 sleep 1
Using CPUID GenuineIntel-6-9E-9
metric expr inst_retired.any / cycles for CoreIPC
found event inst_retired.any
found event cycles
metric expr inst_retired.any for Instructions
found event inst_retired.any
adding {inst_retired.any,cycles}:W,{inst_retired.any}:W
intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
inst_retired.any -> cpu/event=0xc0,(null)=0x1e8483/
inst_retired.any -> cpu/event=0xc0,(null)=0x1e8483/
------------------------------------------------------------
perf_event_attr:
  type                             4
  size                             120
  config                           0xc0
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
------------------------------------------------------------
perf_event_attr:
  size                             120
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING|ID|GROUP
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd 3  flags 0x8 = 4
------------------------------------------------------------
perf_event_attr:
  type                             4
  size                             120
  config                           0xc0
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 5
inst_retired.any: 0: 507070 1000948076 1000948076
cycles: 0: 1250258 1000948076 1000948076
inst_retired.any: 0: 507038 1000953052 1000953052
inst_retired.any: 507070 1000948076 1000948076
cycles: 1250258 1000948076 1000948076
inst_retired.any: 507038 1000953052 1000953052

 Performance counter stats for 'CPU(s) 0':

           507,070      inst_retired.any          #      0.4 CoreIPC
         1,250,258      cycles
           507,038      inst_retired.any          # 507038.0 Instructions

       1.000964961 seconds time elapsed

[root@seventh ~]#

And it ends up printing the "inst_retired.any" multiple times, with
different values, as after all two events were allocated, can't we
notice this and set just one inst_retired.any and then when calculating
the metrics just do something like:

  # perf stat -M CoreIPC,Instructions -C 0 sleep 1

 Performance counter stats for 'CPU(s) 0':

           507,070      inst_retired.any          #      0.4 CoreIPC,
						  #  507,070 Instructions
         1,250,258      cycles

       1.000964961 seconds time elapsed
#

?

Ditto for:

    command:# perf stat -M UPI,IPC sleep 1

     Performance counter stats for 'sleep 1':

             1,023,148      uops_retired.retire_slots #      1.1 UPI
               924,976      inst_retired.any
               924,976      inst_retired.any          #      0.6 IPC
             1,489,414      cpu_clk_unhalted.thread

           1.003064672 seconds time elapsed

Wouldn't this be better as:

    command:# perf stat -M UPI,IPC sleep 1

     Performance counter stats for 'sleep 1':

             1,023,148      uops_retired.retire_slots #      1.1 UPI
               924,976      inst_retired.any
             1,489,414      cpu_clk_unhalted.thread   #      0.6 IPC

           1.003064672 seconds time elapsed

This should help to look at many metrics at the same time by requiring
less counters to be allocated, etc, or am I missing something here?

Since this went thru multiple versions and Jiri is satisfied with it,
I'm applying the patch, but please consider this suggestion.

- Arnaldo
