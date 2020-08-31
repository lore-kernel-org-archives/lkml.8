Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09602C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3DB02083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTYm1SPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgHaSI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgHaSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:08:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D3DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:08:52 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so365743wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PZdD3YkccjOVfF0atuAqD6nWNa6V5XxvIiUqs3VdtEk=;
        b=DTYm1SPdGKG/SQtAldlYoFxpYjZpsl532qhv6HisDz50C8zjjFhEV6VYZYr/ZbT+YP
         2dXuN0EArHJmyGH6Jkl1c2ql7cfM6UVizHL24w3vkUBubm2HJ1ct3QMJd4kMU+UAVlHj
         rzaGTYp0oZXldmNTj8Xb7CpfnTFyYvOqXZwRhFpuLeLTYyTVHZ+rW4/+UFwZOpE7hyS+
         31QOuY6UA00D7IURmMft9i+6WOx45GT/92Dl5UWgoNNppyhJ5XehPXy1wPMLE35Nh8wK
         oiaMu8ZQSo01pCgeXrJAF+WAOxurJw9Tn+Vk7feQaXuBsocQYSjm60tLNh0K/bP3rKhW
         MxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZdD3YkccjOVfF0atuAqD6nWNa6V5XxvIiUqs3VdtEk=;
        b=VrOrYD3Biqnj02R7SLcy3AgzdwiZ82AJGR21AHCZjhBDoYVsjO6jwKcqEtNgqCZPPy
         M3MK8+6xxEL2d9SH7rUd+0SrixS7wlIxEPI0keOVMrqhHSNHYBLKYxPetxlpkTdxXIVi
         m3qq1BPUe8rm80hSy24/is+kTZIkGvd7qXWzGfhEi1GmVwXyuXQfUtJWtAIycfhWx7aH
         Ga+vVAXeOz9JlucxjyvvMsrq/yo+8n8rRbbChDvLxv/b4IjraRzE3btUnelB0/rV5D6J
         DhNu6CsDOfVFaE/hRGp6P6s0bhoZiUwrHb0a/cU1cH5y08+Qo3lqZDHsFyBYbDU8FJbb
         wSvQ==
X-Gm-Message-State: AOAM5323PxhAme0hBf7MXJHYCnqYO4XVy3+uX8pYPQ20tzZdOoMr3WMk
        FHGCV4wlZKcT5PQrbXBORE1B9w==
X-Google-Smtp-Source: ABdhPJwSbeYkTbQaVd/c43rNwMacSmdUE9+ZmFXhzkNUOh+371xDIG9v6A+/BYEq63PSZ7ILqtj4Gw==
X-Received: by 2002:a05:600c:22d6:: with SMTP id 22mr501445wmg.120.1598897331339;
        Mon, 31 Aug 2020 11:08:51 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id e18sm12975638wrx.50.2020.08.31.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:08:50 -0700 (PDT)
Date:   Mon, 31 Aug 2020 20:08:44 +0200
From:   Marco Elver <elver@google.com>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        fan.du@intel.com, foersleo@amazon.de, gthelen@google.com,
        irogers@google.com, jolsa@redhat.com, kirill@shutemov.name,
        mark.rutland@arm.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, sblbir@amazon.com,
        shakeelb@google.com, shuah@kernel.org, sj38.park@gmail.com,
        snu@amazon.de, vbabka@suse.cz, vdavydov.dev@gmail.com,
        yang.shi@linux.alibaba.com, ying.huang@intel.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v8 01/10] mm/damon/debugfs: Allow users to set initial
 monitoring target regions
Message-ID: <20200831180844.GA3992970@elver.google.com>
References: <20200831104730.28970-1-sjpark@amazon.com>
 <20200831104730.28970-2-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831104730.28970-2-sjpark@amazon.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 12:47PM +0200, SeongJae Park wrote:
[...]
> diff --git a/mm/damon.c b/mm/damon.c
> index 7e3c8c82a010..9815d22fc4de 100644
> --- a/mm/damon.c
> +++ b/mm/damon.c
> @@ -2001,6 +2001,147 @@ static ssize_t debugfs_record_write(struct file *file,
>  	return ret;
>  }
>  
> +static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
> +{
> +	struct damon_target *t;
> +	struct damon_region *r;
> +	int written = 0;
> +	int rc;
> +
> +	damon_for_each_target(t, c) {
> +		damon_for_each_region(r, t) {
> +			rc = snprintf(&buf[written], len - written,
> +					"%lu %lu %lu\n",
> +					t->id, r->ar.start, r->ar.end);

This most likely will not work as intended, because snprintf() returns
"[...] the number of characters which would be generated for the given
input, excluding the trailing null [...]". Would scnprintf() -- which
returns "[...] the number of characters written into @buf not including
the trailing '\0' [...]" -- do what you intended?

> +			if (!rc)
> +				return -ENOMEM;
> +			written += rc;
> +		}
> +	}
> +	return written;
> +}
[...]
