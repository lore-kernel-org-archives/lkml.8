Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7862C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948A72067C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgIBREF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:04:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:29925 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgIBRD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:03:58 -0400
IronPort-SDR: i0bPaJdnf3eAcwBmrofq00ucn4zQTHMZAXeXziA6VhJ1X3Ykw9+tjsf5SgZQpjIT4qhESpZcIP
 OHWaVP8eQLpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="218987975"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="218987975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 10:03:55 -0700
IronPort-SDR: ZrY24z2aQE9AVGBJ1lFeL7SsWhASatrIvonsnBe+0lsJZj4FPftWQ/iB+Sm11FeGdvMGLAuPQk
 Tu1QSDpu0+hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; 
   d="scan'208";a="341474219"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2020 10:03:55 -0700
Received: from [10.249.227.213] (abudanko-mobl.ccr.corp.intel.com [10.249.227.213])
        by linux.intel.com (Postfix) with ESMTP id 9433558010E;
        Wed,  2 Sep 2020 10:03:53 -0700 (PDT)
Subject: Re: [PATCH V2 5/6] perf record: Add 'snapshot' control command
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200901093758.32293-1-adrian.hunter@intel.com>
 <20200901093758.32293-6-adrian.hunter@intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3b080496-7357-04a3-ec9b-bf531b8ec75a@linux.intel.com>
Date:   Wed, 2 Sep 2020 20:03:52 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901093758.32293-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.09.2020 12:37, Adrian Hunter wrote:
> Add 'snapshot' control command to create an AUX area tracing snapshot the
> same as if sending SIGUSR2. The advantage of the FIFO is that access is
> governed by access to the FIFO.
> 
> Example:
> 
>  $ mkfifo perf.control
>  $ mkfifo perf.ack
>  $ cat perf.ack &
>  [1] 15235
>  $ sudo ~/bin/perf record --control fifo:perf.control,perf.ack -S -e intel_pt//u -- sleep 60 &
>  [2] 15243
>  $ ps -e | grep perf
>   15244 pts/1    00:00:00 perf
>  $ kill -USR2 15244
>  bash: kill: (15244) - Operation not permitted
>  $ echo snapshot > perf.control
>  ack
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  8 ++++----
>  tools/perf/builtin-record.c              | 24 +++++++++++++++++-------
>  tools/perf/builtin-stat.c                |  1 +
>  tools/perf/util/evlist.c                 | 11 +++++++++--
>  tools/perf/util/evlist.h                 |  5 ++++-
>  5 files changed, 35 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 2ffc1196d2b8..588e6191bf39 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -631,10 +631,10 @@ endif::HAVE_LIBPFM[]
>  --control=fd:ctl-fd[,ack-fd]::
>  ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
>  Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
> -'disable': disable events). Measurements can be started with events disabled using
> ---delay=-1 option. Optionally send control command completion ('ack\n') to ack-fd descriptor
> -to synchronize with the controlling process. Example of bash shell script to enable and
> -disable events during measurements:
> +'disable': disable events, 'snapshot': AUX area tracing snapshot). Measurements can be
> +started with events disabled using --delay=-1 option. Optionally send control command
> +completion ('ack\n') to ack-fd descriptor to synchronize with the controlling process.
> +Example of bash shell script to enable and disable events during measurements:
>  
>   #!/bin/bash
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 117dd180f780..476b34ff3152 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1593,6 +1593,16 @@ static int record__init_clock(struct record *rec)
>  	return 0;
>  }
>  
> +static void hit_auxtrace_snapshot_trigger(struct record *rec)
> +{
> +	if (trigger_is_ready(&auxtrace_snapshot_trigger)) {
> +		trigger_hit(&auxtrace_snapshot_trigger);
> +		auxtrace_record__snapshot_started = 1;
> +		if (auxtrace_record__snapshot_start(rec->itr))
> +			trigger_error(&auxtrace_snapshot_trigger);
> +	}
> +}
> +
>  static int __cmd_record(struct record *rec, int argc, const char **argv)
>  {
>  	int err;
> @@ -1937,6 +1947,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  			case EVLIST_CTL_CMD_DISABLE:
>  				pr_info(EVLIST_DISABLED_MSG);
>  				break;
> +			case EVLIST_CTL_CMD_SNAPSHOT:
> +				hit_auxtrace_snapshot_trigger(rec);

Could possibly print a messages to console that snapshot taking has started,
similar to enabling and disabling of events.

Acked-by: Alexei Budankov <alexey.budankov@linux.intel.com>

Regards,
Alexei

> +				evlist__ctlfd_ack(rec->evlist);
> +				break;
>  			case EVLIST_CTL_CMD_ACK:
>  			case EVLIST_CTL_CMD_UNSUPPORTED:
>  			default:
> @@ -2589,7 +2603,8 @@ static struct option __record_options[] = {
>  		parse_libpfm_events_option),
>  #endif
>  	OPT_CALLBACK(0, "control", &record.opts, "fd:ctl-fd[,ack-fd] or fifo:ctl-fifo[,ack-fifo]",
> -		     "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events).\n"
> +		     "Listen on ctl-fd descriptor for command to control measurement ('enable': enable events, 'disable': disable events,\n"
> +		     "\t\t\t  'snapshot': AUX area tracing snapshot).\n"
>  		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
>  		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
>  		      parse_control_option),
> @@ -2842,12 +2857,7 @@ static void snapshot_sig_handler(int sig __maybe_unused)
>  {
>  	struct record *rec = &record;
>  
> -	if (trigger_is_ready(&auxtrace_snapshot_trigger)) {
> -		trigger_hit(&auxtrace_snapshot_trigger);
> -		auxtrace_record__snapshot_started = 1;
> -		if (auxtrace_record__snapshot_start(record.itr))
> -			trigger_error(&auxtrace_snapshot_trigger);
> -	}
> +	hit_auxtrace_snapshot_trigger(rec);
>  
>  	if (switch_output_signal(rec))
>  		trigger_hit(&switch_output_trigger);
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6170226d44f9..21424ed0734b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -578,6 +578,7 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
>  				process_interval();
>  			pr_info(EVLIST_DISABLED_MSG);
>  			break;
> +		case EVLIST_CTL_CMD_SNAPSHOT:
>  		case EVLIST_CTL_CMD_ACK:
>  		case EVLIST_CTL_CMD_UNSUPPORTED:
>  		default:
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index b74e85bc683e..8cd53dbb0357 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1885,13 +1885,17 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>  		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
>  				    (sizeof(EVLIST_CTL_CMD_DISABLE_TAG)-1))) {
>  			*cmd = EVLIST_CTL_CMD_DISABLE;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_SNAPSHOT_TAG,
> +				    (sizeof(EVLIST_CTL_CMD_SNAPSHOT_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_SNAPSHOT;
> +			pr_debug("is snapshot\n");
>  		}
>  	}
>  
>  	return bytes_read ? (int)bytes_read : err;
>  }
>  
> -static int evlist__ctlfd_ack(struct evlist *evlist)
> +int evlist__ctlfd_ack(struct evlist *evlist)
>  {
>  	int err;
>  
> @@ -1927,13 +1931,16 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  			case EVLIST_CTL_CMD_DISABLE:
>  				evlist__disable(evlist);
>  				break;
> +			case EVLIST_CTL_CMD_SNAPSHOT:
> +				break;
>  			case EVLIST_CTL_CMD_ACK:
>  			case EVLIST_CTL_CMD_UNSUPPORTED:
>  			default:
>  				pr_debug("ctlfd: unsupported %d\n", *cmd);
>  				break;
>  			}
> -			if (!(*cmd == EVLIST_CTL_CMD_ACK || *cmd == EVLIST_CTL_CMD_UNSUPPORTED))
> +			if (!(*cmd == EVLIST_CTL_CMD_ACK || *cmd == EVLIST_CTL_CMD_UNSUPPORTED ||
> +			      *cmd == EVLIST_CTL_CMD_SNAPSHOT))
>  				evlist__ctlfd_ack(evlist);
>  		}
>  	}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index a5678eb5ee60..91d1da6e1fe3 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -363,6 +363,7 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>  #define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
>  #define EVLIST_CTL_CMD_DISABLE_TAG "disable"
>  #define EVLIST_CTL_CMD_ACK_TAG     "ack\n"
> +#define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
>  
>  #define EVLIST_CTL_CMD_MAX_LEN 64
>  
> @@ -370,7 +371,8 @@ enum evlist_ctl_cmd {
>  	EVLIST_CTL_CMD_UNSUPPORTED = 0,
>  	EVLIST_CTL_CMD_ENABLE,
>  	EVLIST_CTL_CMD_DISABLE,
> -	EVLIST_CTL_CMD_ACK
> +	EVLIST_CTL_CMD_ACK,
> +	EVLIST_CTL_CMD_SNAPSHOT,
>  };
>  
>  int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
> @@ -378,6 +380,7 @@ int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
>  int evlist__finalize_ctlfd(struct evlist *evlist);
>  bool evlist__ctlfd_initialized(struct evlist *evlist);
>  int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
> +int evlist__ctlfd_ack(struct evlist *evlist);
>  
>  #define EVLIST_ENABLED_MSG "Events enabled\n"
>  #define EVLIST_DISABLED_MSG "Events disabled\n"
> 
