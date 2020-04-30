Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE84C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479F320784
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAh4bUET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgD3H24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:28:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20687 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726424AbgD3H24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588231735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJ6KEKpmYQDpAbh56ELykhrF1c4Sk5vgaCqZ/v7Kpog=;
        b=IAh4bUETOkWnQtklTUhMjJ7QL+KjrWabVAY6eHbbASKXh2r2euFVbKv1aWcJbhkKBISA42
        DOCU91G/yn+phWhvBL6gmkA+if1G5XN55LeFX0hTsNcu7D5/UmvKlppBFpDvUyi4da9H5i
        2Di6rrGkNDH/cZyXB1amDGcQUdXWXsI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-MX1IucH3PPK0WpbflLrkZQ-1; Thu, 30 Apr 2020 03:28:52 -0400
X-MC-Unique: MX1IucH3PPK0WpbflLrkZQ-1
Received: by mail-wm1-f72.google.com with SMTP id b203so218664wmd.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJ6KEKpmYQDpAbh56ELykhrF1c4Sk5vgaCqZ/v7Kpog=;
        b=rSaeN55b44oCXxmF4xNc+e9ALTST4STgP8KzemB99DEm+xd5p0I+FuxiDepG+wRkKQ
         RCP1fbQvAOs8dMeKTjoVUM4B/6pYpKd/6gMqy5byGY6OvwYHN+1PQ5w+dU/4NaLiC+w5
         aPfbTbSDmyT2ZS42WhJoD6Qz+D+QF1UNBLbJz6v/V+HtwEoROWTKTCyj3Lw7jICNWi6q
         OgwL13KQbi5UyoLAQY5TnXv6DRgo6TIYsoFWTklkSp5Hi/txH7Tl2ncBcC6abzbDUJAx
         dVHc+EZ9ff/xFkkeg/ijhxXUlg/BYUOQFGWrSAHkLjwtTMca7YrEZ85DbRba8hn6LXLv
         QjDw==
X-Gm-Message-State: AGi0PubxuNulxxsYk8MHsotCmblyRvNzStvnt808SsXlLoYO6g98JSE6
        2XnJ+ivoN8wPbtceCc0c2JQNps7QB8nGIxguk9GE6aXvoPM5oT4l1qR+JRz9auZxv1rKcccviBo
        FClL98wYNAa4/Yw1tJXs5bfiE
X-Received: by 2002:a1c:e903:: with SMTP id q3mr1384162wmc.76.1588231731772;
        Thu, 30 Apr 2020 00:28:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXIC4F9C3OyGdM2MlHD+2djAZF8jf10jAIG13lCshEGb6lj9Cyfne9pF70E10jTnYRAC5iVA==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr1384149wmc.76.1588231731463;
        Thu, 30 Apr 2020 00:28:51 -0700 (PDT)
Received: from localhost.localdomain ([151.29.179.209])
        by smtp.gmail.com with ESMTPSA id j13sm2570785wro.51.2020.04.30.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 00:28:50 -0700 (PDT)
Date:   Thu, 30 Apr 2020 09:28:47 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, walken@google.com, dave@stgolabs.net,
        mingo@kernel.org, tglx@linutronix.de, oleg@redhat.com,
        irogers@google.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH 1/7] rbtree: Add generic add and find helpers
Message-ID: <20200430072847.GA68379@localhost.localdomain>
References: <20200429153258.563269446@infradead.org>
 <20200429153549.006661686@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429153549.006661686@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/04/20 17:32, Peter Zijlstra wrote:
> I've always been bothered by the endless (fragile) boilerplate for
> rbtree, and I recently wrote some rbtree helpers for objtool and
> figured I should lift them into the kernel and use them more widely.
> 
> Provide:
> 
> partial-order; less() based:
>  - rb_add(): add a new entry to the rbtree
>  - rb_add_cached(): like rb_add(), but for a rb_root_cached
> 
> total-order; cmp() based:
>  - rb_find(): find an entry in an rbtree
>  - rb_find_first(): find the first (leftmost) matching entry
>  - rb_next_match(): continue from rb_find_first()
>  - rb_for_each(): for loop with rb_find_first() / rb_next_match()
> 
> Also make rb_add_cached() / rb_erase_cached() return true when
> leftmost.
> 
> Inlining and constant propagation should see the compiler inline the
> whole thing, including the various compare functions.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/rbtree.h       |  127 +++++++++++++++++++++++++++++++++++++++++-
>  tools/include/linux/rbtree.h |  129 ++++++++++++++++++++++++++++++++++++++++++-
>  tools/objtool/elf.c          |   63 ++-------------------
>  3 files changed, 257 insertions(+), 62 deletions(-)
> 
> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -141,12 +141,18 @@ static inline void rb_insert_color_cache
>  	rb_insert_color(node, &root->rb_root);
>  }
>  
> -static inline void rb_erase_cached(struct rb_node *node,
> +static inline bool rb_erase_cached(struct rb_node *node,
>  				   struct rb_root_cached *root)
>  {
> -	if (root->rb_leftmost == node)
> +	bool leftmost = false;
> +
> +	if (root->rb_leftmost == node) {
>  		root->rb_leftmost = rb_next(node);

Think we need

 if (root->rb_leftmost)

> +		leftmost = true;

DEADLINE crashes w/o that.

> +	}
>  	rb_erase(node, &root->rb_root);
> +
> +	return leftmost;
>  }

The rest looks good to me.

Thanks,

Juri

