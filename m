Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5221C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD869206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoKAzD74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgD2ISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:18:24 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726625AbgD2ISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588148301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TEpFP5LkqF5Zb/Ez8XYjygC6kZEv0jpsUv7qn32SHY=;
        b=NoKAzD74qGU9qxVGRuKljhyWGLEyU+BThM8z2YTMVlkNpFk7nDdiMeB3rgiYujL0y6YBBF
        Q9eN9+D0lO/D1xG1bfT4HOTpOhLg/R9LtIR3Cz9lyJI1tDC94n0JpSYBODfuDjYDQ0EE1v
        151R4569YD14OFE/ZD67N2KUT6mcPfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-wpIoNryyMHahC6kGG9Us5w-1; Wed, 29 Apr 2020 04:18:19 -0400
X-MC-Unique: wpIoNryyMHahC6kGG9Us5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAA2B8015CF;
        Wed, 29 Apr 2020 08:18:17 +0000 (UTC)
Received: from krava (ovpn-114-35.ams2.redhat.com [10.36.114.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 876371000322;
        Wed, 29 Apr 2020 08:18:13 +0000 (UTC)
Date:   Wed, 29 Apr 2020 10:18:11 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 7/7] perf record: Introduce --switch-output-event
Message-ID: <20200429081811.GK1476763@krava>
References: <20200427211935.25789-1-acme@kernel.org>
 <20200427211935.25789-8-acme@kernel.org>
 <20200428094839.GD1476763@krava>
 <20200428121601.GB2245@kernel.org>
 <20200428132257.GH1476763@krava>
 <20200428180518.GF5460@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428180518.GF5460@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:05:18PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 28, 2020 at 03:22:57PM +0200, Jiri Olsa escreveu:
> > On Tue, Apr 28, 2020 at 09:16:01AM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > SNIP
> > 
> > > > > +				pr_err("Couldn't create side band evlist.\n.");
> > > > > +				goto out_child;
> > > > > +			}
> > > > >  		}
> 
> > > > >  		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
> 
> > > > it's getting bigger, I wonder we should put all the sb_* setup in
> > > > separated functions like sb_start/sb_stop
> 
> > > Well, the rec->thread_id = pthread_self(); part is just for reusing a
> > > 'perf record' specific mechanism, what to do when the event appears in
> > > the side band thread ring buffer, the evlist__set_cb() also is related
> > > to that, moving thread_id to evlist seems too much at this time.
> 
> > hum, I meant record specific static functions sb_start/sb_stop,
> > not inside evlist.. just to have it separated
> 
> Ok, so I have the patch below on top of that series, and its all
> available in my perf/switch-output-event, that is on top of more patches
> collected today, all going well, this perf/switch-output-event will turn
> into perf/core ang go upstream soon, then I have to loo at Adrian's
> kernel+tooling patchkit,

ok looks good

thank,
jirka

> 
> - Arnaldo
> 
> commit a25516b4db23ba8f956b990d37ec6728e5221718
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Apr 28 14:58:29 2020 -0300
> 
>     perf record: Move side band evlist setup to separate routine
>     
>     It is quite big by now, move that code to a separate
>     record__setup_sb_evlist() routine.
>     
>     Suggested-by: Jiri Olsa <jolsa@redhat.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Song Liu <songliubraving@fb.com>
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 7a6a89972691..bb3d30616bf3 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1445,6 +1445,44 @@ static int record__process_signal_event(union perf_event *event __maybe_unused,
>  	return 0;
>  }
>  
> +static int record__setup_sb_evlist(struct record *rec)
> +{
> +	struct record_opts *opts = &rec->opts;
> +
> +	if (rec->sb_evlist != NULL) {
> +		/*
> +		 * We get here if --switch-output-event populated the
> +		 * sb_evlist, so associate a callback that will send a SIGUSR2
> +		 * to the main thread.
> +		 */
> +		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
> +		rec->thread_id = pthread_self();
> +	}
> +
> +	if (!opts->no_bpf_event) {
> +		if (rec->sb_evlist == NULL) {
> +			rec->sb_evlist = evlist__new();
> +
> +			if (rec->sb_evlist == NULL) {
> +				pr_err("Couldn't create side band evlist.\n.");
> +				return -1;
> +			}
> +		}
> +
> +		if (evlist__add_bpf_sb_event(rec->sb_evlist, &rec->session->header.env)) {
> +			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
> +			return -1;
> +		}
> +	}
> +
> +	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
> +		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
> +		opts->no_bpf_event = true;
> +	}
> +
> +	return 0;
> +}
> +
>  static int __cmd_record(struct record *rec, int argc, const char **argv)
>  {
>  	int err;
> @@ -1589,36 +1627,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		goto out_child;
>  	}
>  
> -	if (rec->sb_evlist != NULL) {
> -		/*
> -		 * We get here if --switch-output-event populated the
> -		 * sb_evlist, so associate a callback that will send a SIGUSR2
> -		 * to the main thread.
> -		 */
> -		evlist__set_cb(rec->sb_evlist, record__process_signal_event, rec);
> -		rec->thread_id = pthread_self();
> -	}
> -
> -	if (!opts->no_bpf_event) {
> -		if (rec->sb_evlist == NULL) {
> -			rec->sb_evlist = evlist__new();
> -
> -			if (rec->sb_evlist == NULL) {
> -				pr_err("Couldn't create side band evlist.\n.");
> -				goto out_child;
> -			}
> -		}
> -
> -		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
> -			pr_err("Couldn't ask for PERF_RECORD_BPF_EVENT side band events.\n.");
> -			goto out_child;
> -		}
> -	}
> -
> -	if (perf_evlist__start_sb_thread(rec->sb_evlist, &rec->opts.target)) {
> -		pr_debug("Couldn't start the BPF side band thread:\nBPF programs starting from now on won't be annotatable\n");
> -		opts->no_bpf_event = true;
> -	}
> +	err = record__setup_sb_evlist(rec);
> +	if (err)
> +		goto out_child;
>  
>  	err = record__synthesize(rec, false);
>  	if (err < 0)
> 

