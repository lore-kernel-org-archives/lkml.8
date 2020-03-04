Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AF3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ACD20CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bhceVxNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbgCDDeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:34:13 -0500
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:6172
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387650AbgCDDeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:34:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kgz7EgdnhsWcIq3+zxoqjFXD8SEACQJ1yLFIDsH7UuWnTp5WIO+zqggS0K3GkD6KKEkmd/P81SMrEk+0yFRyncvFq/3uTtFP4vdAlX57v4birvRUCj+j5eFvIvVMIIxNvqP7ShQRRn5VwVQRUCRJ3ylMWzHd6xVu03/Z2Ght/lYG+4y+DMn4FbwxtpH5TSJYGlVeKxKo2B7diaSePSKkuL3PQQ5GNGze5HswIzdj6SnFjnvslyvRI19Aa9UyC4+MR/q+/xMpaPkM8o1Qjb4Ukz0R+MLnfUqL57GDZrE27xn8BsCzrcoNhiXCtDVQL/o2aIjH4WoPl/t3351Qg+YrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FWzA5bG6YrUh/CSvTTgQ0sOabfdKh2/e1flhOp4WUM=;
 b=HNqaJyzXtgSgzeXdKnWtgqQ0rBAoJP/ys+aTncyODPxHBbTbHjwFzbOH9C0dyK4WLp2t8aH+EnB8W/nHurZOepnBiUzW3oFfcRsa6XLde1tnlBrpIc0+pohtS1WClLideHkfaAFAz+NdZeA5QGllDkNZnr8I47r8GzpQs2m+9LX2ZHXWYY8Nyj7puQ1bwy/KB/ivad9uZh+MPegeP5oVm369qqWhHHNffAvnwtJ6r05q0UW8wcbt5kINhwDMdxQYA2jTkrloJZ8IU2kllVvjRAlvnaO/qSSqO3BuPpAS8x/pYi0kYyJuN5fPKw/b7M4Z/8jJPcZ22xh2iQvV6/jGfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/FWzA5bG6YrUh/CSvTTgQ0sOabfdKh2/e1flhOp4WUM=;
 b=bhceVxNexf+MLMGebTjKUxL9wiVQvf0BuGNs7ppQQCnP0bliSNZUUMRmXVMoQjkjVwDrF4g+RPIqSFe5KpT2APP7d6fgXHZtrbFrVaisfgTn0D8ghyhiN0KS+Fy6W4xC3BHYhNFhkGPQQ9A887K1+lTfYYEUJUOzd4x7ax/+Nas=
Received: from DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20)
 by DM6PR12MB3419.namprd12.prod.outlook.com (2603:10b6:5:3c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Wed, 4 Mar
 2020 03:34:09 +0000
Received: from DM6PR12MB4331.namprd12.prod.outlook.com
 ([fe80::21ec:b3dd:e820:bdf2]) by DM6PR12MB4331.namprd12.prod.outlook.com
 ([fe80::21ec:b3dd:e820:bdf2%7]) with mapi id 15.20.2772.019; Wed, 4 Mar 2020
 03:34:09 +0000
From:   "Mancini, Jason" <Jason.Mancini@amd.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: v5.5-rc1 and beyond insta-kills some Comcast wifi routers
Thread-Topic: v5.5-rc1 and beyond insta-kills some Comcast wifi routers
Thread-Index: AQHV8dW3tmU1vr37+0CwhBbrs7FcuQ==
Date:   Wed, 4 Mar 2020 03:34:09 +0000
Message-ID: <DM6PR12MB4331FD3C4EF86E6AF2B3EBC7E5E50@DM6PR12MB4331.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-04T03:34:12.510Z;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jason.Mancini@amd.com; 
x-originating-ip: [24.5.141.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4619fb1b-845e-4085-592e-08d7bfece6a2
x-ms-traffictypediagnostic: DM6PR12MB3419:
x-microsoft-antispam-prvs: <DM6PR12MB3419BC66D42686997A468BE5E5E50@DM6PR12MB3419.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(66574012)(86362001)(5660300002)(478600001)(316002)(81156014)(8676002)(81166006)(6916009)(52536014)(2906002)(8936002)(76116006)(64756008)(7696005)(9686003)(91956017)(66446008)(66476007)(66556008)(33656002)(186003)(6506007)(55016002)(26005)(66946007)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3419;H:DM6PR12MB4331.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3P4FFdWPobx0ry7LqIWJowAjfx0GsrUJZrbFwApkxcYX7er3SUBol84QwRlJuUxsgOYVBc25o/iSqRjdeZK4q/ICR/WWpke981maqoKZ938KudQVQwhf9ODoDcN4e7px7aIRfLoo0E/kU6Daoy/t2Bp1yXY9+I8A4TRFTwy/vdWDyEL0XL++orFpj2d3o0tvmKte8Oy0yNTo9faKlNF9C/nFNSB1P1cPm61GPCOJKZGlYgJANXjYZvn6Vg75hxH6waqeZwl8qfGnOHAS1e5WT11IG6ygk9/Kqfey54Eq5JkwmaJC+4eAA8kzS+0Fmd0Sxx0ZPToc1aM+xtOlDnZ/OxdoyWiUEBuRU4my3u6QEJlIJVMUY9qadRhoorwvbW5zWxUrsooGOMcTCfyh/zYl9I8LOWLBxB82FDdHiUHWTjZ/gMG8t1jHpwPHWqq14nnf
x-ms-exchange-antispam-messagedata: xyUya8TVxXyYdmnJfz49CnOtDK077I1Y376ezlELhDMSr+ddNUClQo1YPfEsiiS+DbECDOgsltG5zqyziNUgf4WgAAG9v/CZOvvQmpgQhXMIEQlLi88eY96xP4FB+BLQU8lRdvqTnBAHLQQ7fnI04g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4619fb1b-845e-4085-592e-08d7bfece6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 03:34:09.7835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6+d+iTjE/Wj6u+gneso2fvDYATIe3MUQLclTx1insy0ZYZY/rcULRc9o6CzxI6L2R2CHMTuM8QyNOcrYd14fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I can't seem to access the linux-net ml per kernel.org faq, apology=0A=
in advance.]=0A=
=0A=
This change, which I think first appeared for v5.5-rc1, basically=0A=
within seconds, knocks out our [apparently buggy] Comcast wifi for=0A=
about 2-3 minutes.  Is there a boot option (or similar) where I can=0A=
achieve prior kernel behavior?  Otherwise I am stuck on kernel 5.4=0A=
(or Win10) it seems, or forever compiling custom kernels for my=0A=
choice of distribution [as I don't have physical access to the router=0A=
in question.]=0A=
Thanks!=0A=
Jason=0A=
=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
=0A=
127eef1d46f80056fe9f18406c6eab38778d8a06 is the first bad commit=0A=
commit 127eef1d46f80056fe9f18406c6eab38778d8a06=0A=
Author: Yan-Hsuan Chuang <yhchuang@realtek.com>=0A=
Date:   Wed Oct 2 14:35:23 2019 +0800=0A=
=0A=
    rtw88: add TX-AMSDU support=0A=
=0A=
    Based on the mac80211's TXQ implementation, TX-AMSDU can=0A=
    be used to get higher MAC efficiency. To make mac80211=0A=
    aggregate MSDUs, low level driver just need to leave skbs=0A=
    in the TXQ, and mac80211 will try to aggregate them if=0A=
    possible. As driver will schedule a tasklet when the TX=0A=
    queue is woke, until the tasklet being served, there will=0A=
    have some skbs in the queue if traffic is heavy.=0A=
=0A=
    Driver can control the max AMSDU size depending on the=0A=
    current bit rate used by hardware/firmware. The higher=0A=
    rates are used, the larger AMSDU size can be.=0A=
=0A=
    It is tested that can achieve higher T-Put at higher rates.=0A=
    If the environment is relatively clean, and the bit_rate=0A=
    is high enough, we can get about 80Mbps improvement.=0A=
=0A=
    For lower bit rates, not much gain can we get, so leave=0A=
    the max_amsdu length low to prevent aggregation.=0A=
=0A=
    Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>=0A=
    Signed-off-by: Kalle Valo <kvalo@codeaurora.org>=0A=
=0A=
 drivers/net/wireless/realtek/rtw88/fw.c   | 24 ++++++++++++++++++++++++=0A=
 drivers/net/wireless/realtek/rtw88/main.c |  1 +=0A=
 2 files changed, 25 insertions(+)=0A=
=0A=
------------------- drivers/net/wireless/realtek/rtw88/fw.c ---------------=
----=0A=
index 4b41bf531998..51649df7cc98 100644=0A=
@@ -29,6 +29,28 @@ static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rt=
wdev,=0A=
        }=0A=
 }=0A=
 =0A=
+static u16 get_max_amsdu_len(u32 bit_rate)=0A=
+{=0A=
+       /* lower than ofdm, do not aggregate */=0A=
+       if (bit_rate < 550)=0A=
+               return 1;=0A=
+=0A=
+       /* lower than 20M 2ss mcs8, make it small */=0A=
+       if (bit_rate < 1800)=0A=
+               return 1200;=0A=
+=0A=
+       /* lower than 40M 2ss mcs9, make it medium */=0A=
+       if (bit_rate < 4000)=0A=
+               return 2600;=0A=
+=0A=
+       /* not yet 80M 2ss mcs8/9, make it twice regular packet size */=0A=
+       if (bit_rate < 7000)=0A=
+               return 3500;=0A=
+=0A=
+       /* unlimited */=0A=
+       return 0;=0A=
+}=0A=
+=0A=
 struct rtw_fw_iter_ra_data {=0A=
        struct rtw_dev *rtwdev;=0A=
        u8 *payload;=0A=
@@ -83,6 +105,8 @@ static void rtw_fw_ra_report_iter(void *data, struct iee=
e80211_sta *sta)=0A=
 =0A=
        si->ra_report.desc_rate =3D rate;=0A=
        si->ra_report.bit_rate =3D bit_rate;=0A=
+=0A=
+       sta->max_rc_amsdu_len =3D get_max_amsdu_len(bit_rate);=0A=
 }=0A=
 =0A=
 static void rtw_fw_ra_report_handle(struct rtw_dev *rtwdev, u8 *payload,=
=0A=
=0A=
------------------ drivers/net/wireless/realtek/rtw88/main.c --------------=
----=0A=
index 690a5c4d64e7..f7044e8bcb5b 100644=0A=
@@ -1310,6 +1310,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ie=
ee80211_hw *hw)=0A=
        ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);=0A=
        ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);=0A=
        ieee80211_hw_set(hw, HAS_RATE_CONTROL);=0A=
+       ieee80211_hw_set(hw, TX_AMSDU);=0A=
 =0A=
        hw->wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION) |=0A=
                                     BIT(NL80211_IFTYPE_AP) |=
