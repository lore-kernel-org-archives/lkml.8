Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D022C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61DE12072B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DO0z3ydC";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="eCFag0nL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgELE57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 00:57:59 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:1490 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbgELE56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 00:57:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04C4sJu8012813;
        Mon, 11 May 2020 21:57:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=euuTC0spb8BL0U5DWEwX7YOB/+Ivz3TNlgXeoiby4sY=;
 b=DO0z3ydC9aV4W+WSJ9AMYIUG/NZiAeevg2YqQHWnZE34pVddwvW+y8vJg7gZwU8JsyQx
 6ZzbZHBr3+j512LDKFrnYnLEt6SO83zu+ekru+49X1WQ1Fzk5O+1TN58svC2K50kdgsX
 0SLgE7q4e/EY0cFeb4gDSdAs3n0W+JFU5ZDIq8P7taIH1qILI7pm5FBWoJNey74fOplz
 JIJ27mkaektSjN4gP4PyzJcw8K83d1utzr8orDoaedsIbQUXLz2fLq/XgjtD0L4Ox8Pj
 nJIve1oAwbezQ80uJHhzkmvljYXD86iBvW/bSNEKROIa0ggNVFpD5qcQBMAboKtD7lsN tA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30wr3xhf8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 21:57:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWOzLsGivY7CobEBNdlR+/je5IOhbENM6QLcYlKFNI/mira5aJU7XvonCZHOv6I2ljkJnSoVKUEowZCTWgvcXzQ/1H9xjFc8UhK/zD/6OHLqwrAJ3m/vkmTxhsygksqj4VZiYmrwn1u0ANh1qe/FD5G2Hsa0pNblXQfnwJQoS+k+PqVxqeS/56jrRBxr0wAqYszjIQeQ3lgIUU1kAQnn+esiSJGpCN2nn0uR6BoU+Qqukt+2aMHVOAazzI9LkxTSiUAbfbLZCTyIg3ciYuQzC/WncwEyy6Qa+xII79Jua9l7OS8mji1FhBtuiG1zddePBc05RG6rfbcDimbRijpKwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euuTC0spb8BL0U5DWEwX7YOB/+Ivz3TNlgXeoiby4sY=;
 b=gVvZQUG/h+Ez04Njdt7zZ9/MJ63CjAteuAAzVvw1De7gmkb7NTz0TkgLcIzz4nNk11w6QANYMzyRrvlpONGsBx3kod4R4TUR0nI4JGkblbjqpCApcdKN634uzAwdKZnS94ywIDvEYX6hlPm2oZ96C0OXZH3V93xXi5TySwuJIlo3rJkXbmCO+yIXIqYe/bBBjMu9IZVh9otxVJhtHSM+2MuK/WVp42upLRAH0z5KHmFrJmEVRLpvLpHXe4JKQ5Kl5SjLRrbCppuUjMFIBeHCw+GFhGqMhe5xcZT47Ez9pYdmFC6WhZKRTkMGGgrQi0rj3VDla4nfNtET9U8dWymZOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euuTC0spb8BL0U5DWEwX7YOB/+Ivz3TNlgXeoiby4sY=;
 b=eCFag0nLV6ThRNr3OMplUnB8gV5aSR9dpo5rc9FEvHDxiOJka5lDd3g97h73R6tLRouGlFlK4t266EfsYjH4o/nySmXFjyDfu9/UihDrAhvpSf2mbVT8MCxrX8sc5WETqow7z0XTaMJsvjMI+L+mV4W/LK8vvYdY0rhTcX62cCM=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM5PR07MB3909.namprd07.prod.outlook.com (2603:10b6:4:af::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26; Tue, 12 May 2020 04:57:36 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::19d0:3872:2f5e:220b]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::19d0:3872:2f5e:220b%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 04:57:36 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "vitor.soares@synopsys.com" <vitor.soares@synopsys.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v7 2/7] i3c: master: use i3c_master_register only for main
 master
Thread-Topic: [PATCH v7 2/7] i3c: master: use i3c_master_register only for
 main master
Thread-Index: AQHWJ5XsWXz3qDTE/0W6yV3eibAfRaijBvqAgADcVjA=
Date:   Tue, 12 May 2020 04:57:36 +0000
Message-ID: <DM5PR07MB31965A4D52023AE50A26A0DEC1BE0@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
        <1589202785-6174-1-git-send-email-pthombar@cadence.com>
 <20200511174437.1a886231@collabora.com>
In-Reply-To: <20200511174437.1a886231@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xNjg3YzQ2Zi05NDBkLTExZWEtODU4NC0xMDY1MzBlZjIyZjVcYW1lLXRlc3RcMTY4N2M0NzEtOTQwZC0xMWVhLTg1ODQtMTA2NTMwZWYyMmY1Ym9keS50eHQiIHN6PSI4OTIiIHQ9IjEzMjMzNzMzMDUzMjAwNzE1NCIgaD0ieFliRnY4bytpelgxQkNldDFTUGJNdi9HQmpJPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: collabora.com; dkim=none (message not signed)
 header.d=none;collabora.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a83499fb-a79e-4dde-d11d-08d7f630fd5a
x-ms-traffictypediagnostic: DM5PR07MB3909:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB390925E41EFB0C5D7C51B2E9C1BE0@DM5PR07MB3909.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pb4MqAH2Yw5ym0E1AOV4PVglQ3ysNWyqT4FUk+lbQX3S95KNi8icOwDByDKdFCNFK7CFardxuqosrqu/DabFQ4+ZZEkdJL7Hc/dGMt04HcDVSbFq1pD7Ac0F9CCYeOxUAaoe5I5yjqUeeTprlQu06EsMiJI36UwemK5a0uy9+/GdhkFQSMLDIrMWfLNGI2YkVJbgHQC1CztFQxXZBI821m3iqzYd2aq5A0/JxehguLGgi4G9QYrh0tgyhxHW/nk8GcYpsrGMlFgCVU1PULzdkkLqvw+57ebIWoeEaCJTh7QpC96L/kDwUtvrKrcC1m5fOgHBhOVBevSAFOxCMCe6FhiDIoAJjG6aaoaj6807m9GaSgl/Ha55yh+dkd3jwBuVUJDwwXZ1NpswzFe6GnPvjgPsTr33XSER6KpQkUL9yEhTIg8o0S8A1dYejTKGtMg/ZjsBq0sQO2zTJceSbqOxAqARetUekjnxNFHFYEZZcCLATwhQbdiLZQ43p9y1NApQAmdnDBJ0YvkPB0oC0yvnTh7wUQ8JvokDb878ecQwpoqDpmogLECquYiX8T6iXptY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(36092001)(33430700001)(33656002)(478600001)(2906002)(9686003)(54906003)(316002)(7696005)(6506007)(55016002)(52536014)(66556008)(66476007)(66946007)(76116006)(8936002)(8676002)(66446008)(64756008)(26005)(4326008)(186003)(86362001)(5660300002)(71200400001)(4744005)(6916009)(33440700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 91z1WUzGOXIgpdF7xyjalH3SP6gKYEFNdK7ekiRByNyUjDEQipjv+I8KtUaS9M5nJ+7G8JcW/4XgKOHZAp2V1I5Z9KchouOKmyEAp8pHTMx1Rt8KTiJF4RXamjv354dhQj2i7iEvWAP5A7WNyPfVMKea6PoZvkU8DyUc0S2M08qqG3UlWS/L99jPDpULqt8qb11WYCaPjnZjmhnu/tqMPEnR6PZxirtZ0SD7kQhznJ2gtVQfdVXiPn/jKPw/9xJcnspikVnrEg+mLgdCHQ7zwxyAummeZg0Nv/2vDN8cMbBWzA2RqL8LJSm9AmgY12uFgZQEIWRCxJMFfrgRufC89BrBRQmUYe4QSJXDskYBact0lkD10+omXEoL3pP+HeZ3ydYkPdUO8tGECNsKYlx9sCfP2zBq2zYXcOXb8mXGKK63jf4ELw+DYjVIyke+4RfKq4F8+ErKkLAxjxzDMkD5DY03hO8HwoxQmiPiI7uqCOk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83499fb-a79e-4dde-d11d-08d7f630fd5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 04:57:36.4205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgulMOZEPrjGa94GJa7B/cHNoh/gq/RZDBpx4o55e2PLD4/FK+IhL2rUhMWHo/RDZ7usRqYyYL+t8ClEdn78piU+N3GLTkBq3NcVyAi5ww8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-12_01:2020-05-11,2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=890 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +/**
>> + * i3c_master_register() - register an I3C master
>
>The function should be renamed and the doc updated to reflect the fact
>that it only works for primary masters:
>
>i3c_primary_master_register() - register a primary I3C master

Sure, I will do that.

>> + * @master: master used to send frames on the bus
>> + * @parent: the parent device (the one that provides this I3C master
>> + *	    controller)
>> + * @ops: the master controller operations
>> + * @secondary: true if you are registering a secondary master. Will ret=
urn
>> + *	       -ENOTSUPP if set to true since secondary masters are not yet
>> + *	       supported
>
>This argument no longer exists.

Thanks, I missed that comment. It should be removed.

Regards,
Parshuram Thombare


