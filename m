Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9232FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DB9221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CFc2buze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgIJVMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:12:53 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15694 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbgIJObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:31:07 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5a38870001>; Thu, 10 Sep 2020 07:30:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 07:30:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Sep 2020 07:30:45 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 14:30:40 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Rik van Riel <riel@surriel.com>
CC:     Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Date:   Thu, 10 Sep 2020 10:30:38 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <A66751D3-447F-4457-A8F3-E11A28452703@nvidia.com>
In-Reply-To: <b3dc8cca3689ea69491370449801ffe8d828c66c.camel@surriel.com>
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
 <b3dc8cca3689ea69491370449801ffe8d828c66c.camel@surriel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_BF9FD1D1-814C-46BB-AA9C-13BCA4D14B60_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599748231; bh=k7azRfoKtt2/zjJ4fEeYdXUZXEVFO8FgKZ148tBF0KY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=CFc2buze5y6GP2Pa+pydcOwETHhWf+oYuxYN17D7pQG9ctxKdJjw7AdZLR3hI03d7
         ejgI2N4J4YAbY1NSwETYR0Azti5QJC34QF+6NopwP0lMaujRNNA0HQ8Hgm04Xsk64h
         nzFf4fmOw7KWESwSEkW0tKQogcvctvt+58+snU2TyOxC+gR7jjOkxXAGcQv5Y8lEsd
         wvDd19PqEyPhW54b7PE/qFlk8A4JHrxABbdjwV+HQifClFmLtVN44tbf6BBi1tv6hZ
         eFP+I36DD5PrxtxcuUXcMum/m0ObxFMXW8YmrtDugZgOCIQ/eAUrnuZVHqRRR8fBkG
         ToyPlkEmLnAuQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_BF9FD1D1-814C-46BB-AA9C-13BCA4D14B60_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 Sep 2020, at 9:32, Rik van Riel wrote:

> On Thu, 2020-09-10 at 09:32 +0200, Michal Hocko wrote:
>> [Cc Vlastimil and Mel - the whole email thread starts
>> http://lkml.kernel.org/r/20200902180628.4052244-1-zi.yan@sent.com
>>  but this particular subthread has diverged a bit and you might find
>> it
>>  interesting]
>>
>> On Wed 09-09-20 15:43:55, David Hildenbrand wrote:
>>>
>>> I am not sure I like the trend towards CMA that we are seeing,
>>> reserving
>>> huge buffers for specific users (and eventually even doing it
>>> automatically).
>>>
>>> What we actually want is ZONE_MOVABLE with relaxed guarantees, such
>>> that
>>> anybody who requires large, unmovable allocations can use it.
>>>
>>> I once played with the idea of having ZONE_PREFER_MOVABLE, which
>>> a) Is the primary choice for movable allocations
>>> b) Is allowed to contain unmovable allocations (esp., gigantic
>>> pages)
>>> c) Is the fallback for ZONE_NORMAL for unmovable allocations,
>>> instead of
>>> running out of memory
>>
>> I might be missing something but how can this work longterm? Or put
>> in
>> another words why would this work any better than existing
>> fragmentation
>> avoidance techniques that page allocator implements already -
>
> One big difference is reclaim. If ZONE_NORMAL runs low on
> free memory, page reclaim would kick in and evict some
> movable/reclaimable things, to free up more space for
> unmovable allocations.
>
> The current fragmentation avoidance techniques don't do
> things like reclaim, or proactively migrating movable
> pages out of unmovable page blocks to prevent unmovable
> allocations in currently movable page blocks.

Isn=E2=80=99t Mel Gorman=E2=80=99s watermark boost patch[1] (merged about=
 a year ago)
doing what you are describing?


[1]https://lore.kernel.org/linux-mm/20181123114528.28802-1-mgorman@techsi=
ngularity.net/


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_BF9FD1D1-814C-46BB-AA9C-13BCA4D14B60_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9aOI4PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKJVEP/3nuRDt806wEH+aC3JJFFmc+QyymvaD1qczP
AzSehhMVUlHxN4b8cS2eH/6r8PfS+RMNjRys1LrZ7zZCg38YXg+oyX6wAK0SJDhi
uO9xeV6B5VvuoWlc2Pu+FDtJiLQDl1I/JIlCqBDYgZvCpmBbamvey1/sapH9V6F6
6QDVuCTn91o3QVGq2ACrKc7XkFe5LKjoOS8jhFpyNh+5VIGS33gcZawI0TsFG/05
g6xnsK4tPuzUnEM7MNCdOegV1860T4jPW5XNSniFTqqFewhFdMVboaD+rXvh1oEj
GE8fwSjj8gHaSp81aa4I1fYsCyUngRpCYkpf7DLjIY89ZYFuQfFyzKl6712aeZ7e
Vgyclm+BcJDwnCRCYCH8f6PU5B+NUJH80e7V01wysJe0FNn0iYBPfQZacLDXoje1
9uAL8sx3bBeYsrcKNziY0dXxc1/vlK/2/MGApIIwIdnWOLaBDesbglROy3YS8U5Z
ANLmYzxxItptzHfzjQBBIi5vdfIEiWhvkuM/iW69dUtVNBN7CXS4Gkpuy/IPRGpr
vDvCUhCbp9MKBgODr41CafqIWMfk0T+I2J8gfMqeEXR2QRjvyFJTPZdGCDj4K0O1
c0/2d5jdHlfpiQlJeM4QzFIeDRMAzuZyz9affaR4yK9prIHwM8tLHHvDw3s0iXne
ur8sCBS/
=6twx
-----END PGP SIGNATURE-----

--=_MailMate_BF9FD1D1-814C-46BB-AA9C-13BCA4D14B60_=--
