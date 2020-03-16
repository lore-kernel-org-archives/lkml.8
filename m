Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AC4C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED875205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 04:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgCPE0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 00:26:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:45836 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbgCPE0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 00:26:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7607AB241;
        Mon, 16 Mar 2020 04:26:40 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Mar 2020 15:26:31 +1100
Cc:     Jeff Layton <jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
In-Reply-To: <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
References: <20200308140314.GQ5972@shao2-debian>
 <34355c4fe6c3968b1f619c60d5ff2ca11a313096.camel@kernel.org>
 <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
 <87blp5urwq.fsf@notabene.neil.brown.name>
 <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
 <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com>
 <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
 <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
 <878sk7vs8q.fsf@notabene.neil.brown.name>
 <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
 <875zfbvrbm.fsf@notabene.neil.brown.name>
 <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
 <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
 <87v9nattul.fsf@notabene.neil.brown.name>
 <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
 <87o8t2tc9s.fsf@notabene.neil.brown.name>
 <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
 <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
 <877dznu0pk.fsf@notabene.neil.brown.name>
 <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
Message-ID: <87sgi9rklk.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14 2020, Linus Torvalds wrote:

> On Fri, Mar 13, 2020 at 7:31 PM NeilBrown <neilb@suse.de> wrote:
>>
>> The idea of list_del_init_release() and list_empty_acquire() is growing
>> on me though.  See below.
>
> This does look like a promising approach.

Thanks.

>
> However:
>
>> +       if (waiter->fl_blocker =3D=3D NULL &&
>> +           list_empty(&waiter->fl_blocked_requests) &&
>> +           list_empty_acquire(&waiter->fl_blocked_member))
>> +               return status;
>
> This does not seem sensible to me.
>
> The thing is, the whole point about "acquire" semantics is that it
> should happen _first_ - because a load-with-acquire only orders things
> _after_ it.

Agreed.

>
> So testing some other non-locked state before testing the load-acquire
> state makes little sense: it means that the other tests you do are
> fundamentally unordered and nonsensical in an unlocked model.
>
> So _if_ those other tests matter (do they?), then they should be after
> the acquire test (because they test things that on the writer side are
> set before the "store-release"). Otherwise you're testing random
> state.
>
> And if they don't matter, then they shouldn't exist at all.

The ->fl_blocker =3D=3D NULL test isn't needed. It is effectively equivalent
to the list_empty(fl_blocked_member) test.

The fl_blocked_requests test *is* needed (because a tree is dismantled
from the root to the leaves, so it stops being a member while it still
holds other requests).  I didn't think the ordering mattered all that
much but having pondered it again I see that it does.

>
> IOW, if you depend on ordering, then the _only_ ordering that exists is:
>
>  - writer side: writes done _before_ the smp_store_release() are visible
>
>  - to the reader side done _after_ the smp_load_acquire()
>
> and absolutely no other ordering exists or makes sense to test for.
>
> That limited ordering guarantee is why a store-release -> load-acquire
> is fundamentally cheaper than any other serialization.
>
> So the optimistic "I don't need to do anything" case should start ouf with
>
>         if (list_empty_acquire(&waiter->fl_blocked_member)) {
>
> and go from there. Does it actually need to do anything else at all?
> But if it does need to check the other fields, they should be checked
> after that acquire.

So it should be
   if (list_empty_acquire(&wait->fl_blocked_member) &&
       list_empty_acquire(&wait->fl_blocked_requests))
           return status;

And because that second list_empty_acquire() is on the list head, and
pairs with a list_del_init_release() on a list member, I would need to
fix the __list_del() part to be
  next->prev =3D prev;
  smp_store_release(prev->next, next)

>
> Also, it worries me that the comment talks about "if fl_blocker is
> NULL". But it realy now is that fl_blocked_member list being empty
> that is the real serialization test, adn that's the one that the
> comment should primarily talk about.

Yes, I see that now.  Thanks.

NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5u//gACgkQOeye3VZi
gbnq1w/+ISFyciqvPqWS1Ax64gsWPXZ6+lksRem8n8G3K2xBqJbF1Y95tXRV+m5j
hTwxRgNLJxskC8rh9Rj2IaklxHqXatVNbYqpqcvr8NjJIi0HyMtj46bjDflSeki3
vNJ1fEHEFyE4YauHccqMiUC8pKat3nWc7fHjZDO6LKp+G4NRNXBLGHlYoKYEComp
HZB/WvVZu8j/GKp/tbt5f7WyYb7HYyUNjytqQlF1T6BopwM47ah8c5BBGk73ZdQt
ODTHHZ1ohl9mfs1APbJXl/LKt8JP3LqMHn/JoD/o+WM2hPFIvjDjOLk4d6+zc9OJ
uf5b3PhuYt6wYcdyN4SDVPcczL0NyOJB84LBW+BCgU4NGaGiL9BcDPvegO5bt8do
JXfT18DVZFhFUGvw8IH4J6DHlSZVrH+yJwahBF2Unvei9InVWBXX/ocVi5ilOKWx
8qgbrRDNuUXiojiSJcaR2+h90LUF3ZlY2bbuM23zK8TlprQwP2uDr9aRTYUiaOTE
i09jnEtrwgD++P2keNoTRAL1VcDM66Z5ZyZtwwA4f6ZmoRxE9MCfBq+hJNb81MKB
Mbdj2/fH1v7rXMqgOW7YGZK0OijcPu40+qZx7B1UbgVwS2SgDPTfbtXNoymx+SGB
bmdx+dfnvVH0wxZKKdHWlNl0U1dF+5dNDzEHJZTtTLp3jnbE4pk=
=7lj8
-----END PGP SIGNATURE-----
--=-=-=--
