Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B551AC82A02
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9377920575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Uyb+S4TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgD0WEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:04:04 -0400
Received: from mail-eopbgr700095.outbound.protection.outlook.com ([40.107.70.95]:8888
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbgD0WEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwtbqctPHdjjntNnzQjNGfCoybwgghT82g6bgptP8RQL6FGLamkyCEs+DgIi6+gK3T7MfuwwI0BVXSHa3EIzVyNCokKzBnRxYDOllLCxaKQhc36In+ze2n3S2g+fTlEINdwXsIN0kjWv30RtiBGxIXw6dZMu9s+2vjJSxxHpaakpa6bz/RtJlQiR89EHWZ3gCm2lkLAHSj2jOFC5sVtvbBgZItHEVWmMeGFkkuf5giUGrH9+yKemOVOFWA9liNAl6CP+od4cbLtREUfaZg2Y9guDrFwFUgIHPTJLuQ/8/Tz5dcs6MSuXb16X9UYpWO9Ii6HWHrs/oOv7duvw1VEw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyVaGdAVd3ZcAA9S86IjWSY51LH4+kE8Af80x+SSG/c=;
 b=hFPe8VTHzzyz9GPwF2zIe99fDIqrL9o8MzqpL9gwUY0nnKUzcAxkvEaRfDg5dMYeHtU1TPuYVYPNekKNH1trsCOfoVGdfAXMCBOWRauwUtYiGRCna8YVBURSae3EAE4XMflN2rxMmdRly0dPevd/3dEMnlXnwTCYazyOlom6nPMEG/JWO17Nx8rAwkC51GexPxYgqV1lhBfqsBeEwwbai0hx8g2H5KGh0P635akp1Bkt8PzHINH+3DOhpic1qK6JhV4dBzRc+Yd0yG3ilF+U1QgPjGl6EYaZCKbzlZdsf1JfZTt4jP+yYGAmA7CoU/ROcyV3PJRqu4bx/xvrymvaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyVaGdAVd3ZcAA9S86IjWSY51LH4+kE8Af80x+SSG/c=;
 b=Uyb+S4TF8FL8TX2/C5GFH6BQwIMQngaRn6ip8SGPNMzRg6F/S0u8nW9K4FDeRIS96Yfn3BwVKkTLCu4tGpPwU1+7E4Ru1aRvZM51CIt/1qeVeOQ05GQnogCd7hIiLvBbrdNEXbRCs5kutEStW6ZM9GI3wn5BbMOr5rsuyXxAcwU=
Received: from CH2PR21MB1511.namprd21.prod.outlook.com (2603:10b6:610:88::24)
 by CH2PR21MB1432.namprd21.prod.outlook.com (2603:10b6:610:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.2; Mon, 27 Apr
 2020 22:03:58 +0000
Received: from CH2PR21MB1511.namprd21.prod.outlook.com
 ([fe80::35cf:633b:4836:674e]) by CH2PR21MB1511.namprd21.prod.outlook.com
 ([fe80::35cf:633b:4836:674e%9]) with mapi id 15.20.2979.005; Mon, 27 Apr 2020
 22:03:58 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Francois Saint-Jacques <fsaintjacques@gmail.com>
CC:     "eranian@google.com" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3] perf inject --jit: Remove //anon mmap
 events
Thread-Topic: [EXTERNAL] Re: [PATCH v3] perf inject --jit: Remove //anon mmap
 events
Thread-Index: AQHVvaj2LRXwQIFSU0aPphN9jUHHyqfRREQAgLz/fEA=
Date:   Mon, 27 Apr 2020 22:03:58 +0000
Message-ID: <CH2PR21MB1511DC522EBE2E19C8185FE8F7AF0@CH2PR21MB1511.namprd21.prod.outlook.com>
References: <CABNn7+pYPSfduacOATcKT1X_=qs70i7Bc8pELXDahY7BoB9_wQ@mail.gmail.com>
 <20191229155112.GA21785@krava>
In-Reply-To: <20191229155112.GA21785@krava>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-27T22:03:57.3964788Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3c4c1af4-6fb1-4315-bf8f-633d69333f0a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a466e4fd-5079-4a9a-2f66-08d7eaf6e305
x-ms-traffictypediagnostic: CH2PR21MB1432:
x-microsoft-antispam-prvs: <CH2PR21MB1432D948F4263B7C27B6C792F7AF0@CH2PR21MB1432.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0386B406AA
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/mt+FYhNk5fWNDX69k6XRr+yPt2kT/tOZWM0bnCi/jH8TlyQE1Mex+Bs3pMrVS5JvZKf65UjeE2o6w9isP6ptJf94uvdOnsaBt+bjAQ3EdqyyZlnXe8vo04Ix+UgB+mPuKSqV/S93Fa02ZSv1/3Sc7rVbHlFoBwvfcJM634sjUR9dm4jpV1fKF8RvTgoR12KdOg2ygNc6OiHmJzKj1XgebzR9lvN4q4fyqH161EPfbDciJpBRTW5v4ZHAWpw+38Si+1azvA/HI9vzaVMCMf7wUesYBIEYRvOdB56RSba5orDz3HsGSmLp0ff/sXcRcQnuTHg3mDqKjSnzAE6k2qJ5+zOwpxYouAEJ7jW5rVOu6N6p5ADsxFQG4DGnXVrCfnGzCKbixqVMQPUDyQz2vrHF18Ytj5yu9tfvI4plUel77wrfDr23rf/Y7+OtEHreOK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1511.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(82960400001)(33656002)(82950400001)(2906002)(7696005)(52536014)(64756008)(66446008)(66946007)(66556008)(66476007)(9686003)(76116006)(4326008)(55016002)(8990500004)(6506007)(8936002)(26005)(186003)(110136005)(86362001)(5660300002)(8676002)(558084003)(10290500003)(71200400001)(478600001)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: n04RHv2ItyUwtiYT92M2s3n+zUxBQIq9GrCGRBSWGD99hWG8WozNoivy4ci9tcSRlEuzlsr3XXrt4vjnzLDJhw8YsBpuB4vv3v2Uh9cZ/VH4uuzjww7jrLMCdKE/wMD+d4WsZ7bHjQCYePLyAlpYLediaDcX7gQEreWuRKzTLQqgZqxgrKrjCivps9FlLKfMTs050QpzqkflXX6aGY9NGWJHaH1Wo4wokNW/mTYlQjCBYRUVVMQPCdLT+ureqy0HMXenXi0Y8n8Fl0JyMy8NprMcCsD1/f/WWKTrUP9Nz5++476dvgamYEcWqYWM5vVkMJs1J0/klScQ5dUXaTGhZZaKVGzDdtGuNU5t6ChsvGsctMK/kYTpURnLH5AFispKLwfJLSucB4GJwekiRca7EOpCZSsxHUTn5+rb7Op1RLjpZEIlzt9wjDdQYDAwMEj1qZlWozX+Tw6b8M8ICjWhttoit2Xci/DC08JYxECjNwEZWskvOkZJyKd4+BHcohTjn7Cd9ivTDQK/+W4jCHgCH5uPljs3xGLlnCHumRVH4pm74u/AWfrg0p8Cy+aQlV3qkF1rM+Xg0wRkast/SaDkQI5ozNmkQP4mXqscfiJTVF5MOyfJAm9MHH5SrmIgRYAk6TN0cATQ0yrzLbW88kOxzz/2j+yPOBVIR1Ovz18GBGzu8iys3+vxmK7vVXRCJjecUfpAPCWqJBkQmBRNfEGBZfpwqfynqTwPFNKLkKs37jzJGk3YoqEfMNXWTLP7L2rGri2VbsY0yMicJA09+petNA+ALrKcPsOSuzKco7+wxg0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a466e4fd-5079-4a9a-2f66-08d7eaf6e305
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 22:03:58.6557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBmonRXUjjV4Q3UoV8uUgFP3jRAaQTu5FMvAtOS2Ki62fkaFMJyTKoXTV3u5IWmeIhghEOB19J3vu6H/tGCing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1432
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> it's simple enough to revert in case there's any issue
>
> thanks,
> jirka

Can we go ahead and merge this?


