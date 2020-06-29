Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C11C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22159204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="cKQTzJIz";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="t9lhMlms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbgF2S6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:58:13 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:37956 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730227AbgF2S6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:58:10 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TBDC87023572;
        Mon, 29 Jun 2020 04:20:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=5jHi/UCFtB3qiGJ580HUSbqb6VfxUpnahNWGTm1U/Bo=;
 b=cKQTzJIz4V7/RImluM6V8kF75PrA6sUVxgr1+g7HnYxKfYjyVPrd7Xc6574HBCeWRmPD
 ki7eu1co0uAlWvG8vPb/u6cEGMokhSb0gsKn/H3gLCnnUcsJ46Vy2zN1UVdxIff9jkjd
 3aru5gbnDImqLs8c2vcV3jYWGxVOqRwj0X1ZYWm9gAfNb8sjreFxGWbv+qESc0TM/cHB
 /5ubrDl7DtzI9hSPG8DHIos9NUPI4ud0iAEsmPerseu1eBupjb0DpP2zPxu6Lidxnfeb
 PSTLeoXrp4L976DLmlBnBi6Cez/RdojyNNnRQvqvJ4jTkHdNNUK8L5xSEn2Ct5jRe41V 0Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxns58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 04:20:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWG5fm8iSOwGV4IsvXPtpXS2B2k8SOFYzm6dleNpt3gyHGRy/Ow7r+6Cz0+fwoY3H/DZjc+FYufdAYr7Um3nFr5k1+5GxS+Qbya/cHtPoLsSrFXaxEga2qhmmCEyE0zfhVZpmA6suyezHHiCr5RwXf+eDeRQq6ptulkU1emdxNsc5PJVD43tFWJVklcyzRG6nAwlGA5KzbdKkOAZXA9SLKVdhjhhMLCxeW8ZwGknH4+pW0V7eBlILAG98Rbq/R+ZvCypcdyjnVMrLOWvRnRwUnTzMhMiYZpiYMfHqYvtUxBCJsATkArnStvU1qlnlFjPGadG5Cta89xP8hwSnwETEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jHi/UCFtB3qiGJ580HUSbqb6VfxUpnahNWGTm1U/Bo=;
 b=PPsHw34eMusjCWk3agbO1WvvYabAFtLbt0ulI1CsJUpnYhx77RkM1QfT6aeKVsx4gerasiuUMRz1mpqNVM6Y4GGewCn17IQ7cVop8RB54bsSDF769lBeFulw9e9Ct/TlwhaHx9ZFnQfO8V5KA6BHeYkITeiMdTAI7kGsylYvBjWpaXl5tWAbfmgVwnp92Ay/FHE7Gz4MxWIi0p0qOgrTOfMDLaj1PopbYjn/tLSGRn/ZWeoXVSPnbEufCascaQonqZ11AIUKHMLXfmpn0JjTIgx4K5+bmWmX53YHE8YOZ1TViTPwI9XgkdYbjsKGgRfmboC+UEKOAIca79AN3xmOeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jHi/UCFtB3qiGJ580HUSbqb6VfxUpnahNWGTm1U/Bo=;
 b=t9lhMlmsNtFFVVYQeK4lePwgqMWSTpDYUobEuNSF1FnXIEOD8qkPEURu/x6AwwvYrpK3kIBJcyD0xBXYBQ9n8jDQO2zmPInIzCtXqE65pxMFGYHh7oPmhqVp/xlwQ+msFTA+5KUTfv2AVe5RUoPNeEL2jC3W1checH6PKZJYE4M=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM6PR07MB7097.namprd07.prod.outlook.com (2603:10b6:5:159::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.25; Mon, 29 Jun 2020 11:20:00 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699%7]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:20:00 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWS3YSDa4tJNrkMUOR89XcmNbpYKjqdbIAgAABeQCABIBZgIAADfQAgABtpzA=
Date:   Mon, 29 Jun 2020 11:20:00 +0000
Message-ID: <DM6PR07MB552969E5B50BF3B29547DAEADD6E0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <878sga5nfr.fsf@kernel.org>
 <BL0PR07MB5522A8796EE7BFB5062A8E76DD930@BL0PR07MB5522.namprd07.prod.outlook.com>
 <20200629034213.GB30684@b29397-desktop> <20200629043146.GA323164@kroah.com>
In-Reply-To: <20200629043146.GA323164@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNzcwZmViNzAtYjlmYS0xMWVhLTg3NjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDc3MGZlYjcxLWI5ZmEtMTFlYS04NzY3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMzk1OSIgdD0iMTMyMzc5MDMxOTg5MzE0NDMzIiBoPSI5WXVBelBzQVNWVng1U1ZKTUthaWxJWmFJVkU9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [34.99.247.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e959c437-d236-493b-0907-08d81c1e5d0b
x-ms-traffictypediagnostic: DM6PR07MB7097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB7097425B2E197E6BFF5E3E1ADD6E0@DM6PR07MB7097.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PdOThiBbIjmHLix58xgsk4HUJBliJI8kCd62fU8Ic2APyLRHmHrO8o10I6yzLap00Xg7m2zfbvsp/v0OyQUGmnLEj0lJlhXAMDdS8Tl74M9XqUkk+LMLSud/b65UkDufQa1aJ0TOOPulwd+0KAQdaM47mOkGBLtAOfm5q6e9aUdrrONbv3RS2Ha2YURp8ZoIjJAsocmCEWnm4dDjbsoA7xat0RhWCcs5dgLLP8QgdzHXuMHg11WeTwIAfeTg3rPMvXcUgldPfFwBlmlL9uhJ+lUKkW0Kqt7mUrloeACec3ueQswWkwIY6WfnrIgd4vsLbQy7qqfgtSMGJ0OQgLMh3JMkNAhCov3GFa01jO+Wb3Mn3BJAQALaNulPs0sHSLAD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(36092001)(76116006)(66946007)(4326008)(66556008)(66446008)(64756008)(66476007)(83380400001)(33656002)(9686003)(71200400001)(107886003)(86362001)(52536014)(2906002)(55016002)(186003)(316002)(54906003)(110136005)(6506007)(7696005)(478600001)(5660300002)(26005)(7416002)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6OihWNxdoRcAsFDXccdi5sJxRPIJEwIpBwjS18ezLtSRgaMcIwNoWT5ahVXPcGlTXKp6ZteanEArUX+38xVQIu+pE9oUnugVIAd53sr6Ic74D2UvsovxQo/tRUPWIvdEJ6S/GU2A/qC2kJlpqYjzUIGwx/mrRguTSCpyKY67h1k3XDhCZJccUVyYvmmN4xQnQvaAWObGuj05epQfsg9IZ2R4K1d717EbMTn3uoF+edOL5bcGJwhfMaBiomH3PsPx2wMAuSlhDUvD7awLsu/7/2a/LNqVJ99Mii69H1zMrslAUg3GQNVn+yaailxEpIs22up1xR6UyusHlM3U03uI2jKZGHayBMvaY+f+gEzUSaVjCyXZubanglbaVT830l7lPOvhi5YrQGtjvmWAnJ+dYScnwkA9hDjWNY4Sj8TW+b1xXsStLQXm4S6UVc8pSppVTqUTX9b2+vt6VJq+db5n0gSrjz0xeqR8ldkiZ0KmJGw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e959c437-d236-493b-0907-08d81c1e5d0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:20:00.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxXGq74zoiWUT0zrdqchMqP5WkbikDy4xmta+cw2xzp8CD6Go02iI4Nlng5nz6Uz2LnWLzq/aACOvu+xMBtr0Izv58tMQ0JfSa3vxxM7awc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7097
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=890 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> > Hi Felipe,
>> >
>> > >
>> > >Hi,
>> > >
>> > >Pawel Laszczak <pawell@cadence.com> writes:
>> > >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>> > >>
>> > >> The Cadence USBSS DRD Controller is a highly configurable IP Core w=
hich
>> > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> > >> Host Only (XHCI)configurations.
>> > >>
>> > >> The current driver has been validated with FPGA burned. We have sup=
port
>> > >> for PCIe bus, which is used on FPGA prototyping.
>> > >>
>> > >> The host side of USBSS-DRD controller is compliance with XHCI
>> > >> specification, so it works with standard XHCI Linux driver.
>> > >>
>> > >> The host side of USBSS DRD controller is compliant with XHCI.
>> > >> The architecture for device side is almost the same as for host sid=
e,
>> > >> and most of the XHCI specification can be used to understand how
>> > >> this controller operates.
>> > >>
>> > >> This controller and driver support Full Speed, Hight Speed, Supper =
Speed
>> > >> and Supper Speed Plus USB protocol.
>> > >>
>> > >> The prefix cdnsp used in driver has chosen by analogy to cdn3 drive=
r.
>> > >> The last letter of this acronym means PLUS. The formal name of cont=
roller
>> > >> is USBSSP but it's to generic so I've decided to use CDNSP.
>> > >>
>> > >> The patch 1: adds DT binding.
>> > >> The patch 2: adds PCI to platform wrapper used on Cadnece testing
>> > >>              platform. It is FPGA based on platform.
>> > >> The patches 3-5: add the main part of driver and has been intention=
ally
>> > >>              split into 3 part. In my opinion such division should =
not
>> > >>              affect understanding and reviewing the driver, and cau=
se that
>> > >>              main patch (4/5) is little smaller. Patch 3 introduces=
 main
>> > >>              header file for driver, 4 is the main part that implem=
ents all
>> > >>              functionality of driver and 5 introduces tracepoints.
>> > >
>> > >I'm more interested in how is this different from CDNS3. Aren't they =
SW compatible?
>> >
>> > In general, the controller can be split into 2 part- DRD part and the =
rest UDC.
>> >
>> > The second part UDC which consist gadget.c, ring.c and mem.c file is c=
ompletely different.
>> >
>> > The DRD part contains drd.c and core.c.
>> > cdnsp drd.c is similar to cdns3 drd.c but it's little different. CDNSP=
 has similar, but has different register space.
>> > Some register was moved, some was removed and some was added.
>> >
>> > core.c is very similar and eventually could be common for both drivers=
.  I thought about this but
>> > I wanted to avoid interfering with cdns3 driver at this point CDNSP is=
 still under testing and
>> > CDNS3 is used by some products on the market.
>>
>> Pawel, I suggest adding CDNSP at driver/staging first since it is still
>> under testing. When you are thinking the driver (as well as hardware) ar=
e
>> mature, you could try to add gadget part (eg, gadget-v2) and make
>> necessary changes for core.c.
>
>I only take code for drivers/staging/ that for some reason is not
>meeting the normal coding style/rules/whatever.  For stuff that is an
>obvious duplicate of existing code like this, and needs to be
>rearchitected.  It is much more work to try to convert code once it is
>in the tree than to just do it out of the tree on your own and resubmit
>it, as you don't have to follow the in-kernel rules of "one patch does
>one thing" that you would if it was in staging.
>
>So don't think that staging is the right place for this, just spend a
>few weeks to get it right and then resubmit it.
>

Ok,=20
I try to reuse the code from cdns3. Where  such common code should be
placed ? Should I move it to e.g. drivers/usb/common/cdns or it should rema=
in in=20
cdns3 directory.

thanks,

pawel
