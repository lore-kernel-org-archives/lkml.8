Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149C4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EDD2076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ElSHiA4H";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="wSwSejXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgFZHUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:20:30 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:7672 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726206AbgFZHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:20:29 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05Q7EiDZ022164;
        Fri, 26 Jun 2020 00:19:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Jq6QQDNx3ZxJUqpMx+z4ckvyd10f/D2LRYbApjxgKUY=;
 b=ElSHiA4HzR1ETyEQwHq9781WX/iU23+kQtyAByU247qCjx9QKUA4ggibhC9rIM1X9E1A
 O7QTrSZNyHu6ALB72tT/WHPkirdGjZTRc84RIXBJObxxzu4zaCuKFbrvr0rb+l8zLuSX
 6xtOzhf12niyUJ9WwV80rY12S1Tbbmo/FSAXgnAMu4GS+whIVrrz99B2PPE0Zie0emwY
 ijgkn5RqQ9iSxkO8rEivflkvsXnx5AzDaXLqq0iG4zsWeUSpJjFYXmqT//TCUwbnm9is
 mfUgc0bt83EuHWWh1hDZGfT8MeQMqi+eLskyGZK7c1aefdySsQhphynVE3UU5Em1DItv DA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31uuqbhyxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 00:19:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H209k++9Wv53y65JRSnTA68EDedMfIjmlyW54bBjEOjzRK2AfE4twhiU76W5KoPYQkhc2IO7xz8vmHxS6yzqKrFkZyF/jvjvac5PjsNrccz5Ju6EYEY4gteRpcFxlybstiJ5UVIivtvzgQ/KNf9b6mw6VF/uuzax6WBzBSM71qlav899sBK8D/BZx8DdU4Lvzk94JjP25mhFLFjWKx/7atS4W7kev00tMbRTBh/iyF6RojzY3U20W5e10OiZ1tOS4Iqf1ITSwqfTc0vBUNXTsDP3Xw5ojDKqOz93Mn08Y8qpAT38FLI/1o1u/Nthg9e8RMv2vHu0oY22FDl/LAH/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq6QQDNx3ZxJUqpMx+z4ckvyd10f/D2LRYbApjxgKUY=;
 b=digM0a32OnQ+67L1BqRC1ADCppcOAYyzYWxVb/RJfn0KqS4iL2OP5D8qDD47WPDvR8O8AWOJz4si8oYH7zyn4hohO9vVfqaR/eN5FvQa75EdO2hGRvv1nv6Lmr8zEGhMujiUTsLr1sCbYPx1aAVxxf93vFs5pTYiYKoptdZzMiaykMyXm5ghkzfQ5fSrGs37yehViFpVCKgX0uPa0jEWaXkrcIdVP0fhZmO6OQNiH+YteI5NB72VZI1d7N/DDxJP21V1vj4YXmtBAVL2Pf8LU5JLdpUxEVH5udaGoDFeOj+08MrSC0dUsPR78cJ1hRf/mdHoqrkjULvsT0SUsbElhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jq6QQDNx3ZxJUqpMx+z4ckvyd10f/D2LRYbApjxgKUY=;
 b=wSwSejXZ8FxFoKBY+JTzckd2QrhLVM2riaXzZrDa4m+TPlulRPzRFjhRWu+VZgjnf+B0o3HOndvh4SXKX9U43O6L6GbmpoB1X8fyEHY7c/oL618bYY49kdCf8uOj/car0W8BdPkmFvR06DKzKA34AhPyyVHuZIAYo4c9Av6lB8g=
Received: from BL0PR07MB5522.namprd07.prod.outlook.com (2603:10b6:208:37::25)
 by BL0PR07MB5763.namprd07.prod.outlook.com (2603:10b6:208:8f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 07:19:56 +0000
Received: from BL0PR07MB5522.namprd07.prod.outlook.com
 ([fe80::e08e:810f:d1d7:e98]) by BL0PR07MB5522.namprd07.prod.outlook.com
 ([fe80::e08e:810f:d1d7:e98%7]) with mapi id 15.20.3131.023; Fri, 26 Jun 2020
 07:19:56 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWS3YSDa4tJNrkMUOR89XcmNbpYKjqdbIAgAABeQA=
Date:   Fri, 26 Jun 2020 07:19:56 +0000
Message-ID: <BL0PR07MB5522A8796EE7BFB5062A8E76DD930@BL0PR07MB5522.namprd07.prod.outlook.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <878sga5nfr.fsf@kernel.org>
In-Reply-To: <878sga5nfr.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctNmMxNDNkNGItYjc3ZC0xMWVhLTg3NjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDZjMTQzZDRjLWI3N2QtMTFlYS04NzY3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjc5MSIgdD0iMTMyMzc2Mjk1OTEwODkwNTQ0IiBoPSJIWGRWRE5VV2cxUmNZNTRuNUxnbFRHcG9jNmc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59818699-ce2b-4bf3-8845-08d819a1543b
x-ms-traffictypediagnostic: BL0PR07MB5763:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR07MB576352F4B05B133049CFFA58DD930@BL0PR07MB5763.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4ZzbR7u2oQH21gnseYWo0gnIa+RqF9pI9b25vy0wSov19t1G9iTiv3w/Sp0hLjdu2UxQO37L/0aaNM74TWzK2RfFWRsGGSUdyAiuZfnkWqUQMFkhpOhcRDv4AVkfmYPlxr/s4lxGMLZHy72lPZ+wvGt9B3XBfICI7N8nMZE9vfCgvF+S8rVDpcHAg0b/oRyQyYDblutz3IBeyMFiqCkNlMWMJw4xwano3fd8slJMb2bJvPXWXZuPuYaR6Og0W1EcjwasHdWThpYfDcC498zlUIix8kMVAVAqRZHZoIAariE5AjrnjG6FkItQ56lBRsHDtHeUmWjPOAVmXTLpJbUIcb/EADsBJMU/QuABmTBgFdWJB1g9p6+xNbeEyJeZly7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR07MB5522.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(36092001)(26005)(55016002)(107886003)(8936002)(316002)(33656002)(66946007)(110136005)(54906003)(52536014)(5660300002)(66556008)(66476007)(4326008)(66446008)(76116006)(71200400001)(6506007)(7416002)(83380400001)(478600001)(86362001)(9686003)(64756008)(2906002)(8676002)(186003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UXWXl1JPjPP9jXKnmioEXf9joVRVrP9p2a3e4ZxbTxw6ocLNoTGl+UubjnuB7UFJiNGAsqpBH1yckKrv1wOS4K4Q2zI1auTKv+/QrMOXdXz/sUJqJW3o7WmZfKSCeNcW8hm9/0rTliQf6lzqhHDg3Z3rC1PThxoNjwcoDCIGRKZQTN2oguXdi+L0+CFcmGUEFJKTA7wCkxMP0p17fnJFxYiA2pSDpO1lj98cPiYcMMs5grbSE3q8m3233LIzobrT9UAiKSGYGN0lXU4QLMKtei/PiFxg459E55Jul8N3UdteuCVhW3LL7JrQ4gZC3PjFx8wFyR6Xl8FpsXmwV0N4dkrRIkmSZWzDFv9DPwtD3Pi5V4h5yI3sI6dWwozMDicZWdoaXI9K1N5RgX1t6fQtSt9q0lbVAEwmDQe6LoGBRpaUV7Ep6+BmfWmYviuH/5jUbDPP2Ve1PgAvHKSR2hrSi2xP0zaEpT1khNEyyUmdc8eU9bLifXoQpihuWl2kWcSD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR07MB5522.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59818699-ce2b-4bf3-8845-08d819a1543b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 07:19:56.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVzQ0OAMtSrEzHMAeJZBdyvtctcnG6qCuuuJiE/rk0dz0SLboD8VG+MAzbMcPQ2vxDBw774uKgMuMBmEK3TTqDLDCzv7yk7ijkdbJxdqKno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5763
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_04:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=480 adultscore=0
 clxscore=1015 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

>
>Hi,
>
>Pawel Laszczak <pawell@cadence.com> writes:
>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>>
>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> Host Only (XHCI)configurations.
>>
>> The current driver has been validated with FPGA burned. We have support
>> for PCIe bus, which is used on FPGA prototyping.
>>
>> The host side of USBSS-DRD controller is compliance with XHCI
>> specification, so it works with standard XHCI Linux driver.
>>
>> The host side of USBSS DRD controller is compliant with XHCI.
>> The architecture for device side is almost the same as for host side,
>> and most of the XHCI specification can be used to understand how
>> this controller operates.
>>
>> This controller and driver support Full Speed, Hight Speed, Supper Speed
>> and Supper Speed Plus USB protocol.
>>
>> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
>> The last letter of this acronym means PLUS. The formal name of controlle=
r
>> is USBSSP but it's to generic so I've decided to use CDNSP.
>>
>> The patch 1: adds DT binding.
>> The patch 2: adds PCI to platform wrapper used on Cadnece testing
>>              platform. It is FPGA based on platform.
>> The patches 3-5: add the main part of driver and has been intentionally
>>              split into 3 part. In my opinion such division should not
>>              affect understanding and reviewing the driver, and cause th=
at
>>              main patch (4/5) is little smaller. Patch 3 introduces main
>>              header file for driver, 4 is the main part that implements =
all
>>              functionality of driver and 5 introduces tracepoints.
>
>I'm more interested in how is this different from CDNS3. Aren't they SW co=
mpatible?

In general, the controller can be split into 2 part- DRD part and the rest =
UDC.=20

The second part UDC which consist gadget.c, ring.c and mem.c file is comple=
tely different.=20

The DRD part contains drd.c and core.c.=20
cdnsp drd.c is similar to cdns3 drd.c but it's little different. CDNSP has =
similar, but has different register space.
Some register was moved, some was removed and some was added. =20

core.c is very similar and eventually could be common for both drivers.  I =
thought about this but
I wanted to avoid interfering with cdns3 driver at this point CDNSP is stil=
l under testing and=20
CDNS3 is used by some products on the market.=20

I thought about merging cdnsp core.c  with cdns3 core.c but after upstreami=
ng over, but=20
I'm not sure if it's a good idea.

>
>--
>balbi

pawel
