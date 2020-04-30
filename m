Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C533AC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A902082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ewodhdp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgD3BEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3BEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:04:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20913C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:04:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ms17so11634pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/d+2FXYYJQin+PulyZilQ2dQwezL2L3EuBnOgOmYOXU=;
        b=Ewodhdp6D51A5Y1bW4IJFsnO1Z3d3n42Sqi6MHYa6M+vzXCN7TyZj2IfR8qivmqych
         aauF1ST07yGo2mEHtXd+ChT6MDxE3eldmilJI2V6V4RORGyCrMF4hNEx98zx/AmPfoB5
         jEYqb+hD6dCrUKahj0eZzXy98h5968mpVK0Iga/HZO97Vt6nhYYsRG9Esd7R0i/iWTbD
         QTtenxUoHZHjVLjakTfC1FkgtpWY0DzztdGHMrxI13/o6yg3GRiwBElkiFldLPxoBfuH
         onNyYnbe8Q/Q0aPvOLYRTY9QpDvTj62nelso/aNS+c+DpfvmOdmRDJ4aV7iOs2u4dE86
         gJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/d+2FXYYJQin+PulyZilQ2dQwezL2L3EuBnOgOmYOXU=;
        b=cj+tAStBIL8a2pf4ngdEAwO7g2SonPebirqMbKaXf/AoynNfkUP3PL4MRVjBQj6o4F
         jpvGT3ESw3BVkIDq2DbeVwOvbuV4jhYIYt7+d2ZXtxtBKtSTzVU6tB0MmLtDxR+7y+No
         2RtHwi9CiXypz002eOq65NUjNI1NQVITOPIihVWX3dpKLd3hqkHKVD9RGnMelwZrwqdC
         yl5rjn5lE9cUyqd28vpXr+Kc+rAsNNCd1x5VC6+DB6wYDYIIYxfQLixpPl5CyriI9Y4w
         nkVSfHdCp19EXcQf7HjqwWZb6wdXnLxj0AwaNsiJ+/EwxfGeWKHeo3c6nYYo2OeCOwAH
         zADg==
X-Gm-Message-State: AGi0PuYlFreCHLD+haWVCZDsiYNsoVY6aA17bRbJcKfdrKZLlR2E9lfE
        Xk7egqAyqQPrMI/6LiZvvIGLBw==
X-Google-Smtp-Source: APiQypJhxvGiZIL3YYFpAGL8fLlGKuLpnj8WD3W75MeXiSsjsbtLWYlhNtdrd1nFCOPgGkL6Ht7ocw==
X-Received: by 2002:a17:902:8218:: with SMTP id x24mr1203763pln.192.1588208649031;
        Wed, 29 Apr 2020 18:04:09 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id gv24sm365131pjb.6.2020.04.29.18.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 18:04:07 -0700 (PDT)
Date:   Wed, 29 Apr 2020 18:04:05 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org
Subject: Re: [RFC][PATCH 1/7] rbtree: Add generic add and find helpers
Message-ID: <20200430010405.GA237715@google.com>
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

Hi Peter,

On Wed, Apr 29, 2020 at 05:32:59PM +0200, Peter Zijlstra wrote:
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

I really like the idea of this change. Also,I think it opens avenues
for converting some users which had previously been avoiding raw rbtrees
seemingly only because they didn't want to write this boilerplate.

Few questions:

- Adding the rb_add_cached() / rb_erase_cached() return value looks
  like it almost belongs to a separate patch. Is this only used in
  patch 3/7 (sched/deadline) or did I miss other uses ? Not objecting
  to it, but it wasn't obvious to me when reading the patch what the
  return value was for.

- Have you considered passing a cmp() function to rb_add() and
  rb_add_cached(), and having these test cmp() < 0 rather than less() ?
  I figure every user will need to have a cmp() function, so it'd be
  nicer if they didn't also need a less() function, if the generated
  code is similar (if you checked and rejected it because of bad code,
  please just say so).

Reviewed-by: Michel Lespinasse <walken@google.com>

I also looked at the other commits in the series, making use of the
helpers, and they seem very reasonable but I did not give them as
thorough a look at this one.

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
> +		leftmost = true;
> +	}
>  	rb_erase(node, &root->rb_root);
> +
> +	return leftmost;
>  }
>  
>  static inline void rb_replace_node_cached(struct rb_node *victim,
> @@ -158,4 +164,121 @@ static inline void rb_replace_node_cache
>  	rb_replace_node(victim, new, &root->rb_root);
>  }
>  
> +static inline bool rb_add_cached(struct rb_root_cached *tree, struct rb_node *node,
> +				 bool (*less)(struct rb_node *, const struct rb_node *))
> +{
> +	struct rb_node **link = &tree->rb_root.rb_node;
> +	struct rb_node *parent = NULL;
> +	bool leftmost = true;
> +
> +	while (*link) {
> +		parent = *link;
> +		if (less(node, parent)) {
> +			link = &parent->rb_left;
> +		} else {
> +			link = &parent->rb_right;
> +			leftmost = false;
> +		}
> +	}
> +
> +	rb_link_node(node, parent, link);
> +	rb_insert_color_cached(node, tree, leftmost);
> +
> +	return leftmost;
> +}
> +
> +static inline void rb_add(struct rb_root *tree, struct rb_node *node,
> +			  bool (*less)(struct rb_node *, const struct rb_node *))
> +{
> +	struct rb_node **link = &tree->rb_node;
> +	struct rb_node *parent = NULL;
> +
> +	while (*link) {
> +		parent = *link;
> +		if (less(node, parent))
> +			link = &parent->rb_left;
> +		else
> +			link = &parent->rb_right;
> +	}
> +
> +	rb_link_node(node, parent, link);
> +	rb_insert_color(node, tree);
> +}
> +
> +static inline struct rb_node *rb_find_add(struct rb_root *tree, struct rb_node *node,
> +			  int (*cmp)(struct rb_node *, const struct rb_node *))
> +{
> +	struct rb_node **link = &tree->rb_node;
> +	struct rb_node *parent = NULL;
> +	int c;
> +
> +	while (*link) {
> +		parent = *link;
> +		c = cmp(node, parent);
> +
> +		if (c < 0)
> +			link = &parent->rb_left;
> +		else if (c > 0)
> +			link = &parent->rb_right;
> +		else
> +			return parent;
> +	}
> +
> +	rb_link_node(node, parent, link);
> +	rb_insert_color(node, tree);
> +	return NULL;
> +}
> +
> +static inline struct rb_node *rb_find(struct rb_root *tree, const void *key,
> +				      int (*cmp)(const void *key, const struct rb_node *))
> +{
> +	struct rb_node *node = tree->rb_node;
> +
> +	while (node) {
> +		int c = cmp(key, node);
> +		if (c < 0) {
> +			node = node->rb_left;
> +		} else if (c > 0) {
> +			node = node->rb_right;
> +		} else
> +			return node;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
> +					    int (*cmp)(const void *key, const struct rb_node *))
> +{
> +	struct rb_node *node = tree->rb_node;
> +	struct rb_node *match = NULL;
> +
> +	while (node) {
> +		int c = cmp(key, node);
> +		if (c <= 0) {
> +			if (!c)
> +				match = node;
> +			node = node->rb_left;
> +		} else if (c > 0) {
> +			node = node->rb_right;
> +		}
> +	}
> +
> +	return match;
> +}
> +
> +static inline struct rb_node *rb_next_match(struct rb_node *node, const void *key,
> +					    int (*cmp)(const void *key, const struct rb_node *))
> +{
> +	node = rb_next(node);
> +	if (node && cmp(key, node))
> +		node = NULL;
> +	return node;
> +}
> +
> +#define rb_for_each(tree, node, key, cmp) \
> +	for ((node) = rb_find_first((tree), (key), (cmp)); \
> +	     (node); (node) = rb_next_match((node), (key), (cmp)))
> +
> +
>  #endif	/* _LINUX_RBTREE_H */
> --- a/tools/include/linux/rbtree.h
> +++ b/tools/include/linux/rbtree.h
> @@ -135,12 +135,18 @@ static inline void rb_insert_color_cache
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
> +		leftmost = true;
> +	}
>  	rb_erase(node, &root->rb_root);
> +
> +	return leftmost;
>  }
>  
>  static inline void rb_replace_node_cached(struct rb_node *victim,
> @@ -152,4 +158,121 @@ static inline void rb_replace_node_cache
>  	rb_replace_node(victim, new, &root->rb_root);
>  }
>  
> -#endif /* __TOOLS_LINUX_PERF_RBTREE_H */
> +static inline bool rb_add_cached(struct rb_root_cached *tree, struct rb_node *node,
> +				 bool (*less)(struct rb_node *, const struct rb_node *))
> +{
> +	struct rb_node **link = &tree->rb_root.rb_node;
> +	struct rb_node *parent = NULL;
> +	bool leftmost = true;
> +
> +	while (*link) {
> +		parent = *link;
> +		if (less(node, parent)) {
> +			link = &parent->rb_left;
> +		} else {
> +			link = &parent->rb_right;
> +			leftmost = false;
> +		}
> +	}
> +
> +	rb_link_node(node, parent, link);
> +	rb_insert_color_cached(node, tree, leftmost);
> +
> +	return leftmost;
> +}
> +
> +static inline void rb_add(struct rb_root *tree, struct rb_node *node,
> +			  bool (*less)(struct rb_node *, const struct rb_node *))
> +{
> +	struct rb_node **link = &tree->rb_node;
> +	struct rb_node *parent = NULL;
> +
> +	while (*link) {
> +		parent = *link;
> +		if (less(node, parent))
> +			link = &parent->rb_left;
> +		else
> +			link = &parent->rb_right;
> +	}
> +
> +	rb_link_node(node, parent, link);
> +	rb_insert_color(node, tree);
> +}
> +
> +static inline struct rb_node *rb_find_add(struct rb_root *tree, struct rb_node *node,
> +			  int (*cmp)(struct rb_node *, const struct rb_node *))
> +{
> +	struct rb_node **link = &tree->rb_node;
> +	struct rb_node *parent = NULL;
> +	int c;
> +
> +	while (*link) {
> +		parent = *link;
> +		c = cmp(node, parent);
> +
> +		if (c < 0)
> +			link = &parent->rb_left;
> +		else if (c > 0)
> +			link = &parent->rb_right;
> +		else
> +			return parent;
> +	}
> +
> +	rb_link_node(node, parent, link);
> +	rb_insert_color(node, tree);
> +	return NULL;
> +}
> +
> +static inline struct rb_node *rb_find(struct rb_root *tree, const void *key,
> +				      int (*cmp)(const void *key, const struct rb_node *))
> +{
> +	struct rb_node *node = tree->rb_node;
> +
> +	while (node) {
> +		int c = cmp(key, node);
> +		if (c < 0) {
> +			node = node->rb_left;
> +		} else if (c > 0) {
> +			node = node->rb_right;
> +		} else
> +			return node;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
> +					    int (*cmp)(const void *key, const struct rb_node *))
> +{
> +	struct rb_node *node = tree->rb_node;
> +	struct rb_node *match = NULL;
> +
> +	while (node) {
> +		int c = cmp(key, node);
> +		if (c <= 0) {
> +			if (!c)
> +				match = node;
> +			node = node->rb_left;
> +		} else if (c > 0) {
> +			node = node->rb_right;
> +		}
> +	}
> +
> +	return match;
> +}
> +
> +static inline struct rb_node *rb_next_match(struct rb_node *node, const void *key,
> +					    int (*cmp)(const void *key, const struct rb_node *))
> +{
> +	node = rb_next(node);
> +	if (node && cmp(key, node))
> +		node = NULL;
> +	return node;
> +}
> +
> +#define rb_for_each(tree, node, key, cmp) \
> +	for ((node) = rb_find_first((tree), (key), (cmp)); \
> +	     (node); (node) = rb_next_match((node), (key), (cmp)))
> +
> +
> +#endif	/* _LINUX_RBTREE_H */
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -43,75 +43,24 @@ static void elf_hash_init(struct hlist_h
>  #define elf_hash_for_each_possible(name, obj, member, key)			\
>  	hlist_for_each_entry(obj, &name[hash_min(key, elf_hash_bits())], member)
>  
> -static void rb_add(struct rb_root *tree, struct rb_node *node,
> -		   int (*cmp)(struct rb_node *, const struct rb_node *))
> -{
> -	struct rb_node **link = &tree->rb_node;
> -	struct rb_node *parent = NULL;
> -
> -	while (*link) {
> -		parent = *link;
> -		if (cmp(node, parent) < 0)
> -			link = &parent->rb_left;
> -		else
> -			link = &parent->rb_right;
> -	}
> -
> -	rb_link_node(node, parent, link);
> -	rb_insert_color(node, tree);
> -}
> -
> -static struct rb_node *rb_find_first(struct rb_root *tree, const void *key,
> -			       int (*cmp)(const void *key, const struct rb_node *))
> -{
> -	struct rb_node *node = tree->rb_node;
> -	struct rb_node *match = NULL;
> -
> -	while (node) {
> -		int c = cmp(key, node);
> -		if (c <= 0) {
> -			if (!c)
> -				match = node;
> -			node = node->rb_left;
> -		} else if (c > 0) {
> -			node = node->rb_right;
> -		}
> -	}
> -
> -	return match;
> -}
> -
> -static struct rb_node *rb_next_match(struct rb_node *node, const void *key,
> -				    int (*cmp)(const void *key, const struct rb_node *))
> -{
> -	node = rb_next(node);
> -	if (node && cmp(key, node))
> -		node = NULL;
> -	return node;
> -}
> -
> -#define rb_for_each(tree, node, key, cmp) \
> -	for ((node) = rb_find_first((tree), (key), (cmp)); \
> -	     (node); (node) = rb_next_match((node), (key), (cmp)))
> -
> -static int symbol_to_offset(struct rb_node *a, const struct rb_node *b)
> +static bool symbol_to_offset(struct rb_node *a, const struct rb_node *b)
>  {
>  	struct symbol *sa = rb_entry(a, struct symbol, node);
>  	struct symbol *sb = rb_entry(b, struct symbol, node);
>  
>  	if (sa->offset < sb->offset)
> -		return -1;
> +		return true;
>  	if (sa->offset > sb->offset)
> -		return 1;
> +		return false;
>  
>  	if (sa->len < sb->len)
> -		return -1;
> +		return true;
>  	if (sa->len > sb->len)
> -		return 1;
> +		return false;
>  
>  	sa->alias = sb;
>  
> -	return 0;
> +	return false;
>  }
>  
>  static int symbol_by_offset(const void *key, const struct rb_node *node)
> 
> 

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
