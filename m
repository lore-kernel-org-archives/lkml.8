Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE91C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9558E206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="J8O1ie20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgGQJIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:08:02 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com ([40.107.220.81]:17264
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbgGQJIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:08:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERazna1vbeM6nNJWh+M2rA/IUQR75e/uwfv4UHSkI6g0cuJxaPJn+GLYe4dBmvrmF1Y/CRUyQ34GmOVpvwvE4xQZnqykejgeorNnqTyFbVqNsp0DKbBmtHV7+WgthGmjaQEu7mClejjMdFxmus+BHS9jiaH4DIh+1L3RKgHamLrKo4aldnGsgEjzax+bbi04H4U1Zisk1Z0mfz3+F1jJZPm0Dn+SLXkZtNTAPfgS+hz2Ot743AUi+bDli94wOZhAukCqF42cRUxAUc63ZiWr12Y7Bukgt4Fzcy7dNTqLN+F75PG73aI2goNUvliswka3s+9Fp+0CKtivZb7a/di+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G8RBIoi+KO5Wtohuuz1YEjANZQasLr63vrMBOOlC1w=;
 b=Rcx7LMYr10Qst+QrvOjnZPIKEjK6XG6E2poY25CtRv3ojDS2jej8LiAh492xdXcFuWWyS8zB1dnq1jGi+oqSgxxg+5PIB9QvqULVHtj2DMHYBlA82oNCaXugJ9DzZLz0n43LkRQjSUIYrQzXrTKim9N5u1RF1GIq7fNDEFJMCkiehdTyUS12pUcVc/8uPSoWccC2oVGANx80Da3GXIfeBxkZzl2VayQy7oy9B/20RBu/yzb3sLc81DdlKh3xRzMtN1/xkSl8LoRlZ/74vbyNoIo8tYmdDR+MmmRXjHRIMXwaEVDOz+knuQZmZ9+g/U+Gg5Jc7BHtKcFQxgn7sLucgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G8RBIoi+KO5Wtohuuz1YEjANZQasLr63vrMBOOlC1w=;
 b=J8O1ie20SwtNdwUeHJhxOEJvQO8wGHW1ldD3gfNhuRRk0m/U2BzBc8weHKYFcVWaj7vqq0GK1BRotPoICNR8eonIF0e0LSlnp5ER/sRZ4QgmrXOyxlW80oeR19cqKphWYcPQbuT6K+Bxs6ul2HOyxHv9tjFO9bCGJTsTZ5p+oSk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.23; Fri, 17 Jul 2020 09:07:57 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 09:07:57 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Qiu Wenbo <qiuwenbo@phytium.com.cn>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chen Wandun <chenwandun@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, yu kuai <yukuai3@huawei.com>,
        "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/powerplay: fix a crash when overclocking Vega M
Thread-Topic: [PATCH] drm/amd/powerplay: fix a crash when overclocking Vega M
Thread-Index: AQHWXAlk403P8m37e0Sx+6uNQ9W+lakLeyoQ
Date:   Fri, 17 Jul 2020 09:07:57 +0000
Message-ID: <DM6PR12MB2619F923B2D2930E3DB71A6DE47C0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200717070958.41489-1-qiuwenbo@phytium.com.cn>
In-Reply-To: <20200717070958.41489-1-qiuwenbo@phytium.com.cn>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a04cbc03-2e10-4977-9ceb-3be8afcc5ca2;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only -
 Unrestricted;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-17T09:06:56Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: phytium.com.cn; dkim=none (message not signed)
 header.d=none;phytium.com.cn; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 375e1b5e-b9a9-40d6-b93a-08d82a30e5c8
x-ms-traffictypediagnostic: DM5PR12MB1163:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1163F2A7DF2E7569384899F1E47C0@DM5PR12MB1163.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tXJrF0wrA7nOYclTKkNJGBguM5B3T03YHbo2YtKRi5SFzXdjRoeQbN6Xow66rmT9GX78ZaEXw/aEMEtSNwtD5fJTpoZzspv23TZeqLwWNmM3aAz4RUtaINV1WAmZ8wCxxJsJYe4xmWgHFNLYU7Mn7108WyTzUF0LkhPFvmdmwU7NCCUq/Bu91IUtejxOGOPkhZygz0XoABOyeVXfNYmJN937IFYb1btbZcNNKT0h2r/hVdLkAJZNAkoKmx1aIGwTX5kpdkaPy8TEp/STtr4IKfGmoO4CxYVm1pNp9WJ3SqXqjIuhKzVT0m8Cp1rGxQcOloTDnQJdaQRpU25QaKWQ0dYI159L3mLFh+fz5I2fI1bZYzzN7TqgIss2msaFFI5WNPwTaT0+vHkPmh9z2UKYoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(110136005)(316002)(66446008)(64756008)(66946007)(478600001)(6506007)(66476007)(76116006)(66556008)(83380400001)(26005)(53546011)(86362001)(2906002)(186003)(7696005)(71200400001)(33656002)(8936002)(55016002)(966005)(8676002)(52536014)(4326008)(45080400002)(54906003)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AsnPvOW0Jt5RINc8ns473BWqoEXUXZvcuUBFvMs3t+C0EdFLidfsosKfpbN7CNbK2gqkJ1YFASxhnYckbhfx0x6QXodq3va0M7kGshCWL/UiEEhM69Sig9aWlFElMZ5SgsJYG8WSyp9edCm526Xkq9xptal3PI6rZ7JAdjqewvTOy7fkrXtytKumNBDOKIMTe0vgQNzUx/XBziXbp0WfJy1N1+az0EKXPW+r9wtbXj+HZo6E4wmtAAx8KlxtEyqvxnUnrzbdWuZDY8RLntUhlu99WPdcATIRRieXdEi+3vUBMVA0f8ms1QUF8cV13Fnv7IhU3LBEGXku3Pzf8Gpgo97FkBhvufurwLbwGAJuyUfl/gUQPE1uVrdkFPdVnmrqiEr20zl/Mm0AVYaM8LjXbTR/Zi8bObWoU6JvQq4M773c5JV7uZOTzZz5bRyOPj3aBvw0lDCrzGFPjPU/IPHb1A8ZncZsVO2SkcCnET62fsx80N+g8dgCJmkrGHkNQ29y
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375e1b5e-b9a9-40d6-b93a-08d82a30e5c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 09:07:57.1810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwXS7ntrVltgITuFUUKkCV4Gv/BggUE+c+oFj9mm4T7TUyabxgJCtPqY1zLDNmT3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Qiu Wenbo <qiuwenbo@phytium.com.cn>
Sent: Friday, July 17, 2020 3:10 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Qiu Wenbo <qiuwenbo@phytium.com.cn>; Deucher, Alexander <Alexander.Deuc=
her@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Zhou, David(Chu=
nMing) <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>; Daniel Vette=
r <daniel@ffwll.ch>; Chen Wandun <chenwandun@huawei.com>; YueHaibing <yueha=
ibing@huawei.com>; yu kuai <yukuai3@huawei.com>; Huang, JinHuiEric <JinHuiE=
ric.Huang@amd.com>; dri-devel@lists.freedesktop.org; linux-kernel@vger.kern=
el.org
Subject: [PATCH] drm/amd/powerplay: fix a crash when overclocking Vega M

Avoid kernel crash when vddci_control is SMU7_VOLTAGE_CONTROL_NONE and
vddci_voltage_table is empty. It has been tested on Intel Hades Canyon
(i7-8809G).

Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu=
gzilla.kernel.org%2Fshow_bug.cgi%3Fid%3D208489&amp;data=3D02%7C01%7Cevan.qu=
an%40amd.com%7Cff6bf841473b46539e1708d82a20723d%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637305666456662890&amp;sdata=3D%2FMXKE9MMkUF2JPR3JiCTNdgA=
yyRnQXkxpZfS9eTPrW8%3D&amp;reserved=3D0
Fixes: ac7822b0026f ("drm/amd/powerplay: add smumgr support for VEGAM (v2)"=
)
Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
---
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/=
gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 3da71a088b92..0ecc18b55ffb 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -644,9 +644,6 @@ static int vegam_get_dependency_volt_by_clk(struct pp_h=
wmgr *hwmgr,

 /* sclk is bigger than max sclk in the dependence table */
 *voltage |=3D (dep_table->entries[i - 1].vddc * VOLTAGE_SCALE) << VDDC_SHI=
FT;
-vddci =3D phm_find_closest_vddci(&(data->vddci_voltage_table),
-(dep_table->entries[i - 1].vddc -
-(uint16_t)VDDC_VDDCI_DELTA));

 if (SMU7_VOLTAGE_CONTROL_NONE =3D=3D data->vddci_control)
 *voltage |=3D (data->vbios_boot_state.vddci_bootup_value *
@@ -654,8 +651,13 @@ static int vegam_get_dependency_volt_by_clk(struct pp_=
hwmgr *hwmgr,
 else if (dep_table->entries[i - 1].vddci)
 *voltage |=3D (dep_table->entries[i - 1].vddci *
 VOLTAGE_SCALE) << VDDC_SHIFT;
-else
+else {
+vddci =3D phm_find_closest_vddci(&(data->vddci_voltage_table),
+(dep_table->entries[i - 1].vddc -
+(uint16_t)VDDC_VDDCI_DELTA));
+
 *voltage |=3D (vddci * VOLTAGE_SCALE) << VDDCI_SHIFT;
+}

 if (SMU7_VOLTAGE_CONTROL_NONE =3D=3D data->mvdd_control)
 *mvdd =3D data->vbios_boot_state.mvdd_bootup_value * VOLTAGE_SCALE;
--
2.27.0

