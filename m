Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398EDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050932051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ohuAFsPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbgCPQGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:06:09 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:27300 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731505AbgCPQGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:06:08 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02GG0V0Q002456;
        Mon, 16 Mar 2020 09:03:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=8aTc2Q+gwu5/tB/S2K13Hx/dW7HbMbLVNLQBM704BSs=;
 b=ohuAFsPKFHGLEdto0+iI8dDr5IZZ5+NkB8FH95WiKvXlG4tdroZZL+aC+MLAFtqp6LKr
 GxV8v1DD28hlawfTVVIKfgW3w+KmiebE1Un1pTiNrsuAno73SVw9B54wogulrWr4Gb3f
 r3vanpIfZJvqpxcu5blXQR0sydEyH8NGt6Se5J/hwJeO2evNzyAIwUirRVVVLECuaNve
 DrZY08xAeb4MsiNQnSod91lvgetPlqKJ7822V2SoNWXYTIHlfcEgyFVkYlonZHlRea/m
 kFLL5DmBj5m9xcPhfDptouT+aIZIjlbZidnRylV4WD3FoTUgugb9oe6bzFQBMiL/Vlp9 ig== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2ysphst56e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Mar 2020 09:03:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ye+KXoNDJPyRuBpzsT4wNCg23VmuaKsVNKK4hb76JhSaAhjOsQCYtq5KspCK4ZXs8DZSqk6t7Rz+GNLA7mjYLT5M8It/4yDnUgmL6fQg7IzxhjJmNamIf/VLcdgjk4KiUpCp1u9Nyu02lmemPYQuispIHtx4hf63Mhp92gOviumJGyADceEUydIyabQ19WmqBdBmuNfQB2wLRKQti/AtvGD17SUdIxLvmmGWoKO1Y9npX/MXUZPbe898OzHmVkGXx2Av3bukex0YEsYboWGArDSrAzdZs9Y0Afk2Eub9Lf002LTeaqBfdSdrd+zxYsKM68O1hixy2nVPfwnPBxkgkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aTc2Q+gwu5/tB/S2K13Hx/dW7HbMbLVNLQBM704BSs=;
 b=aiIlZx6l/E4nccDJ0kooE1HbxKDgi5DD05c64ksDVPFq4ARaJXhmFqA910cQR103t2MpBDSrg2LsOH3q+QkJkNUjE0wOh1Bj/mFzk8GUg7DLXz0RhRGI6zwRuoM3ETKGiDWJx27XBqg8URuvpGLuPGStGYhLrYs96FhJJwx4fJ8Z7pIVfasS8cm6u9CO4uXDZyd+hO2duS5NAYyQnj6sD9pnk/qC+XRALdST5q4CaQHR49mgDyUwFT19q8yExOawJHTE/b7ytrH4Ttw16oYe3A5k3Jt3OYeyGrMVbAhIt/bUupwswDfrIxLc5qtFqjzx1pIj8t+/ydUvHlR6/9Otdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB5601.namprd02.prod.outlook.com (2603:10b6:208:88::10)
 by BL0PR02MB3681.namprd02.prod.outlook.com (2603:10b6:207:40::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 16:03:08 +0000
Received: from BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c]) by BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 16:03:08 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
To:     David Rientjes <rientjes@google.com>
CC:     Chris Down <chris@chrisdown.name>,
        Matthew Wilcox <willy@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Topic: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Index: AdX3zHNqbuFpQvKERxyPueA21j6FDgAD0RWAACPlSzAAAfzUAAAA7+kAACrp4sAAF6xNgACGhKBg
Date:   Mon, 16 Mar 2020 16:03:08 +0000
Message-ID: <BL0PR02MB5601F1945BADC0AF46FC3962E9F90@BL0PR02MB5601.namprd02.prod.outlook.com>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <alpine.DEB.2.21.2003111227230.171292@chino.kir.corp.google.com>
 <BL0PR02MB5601808F36BE202813E9D562E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312133636.GJ22433@bombadil.infradead.org>
 <20200312140326.GA1701917@chrisdown.name>
 <BL0PR02MB56011828432D343371088516E9FA0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <alpine.DEB.2.21.2003131447220.242651@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003131447220.242651@chino.kir.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e98b4720-df17-48ff-dca9-08d7c9c38527
x-ms-traffictypediagnostic: BL0PR02MB3681:
x-microsoft-antispam-prvs: <BL0PR02MB3681DBD6E2BBD79755CCC37CE9F90@BL0PR02MB3681.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(346002)(396003)(366004)(199004)(71200400001)(9686003)(6506007)(33656002)(52536014)(66946007)(44832011)(54906003)(55016002)(316002)(76116006)(186003)(66476007)(81166006)(81156014)(8936002)(8676002)(4744005)(26005)(478600001)(7696005)(4326008)(5660300002)(7416002)(66446008)(64756008)(66556008)(6916009)(2906002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB3681;H:BL0PR02MB5601.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jpvvLLPx7aL1e4jCFxSt2pgw5voaJ7Dh+gr3n8NhYlsNnnFHvoaU9UvzM5qP+h6txe8hOPj0bmSS9fAfR0oKDIDV0WNsQDaiTR25MhqQsZgLR5f4Zml6YDLmY+US0P1bytT7GZ4rCmj+TpblDNeqO2aE9s5NiRTt6zCvQaWzt78qRy8MfesiF0iM3dsXwbN6eayM0K8sl1S92nxubbZEaNNEGBtdyJ60wxaGGIW0GkPZn9vxpfu8oOu5C6kwI61H7Qiu6X9hn9O4klk9x50FwlVuVV/gd9AAUtb0Q8PQhht2VveLeqanzkhQ+rciMeMU0yUaFTbQOjZhweByHR6qbNFzWawAPnau7UHcGMZzOKRLhk/M9YlMyeMXdCuTyd4xNGbJwoeyfI1JRYk3VoaWeQJ+OXclANOu5ohZUabQQiqoIPzw1Qi/8XYotigJmGT
x-ms-exchange-antispam-messagedata: URBKcwZZSelW8tjIu2fix39GAg+dpxvezlKpyIDow9pnPBA87/iwC7mQDigDq5LU+BG09NZIvOMn5xlCI7wdRhjxruGFkTHVzEiCxJvY4CByCemTQBIPeIOGpIDzQLZFDI3XT0CtC1SAUhSEIwuT2w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98b4720-df17-48ff-dca9-08d7c9c38527
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 16:03:08.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9jCZR0Zki0tQpmnFWWXUMKJtC/9W7OIKUI0xLj0X1XywkELGTRpgoFOf5w1ZRhSA06B6qgnklhlMWmZNMp/tGJdq4Bf4vQgVS2GUta2878=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3681
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-16_07:2020-03-12,2020-03-16 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020, David Rientjes wrote:

> I'll renew my suggestion of defaulting memcg->swappiness to -1 and then
> letting mem_cgroup_swappiness() return vm_swappiness when
> memcg->swappiness =3D=3D -1.
>=20
> I don't think the act of creating a memcg and not initializing the
> swappiness value implies that the existing value meets your expectation.
>=20
Thanks, David, I haven't considered this point.

This point has made me realising that the existing behaviour, where
the swappiness is inherited from the parent, is not documented and,
apparently, just appears to be implemented that way.

In this case, the -1 approach looks less harmful in comparison with
the original patch, unless I underestimate a number of users "affected"
by the assumptions about how memcg->swappiness is getting propagated.

I'll send another patch implementing the -1 approach shortly,
perhaps with some clarifications in the "swappiness" documentation.

