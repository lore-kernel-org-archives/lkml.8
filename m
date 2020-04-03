Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0727CC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD431207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgDCVX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:23:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:45120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgDCVX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:23:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D9212ABCC;
        Fri,  3 Apr 2020 21:23:54 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>
Date:   Sat, 04 Apr 2020 08:23:45 +1100
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
In-Reply-To: <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
References: <20200403083543.11552-1-mhocko@kernel.org> <20200403083543.11552-2-mhocko@kernel.org> <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
Message-ID: <87blo8xnz2.fsf@notabene.neil.brown.name>
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

On Fri, Apr 03 2020, David Rientjes wrote:

> On Fri, 3 Apr 2020, Michal Hocko wrote:
>
>> From: Michal Hocko <mhocko@suse.com>
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
>> [1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>> ---
>>  include/linux/gfp.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index e5b817cb86e7..e3ab1c0d9140 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -110,6 +110,9 @@ struct vm_area_struct;
>>   * the caller guarantees the allocation will allow more memory to be fr=
eed
>>   * very shortly e.g. process exiting or swapping. Users either should
>>   * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
>> + * Users of this flag have to be extremely careful to not deplete the r=
eserve
>> + * completely and implement a throttling mechanism which controls the c=
onsumption
>> + * of the reserve based on the amount of freed memory.
>>   *
>>   * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency r=
eserves.
>>   * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>
> Hmm, any guidance that we can offer to users of this flag that aren't=20
> aware of __GFP_MEMALLOC internals?  If I were to read this and not be=20
> aware of the implementation, I would ask "how do I know when I'm at risk=
=20
> of depleting this reserve" especially since the amount of reserve is=20
> controlled by sysctl.  How do I know when I'm risking a depletion of this=
=20
> shared reserve?

"how do I know when I'm at risk of depleting this reserve" is definitely
the wrong question to be asking.  The questions to ask are:
=2D how little memory to I need to ensure forward progress?
=2D how quick will that forward progress be?

In the ideal case a small allocation will be all that is needed in order
for that allocation plus another page to be freed "quickly", in time
governed only by throughput to some device.  In that case you probably
don't need to worry about rate limiting.

The reason I brought up ratelimiting is that RCU is slow.  You can get
quite a lot of memory caught up in the kfree-rcu lists.  That's not much
of a problem for normal memory, but it might be for the more limited
reserves.

The other difficulty with the the kfree_rcu case is that we have no idea
how many users there will be, so we cannot realistically model how long
the queue might get.  Compare with NFS swap-out there the only user it
the VM swapping memory which (I think?) already tries to pace writeout
with the speed of the device (or is that just writeback...).  I'm
clearly not sure of the details but it is a more constrained environment
so it is more predicatable.

In many cases, preallocating a private reserve is better than using
GFP_MEMALLOC.  That is what mempools provide and they are very effective
(though often way over-allocated*).
GFP_MEMALLOC was added because swap-over-NFS requires lots of different
allocations (transmit headers, receive buffers, possible routing changes
etc), many of them in the network layer which is very sensitive
to latency (and mempools require a spinlock to get the reserves).

Maybe the documentation should say.
 Don't use this - use a mempool.  Here be dragons.

I'm not sure you can really say anything more useful without writing a
long essay.

NeilBrown

(*) mempool sizes should not exceed 2 without measurements demonstrating
that more provides better throughput. Many are 2, (BIO_POOL_SIZE is 2,
which is perfect) but some aren't.
 #define DRBD_MIN_POOL_PAGES       128
way too big!
 #define MIN_IOS 256
even bigger!
 mempool_create_page_pool(2 * (F2FS_IO_SIZE(sbi) - 1), 0);
This is really wrong.  If the IO size is relevant, then each object in
the pool needs to be that size.  Having that many objects in the pool
doesn't mean anything useful.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6HqWIACgkQOeye3VZi
gblsVA/6Aqj2d5fTiHsD2gn0anUaLQhlnZk/F9iPiqJLg0l4Y5puFl5T3XRb2EXm
gUF1UwAIgdmvEsiv+7hnYkh/tOwNOVDO9t5dupgF0ObTgNmxLYJSWAa8KaZZJkXP
KPwDsXCLhf/bDJIj2kZgvI0UdFWPE8oniiHuZBI3DAuPACCK9VY0Iuzu6ZGhEUNy
UDXyRSNmit5XTceuaE+eL6iSq9ARMO7N3+INxnd7x0syHKhwy+pBQG+ODHTvTP0E
4W1nMZsjxMlkmoPGEP2O6cq7/bfido/82abUgm+VYPtD0yLe1hCfbAqmCJj2Iq7R
nqtCStoYRYWPRenUlGR2PtUqa5WRx0pZsVDTdyz274/HfoGqenQ3HzDul/eXerRt
26vyD+Tge+WbjmOywQ0/8pUoz5cPlUMJFDshDeYcMmS0QnHUkHTXhTGxNWPtubaD
PWT3dOJ5Le4xrAoFB4eYeoqYfuoyOMcl7z6DGJz+rm/cfwZAcVAvr4umYaOvKFbn
yQjZ7MHdL74McU/dQQvxZGGHR0fOaVom0BpjKM97xbeNcAWqEvi1H58GK89HI+0b
MeLppn33UjJ2Yh5gqN44ty9qp5r9HcNQLum3i102NoEG/5kPxqMMvx1uctJoT38B
x5w+RPc+7Tz5yrHYuvNlF2+D74HOASzjQMZE9WBgcyZ860xPhCM=
=oyj8
-----END PGP SIGNATURE-----
--=-=-=--
