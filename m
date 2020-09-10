Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 819AB21D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FixPFW2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgIJV0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:26:37 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5318 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbgIJOXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5a36050000>; Thu, 10 Sep 2020 07:19:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 07:22:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Sep 2020 07:22:05 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 14:22:00 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
        "Roman Gushchin" <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Date:   Thu, 10 Sep 2020 10:21:58 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <C249991F-A64E-4262-892F-F1587B800264@nvidia.com>
In-Reply-To: <9ffa345f-fd45-aeac-691d-54d1364bff6d@redhat.com>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908143503.GE26850@dhcp22.suse.cz>
 <7ed82cb06074b30c2956638082c515fb179f69a3.camel@surriel.com>
 <20200909070445.GA7348@dhcp22.suse.cz>
 <054d02f3b34d9946905929ff268b685c91494b3e.camel@surriel.com>
 <6135d2c5-2a74-6ca8-4b3b-8ceb25c0d4b1@redhat.com>
 <20200910073213.GC28354@dhcp22.suse.cz>
 <9ffa345f-fd45-aeac-691d-54d1364bff6d@redhat.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_9E36EC25-760B-49D5-ABC0-2FAB7AA53EE0_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599747589; bh=eUrNF+gcmr4jLs8H/kXqNPI1S7iQ60ZMzf9ZSigG0Bg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=FixPFW2tYExQm0i3SbHUMUp1us2QpOUk2aItQLRl1psIFx08Nm/kuHpwev+BRr7tX
         w4H+KzL43afvy+SQAmhy4TeJo5oKtC0TBstdO7/GRGQNQ5bvjKlU1HBMo7ISSvUcvk
         pAz5rQ0YJHlEcdr7p3KpMj3EJRLlLVROVjIX1/H1CdJNuHMwoOlc4+bGrU5m78V8vJ
         4FD4LM+S7pYFP7vSrepbPv5vecblG5TwniishMIAxs1aTRE/KlQ+SSRUbUm2TpbkC4
         9HXMhV2FcDQQeNxhuL4kO1NNPn9b+/1far+hqeYJzYuU6otrto6hIl0VdIfa1EZMWs
         75PgM1zCUunHQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_9E36EC25-760B-49D5-ABC0-2FAB7AA53EE0_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 Sep 2020, at 4:27, David Hildenbrand wrote:

> On 10.09.20 09:32, Michal Hocko wrote:
>> [Cc Vlastimil and Mel - the whole email thread starts
>> http://lkml.kernel.org/r/20200902180628.4052244-1-zi.yan@sent.com
>>  but this particular subthread has diverged a bit and you might find i=
t
>>  interesting]
>>
>> On Wed 09-09-20 15:43:55, David Hildenbrand wrote:
>>> On 09.09.20 15:19, Rik van Riel wrote:
>>>> On Wed, 2020-09-09 at 09:04 +0200, Michal Hocko wrote:
>>>>> On Tue 08-09-20 10:41:10, Rik van Riel wrote:
>>>>>> On Tue, 2020-09-08 at 16:35 +0200, Michal Hocko wrote:
>>>>>>
>>>>>>> A global knob is insufficient. 1G pages will become a very
>>>>>>> precious
>>>>>>> resource as it requires a pre-allocation (reservation). So it
>>>>>>> really
>>>>>>> has
>>>>>>> to be an opt-in and the question is whether there is also some
>>>>>>> sort
>>>>>>> of
>>>>>>> access control needed.
>>>>>>
>>>>>> The 1GB pages do not require that much in the way of
>>>>>> pre-allocation. The memory can be obtained through CMA,
>>>>>> which means it can be used for movable 4kB and 2MB
>>>>>> allocations when not
>>>>>> being used for 1GB pages.
>>>>>
>>>>> That CMA has to be pre-reserved, right? That requires a
>>>>> configuration.
>>>>
>>>> To some extent, yes.
>>>>
>>>> However, because that pool can be used for movable
>>>> 4kB and 2MB
>>>> pages as well as for 1GB pages, it would be easy to just set
>>>> the size of that pool to eg. 1/3 or even 1/2 of memory for every
>>>> system.
>>>>
>>>> It isn't like the pool needs to be the exact right size. We
>>>> just need to avoid the "highmem problem" of having too little
>>>> memory for kernel allocations.
>>>>
>>>
>>> I am not sure I like the trend towards CMA that we are seeing, reserv=
ing
>>> huge buffers for specific users (and eventually even doing it
>>> automatically).
>>>
>>> What we actually want is ZONE_MOVABLE with relaxed guarantees, such t=
hat
>>> anybody who requires large, unmovable allocations can use it.
>>>
>>> I once played with the idea of having ZONE_PREFER_MOVABLE, which
>>> a) Is the primary choice for movable allocations
>>> b) Is allowed to contain unmovable allocations (esp., gigantic pages)=

>>> c) Is the fallback for ZONE_NORMAL for unmovable allocations, instead=
 of
>>> running out of memory
>>
>> I might be missing something but how can this work longterm? Or put in=

>> another words why would this work any better than existing fragmentati=
on
>> avoidance techniques that page allocator implements already - movabili=
ty
>> grouping etc. Please note that I am not deeply familiar with those but=

>> my high level understanding is that we already try hard to not mix
>> movable and unmovable objects in same page blocks as much as we can.
>
> Note that we group in pageblock granularity, which avoids fragmentation=

> on a pageblock level, not on anything bigger than that. Especially
> MAX_ORDER - 1 pages (e.g., on x86-64) and gigantic pages.
>
> So once you run for some time on a system (especially thinking about
> page shuffling *within* a zone), trying to allocate a gigantic page wil=
l
> simply always fail - even if you always had plenty of free memory in
> your single zone.
>
>>
>> My suspicion is that a separate zone would work in a similar fashion. =
As
>> long as there is a lot of free memory then zone will be effectively
>> MOVABLE. Similar applies to normal zone when unmovable allocations are=

>
> Note the difference to MOVABLE: if you really want, you *can* put
> movable allocations into that zone. So you can happily allocate giganti=
c
> pages from it. Or anything else you like. As the name suggests "prefer
> movable allocations".
>
>> in minority. As long as the Normal zone gets full of unmovable objects=

>> they start overflowing to ZONE_PREFER_MOVABLE and it will resemble pag=
e
>> block stealing when unmovable objects start spreading over movable pag=
e
>> blocks.
>
> Right, the long-term goal would be
> 1. To limit the chance of that happening. (e.g., size it in a way that'=
s
> safe for 99.9% of all setups, resize dynamically on demand)
> 2. To limit the physical area where that is happening (e.g., find lowes=
t
> possible pageblock etc.). That's more tricky but I consider this a pure=

> optimization on top.
>
> As long as we stay in safe zone boundaries you get a benefit in most
> scenarios. As soon as we would have a (temporary) workload that would
> require more unmovable allocations we would fallback to polluting some
> pageblocks only.

The idea would work well until unmoveable pages begin to overflow into
ZONE_PREFER_MOVABLE or we move the boundary of ZONE_PREFER_MOVABLE to
avoid unmoveable page overflow. The issue comes from the lifetime of
the unmoveable pages. Since some long-live ones can be around the boundar=
y,
there is no guarantee that ZONE_PREFER_MOVABLE cannot grow back
even if other unmoveable pages are deallocated. Ultimately,
ZONE_PREFER_MOVABLE would be shrink to a small size and the situation is
back to what we have now.

OK. I have a stupid question here. Why not just grow pageblock to a large=
r
size, like 1GB? So the fragmentation of unmoveable pages will be at large=
r
granularity. But it is less likely unmoveable pages will be allocated at
a movable pageblock, since the kernel has 1GB pageblock for them after
a pageblock stealing. If other kinds of pageblocks run out, moveable and
reclaimable pages can fall back to unmoveable pageblocks.
What am I missing here?

Thanks.


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_9E36EC25-760B-49D5-ABC0-2FAB7AA53EE0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9aNoYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKCQcP/1eDkNeK+Kh9/eT85rTAJci0ZT/baY+2cnVQ
kyNC4jssYlaIK70IvcZ3usJM75XdUQzOW640/37EZFvr01m1LfI4DOvTT4dck/rw
2ROqjtNZ3+Wlglt38uWS8Pa2I/2UYjTt6JN/Yw4j2QozbWJO5bI13SU/qpv9KkDj
DHGl84RQAj3+DyL/quQ3/S9suCTXMpDj50ZV27j9vPNA7Uu0R/3ZyggDA7ebSNRv
yqo28tmIUIG+NOyfg28zYiWrf7EytyDGRDLAaCCwXsMku5gm2n+KeQw3g3GHT68j
MeBflD6yQY/9SpNt481VX0ibS7r/v7CBMO8abJOVtDM2JFXnTIA2lPoqwoJp58AB
MXXwvpjaV8SQlyRWZYRx9xYA9wwW/V8NqnuSHxsl5G+z/UXAPMjaQFBg2P7ih4p8
zKoC48qU+RhprYr0r9iLIweZrSrlCiKOvbTTcRlzQl0cvxrG1zlMSEnp8FjPJeBM
9kuuXptKE0Mow0spuiqFGDqLxoReuo6+8bAqdffte4RWIVXmqGh0Nla2n1LLV7tW
bJof7DWXAFE3snuPh4ZJFJNcnPLRWR31BAklkjMa0NwONJx+QavTsMJS7+2Hx2qk
qGoEF4XtNMZDV5CYZs65zJbGQ1dzanWD8uFcafXcpviNyLc8HV8xPMNjQXMvAVi5
pYZxTovn
=Hojg
-----END PGP SIGNATURE-----

--=_MailMate_9E36EC25-760B-49D5-ABC0-2FAB7AA53EE0_=--
