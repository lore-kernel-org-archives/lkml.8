Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E960C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1DA206B9
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RXum/kcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgDYOYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgDYOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:24:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEBDC09B04B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 07:24:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so14952667wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 07:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=jnGMwqxDJTUwXxH8vie5J2AOeWeVUc9XLUd9uVmVOK0=;
        b=RXum/kcdev5kFunjRwVnErwBSmTKoHcyC3Ak/1zmGj13o4Kf4pduDeug7NsGKFxVG4
         0SU5XsgmKEyaYSnJ6TMEtVReSu2Ol3M5Kkkdxgpdwz0nUWYQlFDdFZ1qSneN1f1FPPO3
         Qaetz1VEJcPpLmjtVrq1rMGf+BhEsQCLoZfgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=jnGMwqxDJTUwXxH8vie5J2AOeWeVUc9XLUd9uVmVOK0=;
        b=tBHZMs3RNB/Ck/xNe2qDDn0uYbaAJcIroPBQClaR/DuFGv0O47JMmDJhixIbHxUaEn
         dTXRJXZqY5LfUkxlSpejM4N2hc5zACsGd9Tp2v/utxYHu33bbuxRMUgLvKWT1jOSxpS4
         fGVbtO1e/YGfu9R6VHtb6ch1Kb+6yf8GXm2jGzF1jcqhV1NVxnN9offUP9jbI30TIR1E
         Iv6r1J3LscLU0cv3zLVT4SqME1SJFDgZqTRn7wt79XOTTxiLWxKy8SrFKPrCpflN4Bvk
         dIkDHrRYodQlTZXeKTIEf9BQudVgtKkFePZMmtCsw2LkUUaL6gw8KPb4ii0DZgBgTas/
         QX5w==
X-Gm-Message-State: AGi0PubGUTSZf/SKuB25qStvHedM4C2lgdx2N+bMOv98hgQXvPd9qJri
        p0f87+O+5jUElwBz8bV6N+mREw==
X-Google-Smtp-Source: APiQypJWu9LEffosU8ysy0XWABFIgtJCI/VVV2LrHyMeG66GzJRTnFyeyyWTmEc7h5wdBP1x5keG8A==
X-Received: by 2002:adf:a11a:: with SMTP id o26mr16996447wro.284.1587824686568;
        Sat, 25 Apr 2020 07:24:46 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id o18sm12534047wrp.23.2020.04.25.07.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 07:24:45 -0700 (PDT)
References: <1587819040-38793-1-git-send-email-xiyuyang19@fudan.edu.cn>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] bpf: Fix sk_psock refcnt leak when receiving message
In-reply-to: <1587819040-38793-1-git-send-email-xiyuyang19@fudan.edu.cn>
Date:   Sat, 25 Apr 2020 16:24:44 +0200
Message-ID: <87lfmjve1f.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 02:50 PM CEST, Xiyu Yang wrote:
> tcp_bpf_recvmsg() invokes sk_psock_get(), which returns a reference of
> the specified sk_psock object to "psock" with increased refcnt.
>
> When tcp_bpf_recvmsg() returns, local variable "psock" becomes invalid,
> so the refcount should be decreased to keep refcount balanced.
>
> The reference counting issue happens in several exception handling paths
> of tcp_bpf_recvmsg(). When those error scenarios occur such as "flags"
> includes MSG_ERRQUEUE, the function forgets to decrease the refcnt
> increased by sk_psock_get(), causing a refcnt leak.
>
> Fix this issue by calling sk_psock_put() when those error scenarios
> occur.
>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  net/ipv4/tcp_bpf.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 5a05327f97c1..feb6b90672c1 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -265,11 +265,15 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>  	psock = sk_psock_get(sk);
>  	if (unlikely(!psock))
>  		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
> -	if (unlikely(flags & MSG_ERRQUEUE))
> +	if (unlikely(flags & MSG_ERRQUEUE)) {
> +		sk_psock_put(sk, psock);
>  		return inet_recv_error(sk, msg, len, addr_len);
> +	}
>  	if (!skb_queue_empty(&sk->sk_receive_queue) &&
> -	    sk_psock_queue_empty(psock))
> +	    sk_psock_queue_empty(psock)) {
> +		sk_psock_put(sk, psock);
>  		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
> +	}
>  	lock_sock(sk);
>  msg_bytes_ready:
>  	copied = __tcp_bpf_recvmsg(sk, psock, msg, len, flags);

Thanks for the fix.

We can pull up the error queue read handling, that is the `flags &
MSG_ERRQUEUE` branch, so that it happens before we grab a psock ref.

The effect is the same because now, if we hit the !psock branch,
tcp_recvmsg will first check if user wants to read the error queue
anyway.

That would translate to something like below, in addition to your
changes.

WDYT?

---8<---

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 5a05327f97c1..99aa57bd1901 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -262,14 +262,17 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	struct sk_psock *psock;
 	int copied, ret;

+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
-	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
 	if (!skb_queue_empty(&sk->sk_receive_queue) &&
 	    sk_psock_queue_empty(psock))
		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
