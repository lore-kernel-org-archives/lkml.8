Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA30C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B334D20663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ID3zIu4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbgCLODg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:03:36 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43621 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgCLODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:03:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id x1so1447178qkx.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=llnqGMEP0WhestZ7Ck/j/TXED0wzZ+R7hJNKQAMFwSw=;
        b=ID3zIu4I4SYuh3dOvdboHzfUp3zrBkMZ78ALde5G9suHbGgxzk14dfh6HX6hcn9Wna
         R4ATKeTZ0UR88ii+B9cp/1mPaYzSAC5G9EeUbljITfIR+vL15CV2FxSBDzHfsJsOf/K/
         8II7onlt8fLcH04pHDA7OfApc7ziQMikZIPDK1Eh2hhcP5cZ2Ltqn5W7guqO0bcw92Dy
         UoJ8pBBedDvQJJp7uMwIBFXs1WdRqOHXknP4GZvozHABqttvVfrD9XUwXuTWJWsMqmP9
         X5y4lDZKcLxXW/j7o/6fhQOpzl03B5NLKJ+fTJBx7IBEqQerGIPB0/9zM36V2y5Yqgo3
         cweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=llnqGMEP0WhestZ7Ck/j/TXED0wzZ+R7hJNKQAMFwSw=;
        b=b4JFW+C8b9j+XTv6d4UPEocXqHo6M1mvLQvaDgUjGQKgkp47a6BK55UvMmxDwB4jIq
         zH+vP3nMarxWFlkgJGoSysNYN9BHnUPcVeCLR1Ly4GsKSKr6q0u8fyIHARPZ9SN+d1Zs
         UwMIFZSwBKqwEsLi7n/UmXb7Q8kTDFVDf3AxlC+M7jENbUN5FuRk4rFcQYRDDGLi/hp5
         LY9vZBmSkyvhrWNNqvkYDsC497APXh8Eqp5Zy5fBpKezCTg/hYZ1XBc6A2m/eTGbG0os
         ec2tsJEwUdAFovUm1Vlx4eslpaRgqGjDlmyc061jkTcZ80NLP4BBmptCiq4hEhayQ0mZ
         yz2A==
X-Gm-Message-State: ANhLgQ16/jRy5ig45clbjqLhufR50IfWwSD9+BgqKTYO1NY3czkeeMVV
        5hdP0hh51OxKOkx2O/T5qiwcGw==
X-Google-Smtp-Source: ADFU+vsttBVJyaFPAv/6+uT5X/zUbwGQzRZzYpJbEOkSBPOQimT0W9lYBi/8o5HSNH3mjdxwoqUFkg==
X-Received: by 2002:a37:4cc3:: with SMTP id z186mr7646916qka.69.1584021813971;
        Thu, 12 Mar 2020 07:03:33 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j85sm12186207qke.20.2020.03.12.07.03.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:03:33 -0700 (PDT)
Message-ID: <1584021811.7365.180.camel@lca.pw>
Subject: Re: [PATCH v4 2/2] net: memcg: late association of sock to memcg
From:   Qian Cai <cai@lca.pw>
To:     Shakeel Butt <shakeelb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 12 Mar 2020 10:03:31 -0400
In-Reply-To: <20200310051606.33121-2-shakeelb@google.com>
References: <20200310051606.33121-1-shakeelb@google.com>
         <20200310051606.33121-2-shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 22:16 -0700, Shakeel Butt wrote:
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index a4db79b1b643..65a3b2565102 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -482,6 +482,26 @@ struct sock *inet_csk_accept(struct sock *sk, int flags, int *err, bool kern)
>  		}
>  		spin_unlock_bh(&queue->fastopenq.lock);
>  	}
> +
> +	if (mem_cgroup_sockets_enabled) {
> +		int amt;
> +
> +		/* atomically get the memory usage, set and charge the
> +		 * sk->sk_memcg.
> +		 */
> +		lock_sock(newsk);

Here we have a deadlock,

[  362.620977][ T4106] WARNING: possible recursive locking detected
[  362.626983][ T4106] 5.6.0-rc5-next-20200312+ #5 Tainted: G             L   
[  362.633941][ T4106] --------------------------------------------
[  362.639944][ T4106] sshd/4106 is trying to acquire lock:
[  362.645251][ T4106] 7bff008a2eae6330 (sk_lock-AF_INET){+.+.}, at:
inet_csk_accept+0x370/0x45c
inet_csk_accept at net/ipv4/inet_connection_sock.c:497
[  362.653791][ T4106] 
[  362.653791][ T4106] but task is already holding lock:
[  362.661007][ T4106] c0ff008a2eae9430 (sk_lock-AF_INET){+.+.}, at:
inet_csk_accept+0x48/0x45c
inet_csk_accept at net/ipv4/inet_connection_sock.c:451
[  362.669452][ T4106] 
[  362.669452][ T4106] other info that might help us debug this:
[  362.677364][ T4106]  Possible unsafe locking scenario:
[  362.677364][ T4106] 
[  362.684666][ T4106]        CPU0
[  362.687801][ T4106]        ----
[  362.690937][ T4106]   lock(sk_lock-AF_INET);
[  362.695204][ T4106]   lock(sk_lock-AF_INET);
[  362.699472][ T4106] 
[  362.699472][ T4106]  *** DEADLOCK ***
[  362.699472][ T4106] 
[  362.707469][ T4106]  May be due to missing lock nesting notation
[  362.707469][ T4106] 
[  362.715643][ T4106] 1 lock held by sshd/4106:
[  362.719993][ T4106]  #0: c0ff008a2eae9430 (sk_lock-AF_INET){+.+.}, at:
inet_csk_accept+0x48/0x45c
[  362.728874][ T4106] 
[  362.728874][ T4106] stack backtrace:
[  362.734622][ T4106] CPU: 22 PID: 4106 Comm: sshd Tainted:
G             L    5.6.0-rc5-next-20200312+ #5
[  362.744096][ T4106] Hardware name: HPE Apollo
70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  362.754525][ T4106] Call trace:
[  362.757667][ T4106]  dump_backtrace+0x0/0x2c8
[  362.762022][ T4106]  show_stack+0x20/0x2c
[  362.766032][ T4106]  dump_stack+0xe8/0x150
[  362.770128][ T4106]  validate_chain+0x2f08/0x35e0
[  362.774830][ T4106]  __lock_acquire+0x868/0xc2c
[  362.779358][ T4106]  lock_acquire+0x320/0x360
[  362.783715][ T4106]  lock_sock_nested+0x9c/0xd8
[  362.788243][ T4106]  inet_csk_accept+0x370/0x45c
[  362.792861][ T4106]  inet_accept+0x80/0x1cc
[  362.797045][ T4106]  __sys_accept4_file+0x1b0/0x2bc
[  362.801921][ T4106]  __arm64_sys_accept+0x74/0xc8
[  362.806625][ T4106]  do_el0_svc+0x170/0x240
[  362.810807][ T4106]  el0_sync_handler+0x150/0x250
[  362.815509][ T4106]  el0_sync+0x164/0x180


> +
> +		/* The sk has not been accepted yet, no need to look at
> +		 * sk->sk_wmem_queued.
> +		 */
> +		amt = sk_mem_pages(newsk->sk_forward_alloc +
> +				   atomic_read(&sk->sk_rmem_alloc));
> +		mem_cgroup_sk_alloc(newsk);
> +		if (newsk->sk_memcg && amt)
> +			mem_cgroup_charge_skmem(newsk->sk_memcg, amt);
> +
> +		release_sock(newsk);
> +	}
>  out:
>  	release_sock(sk);
>  	if (req)
