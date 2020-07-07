Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385CAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1488120720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="k7md7ayL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGGTa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:30:59 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4127 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGTa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:30:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f04cd650001>; Tue, 07 Jul 2020 12:30:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 12:30:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jul 2020 12:30:58 -0700
Received: from [10.2.50.36] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jul
 2020 19:30:57 +0000
Subject: Re: [PATCH v2 2/3] xen/privcmd: Mark pages as dirty
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
CC:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <sstabellini@kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, Paul Durrant <xadimgnik@gmail.com>
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
 <1594059372-15563-3-git-send-email-jrdr.linux@gmail.com>
 <8fdd8c77-27dd-2847-7929-b5d3098b1b45@suse.com>
 <CAFqt6zZRx3oDO+p2e6EiDig9fzKirME-t6fanzDRh6e7gWx+nA@mail.gmail.com>
 <4abc0dd2-655c-16fa-dfc3-95904196c81f@suse.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <4c6e52e7-1d33-132b-1d7e-e57963966dcc@nvidia.com>
Date:   Tue, 7 Jul 2020 12:30:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4abc0dd2-655c-16fa-dfc3-95904196c81f@suse.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594150245; bh=dpqlDiB4hX+WGF7HO6/5EfWHYhPI+AkkSY6wCIzaoGI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=k7md7ayLM9GOFI11DNbkGz1E86R2aKIrNml3+R0dG1CxEQpyzJwxmDVWz4rsASK/I
         Tqdu9EMUjsfwzvxkxQfxYOw/cqRVNZH3vST7zs68eD2pn+JZyrRb9s8MHKsB8ODbYn
         HfgOfBluQzlyPE7gtGVbu740+lonybCMcXoEUlPyVNdwaUB6n1GlppmnknUS6S44pQ
         53cO71d9AodweLvrmv422MJjRySe+0+CB34gdp7S0Oynv24TjAoeXoijmbpLzTfoNj
         MKtnXjDMTRCGqioDkQN7Dh+/amw/q/x0JeMhjvatfn/genCs/lSHd/LnBe1976d6Dd
         uiI+ffTpw6+og==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-07 04:43, J=C3=BCrgen Gro=C3=9F wrote:
> On 07.07.20 13:30, Souptick Joarder wrote:
>> On Tue, Jul 7, 2020 at 3:08 PM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> w=
rote:
...
>>>> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
>>>> index 33677ea..f6c1543 100644
>>>> --- a/drivers/xen/privcmd.c
>>>> +++ b/drivers/xen/privcmd.c
>>>> @@ -612,8 +612,11 @@ static void unlock_pages(struct page *pages[], un=
signed int nr_pages)
>>>> =C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int i;
>>>>
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nr_pages; i++)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nr_pages; i++) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (!PageDirty(pages[i]))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_page_dirty_lock(pag=
es[i]);
>>>
>>> With put_page() directly following I think you should be able to use
>>> set_page_dirty() instead, as there is obviously a reference to the page
>>> existing.
>>
>> Patch [3/3] will convert above codes to use unpin_user_pages_dirty_lock(=
)
>> which internally do the same check. So I thought to keep linux-stable an=
d
>> linux-next code in sync. John had a similar concern [1] and later agreed=
 to keep
>> this check.
>>
>> Shall I keep this check ?=C2=A0 No ?

It doesn't matter *too* much, because patch 3/3 fixes up everything by
changing it all to unpin_user_pages_dirty_lock(). However, there is somethi=
ng
to be said for having correct interim patches, too. :)  Details:

>>
>> [1] https://lore.kernel.org/xen-devel/a750e5e5-fd5d-663b-c5fd-261d7c939b=
a7@nvidia.com/
>=20
> I wasn't referring to checking PageDirty(), but to the use of
> set_page_dirty_lock().
>=20
> Looking at the comment just before the implementation of
> set_page_dirty_lock() suggests that it is fine to use set_page_dirty()
> instead (so not calling lock_page()).


no no, that's a misreading of the comment. Unless this xen/privcmd code has
somehow taken a reference on page->mapping->host (which I do *not* think is
the case), then it is still racy to call set_page_dirty() here. Instead,
set_page_dirty_lock() should be used.


>=20
> Only the transition from get_user_pages_fast() to pin_user_pages_fast()
> requires to use the locked version IMO.
>=20

That's a different misunderstanding. :) pin_user_pages*() APIs are meant to=
 be
functionally drop-in replacements for get_user_pages*(). Internally,
pin_user_pages*() functions do some additional tracking, but from a caller'=
s
perspective, it should look the same. In other words, there is nothing
about pin_user_pages_fast() that requires set_page_dirty_lock() upon releas=
e.
The reason set_page_dirty_lock() was chosen is that there are very few
(none at all?) call sites that need to release and dirty a page, that also =
meet
the requirements to safely call set_page_dirty().

That's why there is a unpin_user_pages_dirty_lock(), but there is not a
corresponding unpin_user_pages_dirty() call: the latter has not been requir=
ed
so far, even though the call site conversions are nearly done.


thanks,
--=20
John Hubbard
NVIDIA
