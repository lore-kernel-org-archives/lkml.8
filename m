Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D21C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D4721739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyzupQSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCBP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:27:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54718 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726751AbgCBP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583162868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEaoL0NQ8YVPWWyRVDVCR6lLWIpeqTebjG8iPOD9Bmg=;
        b=JyzupQStQi8/1XphmwQdxK4rPr6C5W4llKwqafdCLn4ByN2AilQ/6sI1Sdrva/9dvLKPI3
        bf/4lajld5j1orR0hnaVOoRLqDypcll/n+PN4EimFtACBjZNBNnHg/R4dTRt4ApLABWufZ
        6chxmsFGWlF+8uzjhheQjWxi1a3ciZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-WeqELKtxNR2vKMOTZb8t9w-1; Mon, 02 Mar 2020 10:27:46 -0500
X-MC-Unique: WeqELKtxNR2vKMOTZb8t9w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CB13CF98F;
        Mon,  2 Mar 2020 15:27:45 +0000 (UTC)
Received: from krava (ovpn-205-46.brq.redhat.com [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 077039CA3;
        Mon,  2 Mar 2020 15:27:43 +0000 (UTC)
Date:   Mon, 2 Mar 2020 16:27:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf parse-events: Use asprintf() instead of strncpy()
 for tracepoints
Message-ID: <20200302152741.GA263077@krava>
References: <20200302145535.GA28183@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302145535.GA28183@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 11:55:35AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

>       |          ^~~~~~
>   CC       /tmp/build/perf/util/call-path.o
> 
> So I replaced it with asprintf to make the code shorter, use a bit less
> memory and deal with the above problem, ok?
> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index c01ba6f8fdad..a14995835d85 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -257,21 +257,15 @@ struct tracepoint_path *tracepoint_id_to_path(u64 config)
>  				path = zalloc(sizeof(*path));
>  				if (!path)
>  					return NULL;
> -				path->system = malloc(MAX_EVENT_LENGTH);
> -				if (!path->system) {
> +				if (asprintf(&path->system, "%.*s", MAX_EVENT_LENGTH, sys_dirent->d_name) < 0) {
>  					free(path);
>  					return NULL;
>  				}
> -				path->name = malloc(MAX_EVENT_LENGTH);
> -				if (!path->name) {
> +				if (asprintf(&path->name, "%.*s", MAX_EVENT_LENGTH, evt_dirent->d_name) < 0) {
>  					zfree(&path->system);
>  					free(path);
>  					return NULL;
>  				}
> -				strncpy(path->system, sys_dirent->d_name,
> -					MAX_EVENT_LENGTH);
> -				strncpy(path->name, evt_dirent->d_name,
> -					MAX_EVENT_LENGTH);

looks good to me, and we can probably remove MAX_EVENT_LENGTH as well?

jirka

