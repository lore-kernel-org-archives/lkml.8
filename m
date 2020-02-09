Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE2CC35242
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 01:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74F121741
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 01:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mpf3HZTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgBIBol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 20:44:41 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2079 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbgBIBok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 20:44:40 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3f63f90000>; Sat, 08 Feb 2020 17:44:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 08 Feb 2020 17:44:39 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 08 Feb 2020 17:44:39 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 9 Feb
 2020 01:44:39 +0000
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>
CC:     Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <20200206145501.GD26114@quack2.suse.cz>
 <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
 <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
 <235ACF21-35BE-4EDA-BA64-9553DA53BF12@lca.pw>
 <90ab0b09-0f70-fe6d-259e-f529f4ef9174@nvidia.com>
 <1CFC5A47-3334-4696-89FE-CDF01026B12B@lca.pw>
 <CANpmjNPh0ZXt_t-cZGpM9nm3pzSsb4gzbpGVkhKKVOMdapxwMg@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <5402183a-2372-b442-84d3-c28fb59fa7af@nvidia.com>
Date:   Sat, 8 Feb 2020 17:44:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CANpmjNPh0ZXt_t-cZGpM9nm3pzSsb4gzbpGVkhKKVOMdapxwMg@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581212665; bh=E7GzsYTh3hvrJQzYZCS576webV159OM2bjNdTzPPOv0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mpf3HZTIb0sgaDxY90mPHao4qrS1L7zjUpkO/6WJqkIPSYzg5Wm/vzorGHi6MOumM
         Jzhjj8fxOcDErTYBcbnk4Wbll5W7jw7sTGsQ/yuMQ51eGXJLk7UPxLoXuBce6oQawk
         ZAFRqhzBUICoN4/sVyw8g6dIVD5FVeXejsqAHCKEuQQeC/xbJaShMn6Nst7f94lOjz
         zkIofp1DlgoSZlgTq38u3AMq/hkWOxuPAb+EAMawN1fstgEUGUJzBpBFQcI5Y7+pxc
         U6ApOKfiDajSLj3MvDA4+sYz9VQUuOtmXFD31aBGES2ODsiyKKhk8c1xGpOjgm7nwA
         /PD/LztccnPDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/20 5:17 AM, Marco Elver wrote:
...
>> Yes. I'm grasping at straws now, but...what about the idiom that page_zo=
nenum()
>> uses: a set of bits that are "always" (after a certain early point) read=
-only?
>> What are your thoughts on that?
>=20
> Without annotations it's hard to tell. The problem is that the
> compiler can still emit a word-sized load, even if you're just
> checking 1 bit. The instrumentation emitted for KCSAN only cares about
> loads/stores, where access size is in number of bytes and not bits,
> since that's what the compiler has to emit.  So, strictly speaking
> these are data races: concurrent reads / writes where at least one
> access is plain.
>=20
> With the above caveat out of the way, we already have the following
> defaults in KCSAN (after similar requests):
> 1. KCSAN ignores same-value stores, i.e. races with writes that appear
> to write the same value do not result in data race reports.
> 2. KCSAN does not demand aligned writes (including things like 'var++'
> if there are no concurrent writers) up to word size to be marked (with
> READ_ONCE etc.), assuming there is no way for the compiler to screw
> these up. [I still recommend writes to be marked though, if at all
> possible, because I'm still not entirely convinced it's always safe!]
>=20
> So, because of (2), KCSAN will not complain if you have something like
> 'flags |=3D SOME_FLAG' (where the read is marked). Because of (1), it'll
> still complain about 'flags & SOME_FLAG' though, since the load is not
> marked, and only sees this is a word-sized access (assuming flags is a
> long) where a bit changed.
>=20
> I don't think it's possible to easily convey to KCSAN which bits of an
> access you only care about, so that we could extend (1).   Ideas?


I'm drawing a blank as far as easy ways forward, so I'm just going accept
the compiler word-level constraints as a "given". I was hoping maybe you
had some magic available, just checking. :)


>=20
>>>> A similar thing was brought up before, i.e., anything compared to zero=
 is immune to load-tearing
>>>> issues, but it is rather difficult to implement it in the compiler, so=
 it was settled to use data_race(),
>>>>
>>>> https://lore.kernel.org/lkml/CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=3DcozW=
5cYkm8h-GTBg@mail.gmail.com/#r
>>>>
>>>
>>> Thanks for that link to the previous discussion, good context.
>>>
>>>>>
>>>>> b) Add a new, better-named macro to indicate what's going on. Initial=
 bikeshed-able
>>>>>  candidates:
>>>>>
>>>>>     READ_RO_BITS()
>>>>>     READ_IMMUTABLE_BITS()
>>>>>     ...etc...
>>>>>
>=20
> This could work, but 'READ_BITS()' is enough, if KCSAN's same-value
> filter is default on anyway.  Although my preference is also to avoid
> more macros if possible.


So it looks like we're probably stuck with having to annotate the code. Giv=
en
that, there is a balance between how many macros, and how much commenting. =
For
example, if there is a single macro (data_race, for example), then we'll ne=
ed to
add comments for the various cases, explaining which data_race situation is=
=20
happening.

That's still true, but to a lesser extent if more macros are added. In this=
 case,
I suspect that READ_BITS() makes the commenting easier and shorter. So I'd =
tentatively
lead towards adding it, but what do others on the list think?



thanks,
--=20
John Hubbard
NVIDIA

>=20
>>>> Actually, Linus might hate those kinds of complication rather than a s=
imple data_race() macro,
>>>>
>>>> https://lore.kernel.org/linux-fsdevel/CAHk-=3Dwg5CkOEF8DTez1Qu0XTEFw_o=
HhxN98bDnFqbY7HL5AB2g@mail.gmail.com/
>>>>
>>>
>>> Another good link. However, my macros above haven't been proposed yet, =
and I'm perfectly
>>> comfortable proposing something that Linus *might* (or might not!) hate=
. No point in
>>> guessing about it, IMHO.
>>>
>>> If you want, I'll be happy to put on my flame suit and post a patchset =
proposing
>>> READ_IMMUTABLE_BITS() (or a better-named thing, if someone has another =
name idea).  :)
>>>
>>
>> BTW, the current comment said (note, it is called =E2=80=9Caccess=E2=80=
=9D which in this case it does read the whole word
>> rather than those 3 bits, even though it is only those bits are of inter=
ested for us),
>>
>> /*
>>  * data_race(): macro to document that accesses in an expression may con=
flict with
>>  * other concurrent accesses resulting in data races, but the resulting
>>  * behaviour is deemed safe regardless.
>>  *
>>  * This macro *does not* affect normal code generation, but is a hint to=
 tooling
>>  * that data races here should be ignored.
>>  */
>>
>> Macro might have more to say.
>=20
> I agree that data_race() would be the most suitable here, since
> technically it's still a data race. It just so happens that we end up
> "throwing away" most of the bits of the access, and just care about a
> few bits.
>=20
> Thanks,
> -- Marco
>=20
