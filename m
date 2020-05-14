Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86900C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526AA20748
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BMf5ILAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgENO25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:28:57 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1175 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgENO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:28:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebd551f0000>; Thu, 14 May 2020 07:26:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 14 May 2020 07:28:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 14 May 2020 07:28:56 -0700
Received: from [10.2.172.156] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 14:28:55 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mm/vmstat: Add events for THP migration without split
Date:   Thu, 14 May 2020 10:28:53 -0400
X-Mailer: MailMate (1.13.1r5685)
Message-ID: <67C72AD3-120C-4825-B67B-AECD4245EC4E@nvidia.com>
In-Reply-To: <1589257372-29576-1-git-send-email-anshuman.khandual@arm.com>
References: <1589257372-29576-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_CCB29A76-A65E-4F13-92D6-59BC5B189DEC_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589466399; bh=OGgSR5gx2J6NyZmuHH/rWO4iXUFj+kkkfJWi2YkP9jc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=BMf5ILAuRsX0OduG1sqZnhNAIRPq1gAK1FJmBU6AkOJDFqFpdysAFRk5LMLrximJz
         bNAVrYKUNUd9/TgCA8H7a7ymoz4xHMyvAj0mjdvdENTPaAqtBCS7jBDtGA2XyzQjmc
         Gve5RYhNIrk7MAlWrFsXXAd1AVdjZ1BKhf+5z23Nco78hdzfLP5V0bX3nkqHvppgbV
         08qFzgs7ESSHJ96c9saFbak8wCbVzv/EuICxTYBe8P5Rx7GRRMaFsVW2FLgAlisEcU
         vrWHm6SPC1YcNl0/dXyr/Akr/UP29fUQOAm51uP05es0C1c9bLw8l4z3Bc1BVvpihZ
         G2sfTbUi93b9g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CCB29A76-A65E-4F13-92D6-59BC5B189DEC_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 12 May 2020, at 0:22, Anshuman Khandual wrote:

> Add the following new trace events which will help in validating migrat=
ion
> events involving PMD based THP pages.
>
> 1. THP_PMD_MIGRATION_ENTRY_SET
> 2. THP_PMD_MIGRATION_ENTRY_REMOVE
>
> There are no clear method to confirm whether a THP migration happened w=
ith
> out involving it's split. These trace events along with PGMIGRATE_SUCCE=
SS
> and PGMIGRATE_FAILURE will provide additional insights. After this chan=
ge,
>
> A single 2M THP (2K base page) when migrated
>
> 1. Without split
>
> ................
> pgmigrate_success 1
> pgmigrate_fail 0
> ................
> thp_pmd_migration_entry_set 1
> thp_pmd_migration_entry_remove 1
> ................
>
> 2. With split
>
> ................
> pgmigrate_success 512
> pgmigrate_fail 0
> ................
> thp_pmd_migration_entry_set 0
> thp_pmd_migration_entry_remove 0
> ................
>
> pgmigrate_success as 1 instead of 512, provides a hint for possible THP=

> migration event. But then it gets mixed with normal page migrations ove=
r
> time. These additional trace events provide required co-relation.

To track successful THP migrations, the code below should work, right?

diff --git a/mm/migrate.c b/mm/migrate.c
index b1092876e537..d394f5331288 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1220,6 +1220,8 @@ static ICE_noinline int unmap_and_move(new_page_t g=
et_new_page,
         * we want to retry.
         */
        if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
+               if (PageTransHuge(newpage))
+                       count_vm_event(THP_PMD_MIGRATION_SUCCESS);
                put_page(page);
                if (reason =3D=3D MR_MEMORY_FAILURE) {
                        /*

Maybe you could give more details on why you want to add the THP migratio=
n event and
how you are going to use the event in your use case. That would be very h=
elpful to this
code review. Are you going to do anything if you see THP migration failur=
es?

Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_CCB29A76-A65E-4F13-92D6-59BC5B189DEC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl69VaUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKl+kP/RvAsnjpBdzFa4nok58lz5bwn+wwXw+LmbBm
qXOUo6mTy5zfB7MpB07loMJm9rh9PsBGbmMlUL3fuchA2UofWs6PU0VwydJUto6v
YDyxj3/Wd5gd65wkEtNjQziQ5y2t5dEXDDX63HW5drbJPG6VR1AKAAwxhYfRw5Ao
cjeJS1hFvplf/SX4sZEOaqoc/b72V5mq4fJ4eDQk0h2GKDI0S4rkYn1MYvYFziuc
vScp76N6tFP3k7LRxoWNftW7iE8xP3oIE98xS0k7lPr1TCIo0s9SDf/wwJTMp2+p
UvmTemGIwGuIkTqTjsNEmyeoEYv0dC4xl71i8fAJX0ms3VEy+apKxH2RNGGfKIxG
M5iRuM1Ar+4b+S17GCKUgkb6BgbTsm1kiKa8+9V6B10M7LKLFpRQNioeidv+77qi
yqs+d38Y75b1w8ZklJ3b2mKHSukbmsPs0F8MiKlgr3USxGx6XqNRa6ZNBFgyddVj
BTkSrsyPPcWabYkwt4gGTd9RRKM4NHgeLG9FDAm+QK2bZJLrTpZgMivYbKfjkUct
zqzQHIthMrkXQ7kTWCHhO1BE6wLdW2naClzkIvQMxjDPeoxlKuaB0Xj0q3EKfR3K
0sUkRyOJ0BMc22frfiDR0QQgouTIevQg94meTIic5nqNDU+fB6W97f1ksL/cU2cO
CtfSXJlC
=iRZb
-----END PGP SIGNATURE-----

--=_MailMate_CCB29A76-A65E-4F13-92D6-59BC5B189DEC_=--
