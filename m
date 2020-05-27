Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9AFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0556A207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZdwrY6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgE0KZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:25:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52307 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbgE0KZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590575138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pCH+Sehu6P7XqS4qbiCktbpA1kblie/UDIy1mCh/XtA=;
        b=PZdwrY6LFBx4DWyMbPaSkE912d3rbRtgtlYuhILyvCb2Gf0h9hTZBPWMmANEro5fG8JvRZ
        JKvHy5lKt5ndVZibKHYgrWZts99cT9DaMYTTGJOQBx6/INLj6L+ktTIBDF12TkjGx5qMA5
        X4xu+/WrmCvIJAtkyaMYwLcNiOqx16U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-GRmnCcb5OGOHh0N_94S4EA-1; Wed, 27 May 2020 06:25:36 -0400
X-MC-Unique: GRmnCcb5OGOHh0N_94S4EA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32B8EEC1B5;
        Wed, 27 May 2020 10:25:35 +0000 (UTC)
Received: from krava (unknown [10.40.195.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 227ED60C05;
        Wed, 27 May 2020 10:25:33 +0000 (UTC)
Date:   Wed, 27 May 2020 12:25:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf ordered_events: Optimise event object reuse
Message-ID: <20200527102533.GG350217@krava>
References: <20200526135928.946-1-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526135928.946-1-matt@codeblueprint.co.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:59:28PM +0100, Matt Fleming wrote:

SNIP

> +
> +/*
> + * Allocate a new event object from the free event cache.
> + *
> + * Find the first address range in the cache and carve out enough bytes
> + * for an ordered_event objects. The object with the lowest address is
> + * always returned so that subsequent allocations benefit from
> + * contiguous memory accesses (spatial locality).
> + */
> +static struct ordered_event *free_event_get_tree(struct ordered_events *oe)
> +{
> +	struct interval_tree_node *it;
> +	struct ordered_event *new;
> +	size_t bytes = sizeof(*new);
> +
> +	it = interval_tree_iter_first(&oe->cache.rb, 0, ULONG_MAX);
> +	if (!it)
> +		return NULL;
> +
> +	/* Has the cache memory been exhausted? */
> +	assert(cache_region_size(it) >= bytes);
> +
> +	new = (void *)it->start;
> +
> +	if (cache_region_size(it) == bytes) {
> +		interval_tree_remove(it, &oe->cache.rb);
> +		free(it);
> +	}
> +
> +	it->start += bytes;

this does not look right.. should this go to else path in above condition?

jirka

> +	return new;
> +}
> +

SNIP

