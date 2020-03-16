Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6458AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6EC20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Bf57S5nw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Zdjk1ImK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgCPLWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:22:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53904 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730734AbgCPLWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:22:18 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 60E3443B14;
        Mon, 16 Mar 2020 11:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1584357737; bh=zwcEPQwkn65vGGEclhkCAuf+7QFOR9xXIkQzp3NYels=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Bf57S5nw9oNK5QZOLill+mVuIylXHFZuQ+nGLDfrUivdjz/hwsXyj7z9drCU0eqWw
         bpyJVxi/8Dv4hHTHsghzMvJKaRh/LzODI/X7xmtty6pck2HWlLQXdznHntDCRNHdNI
         IJF/w7+db0SRLFDsACKUQyKxyi4QEtUsZ7YqlEEHHwCkCrimNFhmlmb40wlGPiysa8
         3tivAUm8sg8n6TWecx5vAYU9IimV2hs0x6qa5ar2AVYGEz3H/lPmedo1XC0TdpkbiZ
         cFOl38uc9qNwk+uVCweqzbkMqmjai2IX13+EZ6KTGBj/bKmyWwqcqAPh0vBvw8VXyD
         FL9xM29RzGe0w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EFA42A007A;
        Mon, 16 Mar 2020 11:22:06 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 16 Mar 2020 04:22:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 16 Mar 2020 04:22:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lhq+b3a8WoozFO+L0+JwTI7kfF3UaWN/LuPT8rbXWnZfH++m53IFgazA6chw0bGQkQPDC1ihC2duyNCivJNlXqeYTodT6iUG6heq3A2ujN5gzuIdk6JE+4Z41RewQPGK/FUzhsrRdWtDoDGUG3Z6gANbunyy9TpAeeXBjE8+HbNyl21sGYucgjbB9Cm2JXfnezrtQ2zpc/p+a9r37CSXdPcS5yMfUekWsjn5PiaVBFN5Gr9zJuh3mBurbN9nDfGbUmA/t9+Lo5jZDQjyRCuSrvfv5fxGsWn3EMae1fYWz1Z4v5QmpZQz460rcix3kF5MPNXL7Lxh13dOvKYyzSvo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzoKHLtvndrVAH2je4Q3GcFBAa18kZGtGFU4z/Vqz1Y=;
 b=JWbA/eU+plC/mNGP6wIKW9jYa+kxsvFTekS4xiX/OrbNSrZJ2o6iwnC6lNlI3Av+wJFSqZjAlkz7cr99XWXIrRcRov5yoWxSA42Pi+Bs63aObBfEKLDxhaWRjgBw39E0qkBiK5sCTvHn7mYcqj56NgyCVpBLbo4/UYtjK8MdrbkHGwJKY9hTsVHuNLUI6466ejIUAMLXuLjjFTwBeZqBu9nFKubIAKfQop8j2m9xRYd6ecBFRLHUMS0KLBVjhNHzyj0TzHyYeNcwG6iYBR7C6ut3JbhEW6yo3Chq2DhTWHmbQEUwHeXrIbGbIqa305C2N6d9Is1ijuP+6VE6Msw/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzoKHLtvndrVAH2je4Q3GcFBAa18kZGtGFU4z/Vqz1Y=;
 b=Zdjk1ImKTk5+giuuJC1aZXEqVCoQc0um0YGmKUXEYMEGlrqAGmaM7D1sl/KHdR9EvKWVK12YLwVgT3hG80jeuxItlMDppVEl6dlza8MmzzIK/1+nx67pDcfsi/OLVwC6v4MJaldVwzdMzonaGZ5crVKstXf7SGVzAchqaOGFVXU=
Received: from BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9)
 by BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 11:22:03 +0000
Received: from BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a]) by BY5PR12MB4034.namprd12.prod.outlook.com
 ([fe80::3531:93d8:93db:207a%5]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 11:22:03 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] initramfs: restore default compression behaviour
Thread-Topic: [PATCH] initramfs: restore default compression behaviour
Thread-Index: AQHV948GpjzRGPXRkkaV3g1nK8etBKhD06gAgAdDK4g=
Date:   Mon, 16 Mar 2020 11:22:03 +0000
Message-ID: <BY5PR12MB4034829B9DC8EC77C5164439DEF90@BY5PR12MB4034.namprd12.prod.outlook.com>
References: <20200311102217.25170-1-Eugeniy.Paltsev@synopsys.com>,<CAK7LNARSNBOMK9+s9pmVsVtnzr2qqFxHNr+GhJd_BnbgNW4SSQ@mail.gmail.com>
In-Reply-To: <CAK7LNARSNBOMK9+s9pmVsVtnzr2qqFxHNr+GhJd_BnbgNW4SSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paltsev@synopsys.com; 
x-originating-ip: [84.204.78.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ad9ce92-b82a-4315-2352-08d7c99c409e
x-ms-traffictypediagnostic: BY5PR12MB3763:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3763E626E99F9C2C61507833DEF90@BY5PR12MB3763.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(66476007)(64756008)(66446008)(66556008)(9686003)(55016002)(71200400001)(26005)(66946007)(186003)(316002)(6916009)(52536014)(33656002)(2906002)(54906003)(5660300002)(76116006)(91956017)(478600001)(4326008)(8936002)(81156014)(107886003)(7696005)(86362001)(6506007)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR12MB3763;H:BY5PR12MB4034.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ECtIJURypmmvOA91LpKOzKLZkhzHIPrC/lxZxc0hqm4B8wX6TyThWvkWcgzm7e1NoJw5GtiNbUM3vEgPR0nXA1CYmyjjvixf5EIKwjEqBWBCEZl1T7QeHp6DACxMZaOMQrvyIJhvtx+YMJKpBAzhroG2N5f1dtrzGPRKiyvktRKlEkSs7wxMHN6cFPTvnohaefmy+ObqgcMt6MN63Zn201aRgYRFEus5WlIRaxVBdYtzhDz4MANnV+MNeYL9Q3YoMk63cBGI0TLWFWx93l5tVyxKAa6CrBjfO6ukH4T+pSiAnqG47fs9Qqp1Ydw5aObbcWPDDClvVOOOO6nBt9z7LX2eA8dMLBpXvCmRXeA0NZLpgHoMO06tH6o9SyWXt7lwMo0hr2BqgCyN9mUGaE808wTBzXojgmqwcUlztHfxXF1F7+R59uqiNeaIPpTYrWj
x-ms-exchange-antispam-messagedata: bNCyqHWa78at3y0NpEpDnbMrIG02iYn7jnOTfrROFe6FtqYUZH1pK77G6xnvvTV0Im7y9kB87L/ny/Ftq0ubjWrouDHxLMni1nHv/zB9TvpiTk4toh98cNmxXVqGVD9b9kbGkKofwxkAySu1jrtRPg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad9ce92-b82a-4315-2352-08d7c99c409e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 11:22:03.0519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Xd6+EZ8PuQjj/bcXqgmXNmuKqSOYa9Ov5l9og94avanqGmce3H20+LNC0DbmtwdmaTDum5UFUlanr0iYFUi5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3763
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,=0A=
=0A=
>From: Masahiro Yamada <masahiroy@kernel.org>=0A=
>Sent: Wednesday, March 11, 2020 23:12=0A=
>To: Eugeniy Paltsev=0A=
>Cc: Linux Kernel Mailing List; arcml; Vineet Gupta; Alexey Brodkin=0A=
>Subject: Re: [PATCH] initramfs: restore default compression behaviour=0A=
>=0A=
>Hi Eugeniy.=0A=
>=0A=
>On Wed, Mar 11, 2020 at 7:22 PM Eugeniy Paltsev=0A=
><Eugeniy.Paltsev@synopsys.com> wrote:=0A=
>>=0A=
>> Even though INITRAMFS_SOURCE kconfig option isn't set in most of=0A=
>> defconfigs it is used (set) extensively by various build systems.=0A=
>> Commit f26661e12765 ("initramfs: make initramfs compression choice=0A=
>> non-optional") has changed default compression mode. Previously we=0A=
>> compress initramfs using available compression algorithm. Now=0A=
>> we don't use any compression at all by default.=0A=
>> It significantly increases the image size in case of build system=0A=
>> chooses embedded initramfs. Initially I faced with this issue while=0A=
>> using buildroot.=0A=
>>=0A=
>> As of today it's not possible to set preferred compression mode=0A=
>> in target defconfig as this option depends on INITRAMFS_SOURCE=0A=
>> being set.=0A=
>> Modification of build systems doesn't look like good option in this=0A=
>> case as it requires to check against kernel version when setting=0A=
>> compression mode. The reason for this is that kconfig options=0A=
>> describing compression mode was renamed (in same patch series)=0A=
>=0A=
>Which commit?=0A=
>=0A=
>I do not remember the renaming of kconfig options=0A=
>with this regard.=0A=
=0A=
Ok, I've checked it again - looks like I was confused a bit by=0A=
"CONFIG_INITRAMFS_COMPRESSION" option=0A=
as in v5.5 kernel I have in ".config":=0A=
CONFIG_INITRAMFS_COMPRESSION=3D".gz"=0A=
=0A=
And for v5.6-rc1 I have in ".config":=0A=
CONFIG_INITRAMFS_COMPRESSION_GZIP=3Dy=0A=
=0A=
But they are different options actually...=0A=
=0A=
>=0A=
>> so=0A=
>> we are not able to simply enable one option for old and new kernels.=0A=
>>=0A=
>> Given that I propose to use GZIP as default here instead of NO=0A=
>> compression. It should be used only when available but given that=0A=
>> gzip is enabled by default it looks like good enough choice.=0A=
>=0A=
>=0A=
>Another solution would be to move=0A=
>INITRAMFS_COMPRESSION_NONE to the end of the choice menu.=0A=
>=0A=
>The default of the choice menu is the first visible entry.=0A=
>=0A=
>GZIP if RD_GZIP is defined, BZIP2 if RD_BZIP2 is defined ...=0A=
=0A=
Thanks for advice. It looks like an excellent option here, I'll send a patc=
h.=0A=
=0A=
>=0A=
>> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
>> ---=0A=
>>  usr/Kconfig | 1 +=0A=
>>  1 file changed, 1 insertion(+)=0A=
>>=0A=
>> diff --git a/usr/Kconfig b/usr/Kconfig=0A=
>> index bdf5bbd40727..690ef9020819 100644=0A=
>> --- a/usr/Kconfig=0A=
>> +++ b/usr/Kconfig=0A=
>> @@ -102,6 +102,7 @@ config RD_LZ4=0A=
>>=0A=
>>  choice=0A=
>>         prompt "Built-in initramfs compression mode"=0A=
>> +       default INITRAMFS_COMPRESSION_GZIP if RD_GZIP=0A=
>>         depends on INITRAMFS_SOURCE !=3D ""=0A=
>>         help=0A=
>>           This option allows you to decide by which algorithm the builti=
n=0A=
>> --=0A=
>> 2.21.1=0A=
>>=0A=
>--=0A=
>Best Regards=0A=
>Masahiro Yamada=
