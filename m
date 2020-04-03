Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311BEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7899206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=invensense.com header.i=@invensense.com header.b="eQIYaGMP";
	dkim=pass (1024-bit key) header.d=invensense.onmicrosoft.com header.i=@invensense.onmicrosoft.com header.b="YZOGADGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbgDCHqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:46:19 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:30904 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389116AbgDCHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:46:19 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0337j7hQ010412
        for <linux-kernel@vger.kernel.org>; Fri, 3 Apr 2020 00:46:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=GzCTbJ+07kHRAlKIsEbJt5ngQwRTIxGGugPS8trlEm0=;
 b=eQIYaGMPIrFh1uIwxeyYl/U9t1mJuBZbvama2nzU7bBM4KrA8D1flVE5KksVHRIG6ypN
 radytZFEAdyC1GQIO/iex6Qdq6zs7URkGSVE1HxAEmMvf8YPCLf/pV5/LZ5rJ9xBEPTQ
 JIdIuCJ44tK4jbEDPGyulBU3l+FIbH1uKPIPiypj+I0v6R3HVjTVm2ihuUxQaR18RitE
 GIWa3BnAefNnv0uCzLaStkWX64xZvkVnS8h3HqU8SxhfhCmVfB6cBS+FsVy38jKEcS1Y
 XKq/Sz9TqzNCxNx1vf4f1luwcw4XfIg8MZT5fbbItHmKMfIU8HIVXgcu00rqfH3/dWjF aw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-00328301.pphosted.com with ESMTP id 3053vw0mqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 00:46:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EC9S19rbotpJo1Ntx34aGsVk6tO5DaADMGYGVDlixhZ+yWSNgVvg+VWtGIi7Gtk01aNEvW9Qx2rlxfIeQerl+9ujN011jllkjBkoz5ivKZHS3WYGxCALg1NAcoEho4Dvi9EeR2FPyQsaDOU8CVV0gtar9tghTogUzAGllmVGjYpzk7XjPZyndU5t1AvQdBANGtNCMfIOm2O8bH+yLeN/cQh38YovCcSpLGfTdMzpLnuOmr3GMz7Ry6HXjufpI+WeFyRokkNV+Ff+OFm6AJ1VIGeoIGK0N3ak/aMNBYDXNJB7UeDMtXvQEN22xLi+QlitfI8uIOBFl+L2fGlD4n0Pkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzCTbJ+07kHRAlKIsEbJt5ngQwRTIxGGugPS8trlEm0=;
 b=IEmqXGp2/kJxK/HvouC0k+QjeXVA7xxOL2TKHkni3VdELRLLt2Rbvnt4rZYx83LNKhzgvZ4TOI9jyz54EOjMDoDUkRKCFg2bPH1AJbp98ti7de6whC0YIOzkHLTSj6Es0ArE1nsOsYGK7VxPdWGnKMXSd2gy32zdzDZVmQIL0ADehnzei4B/TcdsW1kmplJ7tfaSAahjyxCu9kLm3qXKuC5q1dfer9NDjY6KmDJddV4Rje7Jl3LeJeu1WNUC7U3p8mi1qio0fRnohbhNFNUCZjJVkgOCyzzZiNXSYsip6t+645PRHxe0bR2kKWhC48L3h01+0yodPpXSbyzN075rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzCTbJ+07kHRAlKIsEbJt5ngQwRTIxGGugPS8trlEm0=;
 b=YZOGADGoHdRMdh1HqsGeHhowomXFlp0WtMawz0GQ1az6u3oU+HmE1J9MdyPHxgK9V48xp5brNRY9hisJhrqdYC87wJ17csqCojc0pxv1joml9aX67Ok36I7eTIM6dPdIY5+Xn4IGlAnRYhM06V42iEZPO4NNHXusPM926AIJaI4=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3727.namprd12.prod.outlook.com (2603:10b6:208:15a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 07:46:14 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2878.017; Fri, 3 Apr 2020
 07:46:13 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: regmap issue with ranges and noinc read
Thread-Topic: regmap issue with ranges and noinc read
Thread-Index: AQHWCYouzYcjR9f54kiGOXYXc1Kxkw==
Date:   Fri, 3 Apr 2020 07:46:13 +0000
Message-ID: <MN2PR12MB44229A91FD24E5020C202177C4C70@MN2PR12MB4422.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8ede01e-50ba-4f49-229d-08d7d7a315b3
x-ms-traffictypediagnostic: MN2PR12MB3727:
x-microsoft-antispam-prvs: <MN2PR12MB3727469BE73BC1C9B605D416C4C70@MN2PR12MB3727.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(136003)(366004)(39850400004)(346002)(396003)(376002)(8936002)(76116006)(66446008)(52536014)(81156014)(66476007)(6506007)(66556008)(81166006)(7696005)(5660300002)(91956017)(316002)(64756008)(33656002)(71200400001)(478600001)(8676002)(9686003)(66946007)(2906002)(186003)(26005)(86362001)(55016002)(6916009);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VTuY2NcmTrxmipss+xxI/SLmKKEoPiG02VpzwgJTq22rdk4ZSjPzK+c0udoCMvwHeFn5zC9BAPHSGqQB80SY1kd8N6ET2y5xNsfylc4YsS1pZftQJxfN0shz+3JlXE90IVqkxZ94FgxQn7Bf9TMEnR8rWrXi1ZeZTQ9BVs/h4xtbq6XPxW7lwpPyuixDR5xMyYQYU1NhTmTBeIX41TW4LxnrNgyigKVYnHdaej+LTyJ08Vx5zCM4ikNZs0VE+h5RPoph6WiAL+7/3J9b1EkkbL2jCgyhbplFDeBbo7HFNJyjZg1vXnSutxqWHAOVGLwSa4f0Wlvsn0GkWA7t/dUd4LflFnRT3BW/6uRhaIgQBdPKsoGtaYNTts5Zi0+bg9ODPZhRIM2B9Hqa3a2hiqhZrPR+tzvh9RbCovagUzbQTNHZjwWy+VOW6puNP7UIbt0e
x-ms-exchange-antispam-messagedata: ovi0C9qrw0QiYKcZRWlrsykBTwOZBupxnUTUtuTdrswN4Dwo6wNwiU+XQUfbP+nHacwtB78IgIWE8adznu2+uFpiZ/bJ0E6GEP1D4PCoWnPtYY6DW/NdrbN7RxmJ30X8JpmCmx+cBwFu56EMRkTDQA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ede01e-50ba-4f49-229d-08d7d7a315b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 07:46:13.7846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w86sRjCuBTgCx1Kv+hyo+D1+izaBK8NFLI6eeT3YXggpaUreEn6NReNC0JdesBHmJC5miSTAlZqIRn0LfY99HROXAq/VYKdX3TWzWZdosTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3727
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_05:2020-04-02,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=797
 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,=0A=
=0A=
I have an issue using regmap noinc read when using ranges.=0A=
=0A=
My device is 8-bits registers and 8-bits values and uses several register b=
anks that you can switch using a bank register available on all banks.=0A=
I am configuring regmap with 1 range with window len of 0x100 and using vir=
tual register addresses like 0x0aRR, where a is the bank number and RR regi=
ster address (0x0032 for register 0x32 in bank 0, and 0x0123 for register 0=
x23 in bank 1). This is working pretty well so far.=0A=
=0A=
The device has in bank 0 a virtual register for reading a data FIFO, which =
is larger than a bank (0x800, 2048). When using the regmap_noinc_read API f=
or reading my FIFO, I am limited in size to not overflow the range window l=
en. regmap is checking that and returns EINVAL in this case (check is done =
inside _regmap_select_page called in _regmap_raw_read). It certainly makes =
sense when using the standard remap_bulk_read API, but for the noinc_read w=
here we are not reading continuous register this doesn't seem to be relevan=
t. And this prevent the read of the entire FIFO data in this case.=0A=
=0A=
Is there any reason to check the range window len bounds for the noinc_read=
 API or is this a bug?=0A=
=0A=
Thanks for your help.=0A=
=0A=
Best regards,=0A=
JB=
