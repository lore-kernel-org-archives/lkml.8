Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6230C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF4C20704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeLpFj/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAWRMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:12:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28025 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgAWRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579799562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2gQFOE3eZCJDYvBNgH30Kf453Z08E1vS+GpfLhJCCns=;
        b=KeLpFj/1G6pejgJTEbixZkZZRKn8F41lCUv0GcWy2tT+qjyC/qmuJ7Oj09u9kiL7W6Aq7k
        kopcol1I2A5fWuXNuElHqWTjHqWYnvpDffZtoP16Qu9vLBTna7qv2VwJ+7noxOOSORaKbX
        arxTJ9GYTcYnAjPmvw6jsc7tl/xsTHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-Nj5iUlfuN1GS-F4u-sFSkw-1; Thu, 23 Jan 2020 12:11:05 -0500
X-MC-Unique: Nj5iUlfuN1GS-F4u-sFSkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64AA618B6396;
        Thu, 23 Jan 2020 17:11:04 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B4CB8CCE3;
        Thu, 23 Jan 2020 17:11:03 +0000 (UTC)
Subject: Re: [PATCH -next] arm64/spinlock: fix a -Wunused-function warning
To:     Qian Cai <cai@lca.pw>, peterz@infradead.org
Cc:     will@kernel.org, mingo@redhat.com, catalin.marinas@arm.com,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200123162945.7705-1-cai@lca.pw>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2fe3a534-feb6-490c-71c6-208607e6cdf6@redhat.com>
Date:   Thu, 23 Jan 2020 12:11:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200123162945.7705-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/20 11:29 AM, Qian Cai wrote:
> The commit f5bfdc8e3947 ("locking/osq: Use optimized spinning loop for
> arm64") introduced a warning from Clang because vcpu_is_preempted() is
> compiled away,
>
> kernel/locking/osq_lock.c:25:19: warning: unused function 'node_cpu'
> [-Wunused-function]
> static inline int node_cpu(struct optimistic_spin_node *node)
>                   ^
> 1 warning generated.
>
> Since vcpu_is_preempted() had already been defined in
> include/linux/sched.h as false, just comment out the redundant macro, s=
o
> it can still be served for the documentation purpose.
>
> Fixes: f5bfdc8e3947 ("locking/osq: Use optimized spinning loop for arm6=
4")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/include/asm/spinlock.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm=
/spinlock.h
> index 102404dc1e13..b05f82e8ba19 100644
> --- a/arch/arm64/include/asm/spinlock.h
> +++ b/arch/arm64/include/asm/spinlock.h
> @@ -17,7 +17,8 @@
>   *
>   * See:
>   * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programmin=
g.kicks-ass.net
> + *
> + * #define vcpu_is_preempted(cpu)	false
>   */
> -#define vcpu_is_preempted(cpu)	false
> =20
>  #endif /* __ASM_SPINLOCK_H */

Does adding a __maybe_unused tag help to prevent the warning? Like

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 6ef600aa0f47..0722655af34f 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -22,7 +22,7 @@ static inline int encode_cpu(int cpu_nr)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return cpu_nr + 1;
=C2=A0}
=C2=A0
-static inline int node_cpu(struct optimistic_spin_node *node)
+static inline int __maybe_unused node_cpu(struct optimistic_spin_node
*node)
=C2=A0{
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return node->cpu - 1;
=C2=A0}

Cheers,
Longman

