Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261E2C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EC620873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="I097htkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgCKOBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:01:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39247 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729726AbgCKOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:01:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id f7so2256018wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=st6T0r/6+bS/alnv4g1bn1POyCeaa5C0vH9S2dNg93o=;
        b=I097htkv9toD64jIus4MDQriHnPlX5I5/u3CJzx3HOAgCGqcN+niX1b8vF7fQZYcql
         D7P4OFoIs/2RXu75huetc2RqudjX4l8BMEc//T2iGzqaOvk7yGDYSBYbsO4GWkNoWH9r
         wxn1mu0+he3WdaN+lmKOw4NOMoxv+sh8jWTLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=st6T0r/6+bS/alnv4g1bn1POyCeaa5C0vH9S2dNg93o=;
        b=GgfTCNsJmXXvUEEFyJPq/uRbJiJ6UTEWxB3I/U5bnA0MqLyVkn7S+KEE8I/gpSIp9D
         oq2vgn/zRE6dR7wRchlLGKREy6Uqo0mQ8mNxhEXXLD1ZrRLw6KbduYnd2WRWKK7i0avv
         neXAdMLxcwKrX5dUqnQiEXGnCJ3p1Ms7sN5LwutnQ0evTib2GY/xR8GvYDAeKgMp6AfR
         2vrHLDoq8nhmEAfyYwSBUlaN/JR14gtfqA6SQRjEJ+6daQWI2AyIkLoEXgU7f1O3DJx2
         KmXP4V3g2zAKct+uS8/xI+otD6KpYEL3FPekqOWSbJNLRAUWqv51K42yfF6yifQVmTrx
         lz+A==
X-Gm-Message-State: ANhLgQ0Zen+0G/Ol8Q/S7FsmyPdTA6zRpetdwVUBdlKxH8zMKq4n6hRQ
        UqzSouCbILGuFRx5W5yJWrfLlg==
X-Google-Smtp-Source: ADFU+vuNzZZ/aB/DBFskPbkdKY5PpuNWXDnHImPs87RpTw4z3v+JjU4zYukfDdogLaUZu6g/Gmwfsw==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr2719125wml.26.1583935258738;
        Wed, 11 Mar 2020 07:00:58 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id k5sm6012188wmj.18.2020.03.11.07.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:00:58 -0700 (PDT)
References: <20200310174711.7490-1-lmb@cloudflare.com> <20200310174711.7490-3-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] bpf: convert queue and stack map to map_copy_value
In-reply-to: <20200310174711.7490-3-lmb@cloudflare.com>
Date:   Wed, 11 Mar 2020 15:00:57 +0100
Message-ID: <87tv2vxa7a.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 06:47 PM CET, Lorenz Bauer wrote:
> Migrate BPF_MAP_TYPE_QUEUE and BPF_MAP_TYPE_STACK to map_copy_value,
> by introducing small wrappers that discard the (unused) key argument.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  kernel/bpf/queue_stack_maps.c | 18 ++++++++++++++++++
>  kernel/bpf/syscall.c          |  5 +----
>  2 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
> index f697647ceb54..5c89b7583cd2 100644
> --- a/kernel/bpf/queue_stack_maps.c
> +++ b/kernel/bpf/queue_stack_maps.c
> @@ -262,11 +262,28 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
>  	return -EINVAL;
>  }
>
> +/* Called from syscall */
> +static int queue_map_copy_value(struct bpf_map *map, void *key, void *value)
> +{
> +	(void)key;

Alternatively, there's is the __always_unused compiler attribute from
include/linux/compiler_attributes.h that seems to be in wide use.

> +
> +	return queue_map_peek_elem(map, value);
> +}
> +
> +/* Called from syscall */
> +static int stack_map_copy_value(struct bpf_map *map, void *key, void *value)
> +{
> +	(void)key;
> +
> +	return stack_map_peek_elem(map, value);
> +}
> +
>  const struct bpf_map_ops queue_map_ops = {
>  	.map_alloc_check = queue_stack_map_alloc_check,
>  	.map_alloc = queue_stack_map_alloc,
>  	.map_free = queue_stack_map_free,
>  	.map_lookup_elem = queue_stack_map_lookup_elem,
> +	.map_copy_value = queue_map_copy_value,
>  	.map_update_elem = queue_stack_map_update_elem,
>  	.map_delete_elem = queue_stack_map_delete_elem,
>  	.map_push_elem = queue_stack_map_push_elem,
> @@ -280,6 +297,7 @@ const struct bpf_map_ops stack_map_ops = {
>  	.map_alloc = queue_stack_map_alloc,
>  	.map_free = queue_stack_map_free,
>  	.map_lookup_elem = queue_stack_map_lookup_elem,
> +	.map_copy_value = stack_map_copy_value,
>  	.map_update_elem = queue_stack_map_update_elem,
>  	.map_delete_elem = queue_stack_map_delete_elem,
>  	.map_push_elem = queue_stack_map_push_elem,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6503824e81e9..20c6cdace275 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -218,10 +218,7 @@ static int bpf_map_copy_value(struct bpf_map *map, void *key, void *value,
>  		return bpf_map_offload_lookup_elem(map, key, value);
>
>  	bpf_disable_instrumentation();
> -	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
> -	    map->map_type == BPF_MAP_TYPE_STACK) {
> -		err = map->ops->map_peek_elem(map, value);
> -	} else if (map->ops->map_copy_value) {
> +	if (map->ops->map_copy_value) {
>  		err = map->ops->map_copy_value(map, key, value);
>  	} else {
>  		rcu_read_lock();
