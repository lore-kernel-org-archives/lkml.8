Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3F1C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C17C20724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mVNDWJON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgCTV1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:27:00 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:44544
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbgCTV07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:26:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE2quSp5bq3tYDWCzpVc/sJvJl/8y2NhSojYDSBsGF+kOQKi6UbOzB50vSITc53IgMYzwuN7ikx8x+2FwLRgApqLD1JMKLX6h7b3uCk1xtcXKLchHVLTunv/g/8oZ2xuWBhual99RB/DLxUNa6XafLeadLf+v4iOZG/4iKbGQPqv/i1Kb5cpSzk/P0cLQ57TeJzStXpYRPSUiVNDMYNM9qAEz00Rzb/YfbfqsD3NV0KuEzHTa8IBzDdc7RDoXEPPW1tF++OpbmfY7zTIZ7+rue6QAw3EYDlytxRbNs3/gswTvlFEuKklr7ZERI3l4hgjUcN1nv8x8wnZM7haSVkZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6alEr6igetNhKSUueIMmGxfB9m+HdjZ+McPk/Du/+w=;
 b=mb03Q2LzXCAqZwzb6Z1AYm1pu/NZNrqW0wp2eTcFttPWLcfCLgEChJCzOvLs/QYI7SUzsW+h3SMJVfPdsAJjYWHp5uHSXi0Q+aMcvsUZ8AA2cIUY3/YcYVyUgK0AsJxDiy+C0Z5sTNmsFr1rtjS8bCe8oFZFeDhCPqLdHiqPUxDl9oKeRaEMvSRjcXQDCVahaBKR9NUjKtTJNUHLc0McsbmkWwG0AOuslskSCy6LLnnSI1FPcGnjOIUToEUO67DI4YNKcjQ+HVmYjHEL+NA3O9qtKMwMEkqx+duVxkWqoxdzzUYTj2uk+/ytU80e4z6HyvtgTFG/qU7a/Sh+9MWY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6alEr6igetNhKSUueIMmGxfB9m+HdjZ+McPk/Du/+w=;
 b=mVNDWJON5Ni1JIQo0B9qKCHb9IKvtrGiMFPn4/Zi91gTWy8AbBr+gMyBxxJRmus+PQFql6DGc6KlNUZqkPS9dDprwW3VdmETLdN/s7CD6+31bN2E5IULNVzg+6QiAHSd7UAPvL145d0g7XCRIm5I8Fjzm8wWKlpKoJl3u7tC3Bc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=amakhalov@vmware.com; 
Received: from BYAPR05MB5975.namprd05.prod.outlook.com (2603:10b6:a03:da::10)
 by BYAPR05MB5126.namprd05.prod.outlook.com (2603:10b6:a03:9a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.8; Fri, 20 Mar
 2020 21:26:49 +0000
Received: from BYAPR05MB5975.namprd05.prod.outlook.com
 ([fe80::d5ff:6689:3a3:eff8]) by BYAPR05MB5975.namprd05.prod.outlook.com
 ([fe80::d5ff:6689:3a3:eff8%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 21:26:49 +0000
From:   Alexey Makhalov <amakhalov@vmware.com>
Message-Id: <3A7A333D-9CF4-4607-A99B-52838F85512A@vmware.com>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_1EFDD86F-A006-4BA1-BEB7-2A7C21F79F8E";
        protocol="application/pgp-signature";
        micalg=pgp-sha256
Subject: Re: [PATCH 0/5] x86/vmware: Steal time accounting support
Date:   Fri, 20 Mar 2020 14:26:47 -0700
In-Reply-To: <20200320211631.GI23532@zn.tnic>
Cc:     "linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
To:     Borislav Petkov <bp@alien8.de>
References: <20200320203443.27742-1-amakhalov@vmware.com>
 <20200320205929.GH23532@zn.tnic>
 <A9A30A6C-F5C3-45ED-8225-07EFF4F6E8E4@vmware.com>
 <20200320211631.GI23532@zn.tnic>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-ClientProxiedBy: BY5PR17CA0002.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::15) To BYAPR05MB5975.namprd05.prod.outlook.com
 (2603:10b6:a03:da::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.16] (50.47.105.33) by BY5PR17CA0002.namprd17.prod.outlook.com (2603:10b6:a03:1b8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend Transport; Fri, 20 Mar 2020 21:26:48 +0000
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-Originating-IP: [50.47.105.33]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3322b76-854b-4e6a-cf86-08d7cd156644
X-MS-TrafficTypeDiagnostic: BYAPR05MB5126:
X-Microsoft-Antispam-PRVS: <BYAPR05MB512638BD51F0DB2BCF03ADDDD5F50@BYAPR05MB5126.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(6916009)(33656002)(81156014)(81166006)(4326008)(2906002)(8936002)(15650500001)(2616005)(316002)(7416002)(16576012)(52116002)(36756003)(956004)(86362001)(33964004)(54906003)(8676002)(186003)(45080400002)(5660300002)(16526019)(235185007)(6486002)(66476007)(66556008)(26005)(478600001)(966005)(66946007)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5126;H:BYAPR05MB5975.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VURGm8FaXH3IfDlpNLV7mfBvUfZ/LnDUBdVNaB5ZphxHHcIL5D1w8Go4wK3Xq88kL/H9euK48gBp+2W9h8mX2JSURRoHWHxv6P8yzEY4ay2JJ3arSBF2HSUL1XSnAviqt3p7LelIKjRcr4hbxRCeAhAlr+XWgjIyxk8qQb3Eko+lD0LpMFcog3wCIZ+CoVIrj4c9xbzPR3NpCRcC0gHhqRKXVKOnxtBxRqkNITeM53gAcCu7RAFofl7O0N8BU0gfHGpy/PhSP6ZxWZKBfRt+y0Ttp6FVvZMe2vl1xeXZVmjNvQNL5hL4dzHaZ+Y4osln5m1mo4MJCHpffHbZDWr9zTbw2QkFiMKhZCtdw6n1jM2MvxO9jcmQwS60Xj9/UUKk+y/x21JlJDAAfeNCzmA5oZgcpN9G18zIQ7RppKvZz4mgApowb9fxfXcuJXPXL3xZ6ReEAKKvFPu+FGcFX1Vig26L2fCCl58W8OD3QWGv38fN1WcGgHN1fmfS47x8HSm/tSf8g8yuyVsCOX1xbdsuP12HIy694VcK/gPASmE3Zhde+5wZPZzY3zrNNUOu1Nol
X-MS-Exchange-AntiSpam-MessageData: wJxeyGUtlOaNFj1l+xCu+MHKQqRC7FaP3XKC+AmuqrXYrtERiA0KYiS4NnNrTNaJ1EBqqAbeQoMKFVVahGsEHs3Uu/7H8oTMjL0x1p64qjW4ytpVhy/Mycz+pXsIO3wrWFp830FxXD2oQRWEtvcX/A==
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3322b76-854b-4e6a-cf86-08d7cd156644
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 21:26:49.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hBeyEtmqW0E4J9KYVekzkBaocV66XOfzX62squCiGNMeoX4KNtHoWFa5Z01UtQYT6yBejqvKdVvRul61wQg4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_1EFDD86F-A006-4BA1-BEB7-2A7C21F79F8E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> Perhaps in your spam folder.
Not in spam/junk folder

> Did you, per chance, receive this reply:
>=20
> =
https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fmarc.i=
nfo%2F%3Fl%3Dlinux-virtualization%26m%3D158403993331603%26w%3D2&amp;data=3D=
02%7C01%7Camakhalov%40vmware.com%7Cd6008c5deddf4d17315b08d7cd13f322%7Cb391=
38ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7C637203357928546249&amp;sdata=3DCrOJ=
hbOoIutstB9FYIvZ9Orrl3Xp3JmZSk%2BM6xODGOk%3D&amp;reserved=3D0
>=20
> ?
Got it from marc.info web page you pointed out. I will address is as =
well.

> Btw, please do not top-post.
>=20
Thanks for the hint.

=E2=80=94Alexey


--Apple-Mail=_1EFDD86F-A006-4BA1-BEB7-2A7C21F79F8E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEQe6bu7hIFElmsM7CGW4w8WwwaSUFAl51NRcACgkQGW4w8Www
aSUKag//eT9aInTo52Tt035lj5HzgBDXq3F+5dtABNpZuSCL0fo3WqwG1TAYPpjC
+5cEmtE6PT/Ax3vRCS1vlpiX8uBiCVHVKFAs/ULe5IZVthsf7KkD3cc11M6dIkRe
DHnvXQo0iGWBaBfLYoxuQbPnmRZ+fBIupbgJikYSLAhF8Y0ZKrgVm5ZF1hyiioJP
WVLDRTlK232KAchFymDtHxEYfrWLjduFeypMIqOBt3doIk6EQIiOzVH+uhhM9XLl
zwz1Yrab4IecqhWljofSZtvMv5W3olWvvDfeeqGArOLXhzU8bNSJB+xBk2oZGiIe
0YdAuItG/UxKWCHHfyrnuA4KNP8EKTdkx/5eSOqCVaKfaTK0Mxs15EIS5B0RpZz6
ZLuiCrYgeiL+hgdIxpxmQFVWqPy9JN/gXI6i6yG14HiPySUlZpidxyoRSZJK32+x
pX81oMH71CPejAGMXWlwmYK3NXWDmqmHkVle2WudtO3fQMU5gVNBR8Q6QuLVNeP4
tHMpNnbj2ymea5I4VThxkZwwUbJNpTyzlmEOmCXL9CPGhk3oQuxaYPaYDOsNyveN
3GgHh9fPOPolAjDflY2hhfS0ukEeuoJ5fbFfnI6U/8quT9yLH9R/FiZnJJBU+6oa
4lxUV7hmYQqCbMJbavmynQP4yRBUlTYUhqoMV38eh2lGmCus3Ug=
=RBwZ
-----END PGP SIGNATURE-----

--Apple-Mail=_1EFDD86F-A006-4BA1-BEB7-2A7C21F79F8E--
