Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB37C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DFD21739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 22:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=seagate.com header.i=@seagate.com header.b="B75B0yx/";
	dkim=pass (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="Flwi/Pb5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=seagate.com header.i=@seagate.com header.b="GXL+yPBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgCBW6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 17:58:01 -0500
Received: from mx0b-00003501.pphosted.com ([67.231.152.68]:21420 "EHLO
        mx0b-00003501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbgCBW6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:58:00 -0500
X-Greylist: delayed 804 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2020 17:58:00 EST
Received: from pps.filterd (m0075028.ppops.net [127.0.0.1])
        by mx0b-00003501.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022MhJUE013117;
        Mon, 2 Mar 2020 17:44:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=avkiQ6FsK2SJlZcAaw7vQj1o+qiJuob8s2HC+9h/RRY=;
 b=B75B0yx/1DsnARqcAUuptyZ4lhXiESwNd262QtnUuYhFrF9wsXAB0F14oa2xJcQ7Tfdn
 iS2KCb3uTuBkWc47+uHCmvUDDXbhiIE75+jXLmDu+R6tQWlxhR1094sy36Ja/cBYvvEw
 U2eXvrxgXFIYNYeyU9ZnYG4BRm/ifrZgHYSlCYDyJhyZam08E9Z4DbWbJBQBOKPk/uYD
 +9gaGEWgXgAI4/e99TglsJYr8EX0mWX2ss8gWj94w2lWDK6lpuuUu3KE6Jml6CKaJQ4d
 tUXvFZrHYmND2zNXcTFMTacthCp8Wn6eD4HW3OZAJbiEi0KymXzZUXCC0O7LH6T0AWHM rA== 
Authentication-Results: seagate.com;
        dkim=pass header.s=selector1 header.d=seagate.com;
        dkim=fail header.s=selector1 header.d=seagate.com
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0b-00003501.pphosted.com with ESMTP id 2yg5ueaab1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Mar 2020 17:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avkiQ6FsK2SJlZcAaw7vQj1o+qiJuob8s2HC+9h/RRY=;
 b=Flwi/Pb5jM0ds0yP/QH11NgDbUUvx5EKc6ZRgZZLMdLMrtzWDhaSwbL7jChHtHkU1gOpkymvjTi2kRqlXj785atFD4icHnCykRzGpbQOpyQqi22B1TxcLxhL+3zJAliEMBQ1w4l80NMBLiyJY3kso+DZjIJg89ARM2dWqfuVX5k=
Received: from MW2PR20MB2106.namprd20.prod.outlook.com (2603:10b6:907:4::14)
 by MW2PR20MB2060.namprd20.prod.outlook.com (2603:10b6:907:5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 22:44:29 +0000
Received: from MW2PR20MB2106.namprd20.prod.outlook.com
 ([fe80::c983:9197:f341:7e56]) by MW2PR20MB2106.namprd20.prod.outlook.com
 ([fe80::c983:9197:f341:7e56%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 22:44:28 +0000
From:   Luis Tanica <luis.f.tanica@seagate.com>
To:     "john.garry@huawei.com" <john.garry@huawei.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: LPC Bus Driver
Thread-Topic: LPC Bus Driver
Thread-Index: AQHV8OEwW1ITeLF/ykCZZuoytr/YLw==
Date:   Mon, 2 Mar 2020 22:44:28 +0000
Message-ID: <6daf1bb266a24c239aed34d8661fc5eaMW2PR20MB210660F6B17CB90ACD0B6E7CA0E70@MW2PR20MB2106.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
received-spf: None (protection.outlook.com: seagate.com does not designate
 permitted sender hosts)
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yTZj9zbCU55N/Uw21fg1NbVm5gozCs6uTgsCJbF3PU=;
 b=GXL+yPBbv915itkxGcKRHiW4a1z1U87hn3R9ph8bt8zzUIA8b/DQiy/PbOqsSutmKt5N/8RaCm6gOAFRZ7pw3DSxPRG5IycSGt2iIBswcpbUKk7EZrunKmBi0DanxDdFwajsvOgJNW+W0dS/+iz5SkgwpszqBOkkPDu19eq7Z4s=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NESN06Q7mDcOu6Wci+IbA9LUNsY8lDJZfin9XtDxsnCWfE7Rb0zQljgkeuIqpjJ8PfV9IPfsxGtZWHNQD8oyl0NXqillwsw3fxiQgWiziBD2ZJqlQ7+hOC4/sTOYvaEOypDuekQlaQ7bJED6XnLxagFfjkXchDdX43If2CHGkBwIGQGWrQ+Z7PkBZphqw1XqsnbtM6fT2gZmXp1p57Uh92c6B1fTLrfNzyFIKqRoalEQCpUbpYMTCaqZg5xI8TAq31uGva4Mxp0dMXcQWrT4oFpzrug5+qG8UV8uQUG4kGnwrOztFznzSwJJNhduJ9oT3/52QT0GcmEIBx2hLBlfDQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yTZj9zbCU55N/Uw21fg1NbVm5gozCs6uTgsCJbF3PU=;
 b=O66VwW20Ey8YN9Dq3R5x/etx6fGmzb8wnLU5EQRfswfOyxrUVkA44Z2cabNysGk5y3dcQSniC2EANLSISni0gOFk8/dike7ZLTbsgv43PHSbUmX0PPjL6/6haxMouc7ach2f10ykgcgO8mqYE61ABOFsp2NeTIorGbPXoZf2ymcn8MHw+Kw7fk2KLBtthezlxK/tsqLColYbjr4o7pteiM8YTyRUbmzfr+gcIHst3XoXQ44ZNqwijLQIoBLRInUiNJ04Ys8orT8zuxzbMkyqmaC94u3G47d0cBFdgzLNFsiSFcuifHTJ0VTIFTrGBfLKv6IfCVMoJkWkN49X7hsNBw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
x-originating-ip: [2601:282:1080:10c0:8dc0:77ee:fba6:f449]
x-ms-office365-filtering-correlation-id: 93f941f4-4f00-4c04-a8da-08d7befb445c
x-ms-traffictypediagnostic: MW2PR20MB2090:|MW2PR20MB2060:
x-microsoft-antispam-prvs: <MW2PR20MB2060CCD5AF53E91B271E28B4A0E70@MW2PR20MB2060.namprd20.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: =?iso-8859-1?Q?SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(34600?=
 =?iso-8859-1?Q?2)(396003)(136003)(199004)(189003)(9686003)(7116003)(47440?=
 =?iso-8859-1?Q?05)(66476007)(91956017)(66556008)(64756008)(66446008)(7611?=
 =?iso-8859-1?Q?6006)(55016002)(66946007)(6506007)(186003)(33656002)(76960?=
 =?iso-8859-1?Q?05)(71200400001)(316002)(6916009)(19627405001)(4326008)(47?=
 =?iso-8859-1?Q?8600001)(5660300002)(86362001)(52536014)(8676002)(81166006?=
 =?iso-8859-1?Q?)(3480700007)(8936002)(2906002)(81156014);DIR:OUT;SFP:1101?=
 =?iso-8859-1?Q?;SCL:1;SRVR:MW2PR20MB2090;H:MW2PR20MB2106.namprd20.prod.ou?=
 =?iso-8859-1?Q?tlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1?=
 =?iso-8859-1?Q?;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(3960?=
 =?iso-8859-1?Q?03)(376002)(366004)(199004)(189003)(2906002)(7116003)(5501?=
 =?iso-8859-1?Q?6002)(9686003)(64756008)(6916009)(66556008)(66446008)(6647?=
 =?iso-8859-1?Q?6007)(66946007)(91956017)(76116006)(86362001)(4744005)(712?=
 =?iso-8859-1?Q?00400001)(478600001)(81166006)(8936002)(81156014)(316002)(?=
 =?iso-8859-1?Q?186003)(4326008)(3480700007)(8676002)(6506007)(7696005)(56?=
 =?iso-8859-1?Q?60300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR20MB2060;H:MW2P?=
 =?iso-8859-1?Q?R20MB2106.namprd20.prod.outlook.com;FPR:;SPF:None;LANG:en;?=
 =?iso-8859-1?Q?PTR:InfoNoRecords;A:1;MX:1;?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufx6uC19EOprLLY+1+P11ZY0le3bviFa4cG2Ei+PO8CBbgP/SI1EQvN9rir3LW3pohmeYMJG3kLbXULalsghmYE3hTsJz2LDUAvs7RSS1Ul24m+70LCtSx1LUdDRpVefsuWlMkx6m1cu8CIufYxP68jWasKV8362c4Q71xRPxSoDnjkSPF/AQANknCKYH0Fo8B+kmSkf0So/vWn3NYnsmrS+dSTakVKDzdthAISqlgPlfmfJZDPW5VS96xdU3NjpOylb0xerOMplQ9Imyznb0ulFek6UAZplK7/G9nNprNW1bi0KAVDh/tMBCZVPALupcpBFHuCn0k5eTji3SxemIo/Mq/+XtGjJ5ozpSKIdpnV3eYS199gKzpPXbZzjX/Tgk6zqiDr13L6h5ZKilx+hNpqjCc2AVEntIIfs+c/s5ztJkuy4MLTUdrgQG6K5AmCt
x-ms-exchange-antispam-messagedata: fWX2bO77X2Cw+rlKerAxHAQMYfB5lRqOoNYaZiwP8G+NYqlgwMsf7QDueR42sDccGAoNgsfnxDYav6rd+DgXqNHT4VN550F6higKhqv2eMvlq/w2KXeO5Ft+r66kpFgWcb4VrLnowTxHm7NeOLbtdK2mMph5Vhuf/UNEFtkRs9Eityrg1BpcOc7HMPDvbnHEcFQV2CXLs19/PeQqwY4zMQ==
x-ms-exchange-transport-forked: True
x-ms-exchange-crosstenant-network-message-id: f5164009-1f24-446f-4d7c-08d7bef8bb12
x-ms-exchange-crosstenant-originalarrivaltime: 02 Mar 2020 22:26:19.3311 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: d466216a-c643-434a-9c2e-057448c17cbe
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: AbROY9GYuQnIOezRsmBcme3Jd5Twk+M9xd4/0I5vzFzq7l7+eKC8jVIZmjwiwdvsQDcU+ZskjaDQUH1VfcPKqjyTTiTNCsz5P2AK1C4Jw64=
x-ms-exchange-transport-crosstenantheadersstamped: MW2PR20MB2090
x-proofpoint-policyroute: Outbound
x-proofpoint-virus-version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_09:2020-03-02,2020-03-02 signatures=0
x-proofpoint-spam-details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=477
 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020145
x-proofpoint-spam-policy: Default Domain Policy
x-ms-office365-filtering-correlation-id-prvs: f5164009-1f24-446f-4d7c-08d7bef8bb12
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <532E310371C51443BA0DC85A1CD0A249@namprd20.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f941f4-4f00-4c04-a8da-08d7befb445c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 22:44:28.7517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6hM0hEOASPyjeRLUli0OzVmKKRR4mSj6Ahcie5LuJlGwgB+CAr2pZWLFLSIpX/lddcsXV8b/UXWjgxFtKRO502jlHc27Hwf1s+357fZokhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR20MB2060
X-Proofpoint-PolicyRoute: Outbound
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_09:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=452 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020148
X-Proofpoint-Spam-Policy: Default Domain Policy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,=0A=
=0A=
We have this board with our own SoC, which is connected to an external CPLD=
 (FPGA) via LPC (low pin count) bus.=0A=
I've been doing some research to see what the best way of designing the dri=
vers for it would be, and came across the Hisilicon LPC driver stuff (which=
 I believe you're the maintainer for).=0A=
=0A=
Just a little background. Let's say our host (ARM) has a custom LPC control=
ler. The LPC controller let's us perform reads/writes of CPLD registers via=
 LPC bus. This CPLD is the only slave device attached to that bus and we on=
ly use it for reading/writing certain=0A=
 registers (e.g., we use it to access some system information and for reset=
ting the ARM during reboot).=0A=
=0A=
I was looking at the regmap framework and that seemed a good way to go. But=
 then I saw the logic_pio stuff as well and now I'm not sure what the best =
approach would be anymore=0A=
=0A=
Would kindly ask for some advice here.=0A=
=0A=
Kind regards,=0A=
Luis Tanica=
