Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EB4C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5805420714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Tpr5B2vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgCQPS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:18:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40387 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgCQPS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:18:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id z12so13270621wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=qBXIZEzxGUqAyM9pIpBwJ4AViTVInHf7b+TVClzYuWM=;
        b=Tpr5B2vnUsJrytN/KjvohZZDnhPLmWc3gu4a7Zk4pVGhdvmPPnlHbigO8nJnUjZLmU
         dqYbnDaKnyVRP3t+CJcHtZdUjmNWIN8OIXh6KsPjBBY4qg0CSeaWC7Njw3goh2Q1gW62
         6eylyApKAtGTwhaY3RuFk4B+CtUIK2dMIdAxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=qBXIZEzxGUqAyM9pIpBwJ4AViTVInHf7b+TVClzYuWM=;
        b=sR77mDGxNKv1htSBspUCbKN7BWA2UYalqrZpC9ZeibWXFK0E6/TEn7TxTueRDVKnQ4
         5y5sFj8vCCcHiDMMKoQEixlotQ8j/DKFoOhEZRWAKzrwx4d0oMG975TErHmps2RjVY9X
         uPWef0qzYs9cbiYg7min1/WCTlr9+wpkihkbY9ArzmDUi6P65oiFM+5kgJIaFyM4G4Yg
         CjehiN710JYenHvHwIWGnf4LKulm/7y+R3H5E5bToPBpUOcM1UXwwGSVdsaN16WyjUIN
         dEsfUZlWv3JKRqIG0BN1SQHfzPKeKj7VQYjXZ0YtZ4HJSxqsg1WBhiaRw+fY9jQSnp+U
         nTmg==
X-Gm-Message-State: ANhLgQ2b6pkpgB6UF0lbz/KJaxojAGDG61YpOHWgIucOpkASDDFPoKEV
        q57gbIftsGZ092a6ZUgw4Id+8Q==
X-Google-Smtp-Source: ADFU+vvvZ5+/lYRbIsazixQyqzZRdmk+3TtUtyYZ4FfAMpZUuapXzOiEWdXWf3/4kpMBhcOF5C9OaQ==
X-Received: by 2002:a1c:ba42:: with SMTP id k63mr5961236wmf.71.1584458303817;
        Tue, 17 Mar 2020 08:18:23 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w7sm5221114wrr.60.2020.03.17.08.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 08:18:23 -0700 (PDT)
References: <20200310174711.7490-1-lmb@cloudflare.com> <20200310174711.7490-5-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] bpf: sockmap, sockhash: return file descriptors from privileged lookup
In-reply-to: <20200310174711.7490-5-lmb@cloudflare.com>
Date:   Tue, 17 Mar 2020 16:18:22 +0100
Message-ID: <87imj3xb5t.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 06:47 PM CET, Lorenz Bauer wrote:
> Allow callers with CAP_NET_ADMIN to retrieve file descriptors from a
> sockmap and sockhash. O_CLOEXEC is enforced on all fds.
>
> Without this, it's difficult to resize or otherwise rebuild existing
> sockmap or sockhashes.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---
>  net/core/sock_map.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 03e04426cd21..3228936aa31e 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -347,12 +347,31 @@ static void *sock_map_lookup(struct bpf_map *map, void *key)
>  static int __sock_map_copy_value(struct bpf_map *map, struct sock *sk,
>  				 void *value)
>  {
> +	struct file *file;
> +	int fd;
> +
>  	switch (map->value_size) {
>  	case sizeof(u64):
>  		sock_gen_cookie(sk);
>  		*(u64 *)value = atomic64_read(&sk->sk_cookie);
>  		return 0;
>
> +	case sizeof(u32):
> +		if (!capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +
> +		fd = get_unused_fd_flags(O_CLOEXEC);
> +		if (unlikely(fd < 0))
> +			return fd;
> +
> +		read_lock_bh(&sk->sk_callback_lock);
> +		file = get_file(sk->sk_socket->file);

I think this deserves a second look.

We don't lock the sock, so what if tcp_close orphans it before we enter
this critical section? Looks like sk->sk_socket might be NULL.

I'd find a test that tries to trigger the race helpful, like:

  thread A: loop in lookup FD from map
  thread B: loop in insert FD into map, close FD

> +		read_unlock_bh(&sk->sk_callback_lock);
> +
> +		fd_install(fd, file);
> +		*(u32 *)value = fd;
> +		return 0;
> +
>  	default:
>  		return -ENOSPC;
>  	}
