Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618ADC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373C72166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/xtpsps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388077AbgCDM7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:59:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46824 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388060AbgCDM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583326790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hhdoWtYJUAFB+5isvchTA1I3gIKalNxasPf308iYp70=;
        b=i/xtpsps/sca3H1Ea8xLpIN/CElpZ/R1nXFMX+zgWSfOC9a0m2tVLxIC0s0Ojv2zcdqxTv
        ef32+Lmsu6c6yNUIxcAH9rlRbXFMPnW3SBkz+A16rmre3RXAYwO2K4lQbK0qEP3YfM9aRl
        kXGcPhe6PGq5NYAkNUUxfuTk1DOEF2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-AScE1ydWP0Waxce9yLkZhQ-1; Wed, 04 Mar 2020 07:59:47 -0500
X-MC-Unique: AScE1ydWP0Waxce9yLkZhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F24471B18BC0;
        Wed,  4 Mar 2020 12:59:45 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-38.phx2.redhat.com [10.3.112.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B61215DA60;
        Wed,  4 Mar 2020 12:59:43 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 7EE1B121; Wed,  4 Mar 2020 09:59:40 -0300 (BRT)
Date:   Wed, 4 Mar 2020 09:59:40 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools lib traceevent: Remove extra '\n' in
 print_event_time()
Message-ID: <20200304125940.GA6498@redhat.com>
References: <20200303231852.6ab6882f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303231852.6ab6882f@oasis.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 03, 2020 at 11:18:52PM -0500, Steven Rostedt escreveu:
> 
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> If the precesion of print_event_time() is zero or greater than the

precision, right?

Thanks, applied.

- Arnaldo

> timestamp, it uses a different format. But that format had an extra new line
> at the end, and caused the output to not look right:
> 
> cpus=2
>            sleep-3946  [001]111264306005
> : function:             inotify_inode_queue_event
>            sleep-3946  [001]111264307158
> : function:             __fsnotify_parent
>            sleep-3946  [001]111264307637
> : function:             inotify_dentry_parent_queue_event
>            sleep-3946  [001]111264307989
> : function:             fsnotify
>            sleep-3946  [001]111264308401
> : function:             audit_syscall_exit
> 
> Fixes: 38847db9740a ("libtraceevent, perf tools: Changes in tep_print_event_* APIs")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  tools/lib/traceevent/event-parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index beaa8b8c08ff..e1bd2a93c6db 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -5541,7 +5541,7 @@ static void print_event_time(struct tep_handle *tep, struct trace_seq *s,
>  	if (p10 > 1 && p10 < time)
>  		trace_seq_printf(s, "%5llu.%0*llu", time / p10, prec, time % p10);
>  	else
> -		trace_seq_printf(s, "%12llu\n", time);
> +		trace_seq_printf(s, "%12llu", time);
>  }
>  
>  struct print_event_type {
> -- 
> 2.20.1

