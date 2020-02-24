Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C78EC35677
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 571572067D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 03:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="njT8+Bu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgBXDWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 22:22:10 -0500
Received: from mail-dm6nam12on2078.outbound.protection.outlook.com ([40.107.243.78]:6031
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727156AbgBXDWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 22:22:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfq5Lmt4VV1yKsLAiZUND3zBRZx9lI2JgzRS1VBSTpBSpfKqRwPZSG/bsYAfry6rBBRIf54YxHfoCKU62nEySGxsdk1G7vjfg1sTYjJnjzCaZn71fsCVEr8bRAkf+KaWtKIrqGOok+dLrV5nEWOxnq74HKLo9NsBEm/T8p4PzLwg78m9IVt1SRnljTc0MxIcirHcVN+SrPcvr9snvsZc89R5OInjpYGKJFdLWWa9q0RAj6EDZ+j56P0jdECiypRXameK10oIZWkfIR2t7ZukeDmopGygIWwhOyXcqCZkyLHTEiH5pjkv7U0T2tNI4s2TmQ4gujYb3MSv1SZwhpJJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYiK360nRyA7aqtzCF9gPYS3mFfa9ATdkvebWnxZjzk=;
 b=cOtLgeuq2b1ZWJkPeCnKMhDY/laClEu9HkRcSAPNpseMMODhUjML8xI+N+ZAzl5D1wGq8KFY3k0i93YDTmAaVr5pLEa6MyqlGkvLLuKvml6NgucRiNK72MiIuVhMxZr8GGe+ig3o5Ry6ciZyBiR1ILPcM/ClthCDpe9ml3cxvZhr4uW3WY/luP+cJuPBF1y8OMeVBAzmyJhNNuJjd2mw7y2N48mOXbZ2pWHFQJQB+w96ON2Rq5YqzEOwTlr3FB1HmN7GSHB0U/5ifer1IwnWQQjau8FmmPWnJ6LjvoLeCg/3aw9QbY1TTBPrNeMreZItD3U7ICPjBh12AiwpGbLx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYiK360nRyA7aqtzCF9gPYS3mFfa9ATdkvebWnxZjzk=;
 b=njT8+Bu9Lsn4NFlnKqzQGqud5xDYy15TxMV0h9bhC+jDWvwTAXUbjZG9l3NBHO50kk21YMpvm10VcfbWyfnJJMeyZJez5AgzKtCI4WUXUIKRml1hqBcVtLW4af9wLRCK8XJCUA74hT4Jxb44liK9/p6h/KHMsqzif11tqxra3do=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3805.namprd12.prod.outlook.com (2603:10b6:208:15a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 03:21:49 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2729.033; Mon, 24 Feb 2020
 03:21:49 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Chen Zhou <chenzhou10@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
CC:     "Feng, Kenneth" <Kenneth.Feng@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] drm/amd/powerplay: Use bitwise instead of
 arithmetic operator for flags
Thread-Topic: [PATCH -next] drm/amd/powerplay: Use bitwise instead of
 arithmetic operator for flags
Thread-Index: AQHV6LJreIpz8B8T80OFeSAr9vQubqgpsZ2w
Date:   Mon, 24 Feb 2020 03:21:49 +0000
Message-ID: <MN2PR12MB33447575BAF26E919965AB5CE4EC0@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200221122139.148664-1-chenzhou10@huawei.com>
In-Reply-To: <20200221122139.148664-1-chenzhou10@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5cc58c55-68c2-4342-86f5-000040c15cb1;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only -
 Unrestricted;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-24T03:21:30Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b553474c-0bda-4a81-fb1b-08d7b8d8af6f
x-ms-traffictypediagnostic: MN2PR12MB3805:|MN2PR12MB3805:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB38056BEE928F8768BB4F34C8E4EC0@MN2PR12MB3805.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(33656002)(4326008)(81156014)(8676002)(186003)(6506007)(53546011)(7696005)(86362001)(26005)(81166006)(8936002)(66476007)(66446008)(64756008)(76116006)(66946007)(66556008)(52536014)(5660300002)(110136005)(54906003)(55016002)(9686003)(478600001)(2906002)(71200400001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3805;H:MN2PR12MB3344.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Qx5shFwmHgQHVt0kQxKy9JULCvq2Cq4cJKr6Xuwk2zex+b1bmFM6SoAuCnjT8kZ6AVGegGdUmurBJTe3H6J0Lu8eUyklYOl17JzNZ/JON+wDu7QPDNSayRTcinfYTjGDAh6I3NF99dcUy4jVRhX6CIxU59WdPj4zRSNjmROEuaweeYcyup3OkxoK/fV5cS64ssGZ+0nOpWfd/1Uqi18i6l/cs3Zm64D8iRUQETAFU48fdtTN+g2oIC8kF83gWA370kpv94/SN6luR7Fh1eVOSk6ZM89sRPqSk0Qs6BBpAqUAVJAUI+aEQtLYpncaBq/tKVJqSS4V5tJvGR207FIi/pTfBG9nq8leckkn0YyRvbYqdB6BWXpeKlQMwbQkYdre88tKRrZ/11LoYNzREfBRiiAm1TPpK8T8yGkKkrrNf617BWqtLRpDS/6twHu3pJi
x-ms-exchange-antispam-messagedata: 8mP70oeWnmlNrp08F9V4w6pjW+hKF/Obww2tMqJltb7TsTYm56CGAIXjkIa4GYTeBYp7ECKbw7X/zeWGBs9E+knbqGJfIjA24/pNzuPaWgXBgi9Td0lKnANadS3imScMdIJK1UouvvgnWMWtMI2LYw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b553474c-0bda-4a81-fb1b-08d7b8d8af6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 03:21:49.1363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9WypD+Ky7YGYBWqfdCeEFJHZUvBTuFadsQ9AqbSzl8fcrvspwMueCtGUN4nRdEx1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Chen Zhou <chenzhou10@huawei.com>=20
Sent: Friday, February 21, 2020 8:22 PM
To: Quan, Evan <Evan.Quan@amd.com>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(ChunMing=
) <David1.Zhou@amd.com>; airlied@linux.ie; daniel@ffwll.ch
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org; dr=
i-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; chenzhou10@hua=
wei.com
Subject: [PATCH -next] drm/amd/powerplay: Use bitwise instead of arithmetic=
 operator for flags

This silences the following coccinelle warning:

"WARNING: sum of probable bitmasks, consider |"

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/g=
pu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
index 92a65e3d..f29f95b 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
@@ -3382,7 +3382,7 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_l=
evels(
 	}
=20
 	if (data->need_update_dpm_table &
-			(DPMTABLE_OD_UPDATE_SCLK + DPMTABLE_UPDATE_SCLK + DPMTABLE_UPDATE_SOCCL=
K)) {
+			(DPMTABLE_OD_UPDATE_SCLK | DPMTABLE_UPDATE_SCLK |=20
+DPMTABLE_UPDATE_SOCCLK)) {
 		result =3D vega10_populate_all_graphic_levels(hwmgr);
 		PP_ASSERT_WITH_CODE((0 =3D=3D result),
 				"Failed to populate SCLK during PopulateNewDPMClocksStates Function!",=
 @@ -3390,7 +3390,7 @@ static int vega10_populate_and_upload_sclk_mclk_dpm_=
levels(
 	}
=20
 	if (data->need_update_dpm_table &
-			(DPMTABLE_OD_UPDATE_MCLK + DPMTABLE_UPDATE_MCLK)) {
+			(DPMTABLE_OD_UPDATE_MCLK | DPMTABLE_UPDATE_MCLK)) {
 		result =3D vega10_populate_all_memory_levels(hwmgr);
 		PP_ASSERT_WITH_CODE((0 =3D=3D result),
 				"Failed to populate MCLK during PopulateNewDPMClocksStates Function!",
--
2.7.4

