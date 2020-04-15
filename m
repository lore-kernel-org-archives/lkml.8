Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E123C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C99206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWq1s6NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368594AbgDOMLy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:11:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24841 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897600AbgDOLrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586951226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=fl6HpkdoIhmdEhR1o2ViaCfJjhkJ7+6zzBUoZxYEfpM=;
        b=EWq1s6NFxWscZIOD0o1YKvs2YpKvKG5fDZSGXlYdS+dZUEOeqYVRUdqmK1chEK3Uz+dPxv
        uASBQUKcLmPtQRgnV9mDhh2oiX4Pwel72NIqczsiJspiwoWVd3tYSU4PC3dnHM+HaZMfGs
        A1Qg2D5uvis5SqlGlBX+E+iYLv64Ido=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-OjhltUrEO4O8d6gEE4Grwg-1; Wed, 15 Apr 2020 07:47:02 -0400
X-MC-Unique: OjhltUrEO4O8d6gEE4Grwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FB8080256B;
        Wed, 15 Apr 2020 11:47:00 +0000 (UTC)
Received: from [10.10.113.210] (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B64B660BE2;
        Wed, 15 Apr 2020 11:46:58 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: avoid weird message in hugetlb_init
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Longpeng (Mike)" <longpeng2@huawei.com>
Cc:     arei.gonglei@huawei.com, huangzhichao@huawei.com,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200305033014.1152-1-longpeng2@huawei.com>
 <fe9af2ff-01de-93ce-9628-10a54543be07@oracle.com>
 <cb3da0cf-9d4e-633d-c098-cac16d876956@huawei.com>
 <43017337-fe28-16e0-fbdd-d6368bdd2eb2@oracle.com>
 <641eae15-1ea7-c573-0d64-09dcccc1717d@redhat.com>
 <f2bb2878-0584-6774-8e69-162a9ec68728@oracle.com>
 <aec9dc31-6858-3d3d-405e-8fc270167c4f@redhat.com>
 <0b8d283f-dd31-b980-5d53-4bbca4014da7@oracle.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <5c6595f7-7a8a-935f-7267-c2a16ccb1997@redhat.com>
Date:   Wed, 15 Apr 2020 07:46:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0b8d283f-dd31-b980-5d53-4bbca4014da7@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0dG372tR7vYXwb95lp3IL4xTLq1ddr9Ct"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0dG372tR7vYXwb95lp3IL4xTLq1ddr9Ct
Content-Type: multipart/mixed; boundary="IPsz3W7J0spvKcK1NCcJaLgHJcbQVPqQS"

--IPsz3W7J0spvKcK1NCcJaLgHJcbQVPqQS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 4/15/20 12:03 AM, Mike Kravetz wrote:
> On 4/13/20 2:21 PM, Nitesh Narayan Lal wrote:
>> On 4/13/20 2:33 PM, Mike Kravetz wrote:
>>> On 4/10/20 8:47 AM, Nitesh Narayan Lal wrote:
>>>> Hi Mike,
>>>>
>>>> On platforms that support multiple huge page sizes when 'hugepagesz' i=
s not
>>>> specified before 'hugepages=3D', hugepages are not allocated. (For exa=
mple
>>>> if we are requesting 1GB hugepages)
>>> Hi Nitesh,
>>>
>>> This should only be an issue with gigantic huge pages.  This is because
>>> hugepages=3DX not following a hugepagesz=3DY specifies the number of hu=
ge pages
>>> of default size to allocate.  It does not currently work for gigantic p=
ages.
>> I see, since we changed the default hugepages to gigantic pages and we m=
issed
>> 'hugepagesz=3D' no page were allocated of any type.
>>
>>> In the other thread, I provided this explanation as to why:
>>> It comes about because we do not definitively set the default huge page=
 size
>>> until after command line processing (in hugetlb_init).  And, we must
>>> preallocate gigantic huge pages during command line processing because =
that
>>> is when the bootmem allocater is available.
>>>
>>> I will be looking into modifying this behavior to allocate the pages as
>>> expected, even for gigantic pages.
>> Nice, looking forward to it.
>>
>>>> In terms of reporting meminfo and /sys/kernel/../nr_hugepages reports =
the
>>>> expected results but if we use sysctl vm.nr_hugepages then it reports =
a non-zero
>>>> value as it reads the max_huge_pages from the default hstate instead o=
f
>>>> nr_huge_pages.
>>>> AFAIK nr_huge_pages is the one that indicates the number of huge pages=
 that are
>>>> successfully allocated.
>>>>
>>>> Does vm.nr_hugepages is expected to report the maximum number of hugep=
ages? If
>>>> so, will it not make sense to rename the procname?
>>>>
>>>> However, if we expect nr_hugepages to report the number of successfull=
y
>>>> allocated hugepages then we should use nr_huge_pages in
>>>> hugetlb_sysctl_handler_common().
>>> This looks like a bug.  Neither sysctl or the /proc file should be repo=
rting
>>> a non-zero value if huge pages do not exist.
>> Yeap, as I mentioned it reports max_huge_pages instead of the nr_huge_pa=
ges.
> Does this only happen when you specify gigantic pages as the default huge
> page size and they are not allocated at boot time?

Yes.

>   Or, are there other
> situations where this happens?  If so, can you provide a sample of the
> boot parameters used, or how to recreate.

To reproduce this behavior boot the kernel with 'default_hugepagesz=3D1G
hugepages=3D8' parameter in the kernel cmdline, hugepagesz needs to be
skipped to ensure that no gigantic hugepages are allocated. After the
kernel is up check the output of 'sysctl vm.nr_hugepages'.
This should be good enough to reproduce this issue.

>
> I am fixing up the issue with gigantic pages, and suspect this will take
> are of all the issues you are seeing.  This will be part of the command l=
ine
> cleanup series.  Just want to make sure I am not missing something.
Makes sense. Thank you.

--=20
Nitesh


--IPsz3W7J0spvKcK1NCcJaLgHJcbQVPqQS--

--0dG372tR7vYXwb95lp3IL4xTLq1ddr9Ct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl6W9DAACgkQo4ZA3AYy
ozmgMxAAsjHIF5TKLev1iZpUPzMNlIQAJAyAEczazQz2HJJ7REFOfWs2agnemGbD
misO1NoIPtglDEr4Kqa1EF7ojT4aXkQ3zsyd2N3a0rnlD6jX/pE+sKNBmi3HFjft
cQva3K8RVKCxUr4UbqcIudwfR1H/IPQ3MouqqvE3epZJ4uvhyUIct4n5pxQ5X4Ra
BuIQfUo2eIWSsPvivgYUhzOO8qu8UOMvXWlvl1dSNbCcm5PlnlmMDkb6ntZOBg5e
4GYlyPAcHDlvwkiLphs5ePODiUFfLJbIE8QNbacBagZx2t5lx4Lx8k/4wVtZtxqE
knD5FIW998VHABRzzxDemZ4M7c1nNas0jTlaOCLzPvNW31HaRjPi6gzHfJCJ1MFk
j8/6yuuI3qwO3cqVA9b1NvZz/PVPJmNCf3Lnhi4NLaWWQoO4VASh+pE8zfEKdAAx
ogA4l4b9JLsQfY0YYfNBPbGLPMmk7MAduJY0UFGFCgEtFppBJ9pxZ+OMkYOVFyKu
uCytZCqik17mHECfGh4H3JxT0MSXWs4vN5FT+L3KmJQLgIF35Bs3YRxhAfiyk2E6
GRSskOOipJIG8BnP75LhiupzGSf8VA9Yy7kuLKLtCksJI0ANO9+hZZxamyu27Yz7
aZ6rQOTCYrUhXdfFFGYjPvT6xfbda3yTgFbL04fYpr8Ynj9gMhs=
=FYpv
-----END PGP SIGNATURE-----

--0dG372tR7vYXwb95lp3IL4xTLq1ddr9Ct--

