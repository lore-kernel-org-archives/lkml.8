Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7FBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500B22465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIqvcU5K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgCBM6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:58:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727595AbgCBM6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583153920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTxEf2HmtzFDT3ha5LPaBAQb1RviQ7eD1aAzs0lLt8U=;
        b=QIqvcU5KgQTGiCf6R2i20AVZilT7hmhMFLfVCjAxG8nyFjdXCiZtHq0gJ8W6SVfYiIkqZb
        +KOXYpJAnDsygPv5yKrlb8j4tpfl2ADKOyM3GDVYUObi1NhbX0SqQETvhh8eG1zk+6KOmd
        ypeycTBFGIySkFvmshlQynQ2Ya6RMNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-sSzsPTQ8OfSI0JAbas9ugg-1; Mon, 02 Mar 2020 07:58:38 -0500
X-MC-Unique: sSzsPTQ8OfSI0JAbas9ugg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CA5B8017DF;
        Mon,  2 Mar 2020 12:58:37 +0000 (UTC)
Received: from krava (ovpn-205-46.brq.redhat.com [10.40.205.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2751519C4F;
        Mon,  2 Mar 2020 12:58:07 +0000 (UTC)
Date:   Mon, 2 Mar 2020 13:58:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Fix realloc() use in fdarray__grow()
Message-ID: <20200302125805.GB204976@krava>
References: <20200229162607.6000-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229162607.6000-1-jannh@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 05:26:07PM +0100, Jann Horn wrote:
> If `entries != NULL`, then `fda->entries` has been freed, so whatever
> happens afterwards, we must store `entries` in `fda->entries`.
> If we bail out at the second realloc(), the new allocation will be bigger
> than what fda->nr_alloc says, but that's fine.
> 
> Fixes: 2171a9256862 ("tools lib fd array: Allow associating an integer cookie with each entry")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> To the maintainer:
> I'm not sure about the etiquette for using CC stable in
> patches for somewhat theoretical issues in userland tools;
> feel free to tack a CC stable onto this if you think it
> should go into stable.
> 
>  tools/lib/api/fd/array.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 58d44d5eee31..acf8eca1a94a 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -27,15 +27,13 @@ int fdarray__grow(struct fdarray *fda, int nr)
>  
>  	if (entries == NULL)
>  		return -ENOMEM;
> +	fda->entries = entries;
>  
>  	priv = realloc(fda->priv, psize);
> -	if (priv == NULL) {
> -		free(entries);

so we are sure we always call fdarray__exit even
if we fail in here?  if that's the case then

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> +	if (priv == NULL)
>  		return -ENOMEM;
> -	}
>  
>  	fda->nr_alloc = nr_alloc;
> -	fda->entries  = entries;
>  	fda->priv     = priv;
>  	return 0;
>  }
> -- 
> 2.25.0
> 

