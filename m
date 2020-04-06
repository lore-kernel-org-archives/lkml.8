Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC9C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E6D23133
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sPVmAcXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgDFNbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:31:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43538 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728319AbgDFNbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:31:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id 13so3824466qko.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0V2aMn0sTHp1q9cbywc62NPYXIn4X24edf2PKFuIMDQ=;
        b=sPVmAcXyg3O3fFueMXK/FnmysvYrh/ymDFpzaAyEFNn8NPfOl+7gF83XT7Ygdk9nBo
         d0qEuPh/PguXTCd3LtOV4I6vSzNikDXTc8Ul7fRrBT3sg4AUoLhOUSUDjTOfptH9kMa0
         T5o4S+GkPBGdzt+Aln2iBsk8y/IsjRp++txyqFb6H1o6ioS1tcI+yfSt9r0diFjv/tUt
         IIbeDksGUe5e1Dfz6OMbNIw8NDYnPujt6RmdRb15C0FJAlcQl1sjQlKkj72PXTAOV6pV
         6uHT6h1192VYlT5E0dXl2zcRONaacdOCjfPYCDshsz9pDn4jLvZWoKyFs3XBheJkiVvo
         U9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0V2aMn0sTHp1q9cbywc62NPYXIn4X24edf2PKFuIMDQ=;
        b=W+gCqjXN41z8yUtTULrEYZHw4XgMmkJVM80FnaMKmX/PMNn5x7PvsbjbIi2Sm9XQYl
         upeh74EF7uzklUjTkW0qpSgutzwvG7r5dc1R+yPJ1Dh3nVDQ2HbXx2ANIkgendU2bvkO
         BzGAgCtARc3py7MCAk7z6H4eudMYwf07203m1QNeVetoD8JDzicimTpkgwC8/jZQXQpz
         GxIMNmutPtI3r85AGRbriUjVM+hnw2UQ+8B5cwI2hHQ1M094GF0WWniH0k69EBo+oyqL
         DXjC7mTaV+f0bfyJaRYdUJFBoK6bpqNsyQy0us+ewf2wOn1p8fOL2q1GOGsm4le1nVWw
         8/TQ==
X-Gm-Message-State: AGi0PubUTe+KsU6nZtpbSjoN7nMdBG7xWcHf+X0x8es8+rovKaukFzGJ
        Oladd62/PCWBCP6scvmaXiMQ4w==
X-Google-Smtp-Source: APiQypLLMBHVc0/WueSoIoryqhI+TVfU9xBbZ/wFKQRSQg1n9i94VrK/od4/3eSNMEkLE3iXro+QPw==
X-Received: by 2002:a05:620a:b90:: with SMTP id k16mr1180489qkh.321.1586179879727;
        Mon, 06 Apr 2020 06:31:19 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q5sm14887814qkq.17.2020.04.06.06.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 06:31:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH -next v2] locking/percpu-rwsem: fix a task_struct refcount
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200330213002.2374-1-cai@lca.pw>
Date:   Mon, 6 Apr 2020 09:31:18 -0400
Cc:     Will Deacon <will@kernel.org>, dbueso@suse.de,
        juri.lelli@redhat.com, Waiman Long <longman@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6D137A2-15A9-49BC-BCE2-DA1202B5AC3A@lca.pw>
References: <20200330213002.2374-1-cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 30, 2020, at 5:30 PM, Qian Cai <cai@lca.pw> wrote:
>=20
> The commit 7f26482a872c ("locking/percpu-rwsem: Remove the embedded
> rwsem") introduced some task_struct memory leaks due to messing up =
with
> a task_struct refcount. At the beginning of
> percpu_rwsem_wake_function(), it calls get_task_struct(), but if the
> trylock failed, it will remain in the waitqueue. However, it will run
> percpu_rwsem_wake_function() again with get_task_struct() to increase
> the refcount but then only call put_task_struct() once the trylock
> succeeded.
>=20
> Fix it by adjusting percpu_rwsem_wake_function() a bit to guard =
against
> when percpu_rwsem_wait() observing !private, terminating the wait and
> doing a quick exit() while percpu_rwsem_wake_function() then doing
> wake_up_process(p) as a use-after-free.
>=20
> Fixes: 7f26482a872c ("locking/percpu-rwsem: Remove the embedded =
rwsem")

Peter, Ingo, can you take a look at this patch when you have a chance?

For some reasons Ingo had decided to send a pull request which is now =
merged
even though I had informed the commit was broken a few days earlier, it =
makes no
sense to leave known memory leaks in mainline like this.

> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> kernel/locking/percpu-rwsem.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
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
> --=20
> 2.21.0 (Apple Git-122.2)
>=20

