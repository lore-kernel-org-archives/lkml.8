Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C173FC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4D120575
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="lSnzVcyh";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="pry4yPAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgELGmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:42:53 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:42664 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELGmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:42:52 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04C6eNEA028046;
        Mon, 11 May 2020 23:42:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=izC9S5u5jYA992Je4wXsh3vNAySf3SeM0JHqP3B1rmI=;
 b=lSnzVcyhp7LFZONkPg7h1mCtukbFTjxwIlXrJepeK3hmx/9tqBx5aqG3hmqsYTdNX3y/
 4TRJYvY0q3KXET+wvWQDs33aUdNAJxKVxTj/yy70xGnClRl0gYB5gxB8bKinZZqH7dQM
 Vpll/UZUWEG0twar1IDfRfG9t322nni1RVkyq/qep6m+sqVXZKmDX88S+sqHjs0qafzm
 mjFFhYdEaysdMBPZLsRy2u8/FX1LBGddul4xpy4qBGv1FfOcSmIjWm1H+nWlswPjqL36
 nT0dc54R4nG7CoR9YzXdQjkT9K+NOYDnFJhAQkOjM1534e2d9vcZB4YbxZuppHm3DoI4 oA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30wr3xhspf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 23:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMqgxZkxbFRi8tSMDYYEa5KiIpFYqinuNp0qaQCfu5hOzoj1e/amPotW05b17ulkxneE1MR4kRDtj1Gxso7keVVVZScA0Ec/DE4JXzPgOarRRVdCTFH57i+c8/J6wP7aEzsjUAxTYxTMWZvHTyWjbMfJY5IS0xx4HWtsMPepyJSvVHuq8g5dT3yv51axVYCXpQq+j3ydL/9YZPQGeeIvG5oFDb6W5LLSTRR5c0Q0DDvHdF+nBgdDQ1Vet/JOHliI8EycXGVIgUMXpG5EDbA8LiKze2jAl4QDUGLycnzFpWcWY1EBv+y1Wju4yPh7dO7aAOe5dK0qyQyRir4kL9Jd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izC9S5u5jYA992Je4wXsh3vNAySf3SeM0JHqP3B1rmI=;
 b=RNwqt10P3FJYNE7hpWioE6hGxI9dSyUdh8cZe1noLYTtp7sysdN+BXZxJET0dHfGZ4wfVYe8daYu/2IkVJxOf18Gb0dlxQ9nNk1hxp5wpc7ThdZzvZDxxY9Ol2mdXFMJJHxsYXy8TAzUbE0OQvlPbzESnjl0Q2kKBw57uisNpNa637ImbRyd0+V0CI9j7TINYHnS9aPdWxCt97yuH1BBwKyZdfEWXKTuAFpuScP5QfidikqCbMumSyAFXlq3RdFGFpx231uP5B1ZZ+oJXAhLC6o2uVNY0MA+3TyfX+RZ7gMB2QuIOUfRzl1FCvCj1nXpfg036Es+jV3YpUCBgYitwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izC9S5u5jYA992Je4wXsh3vNAySf3SeM0JHqP3B1rmI=;
 b=pry4yPAen0eyDN+DbTb8IOzwrLSlGcgdMgS97NEbnWlJlflFCsIlPghR633JuekrRZ4ba8uJ5bxPmTOe36tI3Q/z7U6l8tcb1FYR3U0cv8JKwlcqoQTCao+njp4wzyvoEgviabHUFn1O18NfAvypTX+XMkL+lBQEg0yWFXunCuk=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM5PR07MB3593.namprd07.prod.outlook.com (2603:10b6:4:69::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Tue, 12 May 2020 06:42:39 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::19d0:3872:2f5e:220b]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::19d0:3872:2f5e:220b%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 06:42:39 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v7 3/7] i3c: master: add i3c_secondary_master_register
Thread-Topic: [PATCH v7 3/7] i3c: master: add i3c_secondary_master_register
Thread-Index: AQHWJ5YJaB6OtFH5EE2uVwjc7BpCO6ijD1WAgADvVZA=
Date:   Tue, 12 May 2020 06:42:39 +0000
Message-ID: <DM5PR07MB31968C66BD3DEB02F6E287BAC1BE0@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
        <1589202833-6908-1-git-send-email-pthombar@cadence.com>
 <20200511181431.442cdf0b@collabora.com>
In-Reply-To: <20200511181431.442cdf0b@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jMzg4MTAxZi05NDFiLTExZWEtODU4NC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcYzM4ODEwMjEtOTQxYi0xMWVhLTg1ODQtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSIxODA3IiB0PSIxMzIzMzczOTM1NjQxNzk2ODIiIGg9Ik0wTDdlRHh5VEhmVWZJeEN4ck1rTzFBWFBVaz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29cdca84-c520-4712-b27f-08d7f63faa6b
x-ms-traffictypediagnostic: DM5PR07MB3593:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB359318CB3AA429E7D3D7C7BAC1BE0@DM5PR07MB3593.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VUec52HeIXV3IexmKKdnrcDEykCqkLfGDARI9Fe9C5ovV6JJQePVFqqguLtkuoTFV5pOIcTi++lJCbaGwevWxocVTxfo3/5J/6HFTXnLkFx2uSsfZ/pI0MDMrlaa6CIjgc71hjCPP6TRBiwLognLHZkUQv6/IruS08fZCj7FQVwKA4fjItA4kMxjvkCpI624D1o7FBrtsHbhQ6gtCATORUHRHSqwkcKVxeun7Bz14Q+JzO5i8qmgoMLYLpL9o9Hyww4x5HzVhtmJHuNVUlsyXzoUG1Gj+r+YkFtzezEJcEeZS1ehcVgOKy0tQR8vrOxLvvqZ26cAWiqsMuegWtAtqU5QiSi7GdugK9EAPP0gopg2sONfmk+t/8uxeBQeSUqocpGZZoyx1r1UfHnt7UrtiIZi8fGszj0rjJgpT58Pb2oapxTn5kgR/3ldy+pmpAcGgWJZFkwFqEs8KRBZu3X6LxjGXgFBycBL2i8ofRG5QRo65xRARoCxLV6HUbXlTkZL9UFpxILJIQ/529CO+ZamecKywHJwiuIMOOpbU9YOAZyQpBbjhcEnk92TTt2mgiKR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(36092001)(33430700001)(66446008)(86362001)(7696005)(478600001)(2906002)(316002)(33656002)(4326008)(6506007)(33440700001)(52536014)(9686003)(55016002)(66476007)(54906003)(66946007)(64756008)(66556008)(76116006)(6916009)(8936002)(186003)(26005)(71200400001)(5660300002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QUcjK+DbJilv9rn7TZ1sdhDsw6njEbofE7j8Y2m46c3cq/S1Rw03eFmXNtKz5u5k6TxgQQiXAWrcrnWeO1lJUulevkhrkc9/ky9vWp0byoJYFj2sMJ9MRQBICRNvH7Q2bKRFOm5T1Vqy0TyzAdGO6CloOGj/4oQMasIhzXpqWTjBGFdgd6HuHKT5iQExNnJonWAbIWs+trlwJVewbWf45EQHBD2kxTust+DH25IN1w5F7rC+vMUMqdErwvbkT+8Xj2rC55IDIzMl+YwzjFIfDCfv2m5kssqFaQfmJSKiQ4BJcP9lHK/ypRYNdL3lXrMY8pQFTImz/uMgTGCZ/GkVYIHVV3bdOIX/mhacV0SAvk4qZduFi8X/wS4PJkaF2srg11F506d4UvpuG7YtUatyEuXBpRZroUXYd4i3RH2JaaFnkXMEkyMWbmM1DU4jMbTBUYYWIYXZvbnMc+5hikivKrPs5ZcVfG67HGl20uQysCI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cdca84-c520-4712-b27f-08d7f63faa6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 06:42:39.7472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+6VR7F5b5Wj6yxBPuFt4JRFzsj7Cm7m4+9NVLGkgBWo4SC6mU0E3l5wAlaTYjj2ctUm22FXzXv9hQ/qMqGU/VLyzu7TluZqmFMwmBSC46g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3593
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_01:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Can you really select the bus mode without knowing the I3C devices you
>have on the bus? Or maybe that's a preliminary initialization which is
>then updated when you receive DEFSLVS events.

I think we can select bus mode based on knowledge of I2C devices on the
bus. I was expecting to support different I2C devices information
on main master and secondary masters. But that seems problematic
for mastership requests. As IMO for mastership acquire and yield to work,
all master capable devices should be operating in same bus mode.

In previous patch set I tried approach of all devices using same (Pure)
bus mode during initialization and updating it on DEFSLVS reception.
But this can cause issue for hot joining devices as current master would
have already switched it's bus mode to something other than pure mode,
and hot join would not work.
To me it's seems for mastership handover to work, we need all masters
to have complete I2C device list on the bus.=20


>I suspect you'll have to request bus ownership first, which means
>they're not really usable, just registered to the I2C subsystem. This
>might lead to a whole bunch of problems when drivers will try to send
>messages to the I2C devices and receive ETIMEDOUT/EBUSY errors. We'll
>probably need some updates to the I2C framework if we want I2C to play
>nicely with bus handover, but I think we can keep that for later. I'd
>suggest to forget about I2C for now and mark that as a limitation (no
>I2C devs on secondary masters).

Correct, here I2C devices are just registered. Irrespective of the device t=
ype (I2C/I3C)
to which master want to communicate with, bus has to be acquired.

Regards,
Parshuram Thombare
