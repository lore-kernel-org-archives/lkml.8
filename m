Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14952C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E92AC20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="F0kLEdkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgE0T4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgE0T4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:56:41 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C742C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:56:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w1so812981qkw.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uWtuI3UUqrcr2MPYY5t1qIqp8t2VdGpdGQyBHayc2+I=;
        b=F0kLEdkPRpFO9sH4wIpK6WFmkk+axi+AF8AIp2TUrvRiQ5IBMPR/xY35x5yDhSQmEe
         7qd3x3C70smXp6N9YZ2ugYa3/Edu51g8JTb+5dcxs5oHL7ox91AXyxIRsBkNIrYvMNeH
         /dBAvk1ujz0GqKOEewegiRaGmAm25tBIInVhUFdlxeO4s44vafo89W6zlYBv5HJtjsas
         a2o4WMkqr9p6Reb7lyX2opm9Ze5J09sHAUyJ5Gz8293k4J/CSalOGy6VrI+87azCztME
         6DuFJ5GyV9LZVq40cWVEKHdf5ipbGToeGK5YW1ffw/2l1Yi6PK6sx8fY0OZYSosgdSIo
         d/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uWtuI3UUqrcr2MPYY5t1qIqp8t2VdGpdGQyBHayc2+I=;
        b=dEgoAh9Dw4UDzJHGWYsTaA8iKcL+/wQmW9ayuHKjbgIGbdB5Xv8B9v7mnPkTZTySh4
         2OvQKIDgGutmkRy9oKttyuwjIcPdjhMDZghYc+Bybi8X2UP0ZKm0U4Ei4LghCTxvB8bi
         9WJhJec7JB+Gv3xOVuxZbb9SfwY5dC5pbPOzRF240gHA5ub4fCt2iGT9+LPfpbMhrqyD
         6R3AYO0kflxxpv8K07t0fvTX0wEK+jAjnc8gN6An/gMchm69eqLcU3kH3P4ydwc+8QX4
         XHpCY+e1y1qqGrXUxexsrwhyJ2aa6jb9gdJBjGEx78bERZ4oYhprUURiecg6VOV/3sSn
         UamQ==
X-Gm-Message-State: AOAM533Xtwi38NOFjKrb8nl4+Tvzu7gNIhlGK1IQAe0BPYtvo5hIqPZh
        mzv+u4kvPc8e1K+L/ayV49m4kQ==
X-Google-Smtp-Source: ABdhPJzlAziYYOCm4VXEycz3sNv4Do6UvsXICCUPA0HIuaPoefFQjqsdZvAOOeXzo/yJ5MNL3mZ2OA==
X-Received: by 2002:a37:79c5:: with SMTP id u188mr5718286qkc.300.1590609400422;
        Wed, 27 May 2020 12:56:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id s74sm3135071qka.54.2020.05.27.12.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:56:39 -0700 (PDT)
Date:   Wed, 27 May 2020 15:56:14 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/19] mm: memcg/slab: obj_cgroup API
Message-ID: <20200527195614.GC47905@cmpxchg.org>
References: <20200526214227.989341-1-guro@fb.com>
 <20200526214227.989341-7-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526214227.989341-7-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:42:14PM -0700, Roman Gushchin wrote:
> @@ -257,6 +257,98 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
>  }
>  
>  #ifdef CONFIG_MEMCG_KMEM
> +extern spinlock_t css_set_lock;
> +
> +static void obj_cgroup_release(struct percpu_ref *ref)
> +{
> +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> +	struct mem_cgroup *memcg;
> +	unsigned int nr_bytes;
> +	unsigned int nr_pages;
> +	unsigned long flags;
> +
> +	/*
> +	 * At this point all allocated objects are freed, and
> +	 * objcg->nr_charged_bytes can't have an arbitrary byte value.
> +	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
> +	 *
> +	 * The following sequence can lead to it:
> +	 * 1) CPU0: objcg == stock->cached_objcg
> +	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
> +	 *          PAGE_SIZE bytes are charged
> +	 * 3) CPU1: a process from another memcg is allocating something,
> +	 *          the stock if flushed,
> +	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
> +	 * 5) CPU0: we do release this object,
> +	 *          92 bytes are added to stock->nr_bytes
> +	 * 6) CPU0: stock is flushed,
> +	 *          92 bytes are added to objcg->nr_charged_bytes
> +	 *
> +	 * In the result, nr_charged_bytes == PAGE_SIZE.
> +	 * This page will be uncharged in obj_cgroup_release().
> +	 */

Thanks for adding this.

> +int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> +{
> +	struct mem_cgroup *memcg;
> +	unsigned int nr_pages, nr_bytes;
> +	int ret;
> +
> +	if (consume_obj_stock(objcg, size))
> +		return 0;
> +
> +	rcu_read_lock();
> +	memcg = obj_cgroup_memcg(objcg);
> +	css_get(&memcg->css);
> +	rcu_read_unlock();

Can you please also add the comment here I mentioned last time? To
explain why we're not checking objcg->nr_charged_bytes if we have
already pre-allocated bytes that could satisfy the allocation.

Otherwise, looks good to me.
