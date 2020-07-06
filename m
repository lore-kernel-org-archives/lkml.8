Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BAFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C13A20771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGCL075U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgGFMYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:24:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28513 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729015AbgGFMYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594038259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j2XQ3Uf19JtmVY8IcDpt2UAD19LvHsUmGskneEF0Q2k=;
        b=gGCL075UaR46idQYQOj3qW/bfRaZuosbhflVc0KQHNUut3miFJNlPH8kyRLGqpgEP1UmZU
        LU5yXXw5pl3CcQ+DT8N/x+C2BFt/0cqro/a7+JHZ6kbFlBHrjNsyQwLOeCh+4JsaBUwb4D
        fLRnojpehqk0rOnZVze5CkiQPv++Ohg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-j9i9UN2fNGm2l7pIGGqkxQ-1; Mon, 06 Jul 2020 08:24:17 -0400
X-MC-Unique: j9i9UN2fNGm2l7pIGGqkxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7330818FE860;
        Mon,  6 Jul 2020 12:24:16 +0000 (UTC)
Received: from krava (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id A8DDD19D7B;
        Mon,  6 Jul 2020 12:24:14 +0000 (UTC)
Date:   Mon, 6 Jul 2020 14:24:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 02/15] tools/libperf: add properties to struct pollfd
 *entries objects
Message-ID: <20200706122413.GB3401866@krava>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <09bbbc85-7ef9-ff9f-9865-fce6a1a4e903@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09bbbc85-7ef9-ff9f-9865-fce6a1a4e903@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:41:45AM +0300, Alexey Budankov wrote:
> 
> Store boolean properties per struct pollfd *entries object in a
> bitmap of int size. Implement fdarray_prop__nonfilterable property
> to skip object from counting by fdarray_filter().

ok, I think can do it like this, few comments below

thanks,
jirka

> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/lib/api/fd/array.c                 | 17 +++++++++--------
>  tools/lib/api/fd/array.h                 | 18 +++++++++++++-----
>  tools/lib/perf/evlist.c                  | 10 +++++-----
>  tools/lib/perf/include/internal/evlist.h |  2 +-
>  tools/perf/tests/fdarray.c               |  2 +-
>  tools/perf/util/evlist.c                 |  2 +-
>  6 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 89f9a2193c2d..a4223f8cb1ce 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -12,31 +12,31 @@
>  void fdarray__init(struct fdarray *fda, int nr_autogrow)
>  {
>  	fda->entries	 = NULL;
> -	fda->priv	 = NULL;
> +	fda->prop	 = NULL;
>  	fda->nr		 = fda->nr_alloc = 0;
>  	fda->nr_autogrow = nr_autogrow;
>  }
>  
>  int fdarray__grow(struct fdarray *fda, int nr)
>  {
> -	void *priv;
> +	void *prop;
>  	int nr_alloc = fda->nr_alloc + nr;
> -	size_t psize = sizeof(fda->priv[0]) * nr_alloc;
> +	size_t psize = sizeof(fda->prop[0]) * nr_alloc;
>  	size_t size  = sizeof(struct pollfd) * nr_alloc;
>  	struct pollfd *entries = realloc(fda->entries, size);
>  
>  	if (entries == NULL)
>  		return -ENOMEM;
>  
> -	priv = realloc(fda->priv, psize);
> -	if (priv == NULL) {
> +	prop = realloc(fda->prop, psize);
> +	if (prop == NULL) {
>  		free(entries);
>  		return -ENOMEM;
>  	}
>  
>  	fda->nr_alloc = nr_alloc;
>  	fda->entries  = entries;
> -	fda->priv     = priv;
> +	fda->prop     = prop;
>  	return 0;
>  }
>  
> @@ -59,7 +59,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow)
>  void fdarray__exit(struct fdarray *fda)
>  {
>  	free(fda->entries);
> -	free(fda->priv);
> +	free(fda->prop);
>  	fdarray__init(fda, 0);
>  }
>  
> @@ -69,7 +69,7 @@ void fdarray__delete(struct fdarray *fda)
>  	free(fda);
>  }
>  
> -int fdarray__add(struct fdarray *fda, int fd, short revents)
> +int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_props props)
>  {
>  	int pos = fda->nr;
>  
> @@ -79,6 +79,7 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
>  
>  	fda->entries[fda->nr].fd     = fd;
>  	fda->entries[fda->nr].events = revents;
> +	fda->prop[fda->nr].bits = props;
>  	fda->nr++;
>  	return pos;
>  }
> diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
> index b39557d1a88f..19b6a34aeea5 100644
> --- a/tools/lib/api/fd/array.h
> +++ b/tools/lib/api/fd/array.h
> @@ -21,10 +21,18 @@ struct fdarray {
>  	int	       nr_alloc;
>  	int	       nr_autogrow;
>  	struct pollfd *entries;
> -	union {
> -		int    idx;
> -		void   *ptr;
> -	} *priv;
> +	struct {
> +		union {
> +			int    idx;
> +			void   *ptr;
> +		} priv;
> +		int bits;
> +	} *prop;
> +};

why not keeping the 'priv' as a struct, like:

	struct {
		union {
			int    idx;
			void   *ptr;
		};
		unsigned int flags;
	} *priv;

I think we would have much less changes, also please rename bits
to flags and use some unsigned type for that

> +
> +enum fdarray_props {
> +	fdarray_prop__default	    = 0x00000000,
> +	fdarray_prop__nonfilterable = 0x00000001
>  };

s/fdarray_props/fdarray_flag/

>  
>  void fdarray__init(struct fdarray *fda, int nr_autogrow);
> @@ -33,7 +41,7 @@ void fdarray__exit(struct fdarray *fda);
>  struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
>  void fdarray__delete(struct fdarray *fda);
>  
> -int fdarray__add(struct fdarray *fda, int fd, short revents);
> +int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_props props);
>  int fdarray__poll(struct fdarray *fda, int timeout);
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 6a875a0f01bb..25e76e458afb 100644

SNIP

