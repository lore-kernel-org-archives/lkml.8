Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D02C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC9D20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598042877;
	bh=ky40Y5YjHz90o9pVQm0aMe9wxiKFgD1hSlf/t9X1qUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M6EJsKtPTmDKX8FGvN9Yk7bvv4XHfEhg1zs9JdRDfYEq3eIK1+cNiVomgNtxtR7C0
	 1z2T30UnDqX2uzs6NpvpUQZ31UZK1eEe/P6PGtFHb8/rS8w2AK357o0jTHR1ZEX1Po
	 Bvhkcr59am4QhibKO1uIKt1JZjNQ7ndygvxCU9kE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgHUUr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:47:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHUUrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:47:55 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C91A20724;
        Fri, 21 Aug 2020 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598042874;
        bh=ky40Y5YjHz90o9pVQm0aMe9wxiKFgD1hSlf/t9X1qUE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qtDsUUMHyFKgEaATg3dwQZQXMoQsoAkigUCnJL75KZyhTKfDeTYb9+V1ORJGrvYFp
         VMXFD18kKw233JixIVRahJsVwXqpsF+MeThiEAoBRjLvSsAIJnbC8gC1st3ymLwyzC
         4jH6AS2LBmfoklsI6bpnyDi1lzUImy6tc1yt/woc=
Date:   Fri, 21 Aug 2020 13:47:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joerg Vehlow <lkml@jv-coder.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in
 interrupt context
Message-Id: <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
In-Reply-To: <20200821110848.6c3183d1@oasis.local.home>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
        <20200528084614.0c949e8d@gandalf.local.home>
        <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
        <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
        <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
        <20200821110848.6c3183d1@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 11:08:48 -0400 Steven Rostedt <rostedt@goodmis.org> wro=
te:

> On Fri, 21 Aug 2020 12:25:33 +0200
> Joerg Vehlow <lkml@jv-coder.de> wrote:
>=20
> > Hi Andrew and Others (please read at least the part with @RT developers=
),
> >=20
> > > Yup, mutex_trylock() from interrupt is improper.  Well dang, that's a
> > > bit silly.  Presumably the 2006 spin_lock_mutex() wasn't taken with
> > > irqs-off.
> > >
> > > Ho hum, did you look at switching the kexec code back to the xchg
> > > approach?
> > > =20
> > I looked into reverting to the xchg approach, but that seems to be
> > not a good solution anymore, because the mutex is used in many places,
> > a lot with waiting locks and I guess that would require spinning now,
> > if we do this with bare xchg.
> >=20
> > Instead I thought about using a spinlock, because they are supposed
> > to be used in interrupt context as well, if I understand the documentat=
ion
> > correctly ([1]).
> > @RT developers
> > Unfortunately the rt patches seem to interpret it a bit different and
> > spin_trylock uses __rt_mutex_trylock again, with the same consequences =
as
> > with the current code.
> >=20
> > I tried raw_spinlocks, but it looks like they result in a deadlock at
> > least in the rt kernel. Thiy may be because of memory allocations in the
> > critical sections, that are not allowed if I understand it correctly.
> >=20
> > I have no clue how to fix it at this point.
> >=20
> > J=F6rg
> >=20
> > [1] https://kernel.readthedocs.io/en/sphinx-samples/kernel-locking.html
>=20
> There's only two places that wait on the mutex, and all other places
> try to get it, and if it fails, it simply exits.
>=20
> What I would do is introduce a kexec_busy counter, and have something
> like this:
>=20
> For the two locations that actually wait on the mutex:
>=20
> loop:
> 	mutex_lock(&kexec_mutex);
> 	ret =3D atomic_inc_return(&kexec_busy);
> 	if (ret > 1) {
> 		/* Atomic context is busy on this counter, spin */
> 		atomic_dec(&kexec_busy);
> 		mutex_unlock(&kexec_mutex);
> 		goto loop;
> 	}
> 	[..]
> 	atomic_dec(&kexec_busy);
> 	mutex_unlock(&kexec_mutex);
>=20
> And then all the other places that do the trylock:
>=20
> 	cant_sleep();
> 	ret =3D atomic_inc_return(&kexec_busy);
> 	if (ret > 1) {
> 		atomic_dec(&kexec_busy);
> 		return;
> 	}
> 	[..]
> 	atomic_dec(&kexec_busy);

Aw gee.  Hide all this in include/linux/rostedt_lock.h...

Sigh.  Is it too hard to make mutex_trylock() usable from interrupt
context?
