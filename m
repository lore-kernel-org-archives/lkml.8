Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D138C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC71A2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qc4yzSS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbgIJOp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:45:27 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8003 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730853AbgIJOl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:41:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5a3a8e0000>; Thu, 10 Sep 2020 07:39:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 10 Sep 2020 07:41:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 10 Sep 2020 07:41:26 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Sep
 2020 14:41:18 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
        "Roman Gushchin" <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Date:   Thu, 10 Sep 2020 10:41:16 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <3684BEAF-C8A2-4EEC-8FC2-55EA5F8F7DA5@nvidia.com>
In-Reply-To: <46604da8-55d0-111d-7854-cbaa8bb65925@redhat.com>
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
 <9ffa345f-fd45-aeac-691d-54d1364bff6d@redhat.com>
 <C249991F-A64E-4262-892F-F1587B800264@nvidia.com>
 <46604da8-55d0-111d-7854-cbaa8bb65925@redhat.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_0713686C-CFCA-464F-BC64-A68C619411CB_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599748750; bh=pRebgiSFI4as2eohti5Cpwsoqc5C86yEFeEFsCxefD4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=qc4yzSS36rdj5VyVOKXvxaSDyr9aAcf1WQlH6J4xqILGBpD9HXxftkHNndNsVcHsF
         WRD0GBeSVI3BT1RyyfChgESkDMR7YCla0DJ9oHuALuJJBEYg1zlXs+pKFUX+lkREcV
         p98f2bNyyPdLXia7hK0OPKN7j00PS+ms4jH9LS5ZBRwzT+m9/CY1sliWn5YbooS6CJ
         dsvU3v4wUq2xIrZqTigr8wXzmOj9j2THwoBVX3Ir5B+boLGmrrcWFbMiM6STKenBtJ
         f4D1LuPpSfN06tvF1HGKRhXmu9Sr2rlR/o0KoG5h2Qct+eeEzPQqNjQaKfnSySi9Un
         tCFDcT1gD0/3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0713686C-CFCA-464F-BC64-A68C619411CB_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 10 Sep 2020, at 10:34, David Hildenbrand wrote:

>>> As long as we stay in safe zone boundaries you get a benefit in most
>>> scenarios. As soon as we would have a (temporary) workload that would=

>>> require more unmovable allocations we would fallback to polluting som=
e
>>> pageblocks only.
>>
>> The idea would work well until unmoveable pages begin to overflow into=

>> ZONE_PREFER_MOVABLE or we move the boundary of ZONE_PREFER_MOVABLE to
>> avoid unmoveable page overflow. The issue comes from the lifetime of
>> the unmoveable pages. Since some long-live ones can be around the boun=
dary,
>> there is no guarantee that ZONE_PREFER_MOVABLE cannot grow back
>> even if other unmoveable pages are deallocated. Ultimately,
>> ZONE_PREFER_MOVABLE would be shrink to a small size and the situation =
is
>> back to what we have now.
>
> As discussed this would not happen in the usual case in case we size it=

> reasonable. Of course, if you push it to the extreme (which was never
> suggested!), you would create mess. There is always a way to create a
> mess if you abuse such mechanism. Also see Rik's reply regarding reclai=
m.
>
>>
>> OK. I have a stupid question here. Why not just grow pageblock to a la=
rger
>> size, like 1GB? So the fragmentation of unmoveable pages will be at la=
rger
>> granularity. But it is less likely unmoveable pages will be allocated =
at
>> a movable pageblock, since the kernel has 1GB pageblock for them after=

>> a pageblock stealing. If other kinds of pageblocks run out, moveable a=
nd
>> reclaimable pages can fall back to unmoveable pageblocks.
>> What am I missing here?
>
> Oh no. For example pageblocks have to completely fit into a single
> section (that's where metadata is maintained). Please refrain from
> suggesting to increase the section size ;)

Thank you for the explanation. I have no idea about the restrictions on
pageblock and section. Out of curiosity, what prevents the growth of
the section size?

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_0713686C-CFCA-464F-BC64-A68C619411CB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9aOwwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKEt0QAIvPUh89vpiDtDpn4N8OsXxU9rrnmJVoMuSy
03/mMkXmOPKwkaOyCrEHb1mMOFDM9F843V/T9zOItzXTCYqntXwsmgUGOEeIxwMV
hcqfZ0Af5qfM1NpnAyHaRwOXhxozFDiu9hIIy5MMS0duBhZSN6z9PQeGd/MYebSM
FrbipJVhm5ULm2bhoXkM2CY3RVcvfv60oLVghSlm+nwIFRTNw/+2jKMn/1K2GcaR
Vx6idXhhHpGBi+CbuA2ZfEjDQLpFR+G7o3Kl0QiK4LesFFwOucgyw6Xust41ElsS
6zefqe8mE7Q6Blo9rJX6d2+gY0hhGWmy3QRtOLWjUFfk+Jvl498r8AuK7HzTHaqU
0vRV05AII3V0EDyaZ+qO3OQXgOaLg/xVw0WPHvHJIdKzYXYbB5IOr/lKv4kT1GE3
dn6/o415q13LkH9glXcl1hSWQTtNqGDRd6xlPFuhQP2F+JPP54HHDU3JihIoI+Bn
IErJUkYz1OiwY8VbUgF0e7+6NUjV6v+7Pzzv7QVHUEdrm07dcCOLUDEjY5jJOJvj
yKPm/Q6ZaH+Mrbk91uq7GWcp2BL0igI7f/Bky0yOHe21de71CRT+WA+6ORVxJJA/
zpazfasdK9DZ0ZIBtNwBCpLvAaH5EBxeCBCNb6CnZDMBFJAwca8UBdZX+kV3mEra
UzykKsRX
=marw
-----END PGP SIGNATURE-----

--=_MailMate_0713686C-CFCA-464F-BC64-A68C619411CB_=--
