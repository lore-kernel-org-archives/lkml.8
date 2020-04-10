Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AEAC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5C20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7e/hYt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgDJL5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:57:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52410 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgDJL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586519830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=J1oLMSO6o++JAudW7yPCWtckurufmlO5PWTlVHhrxn4=;
        b=T7e/hYt/bPWcQBx1aZ5uihtIp/zMd+eusn1yoWMxMxchv3+ck1CuZEFX7yomFKeIyOUj/u
        dHbGmPl9ZJZaJTxHQkKxOCkf7SJDSWSxrWHvQT4IjDs3Qk1RAC9fUG6sLg8zLjkxqTjE9+
        dufzxh7HXDkVHsIg9eZZ9bH9vPz6Jp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-sBprY5czOeWw_AMj2AZNdQ-1; Fri, 10 Apr 2020 07:57:06 -0400
X-MC-Unique: sBprY5czOeWw_AMj2AZNdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF7713FC;
        Fri, 10 Apr 2020 11:57:05 +0000 (UTC)
Received: from [10.10.112.152] (ovpn-112-152.rdu2.redhat.com [10.10.112.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C3FD9DD96;
        Fri, 10 Apr 2020 11:57:01 +0000 (UTC)
Subject: Re: [PATCH] Documentation: hugetlb: Update hugetlb options
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20200409215800.8967-1-peterx@redhat.com>
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
Message-ID: <465b3e80-d8db-510d-f005-7f1cc7831e6f@redhat.com>
Date:   Fri, 10 Apr 2020 07:57:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409215800.8967-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0XjUQfG032zRm6QmnPWsuePcT6inCQ8ks"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0XjUQfG032zRm6QmnPWsuePcT6inCQ8ks
Content-Type: multipart/mixed; boundary="1lLocalmcbgyNm1E0Ukp1K5jm2SWOF4U6"

--1lLocalmcbgyNm1E0Ukp1K5jm2SWOF4U6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 4/9/20 5:58 PM, Peter Xu wrote:
> The hugepage options are not documented clearly.
>
> Firstly, default_hugepagesz=3D should always be specified after the
> declaration of the same type of huge page using hugepagesz=3D.  For
> example, if we boot a x86_64 system with kernel cmdline
> "default_hugepagesz=3D2M", we'll get a very funny error message:
>
> "HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152"

There is an ongoing discussion to fix this issue.
AFAIK it has not been settled yet and Mike was going to post a patch-set.
https://lkml.org/lkml/2020/3/9/96

>
> It's understandable from code-wise because when hugetlb_init() we
> didn't have the 2M page hstate registered, so it's unsupported.
> However 2M is actually the default huge page size on x86_64, so we'll
> register it right after the error message.  However it's very
> confusing if without these knowledges.
>
> Secondly, hugepages=3D option must be used _after_ another hugepagesz=3D.
> The word "interleave" is fine but it didn't declare the fact that
> each of the hugepages=3D option will be applied to the previous parsed
> hugepagesz=3D option.
>
> State all these clear.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 86aae1fa099a..2a77b2b01e5e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -839,7 +839,8 @@
>  =09=09=09the legacy /proc/ hugepages APIs, used for SHM, and
>  =09=09=09default size when mounting hugetlbfs filesystems.
>  =09=09=09Defaults to the default architecture's huge page size
> -=09=09=09if not specified.
> +=09=09=09if not specified.  This option can only be used with a
> +=09=09=09pre-defined "hugepagesz=3D" of the same size.
> =20
>  =09deferred_probe_timeout=3D
>  =09=09=09[KNL] Debugging option to set a timeout in seconds for
> @@ -1475,13 +1476,17 @@
>  =09hpet_mmap=3D=09[X86, HPET_MMAP] Allow userspace to mmap HPET
>  =09=09=09registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
> =20
> +=09hugepagesz=3D=09[HW,IA-64,PPC,X86-64] Declare one type of HugeTLB pag=
es
> +=09=09=09with the size specified.  Valid pages sizes on x86-64
> +=09=09=09are 2M (when the CPU supports "pse") and 1G (when the
> +=09=09=09CPU supports the "pdpe1gb" cpuinfo flag).
> +
>  =09hugepages=3D=09[HW,X86-32,IA-64] HugeTLB pages to allocate at boot.
> -=09hugepagesz=3D=09[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
> -=09=09=09On x86-64 and powerpc, this option can be specified
> -=09=09=09multiple times interleaved with hugepages=3D to reserve
> -=09=09=09huge pages of different sizes. Valid pages sizes on
> -=09=09=09x86-64 are 2M (when the CPU supports "pse") and 1G
> -=09=09=09(when the CPU supports the "pdpe1gb" cpuinfo flag).
> +=09=09=09On x86-64 and powerpc, this option must be used after
> +=09=09=09one hugepagesz=3D to allocate huge pages of that specific
> +=09=09=09size.  This option can also be used multiple times
> +=09=09=09pairing with hugepagesz=3D to allocate huge pages for
> +=09=09=09different sizes.
> =20
>  =09hung_task_panic=3D
>  =09=09=09[KNL] Should the hung task detector generate panics.
--=20
Nitesh


--1lLocalmcbgyNm1E0Ukp1K5jm2SWOF4U6--

--0XjUQfG032zRm6QmnPWsuePcT6inCQ8ks
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl6QXwwACgkQo4ZA3AYy
ozkkGxAA0cf0ab+K20o7f9ds/YZFMWjQK+UyK6GHMqUSDMOOWFBMHaUkS0a3Pxsf
4sRv26WVKVVDOEgmo5J8Ljl/1eJt8//a6smWPnuk+SbstNHfEvSzgLHB9eNWjyYg
Eqn10Fqt5c9xKCfPGDY/Sh3ysjpOQXg9Kp162QcdNoW8CW4Rl1eQq/d7ic9o89v5
eHP2Uann8jgYdQJm5MZGQ5AoIENWBy41r7lK8KR9EphGsFb/n0ciOcvDPoamT7JW
aR/yCnOE93ZA44uByu3asleDgzWLvNkrDi5/NccjLv0u9c+ap/BzaITMJWhZSflI
T+isj8WNaPOH3na2ApFLF3Pwa09kfMVtOCb/rnm1cTDBJku2cTcy1u16Ft0pzcU4
oan35BewIjcAyKI8Avs/x3CDHmxLMLKIczdvPl54fkau6LzzVODaVCQ+CRdVFCpL
NQICH0iGdoGQ9ZyW8PBIign8iSBcpK22f6E1wJFkKpOT9LULyRE3NIWoCWYhiq5c
X7AzdXb1rn2szmYlI78OaTqIh23XlKhNxdE+qUn/07OC/TJFMA0Zts4WrzkshWSu
TfzxYsY5CA3Y9GZm8AbIq58ygePQKcgsg1q1Vu6wweCe7+C0S+9FjZBjT5YVXooe
o6dZYjOf71Hlg7mMT17Fv08CVIl9HCs/5ImuSHpVnWZP3aZg9PE=
=48iJ
-----END PGP SIGNATURE-----

--0XjUQfG032zRm6QmnPWsuePcT6inCQ8ks--

