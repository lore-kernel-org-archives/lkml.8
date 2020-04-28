Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEADBC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC564206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmW/RRFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgD1NXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:23:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28319 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbgD1NXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588080186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QeTe1VZqdF2mNKJQkDt1Swo6+XvFwxRuyivMd/xg+yI=;
        b=JmW/RRFy2RlWABXjylI5O4ahUJgpzUHrcE0Lsa6O0DfVKxaF4ZanTlOMlWKOUK7jCGuJbI
        a1zq6MlCGSYnfNSX1W9ArUgy/OEQIB2kOkkIn/GUBeezkqDR111QZCnPV7vLl8HFV819n7
        peba7IFzr9lYIUY625ns1fFy6fxPc7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-Nhx-R-eIMdGe82_y6PvUQw-1; Tue, 28 Apr 2020 09:23:04 -0400
X-MC-Unique: Nhx-R-eIMdGe82_y6PvUQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A871107ACCA;
        Tue, 28 Apr 2020 13:23:02 +0000 (UTC)
Received: from krava (unknown [10.40.196.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 691C85D750;
        Tue, 28 Apr 2020 13:22:59 +0000 (UTC)
Date:   Tue, 28 Apr 2020 15:22:57 +0200
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
Message-ID: <20200428132257.GH1476763@krava>
References: <20200427211935.25789-1-acme@kernel.org>
 <20200427211935.25789-8-acme@kernel.org>
 <20200428094839.GD1476763@krava>
 <20200428121601.GB2245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428121601.GB2245@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:16:01AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> > > +				pr_err("Couldn't create side band evlist.\n.");
> > > +				goto out_child;
> > > +			}
> > >  		}
> > >  
> > >  		if (evlist__add_bpf_sb_event(rec->sb_evlist, &session->header.env)) {
> > 
> > it's getting bigger, I wonder we should put all the sb_* setup in
> > separated functions like sb_start/sb_stop
> 
> Well, the rec->thread_id = pthread_self(); part is just for reusing a
> 'perf record' specific mechanism, what to do when the event appears in
> the side band thread ring buffer, the evlist__set_cb() also is related
> to that, moving thread_id to evlist seems too much at this time.

hum, I meant record specific static functions sb_start/sb_stop,
not inside evlist.. just to have it separated

> 
> > > @@ -2179,10 +2199,19 @@ static int switch_output_setup(struct record *rec)
> > >  	};
> > >  	unsigned long val;
> > >  
> > > +	/*
> > > +	 * If we're using --switch-output-events, then we imply its 
> > > +	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
> > > +	 *  thread to its parent.
> > > +	 */
> > > +	if (rec->sb_evlist != NULL)
> > > +		goto do_signal;
> > > +
> > >  	if (!s->set)
> > >  		return 0;
>  
> > hum, it looks like this jump is not necessay and can be avoided
> > by some bool checks.. could we add some bool when --switch-output-event
> > is used, so we don't depend on wether rec->sb_evlist was allocated for
> > whatever reason?
> 
> If rec->sb_evlist is NULL, then there was no --switch-output-event
> passed... The only advantage in adding the complexity below would be if
> we had rec->switch_output_event_set which would clarify that sb_evlist
> is not used only for --switch-output-event, to make things clearer.
> 
> And this still leaves us with the jump, otherwise we would have to test
> it twice, right?

still I like the idea of checking bool twice then adding jumps

> 
> I think I'll separate the patch adding OPT_CALLBACK_SET(), then fold the
> switch_output_event_set addition to builtin-record, ok?

ok, or set the bool directly in the callback, both works for me ;-)

thanks,
jirka

