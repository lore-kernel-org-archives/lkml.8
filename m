Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F736C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D83205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 23:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZEREVmbd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAVXyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 18:54:47 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34245 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:54:47 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so686416qvf.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 15:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y891l6t6rwqEphHNBTnl2M3NxO8ptSQ7BIfDNEIR8Ps=;
        b=ZEREVmbdd7dqX7kqu+0lO6gQ+5Zm7Gcoch/RTGP8XxIXmP39GP1tV7hcKLbtSnlgGa
         bW26njd0SdS94EbHuDmHXXt7vlF8Kdb+LrUfIgZNUUuhSwCIdQdwGmqhPCuWM+qWWxjf
         PoPhowA43zRzmp5T906SX9G1hY5etFbt/6i0BoD7RR62aIm2a/dSql0C6IfL19C2lEJw
         v9MCLqjCCDB/ilsse5e3qez7WJcgZxsi2wYN+Jf5OJiCq7vR8bTIl49SZZlFWdyaaXR4
         /rP8461TDgxfdiR9ht+4Em4lidTfiSh0I3V5AMXC+7E6BIfuPIkXTpancUvQGT3283UZ
         DTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y891l6t6rwqEphHNBTnl2M3NxO8ptSQ7BIfDNEIR8Ps=;
        b=X8pXFU7XWNVT0b+Sv3WYY00JHM0yMP4glXX3syawIH/WVtQN8ogOUAJu9oN5zR4+zm
         4cjjLVA2D1CKKX/IOPm8kaDGfcnZQ6pHLobZ39MnPW8IJfQjwk7MhMBfphJDU3xQsgIt
         zeDFe/U3PUTfaocZB+QZJex9JUHh2WielzDPfcuwYNsWnjh+TqrUtXkhvDPXpT/7JWp4
         m6CtSvFZrjoyBxw7u0UbjwPgnZeegA8G8R/nEWGCoMEm1grEBjB1umRfDXa1UfyKb3v0
         vnZN5NxbhbdFZf4UYp8w8f6bThEDqQ45BNyoji8fxni4E0AcgQ9vunnnFmSVoexcutQW
         mOkg==
X-Gm-Message-State: APjAAAUmhQm6A2CsuCcp3IZA0GaoOOjiU114QIVRtJLEjqscNmp0ANNh
        mjfui2e1OfRsQ2si8ONRZK0inw==
X-Google-Smtp-Source: APXvYqzG75hFKrRhyhy+nGo05RbPtEKmluDqiVl/HOpOJATmWBuV2YmzmM2kbeFmxI01FWChd12J0w==
X-Received: by 2002:a0c:f6cd:: with SMTP id d13mr13160587qvo.20.1579737285564;
        Wed, 22 Jan 2020 15:54:45 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e3sm122085qtj.30.2020.01.22.15.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 15:54:45 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200122223851.GA45602@google.com>
Date:   Wed, 22 Jan 2020 18:54:43 -0500
Cc:     Will Deacon <will@kernel.org>, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
To:     Marco Elver <elver@google.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 22, 2020, at 5:38 PM, Marco Elver <elver@google.com> wrote:
>=20
>=20
>=20
> On Wed, 22 Jan 2020, Qian Cai wrote:
>=20
>>=20
>>=20
>>> On Jan 22, 2020, at 11:59 AM, Will Deacon <will@kernel.org> wrote:
>>>=20
>>> I don't understand this; 'next' is a local variable.
>>>=20
>>> Not keen on the onslaught of random "add a READ_ONCE() to shut the
>>> sanitiser up" patches we're going to get from kcsan :(
>>=20
>> My fault. I suspect it is node->next. I=E2=80=99ll do a bit more =
testing to confirm.
>=20
> If possible, decode and get the line numbers. I have observed a data

[  667.817131] Reported by Kernel Concurrency Sanitizer on:
[  667.823200] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W    L    =
5.5.0-rc7-next-20200121+ #9
[  667.832839] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 07/10/2019
[  667.842132] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  672.299421] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  672.307449] BUG: KCSAN: data-race in osq_lock / osq_lock

[  672.315741] write (marked) to 0xffff8f613013be00 of 8 bytes by task =
971 on cpu 59:
[  672.324085]  osq_lock+0x2fb/0x340 kernel/locking/osq_lock.c:200
[  672.328149]  __mutex_lock+0x277/0xd20 kernel/locking/mutex.c:657
[  672.332561]  mutex_lock_nested+0x31/0x40 kernel/locking/mutex.c:1118
[  672.337236]  memcg_create_kmem_cache+0x2e/0x190 mm/slab_common.c:659
[  672.342534]  memcg_kmem_cache_create_func+0x40/0x80
[  672.348177]  process_one_work+0x54c/0xbe0
[  672.352940]  worker_thread+0x80/0x650
[  672.357351]  kthread+0x1e0/0x200
[  672.361324]  ret_from_fork+0x27/0x50

[  672.367875] read to 0xffff8f613013be00 of 8 bytes by task 708 on cpu =
50:
[  672.375345]  osq_lock+0x234/0x340 kernel/locking/osq_lock.c:78
[  672.379431]  __mutex_lock+0x277/0xd20 kernel/locking/mutex.c:657
[  672.383862]  mutex_lock_nested+0x31/0x40 kernel/locking/mutex.c:1118
[  672.388537]  memcg_create_kmem_cache+0x2e/0x190 mm/slab_common.c:659
[  672.393824]  memcg_kmem_cache_create_func+0x40/0x80
[  672.399461]  process_one_work+0x54c/0xbe0
[  672.404229]  worker_thread+0x80/0x650
[  672.408640]  kthread+0x1e0/0x200
[  672.412613]  ret_from_fork+0x27/0x50

This?

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 1f7734949ac8..832e87966dcf 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -75,7 +75,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
                 * wait for either @lock to point to us, through its =
Step-B, or
                 * wait for a new @node->next from its Step-C.
                 */
-               if (node->next) {
+               if (READ_ONCE(node->next)) {
                        next =3D xchg(&node->next, NULL);
                        if (next)
                                break;

> race in osq_lock before, however, this is the only one I have recently
> seen in osq_lock:
>=20
> read to 0xffff88812c12d3d4 of 4 bytes by task 23304 on cpu 0:
>  osq_lock+0x170/0x2f0 kernel/locking/osq_lock.c:143
>=20
> 	while (!READ_ONCE(node->locked)) {
> 		/*
> 		 * If we need to reschedule bail... so we can block.
> 		 * Use vcpu_is_preempted() to avoid waiting for a =
preempted
> 		 * lock holder:
> 		 */
> -->		if (need_resched() || =
vcpu_is_preempted(node_cpu(node->prev)))
> 			goto unqueue;
>=20
> 		cpu_relax();
> 	}
>=20
> where
>=20
> 	static inline int node_cpu(struct optimistic_spin_node *node)
> 	{
> -->		return node->cpu - 1;
> 	}
>=20
>=20
> write to 0xffff88812c12d3d4 of 4 bytes by task 23334 on cpu 1:
> osq_lock+0x89/0x2f0 kernel/locking/osq_lock.c:99
>=20
> 	bool osq_lock(struct optimistic_spin_queue *lock)
> 	{
> 		struct optimistic_spin_node *node =3D =
this_cpu_ptr(&osq_node);
> 		struct optimistic_spin_node *prev, *next;
> 		int curr =3D encode_cpu(smp_processor_id());
> 		int old;
>=20
> 		node->locked =3D 0;
> 		node->next =3D NULL;
> -->		node->cpu =3D curr;
>=20
>=20
> Thanks,
> -- Marco

