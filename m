Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391BCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D152077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 14:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JPETlvwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgGAOYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 10:24:42 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15076 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbgGAOYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 10:24:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efc9c9c0000>; Wed, 01 Jul 2020 07:24:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 07:24:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 01 Jul 2020 07:24:41 -0700
Received: from [10.2.167.170] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 14:24:36 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC] [PATCH 0/8] Migrate Pages in lieu of discard
Date:   Wed, 1 Jul 2020 10:24:33 -0400
X-Mailer: MailMate (1.13.1r5690)
Message-ID: <8927EC7B-76F2-4DFC-9AD8-EC2F15E3CEF9@nvidia.com>
In-Reply-To: <fdfeb902-e363-f8b5-4c63-df224b9817fa@intel.com>
References: <20200629234503.749E5340@viggo.jf.intel.com>
 <CALvZod55OFzOozsDbyTkUh1uZEobo4CZ=+8JgrJJHw8QuWh0hw@mail.gmail.com>
 <654d785f-3fe5-d8bd-86bf-bf7431527184@intel.com>
 <CALvZod5-YuMC8b6rs=a_ahh0WF14wgKJBW18CARJtGa_bYUn0Q@mail.gmail.com>
 <fdfeb902-e363-f8b5-4c63-df224b9817fa@intel.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_ED97B0CF-ABF2-4CF2-859F-B952D1167A95_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593613468; bh=PKq0CC2DX1XXl1/wiF69VNRwdmFx70S5e4iigtdY8Lc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=JPETlvwLsCvM1mqX48qKvUsrXYVLpTyoDi7bWBgatxUweLvhxAEoiP6s0ntJFAo8a
         SRXKwmf5bkihwgVYGb5mpBIByWoj0cRIMnZ79OGt6o88YqwoVnWqy2QFz6n2rDmczn
         1j/bxgQmpZIsv6KlDL3r5dqK4rs8dgH9cKEeQqzoyj3lQjRpJDIjUkBs9bk84xqvR+
         vO1RmJXPIkxH7vBmIXOGpsxIZ5eESMynoQbdHKDg46DgLyGA52ZGvYqZfuPEsI2CN4
         VjrGTm/WMYNr5niARtTFvS1zMpdhvmdy7amFZJN45ww2M98LnpKh6LyeEU3Mzei/Zu
         mfJUyQmJUw+xA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_ED97B0CF-ABF2-4CF2-859F-B952D1167A95_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Jun 2020, at 15:31, Dave Hansen wrote:

>
>
>> BTW is this proposal only for systems having multi-tiers of memory?
>> Can a multi-node DRAM-only system take advantage of this proposal? For=

>> example I have a system with two DRAM nodes running two jobs
>> hardwalled to each node. For each job the other node is kind of
>> low-tier memory. If I can describe the per-job demotion paths then
>> these jobs can take advantage of this proposal during occasional
>> peaks.
>
> I don't see any reason it could not work there.  There would just need
> to be a way to set up a different demotion path policy that what was
> done here.

We might need a different threshold (or GFP flag) for allocating new page=
s
in remote node for demotion. Otherwise, we could
see scenarios like: two nodes in a system are almost full and Node A is
trying to demote some pages to Node B, which triggers page demotion from
Node B to Node A. Then, we might be able to avoid a demotion cycle by not=

allowing Node A to demote pages again but swapping pages to disk when Nod=
e B
is demoting its pages to Node A, but this still leads to a long reclaim p=
ath
compared to making Node A swapping to disk directly. In such cases, Node =
A
should just swap pages to disk without bothering Node B at all.

Maybe something like GFP_DEMOTION flag for allocating pages for demotion =
and
the flag requires more free pages available in the destination node to
avoid the situation above?


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_ED97B0CF-ABF2-4CF2-859F-B952D1167A95_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl78nKEPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKE1AQAIVa+5JqVcHM2uFniFUSGzVgzIka+D1JSM6W
p5gxj3U6mRrFNrSbimOhZUP6qsZEiYlPIR0CCwxAZdkx68CUOFnQvC1pmCljm50/
9rjmttuqcEjeW+vh7CWgmln/gVm250hyIKj726i8C8xnNueMxl52++Z9KNtUBuHy
PFnnpkuWbL2e0XqpwJYmCQpvAchnzGFRhk9xiqz73HirnzOaSgGfzhQJFRs7u1uz
gvIy2rOGX/4n/Ia+4LHdFgp3FwHP4gXzN6v3uoW5tOGtv1qXER99RRly3oIGG2jw
BfQK3rYvfGT7h5sLsuQ16HMXpOrDsy/myHJVzCyO6pnczD6gUzsFHWBGI5YcVzKQ
vxDpJsl3Iz+x5ue3Ppm/hI/Tud5BmDHCS7p4XyXbn3cP7ijDB4eGj+F4j5rDiVTC
Xi6VBAn7gKpAOF+Iwr2DFUAjkwleUn8tpGK4Tuuf2niWu/yQ5A0oskcuJkKoHP9W
5yLgjWnv7KYn0J1zyKw5g76oopU3WzpYHN7iVve7EYz8YmKKRlv3R1gpQi/pwo6x
bgtvVk/MyIcwkMl75EA0elFe98i8M/y65G4ZZ22Ak8wxR/2v7FciSoOkrSbiXVSm
Rqyh6fuwlJ8jG7YeDpvNCVgYpQDubDHAyyTwDrNi1pc+z2VaghbgbJUKHAyJe0tY
AnJGE+T4
=hhli
-----END PGP SIGNATURE-----

--=_MailMate_ED97B0CF-ABF2-4CF2-859F-B952D1167A95_=--
