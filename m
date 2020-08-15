Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FC3C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230AC20639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529469;
	bh=Ku0SprNe4DSbL0fK2tkhd+WpmF55XeOtbZCh6UEp9+8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=13coR1kJtiAW032Q5nz5f6Ng9JcjkM2luoysdLuSG+jpLAzbtQE29z96Kh0yqPXnw
	 YkAkSc0sVD/WlOf+y2dEzUaEIBCKn0cwwyYcXFfx0qlD73MajHqk7kLFs5bP6pEFnp
	 mFkzsMffJ5oq8cGVb2cuZnyY5Fl3RWeLgecZtYzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgHOWLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729480AbgHOWKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4896D22EBD;
        Sat, 15 Aug 2020 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597480647;
        bh=Ku0SprNe4DSbL0fK2tkhd+WpmF55XeOtbZCh6UEp9+8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MfbojFz5eet5HSIuc5i++p49o3r2LZpQ9Ky4vvJrTDQlWVTH9JIFYtNh90GqQ29+h
         lPChbFEFyjhk7AOzomFtyIr5CLK55PPIRFUm6bCSN4R91sIh1iHoQI1tdUp+ciaK/G
         16EiYM8TRgNjfIWPzLKmTc/FbjCD98wPyim0X7D4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87pn7w5fd4.fsf@nanos.tec.linutronix.de>
References: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com> <159722125596.33733.17725649536425524344@swboyd.mtv.corp.google.com> <87pn7w5fd4.fsf@nanos.tec.linutronix.de>
Subject: Re: [RFC V2] kthread: add object debug support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     john.stultz@linaro.org, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
To:     Felix.Kuehling@amd.com, Qianli Zhao <zhaoqianligood@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        akpm@linux-foundation.org, axboe@kernel.dk
Date:   Sat, 15 Aug 2020 01:37:26 -0700
Message-ID: <159748064613.2270147.9288160745183605164@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2020-08-12 03:27:03)
> Stephen,
>=20
> Stephen Boyd <sboyd@kernel.org> writes:
> > Quoting Qianli Zhao (2020-08-11 22:14:14)
> >> +/********** kernel/kthread **********/
> >> +#define KWORK_ENTRY_STATIC     ((void *) 0x600 + POISON_POINTER_DELTA)
> >
> > Is this related to the debugobjects change here? It looks like another
> > version of list poison.
>=20
> Yes, it is. We use these poison entries to mark statically allocated
> objects. debug objects does not know about statically initialized
> objects up to the point where they are used (activated).
>=20
> That means the object state lookup will fail which causes debugobjects
> to complain about using an uninitialized object. But in case of static
> initialized ones that's a false positive. So we mark these objects in
> their list head (or some other appropriate place) with a poison value
> and in case of a failed lookup debug object does:
>=20
>         if (descr->is_static_object && descr->is_static_object(addr)) {
>                 /* track this static object */
>                 debug_object_init(addr, descr);
>                 debug_object_activate(addr, descr);
>         }       =20
>=20
> The object specific is_static_object() callback will then check for the
> magic list poison value being present:

Thanks! I missed this function below.

>=20
> > +static bool kwork_is_static_object(void *addr)
> > +{
> > +     struct kthread_work *kwork =3D addr;
> > +
> > +     return (kwork->node.prev =3D=3D NULL &&
> > +             kwork->node.next =3D=3D KWORK_ENTRY_STATIC);
> > +}
>=20
> and if so the debug object core fixes its internal state by creating a
> tracking object and then activating it.
>=20
> It's not a perfect "yes this is statically initialized" check but good
> enough. If you go and do:
>=20
>    work =3D kzalloc(sizeof(*work);
>    work->node.next =3D KWORK_ENTRY_STATIC;
>=20
>    kthread_insert_work(worker, work);
>=20
> or any other variant of insanity which makes the check claim that this
> is statically initialized then you rightfully can keep the pieces :)

Makes sense. Maybe this "technique" should be documented in
Documentation/core-api/debug-objects.rst? I can cook up a patch to add
is_static_object() to the Fixup functions section.
