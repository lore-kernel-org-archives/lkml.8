Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F69C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBA920656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="b11Kx1T+";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="S56/o6ze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgF2Sq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:46:26 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:25498 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbgF2SqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:46:09 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05TBRHOT011690;
        Mon, 29 Jun 2020 04:35:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=B8/OiIvbTXemE8flIXcq+GhCm/ds5LfdlCXu51tReU8=;
 b=b11Kx1T+lkd/G7KaHRR+WivGnVNJp34j/emI1xlbEIJdsdVkdpN/oq48/on7ryrO0tyq
 eLEDOajTlOUcii8Zi5z6EDJGcZqKpAwQbUbW4mpeElkux+G5D88K+XwF4smeJ7dv5LCE
 JQsJvVnCTB87sEyfoGUIP54bMWSzx7OTN0Tjptdnmd+O57xiKiL0yzLCIg++qp1Po+4/
 PXvJZsNDVMrZD41M4XNBg0APaU4Z6p9FWpFPPW7Gd/8BMZ3K8GNLAL75UO0wf6pWzJSc
 M8iSCp+5jYuPCsngJz0Q5Jt9lkpQPJzZVdEk0VyB3dmV10o+ui4wY2ayq8LZ0auG/Knh 1w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31x2nxntbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jun 2020 04:35:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4kNLOOejVuMi7hUR7Puhe0oNbbMKhsB/N5ycG3/V+RQH7UgV/u/hp9vW2hBJSL1sbTIoW6y6jgkTv9AMwkJPQRgeOA1bsur5Din729w7o643MAsZbBNMbv5mfWKQr52LXltQPrKX5HIm2bHvNmjb9S2ZiIcxzNk7BuiIFMXMak1vuAHW0HJrgH7aVoqXbh8LDIbsDijFTxuOiHPd6SVVP06S26ROtInGs4mSQVYdAb0jW75QtDcuabPOKqpFLoMhJJYLwAw5+mYovufBVSylN2y9ONaS3TvIz8Yg98MycfitAzXL3RMNY1FNPljh7MM9pqi6C9s2Soe0acvyQedzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8/OiIvbTXemE8flIXcq+GhCm/ds5LfdlCXu51tReU8=;
 b=HT/jPCVydYTujc0vEi7cKQR/Yd5Fctd+Vhwkvy9aBGQAW7paKHAZJCLjlHBV3AeXO1D3UsUsBBDyWH64jbl007dH4/aSNbSvzkAK5yDE7gpGMHC0h2PsiKW+LDNqXEJnB1tNK1Vn+c/T5hFLf0SYwurnPUsY8dvemuOxyp9l7pNjI3X9ZgztVEAm+z15jd1kyn2WWuSzOLG3vJ8n0zF3iQQcmWBRZXPbs522Abiwx35dp+Lhz702D3+Vk6eYGmZ+KOt8dKwyo7O0R97OTvWqhgvvB3OBz4bHxmxgTWw94Pql9j1zao6SQBAK07rmGtkFkCCY7b4mOxFsRImm2tna9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8/OiIvbTXemE8flIXcq+GhCm/ds5LfdlCXu51tReU8=;
 b=S56/o6zeWVdz5dXu9hSmG5lei9NyyiTtrNhDokoincdAQTiHnyN1w9OAuUFrcBDuIVe7eln0WyFffnPyKAGfvvs/MbwCSXCKvW5Fam5FwY6ZQex+S6FOE2tT11ZaBIsa3D16T39t1FjbqJzeDBiu+rCSkTmjwfFDB6DwyKr6Xro=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DS7PR07MB7734.namprd07.prod.outlook.com (2603:10b6:5:2d2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.26; Mon, 29 Jun 2020 11:35:32 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699%7]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:35:32 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        "kurahul@cadene.com" <kurahul@cadene.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Thread-Topic: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Thread-Index: AQHWS3YeujIotZUd8kOCCktMnZwmq6jq6LIAgASPrBA=
Date:   Mon, 29 Jun 2020 11:35:32 +0000
Message-ID: <DM6PR07MB5529755E72D87EFDD1867A7BDD6E0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-3-pawell@cadence.com>
 <20200626134344.GA4030531@kroah.com>
In-Reply-To: <20200626134344.GA4030531@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctYTIzZWI0OGQtYjlmYy0xMWVhLTg3NjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGEyM2ViNDhlLWI5ZmMtMTFlYS04NzY3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTA2OSIgdD0iMTMyMzc5MDQxMzAzNzA1NzM0IiBoPSJPbWY4UDVINlpxa28xMmRkeXQza1hiSGZqcGc9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [34.99.247.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a49512-e7f4-47fe-5762-08d81c20884c
x-ms-traffictypediagnostic: DS7PR07MB7734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR07MB7734ECC6C9EFDE32BB23A999DD6E0@DS7PR07MB7734.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KrnH5VC7ao+8vcaVFafV38ze3FHl5+8lbez/252OvMllOjeUZMDznfuynqKFUuhEcJqRWncuV9kzZpddiDpr69WyQIqduEazj8+6TR2irAleN1Vq5d7VkEvZ8JHVC0nJsgrvPr5NZOYzarUsVd+CAfN1Syvm6RZmwXM6SKc87fA0P4DCzh6q4y/ryckdpyVBS9QxZjt7xHrypOKJD+/cIpMwP6bcSq/d1s+k3emqgUi66mIwFWKEQzrQpX3USjdTCtmHDpCILstfMGjHUP1rewdp/LiQ4iBOTsGYtfcPbp5ac4pgCMOynqgu1cxI+2t6MwJmPn8yT9TpGPw7Xy3Iy5NoyQ3UxrGEXpXIFS28q/7AQrYch4qV1/iygEMGMO0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(36092001)(8936002)(54906003)(83380400001)(107886003)(86362001)(4326008)(55016002)(9686003)(478600001)(316002)(26005)(71200400001)(7696005)(7416002)(2906002)(6506007)(33656002)(64756008)(66446008)(6916009)(66476007)(66556008)(5660300002)(66946007)(8676002)(186003)(4744005)(76116006)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jW3mMvcKjMqJqRxfhCsWjfKFHea2Oj5kujIbZrmBUmxTuEsqMObybcA3ZBPLaAxnR96iAAaPnmFVZQQqMsJOdQvyGunHPCQLmEOAvCN91FdEpEf1ZBE3AOc1rzlCST6+eCndabYvc5pV+8afoNMGEwh2vhdcw0VQGCdooDhkroMrnrCdwV6D5YUPARgSaBw9L7ia26ssfGODgqOsqVb1zVCumoAJW1GXUUMSMNbNuI8fX5DlTXpIfnr2z2E+hNywi1HkPOGdcmTxzB+0K99wJF5Em/1jFw93XKuhAUiolS7LuX+OeX1oJY7QNmFR3dOrJ71aBzcoV2jiezZHmla2IrJI/6xmncDzgbsgi2nqwNOops/ViBod3vNfwYvAI8reXC3EC3mvLDlitxuWsxMAf2udfL9uHu8tXxZcAjCRVKSgmykWuoqbujX547XNDb50jNZvxqPuzt2IkmI1/bHybahHAGwvosRNZPng0sdMh48=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a49512-e7f4-47fe-5762-08d81c20884c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:35:32.2181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DC4oPk/UOJJYK2+2daxfy+W+NK7sxUx/b9eFmr9hauIYeNCkM6Mwwu+IF8+xyZOk7WfAuZ/ktiEh3OI+mEBC5LqOERblHj4D3gWQ/0FPkwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_11:2020-06-29,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 cotscore=-2147483648 mlxlogscore=648 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On Fri, Jun 26, 2020 at 06:54:47AM +0200, Pawel Laszczak wrote:
>> Patch adds PCI specific glue driver that creates and registers in-system
>> cdns-usbssp platform device.
>
>Ick, no.
>
>Platform devices are ONLY to be used for when you have a real platform
>device.  If your device is a PCI device, use that.  Don't try to be cute
>and make a platform device when you don't have one please.
>
>> Thanks to that we will be able to use
>> the cdns-usbssp platform driver for USBSS-DEV controller
>> build on PCI board.
>
>No, fix up that driver to not care about it being a platform device,
>make it just accept any type of 'struct device'.
>
Ok, I will remove it form this driver but probably in a few months I will h=
ave to add=20
such support. =20

So I'm going to merge  patch 2/5 "usb:cdns3: Add pci to platform driver wra=
pper" with
main part of driver and remove patch 1/5 "dt-bindings: add binding for CDNS=
P-DRD controller".

thanks,

pawel
