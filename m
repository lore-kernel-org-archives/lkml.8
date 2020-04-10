Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A793CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763F3206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RKAyCJUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDJOhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:37:02 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18478 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJOhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:37:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9084240000>; Fri, 10 Apr 2020 07:35:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Apr 2020 07:37:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Apr 2020 07:37:01 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 14:37:01 +0000
Received: from [10.2.171.178] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 14:36:59 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 1/8] khugepaged: Add self test
Date:   Fri, 10 Apr 2020 10:36:58 -0400
X-Mailer: MailMate (1.13.1r5678)
Message-ID: <DF6A7119-D6D6-4679-A4B6-9A7570984D97@nvidia.com>
In-Reply-To: <20200410114739.b2ndracbyhsdmanv@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-2-kirill.shutemov@linux.intel.com>
 <D55D6A3A-47A1-41F5-B939-36EEA740CF72@nvidia.com>
 <20200410114739.b2ndracbyhsdmanv@box>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: multipart/signed;
        boundary="=_MailMate_6D75E586-D2D1-45A1-BC78-44F983EDECF0_=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586529316; bh=CxxryBNq6ZN+MdLakixZqIa48sGz/mt/RSvdsxSZ1xQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=RKAyCJUEqcymf8YMGTiKX+dyXRhvN3jsEo/ItH5pSVg9KHGVpAnsJHiWlOUkgunex
         Lpg02nSJ35cdyXWixqtpE5/39Cw8GbLl70LleHMY05NxSEz2Byj/MGrjCk204qFOG4
         Doznmo5sIEE8g+Skvi2kBuVaUpu2CrmUUbadBhGTmABD5FylgI4UbugkE0hZ3m10XS
         wwhZ45xQtOTvVSniZUv6EiNSAdlKv97DIbwmAMSHO91psUlBofa5zNJelvOiKzD8xd
         7LcYU3KDdzE5GEuofyndHT8YYHAPVmeg5oJ7tgfmYN8nxaBtOnJ7D1094goYqEFUkN
         vWv6IinnyOV+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_6D75E586-D2D1-45A1-BC78-44F983EDECF0_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 10 Apr 2020, at 7:47, Kirill A. Shutemov wrote:

> External email: Use caution opening links or attachments
>
>
> On Mon, Apr 06, 2020 at 10:59:52AM -0400, Zi Yan wrote:
>> I ran this test with all patches from this series applied to Linus=E2=80=
=99s tree, but still see several failures. Is it expected?
>> The config file is attached. Let me know if I miss anything. BTW, I am=
 running in a VM.
>>
>> Thanks.
>>
>> The output:
>>
>> =E2=9E=9C  ~ sudo ./khugepaged
>> Save THP and khugepaged settings... OK
>> Adjust settings... OK
>> Allocate huge page on fault... OK
>> Split huge PMD on MADV_DONTNEED... OK
>> Collapse fully populated PTE table.... Fail
>
> I was able to reproduce the issue. And it's fun failure mode.
>
> How did you get the test case inside the VM? Copy-paste source using 'c=
at'
> or something similar inside the VM?

First of all, the failure above was from a bare metal and was the only fa=
ilure I saw, whereas I saw more failures in my VM. The test program was n=
ot messed up in either environment.

For VM failures I mentioned before, I used scp to copy the source code in=
to the VM. My VM has its port 22 forwarded to host=E2=80=99s port 11022. =
=E2=80=9C-net user,hostfwd=3Dtcp::11022-:22=E2=80=9D. I also copied a bin=
ary into my VM and saw the same failures.

I kinda think the failures are not related to your patches but something =
else.

>
> It screwed up CHECK_HUGE_FMT and CHECK_SWAP_FMT for me. Double back sla=
sh
> was converted to single. As result check_huge() and check_swap() gave t=
he
> false-negative result all the time.

It was not my case, since CHECK_HUGE_FMT and CHECK_SWAP_FMT from my khuge=
paged.c match your patch code.

>
> Could you check that the source of the test-case is not mangled and
> re-test if it is.

I can confirm that the test-case is not mangled. I think it must be my VM=
 setup or kernel configuration.

Do you mind sharing your .config file with me and which kernel commit you=
 apply the patches on top of in your setup? I can look into it and check =
what the problem is.

Thanks.


--
Best Regards,
Yan Zi

--=_MailMate_6D75E586-D2D1-45A1-BC78-44F983EDECF0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBAgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl6QhIoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKp3UP/2cv2KsIL9qtjLYeoEx8TDDzKusffRM+J/dT
ijyD3KTyOPy/TRpTpXCgrdc5V+NoXiRUa1G4bltyGpSweFR0rrzqXYa1RZ0g62Yf
bzoO8Ge3VOeSKauWAls3LUK10L+mHWKT4tWh+UclZeNL4qezCjkQ0TRgrG40NYxS
utC0aAfyV6Qrlr3RfzKSt8S9UKM6lYriB4yiLfIQJFuz+CqdS3hwPCwuGNvBG5ds
cK5xc7LrUg4n6pKNh/xcB0DR7VT/W9ml5MgSsA8cZr4m9yCIsks0z1Ppr/DJ6uJH
g8NpCJ0fllKAFHJ4ixp28d9gyfFFwdAWsziHhyTai0mwmcg/8Er9q9Fg/0eLk4SN
+TZYoqPgVGcH5F0b+g6WhKTphdIQRAMfkKZy1oKawwbZ3vUQT0hbCRpUr7GweBM/
/AcE7H1G61JCEgK6ehR66Fdg/rAzwZ65cxpGQaxJipYY5JIlExf5yX4vyRzuaSr6
7x1JZaZvJAJt6drYWaZLL6d41rKKi6UlQjy5KjmdnEKNq8dXTS1Z3tBgRqKwbvC4
k7IAueEa2vIz7fLCTedj77TRkNQJhTVbEXijogYcRIh6Ech6JpYfUB67FGgeEz0Y
OEqKy2WqZumoVWdsOIBkqKLueG7tL7vYF48+xmNX8eAvmwOQ+Mhq4aXlfZj0muIk
VP56DlkM
=+EuX
-----END PGP SIGNATURE-----

--=_MailMate_6D75E586-D2D1-45A1-BC78-44F983EDECF0_=--
