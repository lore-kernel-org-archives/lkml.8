Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28A7C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7882420643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvWp9hth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgELOe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:34:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57788 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgELOe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589294095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y3f4zptkSRcSxluqEOKgN4rMXqWWdxu/lC4FoXf5Ak4=;
        b=XvWp9hthfonOC52Ojd9QOICzebTmC0uw7hO7jeko86QoVC6JF8DYk4pOlipAyRA3xLeLPe
        gjkQOOKs4JO5Rhs/KnGNB1rwieY/2R3WqRTCbVLqCvEUjEcNlw0xJoE5mOm7y8kxYlPJyd
        Bx6bRExJpbxWHC9UTMhg84KuLV26NkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-W5Zq4JKgNMOBzMfs_c4PSw-1; Tue, 12 May 2020 10:34:51 -0400
X-MC-Unique: W5Zq4JKgNMOBzMfs_c4PSw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 425A81005510;
        Tue, 12 May 2020 14:34:50 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id E7D196C792;
        Tue, 12 May 2020 14:34:47 +0000 (UTC)
Date:   Tue, 12 May 2020 16:34:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH perf/urgent] perf tools: Fix is_bpf_image function logic
Message-ID: <20200512143447.GB3158213@krava>
References: <20200512122310.3154754-1-jolsa@kernel.org>
 <20200512133223.GI28888@kernel.org>
 <20200512133609.GA3158213@krava>
 <20200512140902.GK28888@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512140902.GK28888@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:09:02AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 12, 2020 at 03:36:09PM +0200, Jiri Olsa escreveu:
> > On Tue, May 12, 2020 at 10:32:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, May 12, 2020 at 02:23:10PM +0200, Jiri Olsa escreveu:
> > > > Adrian reported that is_bpf_image is not working the way it was
> > > > intended - passing on trampolines and dispatcher names. Instead
> > > > it returned true for all the bpf names.
> > > > 
> > > > The reason even this logic worked properly is that all bpf objects,
> > > > even trampolines and dispatcher, were assigned DSO_BINARY_TYPE__BPF_IMAGE
> > > > binary_type.
> > > > 
> > > > The later for bpf_prog objects, the binary_type was fixed in bpf load event
> > > > processing, which is executed after the ksymbol code.
> > > > 
> > > > Fixing the is_bpf_image logic, so it properly recognizes trampoline
> > > > and dispatcher objects.
> > > 
> > > This is not applying on top of torvalds/master, not tip/perf/urgent, and
> > 
> > right.. it's on top of your's perf/core.. I can rebase on perf/urgent
> 
> You don't need to, this hasn't hit torvalds/master, it'll be in the next
> merge window, the one for 5.8.
>  

perfect, thanks

jirka

