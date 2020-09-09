Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEA5C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4591D20C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KKPCfQcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgIIQuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:50:54 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11389 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIQFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:05:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f58e45b0000>; Wed, 09 Sep 2020 07:19:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 07:19:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 09 Sep 2020 07:19:50 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 14:19:45 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 06/16] mm: thp: add 1GB THP split_huge_pud_page()
 function.
Date:   Wed, 9 Sep 2020 10:19:43 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <AF9154F7-74D8-4639-BB53-0B6FF245F623@nvidia.com>
In-Reply-To: <20200909141800.4ueixh2gw5lv4deh@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-7-zi.yan@sent.com>
 <20200909141800.4ueixh2gw5lv4deh@box>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_67E22BE1-702B-406F-8717-49758A0ED8D6_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599661147; bh=ouW3msjo0bxs7Ho0BhRy49F31Peg+avV+uVRSUbnD0s=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=KKPCfQccZ0mz3gX3Iz+YypGO6w/K7rBnVj0RLPJOPNVGoL3aMIpSFGM2kDV0p/O/C
         XRpHplzO0w57y1ftBbS5AUQa1S5FtZMnfZdqU21mtstSAEm5/gqq3QNFFV8spllok2
         0CI2bNbJXhEWVgim7Jm+zaDfYVEOv4PLYtQP2NKH9e5cMK/Clmo22yx+ADrNccssyB
         7wuK9M7ClSh1mnbSsVve9tak0qPCnnIXFo2759Fr90hkf/sT4IfjI4sWqtxG7HJ4C2
         DK87+yaTN9h6P2a8O+K0FvVqwcSozo3G6jku1mcFc12ykG393WIBeo9V8ZO4qBgpey
         lV4YKVzNkP/7A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_67E22BE1-702B-406F-8717-49758A0ED8D6_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 9 Sep 2020, at 10:18, Kirill A. Shutemov wrote:

> On Wed, Sep 02, 2020 at 02:06:18PM -0400, Zi Yan wrote:
>>  25 files changed, 852 insertions(+), 98 deletions(-)
>
> It's way too big to have meaningful review.

Will split it into small patches in the next version.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_67E22BE1-702B-406F-8717-49758A0ED8D6_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9Y5H8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqK6bgP/1zuTfokWA7v5i0dOvkMy4hhGhOvmGQ9uZzf
IHUfm4jaIRwfQQ7U/jwZJatVi5HJTzOYxSMf9hrpv4x/0jsbsszMmvJ/SzIVa0ZD
Q/ZZf8ItL27F0ZUtGctCqfEABtWIlG9mwik2xf8AmQM8L0I2jB2QCrYWyRMC4Fx8
iVCnAmUDr1TOGIWwYy2OE3lLsuwRLwpcnAZtYarJsIvd+Ao+I6tdgTS3Mc7Ewn8A
/G7k8SW8I8oAl+A2RD5c581xGKcvmkXkWkNwZ1meCa17nO4nFmnMz6QCbXYVT2Vm
BPm8QvCvE7uQ41fqJWLjF+CKM9YHXH5qFyvw7PowRWUSOb0FKpvSRZEl7Y6glxY+
QB8dWFT+csKEomrkU8Bb01g6oc73cF9Qiv3GTVVPgPPiwhWF4pyfyKQ0wMr3HLaZ
rKVhl5rVN4zmibwwljaJlO4efUik1GiF16pwcbZNZY/L86XWhZLX8jb18awbEh9I
hLvYP7MDXcePYz1/ZysTkGPW/EbV2btV2zFtqtxHGoVx5IWr3UL4DMVaXoSPyJYz
K+K/7vBg13u/ujCh40v53vU5vBIwmQ+l2t0D4N7uqbjmdIz5x4DTB/CmIb35F3Co
AjLBdCcCWMYngi2iiLCi9zSUJUgMzU49pa57hw5rSiWLnSX2xMCg8hlTZCBPKZpV
TqSMdqVV
=KXb2
-----END PGP SIGNATURE-----

--=_MailMate_67E22BE1-702B-406F-8717-49758A0ED8D6_=--
