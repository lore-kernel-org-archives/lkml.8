Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9669AC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E41D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="c5zX5LAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgAaDcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:32:33 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34970 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgAaDcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:32:33 -0500
Received: by mail-qk1-f193.google.com with SMTP id q15so5286397qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 19:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0gSHAzHwvtexhAGJkoXJN1aU/Deb8qQRpOrPk8l4RYM=;
        b=c5zX5LAMwVTI3fMlTD3/bPelNVo3iMF9WEPxDQqu+mDQbGa//qCFP8nphAvVZ17E2O
         FBBmpISe3KfQdyto9t+50tfNsqDzx+t3MKoluX4XyQr9nTuroMrMeoeSclEIo7tmTsDs
         odGkVf7zyFYAjpBxKQs4m4BCSNCgl+IQz/14FdxYpMdhU9s5TRIkO9JzoXzFi9u7M45+
         w1GhUjEHCPR1co5J29OWD0rSp8AVtYwIhBhSnzTow7COga8gMBdLi00tbpVyIDEivgaX
         CuRS3gk1pZ62461YOX3q6/qsvNv/iVPih2ryw2m5uy7yLQ92II0SaSlSZx9Vw0Hn2jPC
         zQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0gSHAzHwvtexhAGJkoXJN1aU/Deb8qQRpOrPk8l4RYM=;
        b=S+mqE95MY18ZcDGliLvXZX75UJ15hjYl/TVaZnUJGw0+KnWj3w8kz2dG1pxW1dR7Y0
         Ym2Xn4wbSPY2hb8pQO9x7nPG3lbE50ipNBmd7RiA1UgDcjQRuZMbVUSoyqw+DBrjjdIw
         WlpDStAPv/TYEbvy5+joM4Vo34kmhlZAe9IOCjC2bKKHKnDG6aFF86TinIumSMeZmNAW
         8vEKMD+wy18FXYjWTIPFHaOF+usarqOl+5jY0z2qU0kNe5hHoGUWK/+4y23CN9RbieLD
         /hnTpg1PI/ymNzw38uvhEgVqt2HvuTdY23E1S48eDhl9xaovv4ukgkdKPuO/8ebkvWq0
         S2Xw==
X-Gm-Message-State: APjAAAXERkwVkCi+45RJFLA7cMZ9xy68S42XcZLW1NGiOMACx1egCP57
        HX0N4Q28KdJEaC/fjskp4r+87Q==
X-Google-Smtp-Source: APXvYqxqaAlnq8luxm0ViEZLmjeaLoBV507dYesnZLXZKB2zXX+7hLj+0HIy5cd7O+qVXIcDuEI84g==
X-Received: by 2002:a37:89c7:: with SMTP id l190mr8869880qkd.498.1580441551472;
        Thu, 30 Jan 2020 19:32:31 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e13sm4223434qtq.26.2020.01.30.19.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 19:32:30 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200130134851.GY14914@hirez.programming.kicks-ass.net>
Date:   Thu, 30 Jan 2020 22:32:29 -0500
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A97061E-2152-4734-92C6-F5431C27360B@lca.pw>
References: <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
 <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
 <20200128165655.GM14914@hirez.programming.kicks-ass.net>
 <20200129002253.GT2935@paulmck-ThinkPad-P72>
 <CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=cozW5cYkm8h-GTBg@mail.gmail.com>
 <20200129184024.GT14879@hirez.programming.kicks-ass.net>
 <CANpmjNNZQsatHexXHm4dXvA0na6r9xMgVD5R+-8d7VXEBRi32w@mail.gmail.com>
 <20200130134851.GY14914@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2020, at 8:48 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Thu, Jan 30, 2020 at 02:39:38PM +0100, Marco Elver wrote:
>> On Wed, 29 Jan 2020 at 19:40, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
>>> It's probably not terrible to put a READ_ONCE() there; we just need =
to
>>> make sure the compiler doesn't do something stupid (it is known to =
do
>>> stupid when 'volatile' is present).
>>=20
>> Maybe we need to optimize READ_ONCE().
>=20
> I think recent compilers have gotten better at volatile. In part =
because
> of our complaints.
>=20
>> 'if (data_race(..))' would also work here and has no cost.
>=20
> Right, that might be the best option.
>=20

OK, I=E2=80=99ll send a patch for that.

BTW, I have another one to report. Can=E2=80=99t see how the load =
tearing would
cause any real issue.

[  519.240629] BUG: KCSAN: data-race in osq_lock / osq_unlock

[  519.249088] write (marked) to 0xffff8bb2f133be40 of 8 bytes by task =
421 on cpu 38:
[  519.257427]  osq_unlock+0xa8/0x170 kernel/locking/osq_lock.c:219
[  519.261571]  __mutex_lock+0x4b3/0xd20
[  519.265972]  mutex_lock_nested+0x31/0x40
[  519.270639]  memcg_create_kmem_cache+0x2e/0x190
[  519.275922]  memcg_kmem_cache_create_func+0x40/0x80
[  519.281553]  process_one_work+0x54c/0xbe0
[  519.286308]  worker_thread+0x80/0x650
[  519.290715]  kthread+0x1e0/0x200
[  519.294690]  ret_from_fork+0x27/0x50


void osq_unlock(struct optimistic_spin_queue *lock)
{
        struct optimistic_spin_node *node, *next;
        int curr =3D encode_cpu(smp_processor_id());

        /*
         * Fast path for the uncontended case.
         */
        if (likely(atomic_cmpxchg_release(&lock->tail, curr,
                                          OSQ_UNLOCKED_VAL) =3D=3D =
curr))
                return;

        /*
         * Second most likely case.
         */
        node =3D this_cpu_ptr(&osq_node);
        next =3D xchg(&node->next, NULL);    <--------------------------
        if (next) {
                WRITE_ONCE(next->locked, 1);
                return;
        }

        next =3D osq_wait_next(lock, node, NULL);
        if (next)
                WRITE_ONCE(next->locked, 1);
}


[  519.301232] read to 0xffff8bb2f133be40 of 8 bytes by task 196 on cpu =
12:
[  519.308705]  osq_lock+0x1e2/0x340 kernel/locking/osq_lock.c:157
[  519.312762]  __mutex_lock+0x277/0xd20
[  519.317167]  mutex_lock_nested+0x31/0x40
[  519.321838]  memcg_create_kmem_cache+0x2e/0x190
[  519.327120]  memcg_kmem_cache_create_func+0x40/0x80
[  519.332751]  process_one_work+0x54c/0xbe0
[  519.337508]  worker_thread+0x80/0x650
[  519.341922]  kthread+0x1e0/0x200
[  519.345889]  ret_from_fork+0x27/0x50


        for (;;) {
                if (prev->next =3D=3D node &&         =
<------------------------
                    cmpxchg(&prev->next, node, NULL) =3D=3D node)
                        break;

                /*
                 * We can only fail the cmpxchg() racing against an =
unlock(),
                 * in which case we should observe @node->locked =
becomming
                 * true.
                 */
                if (smp_load_acquire(&node->locked))
                        return true;

                cpu_relax();

                /*
                 * Or we race against a concurrent unqueue()'s step-B, =
in which
                 * case its step-C will write us a new @node->prev =
pointer.
                 */
                prev =3D READ_ONCE(node->prev);
        }


[  519.352420] Reported by Kernel Concurrency Sanitizer on:
[  519.358492] CPU: 12 PID: 196 Comm: kworker/12:1 Tainted: G        W   =
 L    5.5.0-next-20200130+ #3
[  519.368317] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 07/10/2019
[  519.377627] Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func=
