Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BF6C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDF420719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDGBAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:00:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:54924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgDGBAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:00:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9134AA7C;
        Tue,  7 Apr 2020 01:00:37 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>
Date:   Tue, 07 Apr 2020 11:00:29 +1000
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
In-Reply-To: <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
References: <20200403083543.11552-1-mhocko@kernel.org> <20200403083543.11552-2-mhocko@kernel.org> <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com> <87blo8xnz2.fsf@notabene.neil.brown.name> <20200406070137.GC19426@dhcp22.suse.cz> <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
Message-ID: <875zecw1n6.fsf@notabene.neil.brown.name>
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

On Mon, Apr 06 2020, John Hubbard wrote:

> On 4/6/20 12:01 AM, Michal Hocko wrote:
> ...
>>  From 6c90b0a19a07c87d24ad576e69b33c6e19c2f9a2 Mon Sep 17 00:00:00 2001
>> From: Michal Hocko <mhocko@suse.com>
>> Date: Wed, 1 Apr 2020 14:00:56 +0200
>> Subject: [PATCH] mm: clarify __GFP_MEMALLOC usage
>>=20
>> It seems that the existing documentation is not explicit about the
>> expected usage and potential risks enough. While it is calls out
>> that users have to free memory when using this flag it is not really
>> apparent that users have to careful to not deplete memory reserves
>> and that they should implement some sort of throttling wrt. freeing
>> process.
>>=20
>> This is partly based on Neil's explanation [1].
>>=20
>> Let's also call out that a pre allocated pool allocator should be
>> considered.
>>=20
>> [1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>> ---
>>   include/linux/gfp.h | 5 +++++
>>   1 file changed, 5 insertions(+)
>>=20
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index e5b817cb86e7..9cacef1a3ee0 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -110,6 +110,11 @@ struct vm_area_struct;
>>    * the caller guarantees the allocation will allow more memory to be f=
reed
>>    * very shortly e.g. process exiting or swapping. Users either should
>>    * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
>> + * Users of this flag have to be extremely careful to not deplete the r=
eserve
>> + * completely and implement a throttling mechanism which controls the c=
onsumption
>> + * of the reserve based on the amount of freed memory.
>> + * Usage of a pre-allocated pool (e.g. mempool) should be always consid=
ered before
>> + * using this flag.

I think this version is pretty good.

>>    *
>>    * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency =
reserves.
>>    * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>>=20
>
> Hi Michal and all,
>
> How about using approximately this wording instead? I found Neil's wordin=
g to be
> especially helpful so I mixed it in. (Also fixed a couple of slight 80-co=
l overruns.)
>
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index be2754841369..c247a911d8c7 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -111,6 +111,15 @@ struct vm_area_struct;
>    * very shortly e.g. process exiting or swapping. Users either should
>    * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
>    *
> + * To be extra clear: users of __GFP_MEMALLOC must be working to free ot=
her
> + * memory, and that other memory needs to be freed "soon"; specifically,=
 before
> + * the reserve is exhausted. This generally implies a throttling mechani=
sm that
> + * balances the amount of __GFP_MEMALLOC memory used against the amount =
that the
> + * caller is about to free.

I don't like this change. "balances the amount ... is about to free"
does say anything about time, so it doesn't seem to be about throttling.

I think it is hard to write rules because the rules are a bit spongey.

With mempools, we have a nice clear rule.  When you allocate from a
mempool you must have a clear path to freeing that allocation which will
not block on memory allocation except from a subordinate mempool.  This
implies a partial ordering between mempools.  When you have layered
block devices the path through the layers from filesystem down to
hardware defines the order.  It isn't enforced, but it is quite easy to
reason about.

GFP_MEMALLOC effectively provides multiple mempools.  So it could
theoretically deadlock if multiple long dependency chains
happened. i.e. if 1000 threads each make a GFP_MEMALLOC allocation and
then need to make another one before the first can be freed - then you
hit problems.  There is no formal way to guarantee that this doesn't
happen.  We just say "be gentle" and minimize the users of this flag,
and keep more memory in reserve than we really need.
Note that 'threads' here might not be Linux tasks.  If you have an IO
request that proceed asynchronously, moving from queue to queue and
being handled by different task, then each one is a "thread" for the
purpose of understanding mem-alloc dependency.

So maybe what I really should focus on is not how quickly things happen,
but how many happen concurrently.  The idea of throttling is to allow
previous requests to complete before we start too many more.

With Swap-over-NFS, some of the things that might need to be allocated
are routing table entries.  These scale with the number of NFS servers
rather than the number of IO requests, so they are not going to cause
concurrency problems.
We also need memory to store replies, but these never exceed the number
of pending requests, so there is limited concurrency there.
NFS can send a lot of requests in parallel, but the main limit is the
RPC "slot table" and while that grows dynamically, it does so with
GFP_NOFS, so it can block or fail (I wonder if that should explicitly
disable the use of the reserves).

So there a limit on concurrency imposed by non-GFP_MEMALLOC allocations

So ... maybe the documentation should say that boundless concurrency of
allocations (i.e. one module allocating a boundless number of times
before previous allocations are freed) must be avoided.

NeilBrown



> + *
> + * Usage of a pre-allocated pool (e.g. mempool) should be always conside=
red
> + * before using this flag.
> + *
>    * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency r=
eserves.
>    * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>    */
>
>
> thanks,
> --=20
> John Hubbard
> NVIDIA

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6L0K4ACgkQOeye3VZi
gbkFeBAAj/ubgl8xubFSCCOIEW1dCuyvy6IlxYESvk6DLZB/zZva93qgEDGMgn4c
1GVJ6IEbJ/uN1kjTZmfz7MM0a/4zNNwwn0BAMCGdnNAqNuc3g071Huj1MYaRk25h
lOiWFu9d7nvLC9WfyapLYYqkxd81VqoG0Ktfx4k0Z9Q4utTvQ3REwEIKvZS/dyjQ
qAxGOP/nSET7FCKY1kGqbgk6Hh3WwP7lP1TB8WB+3MyISZUnGuFlxiie0009DIoY
R5y3ebxfMRbQEv1etqtWyHa315mm9TbFVOZyNoE6N2JSzf8m952QkATKyLwytbIY
TBNg40Dw2TXmDTX1QNhHLJ4l5aHveZokumUxpNgN/wpf3lYlgMtoFpRDiHHql90v
XqKNOD82vLOdUscvILmSjRhS1HX7r8x4/7e7vnvXbOCPFcotgMJk3ZL9AMPymC8e
VvI5pmYs7arjW29UicMptZwMkeQlZu60Kx1Pw3sYh/OJESCzew6O9/IplCOFZ+cA
c5isi5wHiYCfUVegvYbrLO8MbRJXCkCyYGcl+RwbR8NENa95S4vc2tV70VonJ2Pl
d2MTG3jBgD0ZI3AgQmFzW3g9XheB05AJlrUqoDOYsw1/w546YlzCvz/5AWV6xI65
nTwOpSSdNezL/FpmFARwJs4xXzw+0gkXnS9pjlZFTOZtZsYUyv4=
=TrXc
-----END PGP SIGNATURE-----
--=-=-=--
