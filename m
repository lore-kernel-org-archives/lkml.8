Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3431C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7CA20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dksmdyrG";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RTrwBVAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgF2Sy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:54:26 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:3166 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729131AbgF2SyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:22 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05T6n7Ti028144;
        Sun, 28 Jun 2020 23:51:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=+0P35LNO385j12ZZtG+CyUYW9igzCkHftnpikVV5Pss=;
 b=dksmdyrGdyEmeYeUi5zsV364NAsO1x/Mqf+T2+Htw1bhubdTysrxUVPfJF/Qx8XroH6t
 3rGKqImeAha/5/lQA4yM/48z0aB/7UZOHV/8y0XuOnOly2MiQ8q4xD2tnoPUk445Pstw
 Cu/qQiRyQpiNvI0URoBZnTI/Tx5uL6RoZZ8MDEj7NGZvn0wtws8GgRu889NsbflAJnek
 sjCeIE6bQy21lpLWwU7W3iTmYj69GBfNWVskh9k4ZpShrr4Vu95pd5wJpBW3CAQvtkwP
 HUFVyR6IYlpa9x1j5oY3JTG5koco8Ut2AjLhb1gT5A5eRIJSZm/XMN8I0FQD0T5BnJUT kQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 31x1pyd3nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Jun 2020 23:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj34d+SBjllHrzIVRq9CsYJ9lOEm/uVnSDrqLvMe5qwqcAd9vtMvj5jIEKSVtUXaIRl4KPv3+ytthEsL8r0+EOPyJYqlFq0tuItvjAf2f8QmPE930hdSHOBgLgMFcdLsiYt+4zc+n3kCJVOSpQYGyMLrArTWVT6eRvtPTxa9F7G7/FgvFw74ufyOL9SAy2cMpegvqJz/kntJRI0WIJ6dDtyOzuR5KqiL/0d2z1hFDIwqe5c3PFJzEzCkbkll+sAk7MgUKRILJ8Wg21Us0jcE7tDUPfeAzwjWVctt//mELOzKgKPtmnh+mVYW2yzf41cwrnaqrMKX8/1StEJOGob/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0P35LNO385j12ZZtG+CyUYW9igzCkHftnpikVV5Pss=;
 b=bGI48ElJ0/AibgVnY04bYG3nLbMw5kcJS9nShIvXFTol1N66yCBR0T7qkTY692eMxf6uUn/N09o/wOUZvU7NQZGs343Zm+CLKOtPlZ2CaupI5mKNQ0cx2pVFWn6qWcrMo0UGj5B7Wep/nMPtxxtUYQohDNLNxxmI+s/DIadlSoYZ+cncPdgTpjYzOUWRUN9ODUSIyYzDvhFyUmWWrzQ2r9hf8+lgdNwbWdJmIHbfQjK3rGlvIhYwG4xTFIAcqy9P8487qrtJiSF2vhp52MwSL5M+v3z4ZTA+WvhY0Df1jthcTikohOBOlDWZsLwWdFFixLtF7v4NTz9Tn6WdxGWoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0P35LNO385j12ZZtG+CyUYW9igzCkHftnpikVV5Pss=;
 b=RTrwBVAHM66pPAZGIG453G5kR3xL1Ow5TWbhwWIZSlJuW4J6NJ4az+oobORfilT1bhO2/M2eYm0Db5039zBdvDnY5LhmQXMnOgzeP/QQHvt784L7MgauGLPgifut45ZN71uBZdmCM6sehA9qoImXhaqkN6RICDgjIQ5vlM+9dgQ=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DS7PR07MB7736.namprd07.prod.outlook.com (2603:10b6:5:2cc::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.26; Mon, 29 Jun 2020 06:51:21 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::f447:6767:a746:9699%7]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 06:51:20 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Thread-Topic: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Thread-Index: AQHWS3YeujIotZUd8kOCCktMnZwmq6jqxmUAgAAx8KCAAC30gIAEBa6w
Date:   Mon, 29 Jun 2020 06:51:20 +0000
Message-ID: <DM6PR07MB55290187EE04FAB06CA69816DD6E0@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200626045450.10205-1-pawell@cadence.com>
 <20200626045450.10205-3-pawell@cadence.com> <20200626114057.GD2571@kadam>
 <DM6PR07MB5529E239FBA41BDDB52CAFC4DD930@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20200626172411.GE2571@kadam>
In-Reply-To: <20200626172411.GE2571@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZWU0ZmVjMWYtYjlkNC0xMWVhLTg3NjctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGVlNGZlYzIxLWI5ZDQtMTFlYS04NzY3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTMxNCIgdD0iMTMyMzc4ODcwNzgwOTMxMTczIiBoPSJBanFBTGQzdWx1MzFPd2N4MnZQSDg0QUM2Mzg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [34.99.247.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5357d86a-ac54-496f-9b40-08d81bf8d4ce
x-ms-traffictypediagnostic: DS7PR07MB7736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR07MB77361F36EF3DB26531196987DD6E0@DS7PR07MB7736.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6d4dQiM9qLXmzV8VSOTaOvvgHTXhKYdFcAvpKzQn5pvGWNmGAbjaAI+iEceMov+ydd5taBP5OE2p+52IzLc/wLy0IFX7U5swRX0Y1+PVDEMRIy9BrD1jxg5paUtYiWcuwjLbsMKypLCES+F51Na3ZkJnZQ2EyeSSQpHm10xckmp87nozEqZYp6/eWCmW59koiQF9F8zjtAfbpNyUUVe5TN+jEuP5ducP5ge+ULdNJhof6HjdLprcpFKNz9VgUASrJwsmlnJRxBF6da2gXgteZ5aYjc8QZ23ziTNiX0wfsT/Prt0mJ1/oqFLNA6mCir1tjCKO58GU3FQCUmOc5t0QvrB8Kx3LtoG6jj2/2ZMVk80MRQckgJcMmkH34dGuynB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(39850400004)(346002)(376002)(36092001)(316002)(7416002)(478600001)(54906003)(6916009)(86362001)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(52536014)(33656002)(5660300002)(26005)(6506007)(8676002)(7696005)(55016002)(71200400001)(4326008)(2906002)(107886003)(186003)(8936002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7AXBYED67znDSvHsRFs62CsLSDc2/0TY4hK9RJjYqiLLyYeqz+1tXHOYU0/vX8jXXZnRfT5JZKppi3TngvpbTHhEdgm55Yo6FzvplzXzWkXVd4UF8OdiBkVewYNSkxuN6tGoCLSWP35rxY5LpKa5AEoFusOQSgj5Y8vExE/D1dGDZ6yio84hKflRM5+YX/6XW8MmF7Xb1V39WQdcAKr9aQ/G5bklz7dVWqVSKJV12LDX+oksX6hfwHNRoYzcjvCOgEAxYIKGaKbX32oVCL0q2XI5tx3JVnXHdRM7M26LDdDfj8RQSPt4sRWrTHJpMyxQ7793iIMJNchmh2heARJ+cwatpEIpNdQbegnrDE9M/eU6azzMv8R1icpUHDalTFgpflg8j/bgcs/+ZzvpAmAmGzUF1SGe00gS74VpxD+Ztt3/d4OvE9TPLSpzA1IX4dfPMSw32v/j8DidGSsS+BFPxv0H1g5UBz9tY2dHfdWOpzM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5357d86a-ac54-496f-9b40-08d81bf8d4ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 06:51:20.6116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyio5azIVHur0Mxmqd0SKu/gaaraJiju+lcj2EaCRwtpFJnnnPPsVr1S7wuV/B1/zwAzCxT+Bxq+tDMeVjamBlnX56/MlZnrde+02OqKswU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7736
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-29_07:2020-06-26,2020-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 malwarescore=0 cotscore=-2147483648 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=973 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On Fri, Jun 26, 2020 at 03:10:32PM +0000, Pawel Laszczak wrote:
>> >> +static int cdnsp_pci_probe(struct pci_dev *pdev,
>> >> +			   const struct pci_device_id *id)
>> >> +{
>> >> +	struct platform_device_info plat_info;
>> >> +	struct cdnsp_wrap *wrap;
>> >> +	struct resource *res;
>> >> +	struct pci_dev *func;
>> >> +	int err;
>> >> +
>> >> +	/*
>> >> +	 * For GADGET/HOST PCI (devfn) function number is 0,
>> >> +	 * for OTG PCI (devfn) function number is 1.
>> >> +	 */
>> >> +	if (!id || (pdev->devfn !=3D PCI_DEV_FN_HOST_DEVICE &&
>> >> +		    pdev->devfn !=3D PCI_DEV_FN_OTG))
>> >> +		return -EINVAL;
>> >> +
>> >> +	func =3D cdnsp_get_second_fun(pdev);
>> >> +	if (unlikely(!func))
>> >> +		return -EINVAL;
>> >> +
>> >> +	if (func->class =3D=3D PCI_CLASS_SERIAL_USB_XHCI ||
>> >> +	    pdev->class =3D=3D PCI_CLASS_SERIAL_USB_XHCI)
>> >> +		return -EINVAL;
>> >
>> >
>> >Do we need call pci_put_device(func) before returning?
>>
>> We don't need.
>> Such function doesn't exist.
>>
>
>I meant pci_dev_put().  I'm pretty sure that we do need it to match the
>pci_get_device() in cdnsp_get_second_fun().

Right, I will add this,

>
>regards,
>dan carpenter

regards,
pawel
