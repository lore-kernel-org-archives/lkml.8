Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A468C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3291A2253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IXrqbHxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAVWjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:39:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35528 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:38:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so463095wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 14:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QkDSz8x5W+EtQ/vfgEsUN/LxFH8F/pT9uJozD32J7dA=;
        b=IXrqbHxaSH6LIsTRrByoakvUT4ycJoIMoY6Z5KDajxWCMKzAMYzlYrHIPQVInQ31Cc
         hLZFPeSW2GBLkf+p/RpW5kWHsCIbSK7bB8xv8tiOkivKaKEGkhCyJ75jB8JRBkNkIbGP
         k3mFOm5QfxqmoC0KpNts3qsfYU4zpu8zhzsbaIkzHelVXADiJkzk7bGhkMK2dMrY+HRz
         mD0h6GCgw4PbsgybPqws0eR9+AYQEIs0pUOSw7yaL9SQjCKlPGjv3Hx3Ds7eWlqlRFTn
         WXUQStL49CcjikzbacKifKPR0pQoz6fdfTkG4R+plQFrf0aqR0Y6X/NROyEjQnPHH+Hh
         p9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QkDSz8x5W+EtQ/vfgEsUN/LxFH8F/pT9uJozD32J7dA=;
        b=uUCFGHN5SPWCzTGuUn+InkBjJ6F8rJacBiB25yELkYSOJqRtCUHWncTqkI5tnLLzF8
         8CGuIJqNxKjXiDvDN+7Y90DOHSX6kiaikxR5ThlGV1B5nVQDaXYV/JzxSDx/As9pyTG0
         D3aJMWNdz0cHga8542QO/6akGAQvqzqskSoSGNpu8wbbthC4pgoXcJ/OgEpp3QqhOWoe
         TK7F8FWG0F0wgarKjzsbSNUdo46TSABSKUIJKuwYa2aXvOcKs0aLiz/LNr5YK07BJPQF
         dPdQ4sBdhK/GBo+sqgZJnD2250IUJyszaxBULgco8p6bQk3vHK8fmdfCqjK/LBAnQBvO
         qy0w==
X-Gm-Message-State: APjAAAXu6U4oLr6EjNygWgfm9hkO3J5WYaBm1wVOUF0+vUqKcQiQc3GN
        y+HCQKhPEAQSHI/xFDcqbWx8Iw==
X-Google-Smtp-Source: APXvYqyoCoQ0IRz23QahQS5yWYxX98xL3q+dJYPdqBMbTn2rGqt51NFmnVzex3VBep4kDjDHBm/QbA==
X-Received: by 2002:a1c:dfd6:: with SMTP id w205mr284452wmg.151.1579732738033;
        Wed, 22 Jan 2020 14:38:58 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id h17sm392268wrs.18.2020.01.22.14.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 14:38:57 -0800 (PST)
Date:   Wed, 22 Jan 2020 23:38:51 +0100
From:   Marco Elver <elver@google.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Will Deacon <will@kernel.org>, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200122223851.GA45602@google.com>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jan 2020, Qian Cai wrote:

>=20
>=20
> > On Jan 22, 2020, at 11:59 AM, Will Deacon <will@kernel.org> wrote:
> >=20
> > I don't understand this; 'next' is a local variable.
> >=20
> > Not keen on the onslaught of random "add a READ_ONCE() to shut the
> > sanitiser up" patches we're going to get from kcsan :(
>=20
> My fault. I suspect it is node->next. I=E2=80=99ll do a bit more testing =
to confirm.

If possible, decode and get the line numbers. I have observed a data
race in osq_lock before, however, this is the only one I have recently
seen in osq_lock:

read to 0xffff88812c12d3d4 of 4 bytes by task 23304 on cpu 0:
=C2=A0osq_lock+0x170/0x2f0 kernel/locking/osq_lock.c:143

	while (!READ_ONCE(node->locked)) {
		/*
		 * If we need to reschedule bail... so we can block.
		 * Use vcpu_is_preempted() to avoid waiting for a preempted
		 * lock holder:
		 */
-->		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
			goto unqueue;

		cpu_relax();
	}

where

	static inline int node_cpu(struct optimistic_spin_node *node)
	{
-->		return node->cpu - 1;
	}


write to 0xffff88812c12d3d4 of 4 bytes by task 23334 on cpu 1:
 osq_lock+0x89/0x2f0 kernel/locking/osq_lock.c:99

	bool osq_lock(struct optimistic_spin_queue *lock)
	{
		struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_node);
		struct optimistic_spin_node *prev, *next;
		int curr =3D encode_cpu(smp_processor_id());
		int old;

		node->locked =3D 0;
		node->next =3D NULL;
-->		node->cpu =3D curr;


Thanks,
-- Marco
