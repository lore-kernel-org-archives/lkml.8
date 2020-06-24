Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA75C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC77C20663
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDSwQ/Sq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbgFXMuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:50:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46204 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388942AbgFXMuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593003048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TOxBs2AuO1pUP4DqRoz2j9gAHwAjHmTBtWWCzWPuC7s=;
        b=jDSwQ/SqqUko1So4/VlXpZlFPp2JbHcU2l5le+hOihZiN3AVAUNmIWD7YlTteo+ttc1O6y
        CE+pfv6asMEJRkUUZIC2ARnzbLtxK4xJ7B/5AFTlJMlBM8zoOcm31KqnxNDederHi3xF6X
        b0RMrME/FgQVwfvLjqKa0tCsU12IMEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-igigxKaOM0ScstJE1tP5EA-1; Wed, 24 Jun 2020 08:50:46 -0400
X-MC-Unique: igigxKaOM0ScstJE1tP5EA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20AC8800597;
        Wed, 24 Jun 2020 12:50:45 +0000 (UTC)
Received: from krava (unknown [10.40.193.204])
        by smtp.corp.redhat.com (Postfix) with SMTP id 48D1279317;
        Wed, 24 Jun 2020 12:50:43 +0000 (UTC)
Date:   Wed, 24 Jun 2020 14:50:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Gaurav Singh <gaurav1086@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [perf] lsdir_bid_tail_filter: fix index check
Message-ID: <20200624125042.GB2719003@krava>
References: <20200624013524.10836-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624013524.10836-1-gaurav1086@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:35:22PM -0400, Gaurav Singh wrote:
> Check bounds before accessing d->d_name[].
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>  tools/perf/util/build-id.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index c076fc7fe025..8c35cbe93f10 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -431,7 +431,7 @@ static bool lsdir_bid_tail_filter(const char *name __maybe_unused,
>  				  struct dirent *d)
>  {
>  	int i = 0;
> -	while (isxdigit(d->d_name[i]) && i < SBUILD_ID_SIZE - 3)
> +	while (i < SBUILD_ID_SIZE - 3 && isxdigit(d->d_name[i]))

hum, I guess it looks better, but technicaly this is not a problem right?

isxdigit will return false on zero byte which is always present in d->d_name
so it will never get out of bounds

jirka

>  		i++;
>  	return (i == SBUILD_ID_SIZE - 3) && (d->d_name[i] == '\0');
>  }
> -- 
> 2.17.1
> 

