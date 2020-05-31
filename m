Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD33C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95084206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 18:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UewlZAQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEaSTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 14:19:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbgEaSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 14:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590949162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJlzPFi1GzBnXpJrMl3pAkK/ydATTI/Qh7Ges7bcjcQ=;
        b=UewlZAQJgaJyFDKwZZ6F9G8p8+F5kxu7GIIdzdWNbNAPM8MdKxdF7NSMUHg+dT8+lbZi3H
        xXrZhYnyfbM/Projfu6Cr1XRLfNEmYwwwotjlYriD/aNl6vcknASTQSs4qa/3dURj7hP/j
        IbKGrSYSAtwpWNcT4uCqRYV3/oQNgC4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-ZNufbv33PF6AiEx3J36KTw-1; Sun, 31 May 2020 14:19:17 -0400
X-MC-Unique: ZNufbv33PF6AiEx3J36KTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B71F3107ACF2;
        Sun, 31 May 2020 18:19:15 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id A602D7C09A;
        Sun, 31 May 2020 18:19:13 +0000 (UTC)
Date:   Sun, 31 May 2020 20:19:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/10] tools/libperf: introduce static poll file
 descriptors
Message-ID: <20200531181912.GC881900@krava>
References: <653fe5f3-c986-a841-1ed8-0a7d2fa24c00@linux.intel.com>
 <024af6a7-8085-c28d-5067-6ab3225bdc82@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024af6a7-8085-c28d-5067-6ab3225bdc82@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:17:31PM +0300, Alexey Budankov wrote:

SBIP

> +int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
> +{
> +	int pos = fda->nr_stat;
> +
> +	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
> +		return -1;
> +
> +	fda->stat_entries[pos].fd = fd;
> +	fda->stat_entries[pos].events = revents;
> +	fda->nr_stat++;
> +
> +	return pos;
> +}
> +
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>  		    void *arg)
> @@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
>  
>  int fdarray__poll(struct fdarray *fda, int timeout)
>  {
> -	return poll(fda->entries, fda->nr, timeout);
> +	int nr, i, pos, res;
> +
> +	nr = fda->nr;
> +
> +	for (i = 0; i < fda->nr_stat; i++) {
> +		if (fda->stat_entries[i].fd != -1) {
> +			pos = fdarray__add(fda, fda->stat_entries[i].fd,
> +					   fda->stat_entries[i].events);
> +			if (pos >= 0)
> +				fda->priv[pos].idx = i;
> +		}
> +	}

hum, so every time we call evlist__poll we end up in here
adding more stuff to entries?

jirka

> +
> +	res = poll(fda->entries, fda->nr, timeout);
> +
> +	for (i = nr; i < fda->nr; i++)
> +		fda->stat_entries[fda->priv[i].idx] = fda->entries[i];
> +
> +	fda->nr = nr;
> +
> +	return res;
>  }

SNIP

