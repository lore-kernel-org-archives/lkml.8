Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D057C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA3208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgE1JXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:23:24 -0400
Received: from m4a0073g.houston.softwaregrp.com ([15.124.2.131]:36612 "EHLO
        m4a0073g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728161AbgE1JXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:23:23 -0400
Received: FROM m4a0073g.houston.softwaregrp.com (15.120.17.147) BY m4a0073g.houston.softwaregrp.com WITH ESMTP;
 Thu, 28 May 2020 09:20:49 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Thu, 28 May 2020 09:08:26 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (15.124.8.12) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Thu, 28 May 2020 09:08:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALSUkPsCt019wMaWuZGag7+2LY0fss7WVgJuGR+jAnZ3WY/RxKGPPdjN6GClmaFBKT9oCQMYe2YZS7h8qeOZe469q+thxvaNPbEoocNpqKo+DSWYqAotg7aj+qH3LReJRUXcyUqM/ReH41OpxSH0EYd/NsBzfBzRkLZlgq6AwityC2sF8yN6+INGg4RfCspFAZlgKPnHtoE2YMjW6oLbFOI5+qjSwL0M9i0LUYQy62CSh82nSUXZQ2l9VlFgkdpoj5Tqln87hvq2aIJqTqGj4wEXjqZ1Kdzc7GchnrVfhfzCws+UhhMWJJGU131e3eELHXKE3RCBA7lFipPb1YX6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDLFn5nbX+C4dGsd+vzzVyStqbalOdwaNAJ9XagCRE0=;
 b=VM44fLRHNSP+U2OvDQ1FMFHyA9Qq+2gjOAbCUzY4obboHbnPpZhlWGZpj89aRs/jSuWyvd522yjlpmbCd+9zPC1w/ze1rbitM6GNKRhAEiTJYcqvae8m7sGtgrEn87QOXFJk5utd01Z+riLNoQ+9lkRvGeF9wqkh49JInY2LKgNbqsdMOkdpHmL7OW3uHcHIkVAi7dLhYptasvNFnYfLIlNV9KBeRnjWESp1XroLCI9SjursXDssKxk+MH6mC708oPceQ+QKgIZ5SR4/H6VxpVOAI/bsoN96UXpsJbJ+RAVvuhObmTnj9zrpkdqc73A1f32Amnn6gF/OUaZg5YsCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DM6PR18MB3084.namprd18.prod.outlook.com (2603:10b6:5:161::24)
 by DM6PR18MB3602.namprd18.prod.outlook.com (2603:10b6:5:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Thu, 28 May
 2020 09:08:25 +0000
Received: from DM6PR18MB3084.namprd18.prod.outlook.com
 ([fe80::f45a:3f0:2fa:c5ef]) by DM6PR18MB3084.namprd18.prod.outlook.com
 ([fe80::f45a:3f0:2fa:c5ef%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 09:08:25 +0000
Date:   Thu, 28 May 2020 11:08:13 +0200
From:   Petr Tesarik <ptesarik@suse.com>
To:     <linux-s390@vger.kernel.org>
CC:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] s390/pci: Log new handle in clp_disable_fh()
Message-ID: <20200528110813.7eb1fc1f@ezekiel.suse.cz>
In-Reply-To: <20200522183922.5253-1-ptesarik@suse.com>
References: <20200522183922.5253-1-ptesarik@suse.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
Content-Type: multipart/signed; micalg=pgp-sha256;
        boundary="Sig_/CQYNDMfSK8dU_Z=bSKKA6eJ";
        protocol="application/pgp-signature"
X-ClientProxiedBy: AM0PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::35) To DM6PR18MB3084.namprd18.prod.outlook.com
 (2603:10b6:5:161::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ezekiel.suse.cz (2a00:1028:83b8:1e7a:5a6e:d5af:320a:e57) by AM0PR06CA0094.eurprd06.prod.outlook.com (2603:10a6:208:fa::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 09:08:23 +0000
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
X-Originating-IP: [2a00:1028:83b8:1e7a:5a6e:d5af:320a:e57]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fd69b7c-ce74-4d1f-55a2-08d802e6ad83
X-MS-TrafficTypeDiagnostic: DM6PR18MB3602:
X-Microsoft-Antispam-PRVS: <DM6PR18MB36027A1137620422335FF78FA68E0@DM6PR18MB3602.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aVLn47WbsOGEJ66HvwwQmRa54Q8zbK28d9U1u0znVlM0fCneFmbfpx7pdrUs2FrNpBJdUARyb96G34M6Jpg0WkE10BhXGvxPJCom4POTrtL0EDE6ydc2ABM8qNDE3Fm6BNYCYMUGOlp5vj2e3cdTJbSYAhvsCFvPaC1K8dAhbpliSoH3E++bujNGSBAbYaMzXSja2JdEcaFppFj71JV4RjhFSE1Fz1VIcZ91htU4Otc99fZMVKIFZFvta6YpxCdyGwfuBAT3W4gGAKGTWIVrY8eEUxdpMzyT4yYjpu3bb17JHG/VwHQc4zSQJVqe5G+a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB3084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(6506007)(55016002)(6916009)(66946007)(6666004)(66556008)(66476007)(83380400001)(16526019)(8936002)(4326008)(52116002)(5660300002)(7696005)(186003)(2906002)(8676002)(1076003)(316002)(86362001)(66574014)(54906003)(478600001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 7qOgkXTyr5Mu5WhB8wTCMF2p0gq9ntttolkUfDjjd4CjAvlX5XHkpLJJjTGlM74UuRQNPxWsiHE1+adAQuXc52tpFvRHPO/VgX40DeSLlx51jpHNAAFW7ayMUemKvalimMs7Gh1vn3yM64Anl3bRQ07ZKxKkWh+r3r/JFoqvsqeCb1OaULTXPD/XFPY5PBtSllYHFl3Ec/flDJGul6f8eQ0GziRAJ/Zmi5OEXzjzJlhJtUv4TpPIG/hihg/5cSootJQ3SvYRwc8VCOKZOuiuqbVQKHFiEeSJ757Vvy9lYhMdJPqKiMQjE3Vrhr1/lwFO89OtiF3ptfwPFyNYT8HRXWJAEj5p8pvA5KXnftsxmH/RYUDUajqGoeuKLXiRqXxug4yEEdvqLybdkccR9fRmEAn+Y/Y0WXwwFCPd1bVnIoXtyKt8v/MR/GvpHqJNCqfNYR7TBE7SK44Pxvu6IQV4vLd0guvSkrcODTJfAN1OrKJcEljw+LN3GU6k5j+DSSOww+O2f7VCc69movpH4c4YLkkjJuTgg1R3h+cdcHc/BuvNH7OmvQ/+KPSYDRbYjXXK
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd69b7c-ce74-4d1f-55a2-08d802e6ad83
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 09:08:25.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TT/NP1W7UX07UlyurPvGT+Yt23ijrfVEkBe9E+kCR0AC/fZQFYrSfOpdEnG0ktkulcQdj+QH2xhIj4yLZGO2Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3602
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CQYNDMfSK8dU_Z=bSKKA6eJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

just a gentle ping.

If the current behaviour (logging the original handle) was intended,
then it was worth mentioning in the commit message for 17cdec960cf77,
which made the change, but since that's no longer an option, I'd be
happy with an explanation in email.

Petr T

On Fri, 22 May 2020 20:39:22 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> After disabling a function, the original handle is logged instead of
> the disabled handle.
>=20
> Fixes: 17cdec960cf77 (s390/pci: Recover handle in clp_set_pci_fn())
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  arch/s390/pci/pci_clp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
> index ea794ae755ae..179bcecefdee 100644
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
> @@ -309,14 +309,13 @@ int clp_enable_fh(struct zpci_dev *zdev, u8 nr_dma_=
as)
> =20
>  int clp_disable_fh(struct zpci_dev *zdev)
>  {
> -	u32 fh =3D zdev->fh;
>  	int rc;
> =20
>  	if (!zdev_enabled(zdev))
>  		return 0;
> =20
>  	rc =3D clp_set_pci_fn(zdev, 0, CLP_SET_DISABLE_PCI_FN);
> -	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, fh, rc);
> +	zpci_dbg(3, "dis fid:%x, fh:%x, rc:%d\n", zdev->fid, zdev->fh, rc);
>  	return rc;
>  }
> =20


--Sig_/CQYNDMfSK8dU_Z=bSKKA6eJ
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl7Pf30ACgkQqlA7ya4P
R6edXgf/SOTHcC+zEGL/Nw3PDeNRDhU7NJ22hTmyULZtqgAOGCBF5z1/6NtMD+wm
yIfS83Y687EmSkHSGj/w9WQ48F75dUxXGVVjyGcKMaAbe1e3gjqTnsQ5mI0zHU0O
786+7AI+sviai9UeM+5xCaXriExgaMnSjhT98udUZSxXOsYC1WhtBctvVJvLjFog
TsmDdNytv74TgBEN2e2HZmxyrHUSk6lPVF3YNpvxg33WUo2s435tP+He7ePYfKY2
BdxJcweVTPyffg5RFAaij9JbCXga2aologtPCAb1DX5rtRMZt7rorj/XV0DZho7j
fEvIUMezalXdzQrtt31pq2kB/3ni3w==
=71b3
-----END PGP SIGNATURE-----

--Sig_/CQYNDMfSK8dU_Z=bSKKA6eJ--
