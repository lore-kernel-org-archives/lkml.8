Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE36C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2AF20776
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cibQWKrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgC3NSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:18:30 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37994 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbgC3NSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:18:30 -0400
Received: by mail-qv1-f68.google.com with SMTP id p60so8845820qva.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oyPhPDGxJ3faw+iF5XZmXUEt8GkiTJqHI3z+ZzyTC7w=;
        b=cibQWKrgQA8fU2bFZGG3xQ73+wcPnvJ2uUr8S8YyBn37a8OOnOwOv7YoNnZ82+Gidz
         A5gBaiI7f9ps0Sl6vzNn+QzfRlx3dqhtElSyM0ojAq+SEmMKb871HdNsCVx5U8hUx30v
         7wElIznvbinZ8cOkKwREAL/W9z7HorqZG4gpmDXJ/sTuekv7uVYKrsyTiemNeTMbwQOa
         vGEBVImrzweGpp+odvZy0IT40BiTZrvCKdIfImlFmTHNIl5Y043jUTp+gPGp9q/PwQMP
         Vg/xq19DIc504X/s29eVm3MfuGEVB8+VPtCk0Y3F25pF+cUOYzxhbpchRB94b4/VMBS0
         bv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oyPhPDGxJ3faw+iF5XZmXUEt8GkiTJqHI3z+ZzyTC7w=;
        b=r6ymC8g6xztEUaRprjMUqgKhh4cAbrM16alJbcbUhoZECzLLWVT8m207pPs+ZGd7Eq
         yxKCOkDTl3vZ89rIGXwqmI1x8M7jnQwrfZGiqesM/nKAFUzBdpT7Owib5XkIEhooUwXf
         1uiBbuh2bSoXEZvJCmUlUGrt0dd8MIgC6Kl0NRlKGfsKWmreS8+lUz5/CswIWK+iPvmq
         pzhWiSyxGTwSmk3scZMkwVuj3zppD/a90sjzuKyAEwyfwdoXqYqkf3NvDEvV2SUthep0
         wP4QAWIfSNZ96y7yBBwJ3OwbfBy3aRX7Wk7ST52mEJONpr9E90QhBWcHKweLgaiPhSXV
         JaSA==
X-Gm-Message-State: ANhLgQ2R3BscNRk48SUkaf5MkXLcx5vTWXyrjdlFW15jj4Nld1tPcHkn
        cbzOWm1v/6prY0y1G1QBqRAHlA==
X-Google-Smtp-Source: ADFU+vsjuYMwBllljRdw+OvxWT17jOYBsCBc7K1NQROf60zyZBX/osdgWTFJKB4bJIua0QTI9Ihizw==
X-Received: by 2002:a0c:f709:: with SMTP id w9mr11648009qvn.159.1585574307110;
        Mon, 30 Mar 2020 06:18:27 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z18sm11460552qtz.77.2020.03.30.06.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2020 06:18:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH -next] locking/percpu-rwsem: fix a task_struct refcount
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200330111852.GH20696@hirez.programming.kicks-ass.net>
Date:   Mon, 30 Mar 2020 09:18:25 -0400
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        dbueso@suse.de, juri.lelli@redhat.com,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <37BFF03B-470A-46B4-91AB-8A8A64FEF7B8@lca.pw>
References: <20200327093754.GS20713@hirez.programming.kicks-ass.net>
 <BB30C711-B54C-4D61-8BEE-A55F410C4178@lca.pw>
 <20200330111852.GH20696@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 30, 2020, at 7:18 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Mar 27, 2020 at 06:19:37AM -0400, Qian Cai wrote:
>>=20
>>=20
>>> On Mar 27, 2020, at 5:37 AM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>>>=20
>>> If the trylock fails, someone else got the lock and we remain on the
>>> waitqueue. It seems like a very bad idea to put the task while it
>>> remains on the waitqueue, no?
>>=20
>> Interesting, I thought this was more straightforward to see,
>=20
> It is indeed as straight forward as you explain; but when doing 10
> things at once, and having just dug through some low-level arch =
assembly
> code for the previous email, even obvious things might sometimes need
> a little explaining :/
>=20
> So please, always try and err on the side of a little verbose when
> writing Changelogs, esp. when concerning locking / concurrency, you
> really can't be clear enough.
>=20
>> but I may
>> be wrong as always. At the beginning of percpu_rwsem_wake_function()
>> it calls get_task_struct(), but if the trylock failed, it will remain
>> in the waitqueue. However, it will run percpu_rwsem_wake_function()
>> again with get_task_struct() to increase the refcount. Can you
>> enlighten me where it will call put_task_struct() in waitqueue or
>> elsewhere to balance the refcount in this case?
>=20
> See, had that explaination been part of the Changelog, my brain =
would've
> probably been able to kick itself in gear and actually spot the =
problem.
>=20
> Yes, you're right.
>=20
> That said, I wonder if we can just move the get_task_struct() call =
like
> below; after all the race we're guarding against is =
percpu_rwsem_wait()
> observing !private, terminating the wait and doing a quick exit() =
while
> percpu_rwsem_wake_function() then does wake_up_process(p) as a
> use-after-free.

Looks good to me. If no one has any objection, I=E2=80=99ll dust-out the =
commit log
and send out a v2 for it.=20

>=20
> Hmm?
>=20
> diff --git a/kernel/locking/percpu-rwsem.c =
b/kernel/locking/percpu-rwsem.c
> index a008a1ba21a7..8bbafe3e5203 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -118,14 +118,15 @@ static int percpu_rwsem_wake_function(struct =
wait_queue_entry *wq_entry,
> 				      unsigned int mode, int wake_flags,
> 				      void *key)
> {
> -	struct task_struct *p =3D get_task_struct(wq_entry->private);
> 	bool reader =3D wq_entry->flags & WQ_FLAG_CUSTOM;
> 	struct percpu_rw_semaphore *sem =3D key;
> +	struct task_struct *p;
>=20
> 	/* concurrent against percpu_down_write(), can get stolen */
> 	if (!__percpu_rwsem_trylock(sem, reader))
> 		return 1;
>=20
> +	p =3D get_task_struct(wq_entry->private);
> 	list_del_init(&wq_entry->entry);
> 	smp_store_release(&wq_entry->private, NULL);
>=20

