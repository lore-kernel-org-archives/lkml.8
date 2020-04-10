Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C89C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3A720679
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtsVhOhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDJPr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:47:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgDJPrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586533674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=9D/rkzvEawE3AdSOf1/vo4RzqnxxgKfX+1d4AYMrOKI=;
        b=ZtsVhOhPq8IGeM7hG/pN2z2qUSMioJxr+e7x2XVJ0d9hkdvq8zbvqkq942g7SKFFy6xZPZ
        lTNgo6DcH0tFJhJlrDppU2h7w6yOJwJAQnNjWUhoiMyVjkMB2CE4AuLqK0HQSUzCZiZIHM
        yGkaSM5lmctRsgVR5vj6+aobTru/uEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-6tiT7MRRPTiDymWEAZc2Ag-1; Fri, 10 Apr 2020 11:47:51 -0400
X-MC-Unique: 6tiT7MRRPTiDymWEAZc2Ag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FE4F8017F5;
        Fri, 10 Apr 2020 15:47:49 +0000 (UTC)
Received: from [10.10.112.152] (ovpn-112-152.rdu2.redhat.com [10.10.112.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4A3A272CC;
        Fri, 10 Apr 2020 15:47:47 +0000 (UTC)
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
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFl4pQoBEADT/nXR2JOfsCjDgYmE2qonSGjkM1g8S6p9UWD+bf7YEAYYYzZsLtbilFTe
 z4nL4AV6VJmC7dBIlTi3Mj2eymD/2dkKP6UXlliWkq67feVg1KG+4UIp89lFW7v5Y8Muw3Fm
 uQbFvxyhN8n3tmhRe+ScWsndSBDxYOZgkbCSIfNPdZrHcnOLfA7xMJZeRCjqUpwhIjxQdFA7
 n0s0KZ2cHIsemtBM8b2WXSQG9CjqAJHVkDhrBWKThDRF7k80oiJdEQlTEiVhaEDURXq+2XmG
 jpCnvRQDb28EJSsQlNEAzwzHMeplddfB0vCg9fRk/kOBMDBtGsTvNT9OYUZD+7jaf0gvBvBB
 lbKmmMMX7uJB+ejY7bnw6ePNrVPErWyfHzR5WYrIFUtgoR3LigKnw5apzc7UIV9G8uiIcZEn
 C+QJCK43jgnkPcSmwVPztcrkbC84g1K5v2Dxh9amXKLBA1/i+CAY8JWMTepsFohIFMXNLj+B
 RJoOcR4HGYXZ6CAJa3Glu3mCmYqHTOKwezJTAvmsCLd3W7WxOGF8BbBjVaPjcZfavOvkin0u
 DaFvhAmrzN6lL0msY17JCZo046z8oAqkyvEflFbC0S1R/POzehKrzQ1RFRD3/YzzlhmIowkM
 BpTqNBeHEzQAlIhQuyu1ugmQtfsYYq6FPmWMRfFPes/4JUU/PQARAQABtCVOaXRlc2ggTmFy
 YXlhbiBMYWwgPG5pbGFsQHJlZGhhdC5jb20+iQI9BBMBCAAnBQJZeKUKAhsjBQkJZgGABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEKOGQNwGMqM56lEP/A2KMs/pu0URcVk/kqVwcBhU
 SnvB8DP3lDWDnmVrAkFEOnPX7GTbactQ41wF/xwjwmEmTzLrMRZpkqz2y9mV0hWHjqoXbOCS
 6RwK3ri5e2ThIPoGxFLt6TrMHgCRwm8YuOSJ97o+uohCTN8pmQ86KMUrDNwMqRkeTRW9wWIQ
 EdDqW44VwelnyPwcmWHBNNb1Kd8j3xKlHtnS45vc6WuoKxYRBTQOwI/5uFpDZtZ1a5kq9Ak/
 MOPDDZpd84rqd+IvgMw5z4a5QlkvOTpScD21G3gjmtTEtyfahltyDK/5i8IaQC3YiXJCrqxE
 r7/4JMZeOYiKpE9iZMtS90t4wBgbVTqAGH1nE/ifZVAUcCtycD0f3egX9CHe45Ad4fsF3edQ
 ESa5tZAogiA4Hc/yQpnnf43a3aQ67XPOJXxS0Qptzu4vfF9h7kTKYWSrVesOU3QKYbjEAf95
 NewF9FhAlYqYrwIwnuAZ8TdXVDYt7Z3z506//sf6zoRwYIDA8RDqFGRuPMXUsoUnf/KKPrtR
 ceLcSUP/JCNiYbf1/QtW8S6Ca/4qJFXQHp0knqJPGmwuFHsarSdpvZQ9qpxD3FnuPyo64S2N
 Dfq8TAeifNp2pAmPY2PAHQ3nOmKgMG8Gn5QiORvMUGzSz8Lo31LW58NdBKbh6bci5+t/HE0H
 pnyVf5xhNC/FuQINBFl4pQoBEACr+MgxWHUP76oNNYjRiNDhaIVtnPRqxiZ9v4H5FPxJy9UD
 Bqr54rifr1E+K+yYNPt/Po43vVL2cAyfyI/LVLlhiY4yH6T1n+Di/hSkkviCaf13gczuvgz4
 KVYLwojU8+naJUsiCJw01MjO3pg9GQ+47HgsnRjCdNmmHiUQqksMIfd8k3reO9SUNlEmDDNB
 XuSzkHjE5y/R/6p8uXaVpiKPfHoULjNRWaFc3d2JGmxJpBdpYnajoz61m7XJlgwl/B5Ql/6B
 dHGaX3VHxOZsfRfugwYF9CkrPbyO5PK7yJ5vaiWre7aQ9bmCtXAomvF1q3/qRwZp77k6i9R3
 tWfXjZDOQokw0u6d6DYJ0Vkfcwheg2i/Mf/epQl7Pf846G3PgSnyVK6cRwerBl5a68w7xqVU
 4KgAh0DePjtDcbcXsKRT9D63cfyfrNE+ea4i0SVik6+N4nAj1HbzWHTk2KIxTsJXypibOKFX
 2VykltxutR1sUfZBYMkfU4PogE7NjVEU7KtuCOSAkYzIWrZNEQrxYkxHLJsWruhSYNRsqVBy
 KvY6JAsq/i5yhVd5JKKU8wIOgSwC9P6mXYRgwPyfg15GZpnw+Fpey4bCDkT5fMOaCcS+vSU1
 UaFmC4Ogzpe2BW2DOaPU5Ik99zUFNn6cRmOOXArrryjFlLT5oSOe4IposgWzdwARAQABiQIl
 BBgBCAAPBQJZeKUKAhsMBQkJZgGAAAoJEKOGQNwGMqM5ELoP/jj9d9gF1Al4+9bngUlYohYu
 0sxyZo9IZ7Yb7cHuJzOMqfgoP4tydP4QCuyd9Q2OHHL5AL4VFNb8SvqAxxYSPuDJTI3JZwI7
 d8JTPKwpulMSUaJE8ZH9n8A/+sdC3CAD4QafVBcCcbFe1jifHmQRdDrvHV9Es14QVAOTZhnJ
 vweENyHEIxkpLsyUUDuVypIo6y/Cws+EBCWt27BJi9GH/EOTB0wb+2ghCs/i3h8a+bi+bS7L
 FCCm/AxIqxRurh2UySn0P/2+2eZvneJ1/uTgfxnjeSlwQJ1BWzMAdAHQO1/lnbyZgEZEtUZJ
 x9d9ASekTtJjBMKJXAw7GbB2dAA/QmbA+Q+Xuamzm/1imigz6L6sOt2n/X/SSc33w8RJUyor
 SvAIoG/zU2Y76pKTgbpQqMDmkmNYFMLcAukpvC4ki3Sf086TdMgkjqtnpTkEElMSFJC8npXv
 3QnGGOIfFug/qs8z03DLPBz9VYS26jiiN7QIJVpeeEdN/LKnaz5LO+h5kNAyj44qdF2T2AiF
 HxnZnxO5JNP5uISQH3FjxxGxJkdJ8jKzZV7aT37sC+Rp0o3KNc+GXTR+GSVq87Xfuhx0LRST
 NK9ZhT0+qkiN7npFLtNtbzwqaqceq3XhafmCiw8xrtzCnlB/C4SiBr/93Ip4kihXJ0EuHSLn
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <641eae15-1ea7-c573-0d64-09dcccc1717d@redhat.com>
Date:   Fri, 10 Apr 2020 11:47:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <43017337-fe28-16e0-fbdd-d6368bdd2eb2@oracle.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H4mDLrReGiNuKe4QipGpxmwbOV6CXootX"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H4mDLrReGiNuKe4QipGpxmwbOV6CXootX
Content-Type: multipart/mixed; boundary="gMOyYPFK6QyAfFXGpId13pcQz9bGH3Hzp"

--gMOyYPFK6QyAfFXGpId13pcQz9bGH3Hzp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 3/6/20 3:12 PM, Mike Kravetz wrote:
> On 3/5/20 10:36 PM, Longpeng (Mike) wrote:
>> =E5=9C=A8 2020/3/6 8:09, Mike Kravetz =E5=86=99=E9=81=93:
>>> On 3/4/20 7:30 PM, Longpeng(Mike) wrote:
>>>> From: Longpeng <longpeng2@huawei.com>
>>> I am thinking we may want to have a more generic solution by allowing
>>> the default_hugepagesz=3D processing code to verify the passed size and
>>> set up the corresponding hstate.  This would require more cooperation
>>> between architecture specific and independent code.  This could be
>>> accomplished with a simple arch_hugetlb_valid_size() routine provided
>>> by the architectures.  Below is an untested patch to add such support
>>> to the architecture independent code and x86.  Other architectures woul=
d
>>> be similar.
>>>
>>> In addition, with architectures providing arch_hugetlb_valid_size() it
>>> should be possible to have a common routine in architecture independent
>>> code to read/process hugepagesz=3D command line arguments.
>>>
>> I just want to use the minimize changes to address this issue, so I choo=
sed a
>> way which my patch did.
>>
>> To be honest, the approach you suggested above is much better though it =
need
>> more changes.
>>
>>> Of course, another approach would be to simply require ALL architecture=
s
>>> to set up hstates for ALL supported huge page sizes.
>>>
>> I think this is also needed, then we can request all supported size of h=
ugepages
>> by sysfs(e.g. /sys/kernel/mm/hugepages/*) dynamically. Currently, (x86) =
we can
>> only request 1G-hugepage through sysfs if we boot with 'default_hugepage=
sz=3D1G',
>> even with the first approach.
> I=C2=A0'think' you can use sysfs for 1G huge pages on x86 today.  Just bo=
oted a
> system without any hugepage options on the command line.
>
> # cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 0
> # cat /sys/kernel/mm/hugepages/hugepages-1048576kB/^Cugepages
> # echo 1 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> # cat /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 1
> # cat /sys/kernel/mm/hugepages/hugepages-1048576kB/free_hugepages
> 1
>
> x86 and riscv will set up hstates for PUD_SIZE hstates by default if
> CONFIG_CONTIG_ALLOC.  This is because of a somewhat recent feature that
> allowed dynamic allocation of gigantic (page order >=3D MAX_ORDER) pages.
> Before that feature, it made no sense to set up an hstate for gigantic
> pages if they were not allocated at boot time and could not be dynamicall=
y
> added later.
>
> I'll code up a proposal that does the following:
> - Have arch specific code provide a list of supported huge page sizes
> - Arch independent code uses list to create all hstates
> - Move processing of "hugepagesz=3D" to arch independent code
> - Validate "default_hugepagesz=3D" when value is read from command line
>
> It make take a few days.  When ready, I will pull in the architecture
> specific people.

Hi Mike,

On platforms that support multiple huge page sizes when 'hugepagesz' is not
specified before 'hugepages=3D', hugepages are not allocated. (For example
if we are requesting 1GB hugepages)

In terms of reporting meminfo and /sys/kernel/../nr_hugepages reports the
expected results but if we use sysctl vm.nr_hugepages then it reports a non=
-zero
value as it reads the max_huge_pages from the default hstate instead of
nr_huge_pages.
AFAIK nr_huge_pages is the one that indicates the number of huge pages that=
 are
successfully allocated.

Does vm.nr_hugepages is expected to report the maximum number of hugepages?=
 If
so, will it not make sense to rename the procname?

However, if we expect nr_hugepages to report the number of successfully
allocated hugepages then we should use nr_huge_pages in
hugetlb_sysctl_handler_common().


>
>> BTW, because it's not easy to discuss with you due to the time differenc=
e, I
>> have another question about the default hugepages to consult you here. W=
hy the
>> /proc/meminfo only show the info about the default hugepages, but not ot=
hers?
>> meminfo is more well know than sysfs, some ordinary users know meminfo b=
ut don't
>> know use the sysfs to get the hugepages status(e.g. total, free).
> I believe that is simply history.  In the beginning there was only the
> default huge page size and that was added to meminfo.  People then wrote
> scripts to parse huge page information in meminfo.  When support for
> other huge pages was added, it was not added to meminfo as it could break
> user scripts parsing the file.  Adding information for all potential
> huge page sizes may create lots of entries that are unused.  I was not
> around when these decisions were made, but that is my understanding.
> BTW - A recently added meminfo field 'Hugetlb' displays the amount of
> memory consumed by huge pages of ALL sizes.
--=20
Nitesh


--gMOyYPFK6QyAfFXGpId13pcQz9bGH3Hzp--

--H4mDLrReGiNuKe4QipGpxmwbOV6CXootX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl6QlSIACgkQo4ZA3AYy
ozkUew/+Jh7+a6uxx0EX9mcYZgdrb7fiGxR4cuw8rV/mEoThrPtG3HE+W6oeEp+I
Qy80YS8MYuCb1ua5D4fkNK9LnYxOC+bVY9T7d0SOzo2npn8WnNt8lTqdPIHW8rQd
24gPHznfElBKplxTz98XwbGIqnDvhPjBbdDbkYOWvQssmwXZxLbr4pu+dZaFWnr/
FpbNQd+xuYpMLiGZHcU2zYSlv9rqJYCPuhE2vKANS1qoJRoh6egmMTcY95EOPntz
1OyfEpz0bSWhu/Cj+yqcJcDIqyOYT44pyvzKnXa0uGhoPW0E2/WwrufCl4TnCnWS
powewZCdMdokHL3oBOYdd4Fc7N4zGydTkC04LzscsgyVJHa2cDAtUT0s80vMcJdC
a2FfzxpjFIHrV4dob130mgsJO9epbygw5/i9jga5d2aj+8uXdh8lsFb8jNR6acaR
RKLUtLDTcLFb62UFjrHqEbwFye2zRKi+FPvV6/NPOhcUYr2mncKlnwTro4CkQo6f
u1QPVKWJEYYWClPpOs+bB1BAxbNhBj80tU/Vp6teUoy2seoWtfcr5YFo4cOpCVZz
phS4WVeI8zvZR6bC6K2icxOcVPraBvP9gcQ3B5QWSqD5pAKHC8TMnTEWf0FdC5no
cZJT8WZi5KHd7IwR6zYfzwDcbpwDp6iBxdMKX/NUSFYqWfKod4A=
=FDG1
-----END PGP SIGNATURE-----

--H4mDLrReGiNuKe4QipGpxmwbOV6CXootX--

