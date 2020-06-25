Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A48FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4770620706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEM8BURJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406665AbgFYRHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:07:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404498AbgFYRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:07:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593104865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vvjgZ8CJNCVNb3fDLy5IKqRjXF6x1Mi+tUuNrKJzvq0=;
        b=OEM8BURJF6V1Ov805ucG8XrRS14kkZvvIpTa3l2RKrdeSxtGtCA8FSftQcErbqeVGRsb88
        31IV2VVBMpdblOIvQ0mVpNqhmY98sbBindJctJPQuXlt6KUcsMAu6Ekg71a+Xh3+3XZnm6
        CBP2yjAYtKrDsu4DIwmDV6+WUWpyS5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-q3UWgeo6OHyMoJxvSK8gbA-1; Thu, 25 Jun 2020 13:07:41 -0400
X-MC-Unique: q3UWgeo6OHyMoJxvSK8gbA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36EC5800C64;
        Thu, 25 Jun 2020 17:07:40 +0000 (UTC)
Received: from krava (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6C43060E1C;
        Thu, 25 Jun 2020 17:07:38 +0000 (UTC)
Date:   Thu, 25 Jun 2020 19:07:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 12/13] perf record: implement control commands handling
Message-ID: <20200625170737.GJ2719003@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <f48c5f58-96ea-b1f0-a7e6-55315a292bce@linux.intel.com>
 <20200623145434.GD2619137@krava>
 <3107d9cd-03ec-34aa-4226-393547c55517@linux.intel.com>
 <173bf24f-1db4-b496-c258-4e98536d23a5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173bf24f-1db4-b496-c258-4e98536d23a5@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 05:55:02PM +0300, Alexey Budankov wrote:
> 
> On 24.06.2020 17:00, Alexey Budankov wrote:
> > 
> > On 23.06.2020 17:54, Jiri Olsa wrote:
> >> On Wed, Jun 17, 2020 at 11:43:58AM +0300, Alexey Budankov wrote:
> >>>
> >>> Implement handling of 'enable' and 'disable' control commands
> >>> coming from control file descriptor.
> >>>
> >>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >>> ---
> >>>  tools/perf/builtin-record.c | 16 ++++++++++++++++
> >>>  1 file changed, 16 insertions(+)
> >>>
> >>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> >>> index d0b29a1070a0..0394e068dde8 100644
> >>> --- a/tools/perf/builtin-record.c
> >>> +++ b/tools/perf/builtin-record.c
> >>> @@ -1527,6 +1527,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >>>  	bool disabled = false, draining = false;
> >>>  	int fd;
> >>>  	float ratio = 0;
> >>> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
> >>>  
> >>>  	atexit(record__sig_exit);
> >>>  	signal(SIGCHLD, sig_handler);
> >>> @@ -1830,6 +1831,21 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
> >>>  				alarm(rec->switch_output.time);
> >>>  		}
> >>>  
> >>> +		if (evlist__ctlfd_process(rec->evlist, &cmd) > 0) {
> >>> +			switch (cmd) {
> >>> +			case EVLIST_CTL_CMD_ENABLE:
> >>> +				pr_info(EVLIST_ENABLED_MSG);
> >>> +				break;
> >>> +			case EVLIST_CTL_CMD_DISABLE:
> >>> +				pr_info(EVLIST_DISABLED_MSG);
> >>> +				break;
> >>> +			case EVLIST_CTL_CMD_ACK:
> >>> +			case EVLIST_CTL_CMD_UNSUPPORTED:
> >>> +			default:
> >>> +				break;
> >>> +			}
> >>> +		}
> >>
> >> so there's still the filter call like:
> >>
> >>                         if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
> >>                                 draining = true;
> >>
> >> it will never be 0 if the control fds are stil alive no?
> > 
> > Due to change in filter_pollfd() and preceding evlist__ctlfd_process() call
> > now control fd is not counted by filter_pollfd().
> And evlist__ctlfd_process() still should be called second time right
> after evlist_poll() but prior filter_polfd().

aaah it's set to zero in here:

        if (entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
                evlist__finalize_ctlfd(evlist);
        else
                entries[ctlfd_pos].revents = 0;

yea, that's bad.. another reason to call it a hack

jirka

> 
> ~Alexey
> 
> > 
> > However event fds with .revents == 0 are not counted either and this breaks
> > the algorithm thus something more is still required to cover this gap.
> > 
> > ~Alexey
> > 
> >>
> >> jirka
> >>
> 

