Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B50C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11EBF20674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="I0oRNXLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgESSO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:14:59 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2906 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgESSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:14:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec421d30000>; Tue, 19 May 2020 11:13:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 19 May 2020 11:14:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 19 May 2020 11:14:58 -0700
Received: from [10.2.55.90] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 May
 2020 18:14:57 +0000
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
To:     Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>
CC:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com> <20200424013958.GC158937@google.com>
 <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
 <20200519131009.GD189720@google.com>
 <7c540ac9-ba44-7187-5dc2-60b4c761e91c@linux.ibm.com>
 <20200519153251.GY16070@bombadil.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <10d48b77-5c6e-2e10-84e6-16cdd76a45f1@nvidia.com>
Date:   Tue, 19 May 2020 11:14:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519153251.GY16070@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589912020; bh=qRDhgMJVS65zoSzH6J9UQCG5SwUJjCY8MYMjTPxuvOo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=I0oRNXLBA36oLvTod3vkSKAjMd5mPAKcgCBpu/ir6Q1RzqdGLI8LOvRHO5ynWaWH1
         9qCmkPOxn138M6pkRbijpa2pcK1R5KnFizEjwCuNwvAn2D+/Upm7LweZSswHK12iC9
         DrMruKfAD3FSZ2WzcsONkeiOp9e9dv02i3tVh63ufP+68hllQWUgx+ZBsgXq4+smFc
         a2ijFooZjbFt3jckn4cYt5klqBpVhraW89MHe3shh5sPPFVXvw93ZFCOIWOOWmOizI
         sNcghrNgYhpG4yBE6ndv2ulv/xti5fTrhBiSuzH3S0jA4AcO4KHG/IdY72qhAzBXII
         X/WY1CbpkE3Gw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-19 08:32, Matthew Wilcox wrote:
> On Tue, May 19, 2020 at 03:20:40PM +0200, Laurent Dufour wrote:
>> Le 19/05/2020 =C3=A0 15:10, Michel Lespinasse a =C3=A9crit=C2=A0:
>>> On Mon, May 18, 2020 at 03:45:22PM +0200, Laurent Dufour wrote:
>>>> Le 24/04/2020 =C3=A0 03:39, Michel Lespinasse a =C3=A9crit=C2=A0:
>>>>> Rename the mmap_sem field to mmap_lock. Any new uses of this lock
>>>>> should now go through the new mmap locking api. The mmap_lock is
>>>>> still implemented as a rwsem, though this could change in the future.
>>>>>
>>>>> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/=
etnaviv/etnaviv_gem.c
>>>>> index dc9ef302f517..701f3995f621 100644
>>>>> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>>>>> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
>>>>> @@ -661,7 +661,7 @@ static int etnaviv_gem_userptr_get_pages(struct e=
tnaviv_gem_object *etnaviv_obj)
>>>>>     	struct etnaviv_gem_userptr *userptr =3D &etnaviv_obj->userptr;
>>>>>     	int ret, pinned =3D 0, npages =3D etnaviv_obj->base.size >> PAGE=
_SHIFT;
>>>>> -	might_lock_read(&current->mm->mmap_sem);
>>>>> +	might_lock_read(&current->mm->mmap_lock);
>>>>
>>>> Why not a mm_might_lock_read() new API to hide the mmap_lock, and add =
it to
>>>> the previous patch?
>>>
>>> I'm not sure why this is needed - we may rework the lock to be
>>> something else than rwsem, but might_lock_read should still apply to
>>> it and make sense ? I'm not sure what the extra API would bring...
>>
>> I guess at one time the API would become might_lock_read_a_range(), isn'=
t it?
>> Furthermore this would hiding the lock's name which the goal of this ser=
ies.
>=20
> I think this assertion should be deleted from this driver.  It's there
> in case get_user_pages_fast() takes the mmap sem.  It would make sense to
> have this assertion in get_user_pages_fast() in case we take the fast pat=
h
> which doesn't acquire the mmap_sem.  Something like this:
>=20
> +++ b/mm/gup.c
> @@ -2754,6 +2754,7 @@ static int internal_get_user_pages_fast(unsigned lo=
ng start, int nr_pages,
>                                         FOLL_FORCE | FOLL_PIN | FOLL_GET)=
))
>                  return -EINVAL;
>  =20
> +       might_lock_read(&current->mm->mmap_lock);
>          start =3D untagged_addr(start) & PAGE_MASK;
>          addr =3D start;
>          len =3D (unsigned long) nr_pages << PAGE_SHIFT;
>=20
>=20

Hi Michel and Matthew and all,

There are a couple of recent developments in this code to keep in mind. I d=
on't
*think* either one is a problem here, but just in case:

a) The latest version of the above routine [1] is on its way to mmotm as of
yesterday, and that version more firmly divides the fast and slow parts,
via a new FOLL_FAST_ONLY flag. The fall-back to slow/regular gup only occur=
s
if the caller does not set FOLL_FAST_ONLY. (Note that it's a gup.c internal
flag, btw.)

That gives you additional options inside internal_get_user_pages_fast(), su=
ch
as, approximately:

if (!(gup_flags & FOLL_FAST_ONLY))
	might_lock_read(&current->mm->mmap_lock);

...not that that is necessarily a great idea, seeing as how it merely chang=
es
"might lock" into "maybe might lock".  :)

b) I've posted a small patch to that same etnaviv_gem.c file [2], over the
weekend, to convert from get_user_pages()/put_page(), to=20
pin_user_pages()/unpin_user_pages(). It hasn't been merged yet, and it
shouldn't conflict either, but just one more reason to hope that the
etnaviv list can do some run time testing on the whole lot.

[1] https://lore.kernel.org/r/20200519002124.2025955-3-jhubbard@nvidia.com

[2] https://lore.kernel.org/r/20200518054315.2407093-1-jhubbard@nvidia.com


thanks,
--=20
John Hubbard
NVIDIA
