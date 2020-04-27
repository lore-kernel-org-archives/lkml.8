Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D832C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C2B206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vSxhniTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgD0OW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:22:26 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:3433
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgD0OWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:22:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0d7KMIbxnjO+NZ7zh9797kdNzaJXpwS5xRbi2vp2GBdIhvFWEnMykij9Dn+7q83cJFG88OSHD2f0hck1REY2eSS764DCbRLzRt4gRJ7pc9IEGRJuUGUr4+zt8Pzsw7lrVKVAOaww31NZXm+gOMfNlFpQqXY7O14JKHVZkacKDxF2Sy4n7VI+tPSBfHHVHub3ByJjmLPfrVhcbQG0EWSNas42fXFomRP6Zd/fJJwTX0g7SxIVDGxt4uCdfrantib2onGcyUu9vbJkjdSHc+5psry4kxmNb1LvVSwx9wrDt4ffepe0uNdyGyAhRxJ7f9EnI8axmiIipIij2kkkhAnIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcHN2L0hBWiTwm0Xc7ioTkMoL6EXvWo5KzdGeDDSw24=;
 b=SS990FMAMRdnCtZXws/b+AMR3kCHK4/JRSyT2KeQzvsVVSGrSun0GsW4/e2vQn0OALv3tHMXp0Ps64JTTOme2Ktalp87Ju1PWigGfdfAQ1XJpbV3Hfd40sspE9bKQ0Y3XKDGhXQUFko2deyxuyDY+Mdj5Ar11FIHn/DudLDTtL4HDnuwoznCpafFJpeZo1c65I0nyY5fmw8wUFSR3Q3QyUha5bgAQok1RQoBZzOL8L7mWq3WySOqVTCVnietm2R21fueti6BP2G3dp3d2A3XRTTAFWdIFvZ5fryKALTd5Ke2ccSFGOhf7h6e+Os/i5wrptZJYeEl5NTJonVmMWDNtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcHN2L0hBWiTwm0Xc7ioTkMoL6EXvWo5KzdGeDDSw24=;
 b=vSxhniTYH3DJlraZWicYI5G3wBHgcHx1g8b34KsHi7tIWzxrjeIFKiaJHf8iL8vD/NoZRBXzIgg6lD1m81h7FucQambhLOJTUIbx13qIPrFqut5fWKtPYS49d5iLsASVe4Ubf6QANaKtDAKn5CYTEn+T1PdXeMnZAvoyQIHEik4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3421.namprd12.prod.outlook.com (2603:10b6:208:cd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 14:22:22 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::9dee:2a71:22d6:2941%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 14:22:22 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Lukas Wunner <lukas@wunner.de>
CC:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>
Subject: RE: [PATCH 0/1] Fiji GPU audio register timeout when in BACO state
Thread-Topic: [PATCH 0/1] Fiji GPU audio register timeout when in BACO state
Thread-Index: AQHWG+QP7B2I84lvqkerLlrYwJ82raiNBPhQ
Date:   Mon, 27 Apr 2020 14:22:21 +0000
Message-ID: <MN2PR12MB4488E4909C1488FB507E0BF5F7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <PSXP216MB0438D2AF96CE0D4F83F48C4D80AE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB0438D2AF96CE0D4F83F48C4D80AE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-04-27T14:18:09Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=eed96705-c57d-432e-975b-0000e93b92ee;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-04-27T14:22:19Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 301e4f8e-f205-44f9-8289-00005f9729ad
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.72.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f0fb6e4-e621-4cbf-ea92-08d7eab66674
x-ms-traffictypediagnostic: MN2PR12MB3421:|MN2PR12MB3421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3421EA05CAD05C6133C2E01DF7AF0@MN2PR12MB3421.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(45080400002)(186003)(66946007)(52536014)(8676002)(81156014)(6506007)(53546011)(316002)(54906003)(71200400001)(66476007)(110136005)(64756008)(66556008)(478600001)(66446008)(76116006)(86362001)(7696005)(8936002)(26005)(4326008)(2906002)(33656002)(55016002)(5660300002)(9686003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uvc1Yx907NFSQVqgmuc/qAu9Zascsan2M4ZQ/uRlEXT4MAdLZEwD7AiNLv6meCN+qRHbnKMVfhMR7K6dwDuXpUujMymkVZq8tt/do1cCmKKvLYKKyrWTynvEQCaAhOgvlTSxI8YdFGoielks6udWYamLlJmfoOO4qQ/FwoXjauKzFsqXTUUMUdUtJ43ArOfShQAU8aUCNJ5IpVDNFTRiwjIMRlI1M4vLWOvo4n2TjNR9EjlFcAz7Dx5jS40dsVpbkkGmHnbd/3Lw71YPYAPlRRm+5GLyuwxm52lZOe/CAiCBkx4g0AnqSTRwBdjAabnG7PNT0HE0g0M8bj2DNURyY81tALbCjsIvWfZqNG8wmichskhNcSkR2BsicTuTapIcto4mV5oq00bqRcXo37VDiDqCpKkCnFnAVAj+9/Osa94UQZFQhpnc1rILE1J9hC5K
x-ms-exchange-antispam-messagedata: kI3Kc57rhRjGNs8bSzew54vVqxzLROfbEMTXhK6DE2jFSKl7fPoMkaw2/Nci12286uAGYcK2/CAn4RLmlv7cnXiCHSWtUUiTJe//mG9DkQND8aj2hFhBCkd8lLtvqYp4SCUq+H+Nyoec6moOmROyPCY4OIZFXZ2KmM+kXXDZuEhL8d25PPD6x/gQpMshO6knuB/NwVSfPOi3aoa5KaxoDA0fxqzDVEbYlIbPIOqjm/sABdDIp4T9UkPYMqJT+C/4diPY056zoUZA1jDnpyv7yuad3xkykQ/1Fsb8xqKzC8YXnZk6tfvgqo0JY854OiMFklCxmsDZUW3u9opr0w6wk+4JjZDd85kdR0mpTb3Yc6YeZEXvwMQHKIvlfzxOLwRNVzdMRkkQ2mVjtjzC0u4VFzXupyoDuB5FsVHRwKxF+K+TRAQ3OePNCRayiPcOCIZc643Jwe7L+4o5bzyG+9gJCRrsiKKmj719bU/oeVePfCqyb47Nb36XqoWC87xSDY5ZnAm8vGcYVaEEXH5k3bymv+WLecgbq4FPLiZeLRVQX77qo+KtEfRPXICsg845LgNg7BTpIqRx0FG7HsmoetWs01YdlAdhJ6u0yJjfT7se2aYz+FwMw4rVyIsrfUIkzMuDVki8SHo4gVQWyQDFlL6mXH2WU2tg+VILUHmIDcumFtCWRi3AhTKS0/wAiF2nj7Pud91ZAWQsic46fN4qCw/aMqwYVRWgQ9qfTKVmv7KtvFqRWQ7Gm1hIwA+zA3XGhWWvKINQ3rT8n7kL/b0aA87k9KraFYfSNFM9XV++TUwU5nA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0fb6e4-e621-4cbf-ea92-08d7eab66674
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 14:22:21.8825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5K2Mk43z7vfkBwylTgChp11H4ILIzxjw1X3rbBiXwER3UtWUi6oI6yjOy51O6X5h7kTJuCtVKMQMcr3b87BX0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> Sent: Sunday, April 26, 2020 12:02 PM
> To: linux-kernel@vger.kernel.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> <David1.Zhou@amd.com>; Nicholas Johnson <nicholas.johnson-
> opensource@outlook.com.au>
> Subject: [PATCH 0/1] Fiji GPU audio register timeout when in BACO state
>=20
> Hi all,
>=20
> Since Linux v5.7-rc1 / commit 4fdda2e66de0 ("drm/amdgpu/runpm: enable
> runpm on baco capable VI+ asics"), my AMD R9 Nano has been using runpm /
> BACO. You can tell visually when it sleeps, because the fan on the graphi=
cs
> card is switched off to save power. It did not spin down the fan in v5.6.=
x.
>=20
> This is great (I love it), except that when it is sleeping, the PCIe audi=
o function
> of the GPU has issues if anything tries to access it. You get dmesg error=
s such
> as these:
>=20
> snd_hda_intel 0000:08:00.1: spurious response 0x0:0x0, last cmd=3D0x17050=
0
> snd_hda_intel 0000:08:00.1: azx_get_response timeout, switching to pollin=
g
> mode: last cmd=3D0x001f0500 snd_hda_intel 0000:08:00.1: No response from
> codec, disabling MSI: last cmd=3D0x001f0500 snd_hda_intel 0000:08:00.1: N=
o
> response from codec, resetting bus: last cmd=3D0x001f0500
> snd_hda_codec_hdmi hdaudioC1D0: Unable to sync register 0x2f0d00. -11
>=20
> The above is with the Fiji XT GPU at 0000:08:00.0 in a Thunderbolt enclos=
ure
> (not that Thunderbolt should affect it, but I feel I should mention it ju=
st in
> case). I dropped a lot of duplicate dmesg lines, as some of them repeated=
 a
> lot of times before the driver gave up.
>=20
> I offer this patch to disable runpm for Fiji while a fix is found, if you=
 decide
> that is the best approach. Regardless, I will gladly test any patches you=
 come
> up with instead and confirm that the above issue has been fixed.
>=20
> I cannot tell if any other GPUs are affected. The only other cards to whi=
ch I
> have access are a couple of AMD R9 280X (Tahiti XT), which use radeon dri=
ver
> instead of amdgpu driver.

Adding a few more people.  Do you know what is accessing the audio?  The au=
dio should have a dependency on the GPU device.  The GPU won't enter runtim=
e pm until the audio has entered runtime pm and vice versa on resume. Pleas=
e attach a copy of your dmesg output and lspci output.

Alex
