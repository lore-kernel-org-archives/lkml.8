Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0B9C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650AD20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="s2hB3IrZ";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="NTfFHZPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbgEMI3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:29:24 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:13548 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729189AbgEMI3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:29:24 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D8RjS8020054;
        Wed, 13 May 2020 04:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=IR5tDzPnHa66e6Re0Uqkg9M0x1njqxxIXCMJTasF0HE=;
 b=s2hB3IrZa2ov96zToWf1UZIiaT9vLkGfBi31jFp8vptG9Q0LAE2kdkagsPvAXqOCPbxe
 UUCWcHHTyiKhamWMHL47HCWx1YQQYs7opxTqAPgEnjVwbjPqUETnevNxyyaYcNPJZF3P
 srryIScMrKiYE24RfRk5W4lXxBeLRxqV+I9HuohsG6y60gRwlzAKN9+Ag1rhPpPuG6vg
 5ikGUSPuLuu2Uczge0BfXkVuCNf5yZFNmNm0xhf7rt+x6gnyTY3FHF2bZJJOdEPn/DxQ
 wsKT0Z9O6gHT0bD8hw9oDHF0FFTA6i9Luk3PQyVgapxgqkOeCV2bV7erqXPjoR6XGz8J qQ== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 310117hpvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 04:29:20 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D8PjfX074525;
        Wed, 13 May 2020 04:29:19 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-00154901.pphosted.com with ESMTP id 310c4ch1h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 04:29:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RU3wRhsMobTKyU3I39Do70Fn/SP9QuAFfPJPiysV8hTnz4J37S+qpW2GLBw3BXALuGwvjjkrvGYGfQUZhG6ecOr3u1tMWmv0U1F7LWV/pW8Z7wgVtT7Em5RTpE9Zs1heL9zzssAb5Wlp3JQVteYVA6vcaQzaaMiItYj+V3vZhcKvY7Jqs+84LS/xGODCdByK2tLF3iaXbdVt0k6e3sy3NWuL9BY+AHN90G5+xauOzkddfOIWO3395B0D/Z+6Guj5vYcxcpAxnTYW4bVYAWSQuC647NJ1ytsFkdkF0w8Biom4om2mW4zU5UlNQObdCyjNGCwYEWvQJxrkCfKhRBetjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR5tDzPnHa66e6Re0Uqkg9M0x1njqxxIXCMJTasF0HE=;
 b=RQnvmXFnmNEmv8Fty94GXXKyKLiJVRgS7Msdr0VY/HnK8xiC9cntbrL1ASvrs7vgY2aOKXAgt2AQd1cW4KhvJMtmFWCeAwWXA9QZe9cFik60wV8GhZnvZwIY9WKO256gPIubSRmkffJkSoHoyqZ/WB8eBHzvzZNR7zxQlOtzkTreqgZlT3a50glXnWUSicTBR4z9+TyMP6NC4L8JDtbbvrk3C0luMCBPTOJq5dwZ4CR5F4NzEH3Yv8Br7LeSA9kXXxcKXG9AdCb1rZQvX41I9CsGM3TRAehDmQ09Xt5jZicpqlCNuqoLob65yaTE5syeh3pFOqFCNZeHA8387K2Kuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IR5tDzPnHa66e6Re0Uqkg9M0x1njqxxIXCMJTasF0HE=;
 b=NTfFHZPEfrx6fVQlAFvv7Ncidbx4AcrZwe81a6/VlZcjJVPm0segv6WWEqg8aLoEwp34mZycgBdEnZX0kVd0jACYeryp6sIRotwVBF4yAwicg9bVLssM+kPiNwS9hfnM2Q3o4fnlvsB8Dx63EkScH6SpVw9bVzShnMY1z9eB4KQ=
Received: from DM6PR19MB2682.namprd19.prod.outlook.com (2603:10b6:5:139::14)
 by DM6PR19MB4168.namprd19.prod.outlook.com (2603:10b6:5:2b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 13 May
 2020 08:29:17 +0000
Received: from DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::a586:af72:89c5:a6a5]) by DM6PR19MB2682.namprd19.prod.outlook.com
 ([fe80::a586:af72:89c5:a6a5%5]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 08:29:17 +0000
From:   "Ravich, Leonid" <Leonid.Ravich@dell.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Idgar, Or" <Or.Idgar@Dell.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: CMA enhancement - non-default areas in x86
Thread-Topic: CMA enhancement - non-default areas in x86
Thread-Index: AdYoj3CyDXSuH7upSp+PFUP6/DQ3LwAYv2CAAABMfIAAAJ6ogAACYu7Q
Date:   Wed, 13 May 2020 08:29:16 +0000
Message-ID: <DM6PR19MB26827EFC4DDC6CB9DD5C52D098BF0@DM6PR19MB2682.namprd19.prod.outlook.com>
References: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513064755.GA763968@kroah.com>
 <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513071413.GB766804@kroah.com>
In-Reply-To: <20200513071413.GB766804@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Leonid.Ravich@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-13T08:29:14.2615819Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=7fc28b4b-51ba-4f30-96cc-d18b5a352ed8;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=dell.com;
x-originating-ip: [93.173.128.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c06b83b-8125-41db-59ac-08d7f717b9df
x-ms-traffictypediagnostic: DM6PR19MB4168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR19MB41684353E0A493EC937ADE2098BF0@DM6PR19MB4168.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jS3ISpXKUe9AyAKnI2dlaEl5uY7TNDafOxX/UI4YQpYme9isLecwnPOt+xOZnJTfUbWf6BM45DYc/a/1akGSG6y8otnTVTwJcv0gdkKQ+yxj0o5cvQKnOpS41bndbFfAVRUbD/kN0hGxcY0te0vN1jxx0tJtYVcwhsCDwXUw+6CkSKqpz7rCFcUjetwDyPsedo80A5HfIcPnSZU1mxdtmBxgSN7WFe5luY9wbRzH6fX18YsijVC4QCO9d3idxxKJR6i+D0n/2xE20+pTy/u45fLs331a9li8llw+KGm3kS3vQAfkoBo2/qH5U7gH0CK8lVuKVC1+xUXKJAeq/i/fmXRyRxGheWiEByKZWeZt67iW31vEK+55etM+VRM+ziE45wTz/zByVglXkD4A7LdrJhEHIp3IrPJVxzl3k5PJ2mXlKvzsvxp1AzDFjlCEuEWOWo4VLxJvFutQtldFNmWjO2wIgzIi503c3DE9dfpPzZ5aJ9DvRTtWtFHLPP/MvcMEQnag2UBtjh3zXE08kf9hEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2682.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(33430700001)(186003)(66446008)(5660300002)(66556008)(110136005)(55016002)(2906002)(76116006)(6636002)(64756008)(66476007)(86362001)(8676002)(66946007)(8936002)(26005)(498600001)(7696005)(71200400001)(33440700001)(54906003)(4326008)(6506007)(53546011)(52536014)(9686003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1mEM9/zaIcLmiAIAqUX4SrVh3ZgBuwbfpMcbpJ8NEmEUXLmkvP1LOpUHzxZnFgUgelFNmVNo8LUuwmRWQuzwFS1A6m8NI784lewf6om4zghzlYKh9WK4GB8dpeFr6ZmpOF0wibaMJS3eWlchd8WhTmeZIQfdjVX2Ag5v7wj8nfJaN8fC/MsmscyS4985Kg4z3d1PxcR/eIHSg/YGHE+Mqe87VNbbkSefaqHhGLqeqPcdBAiLBwEn6E8Kihrk1y6TqJ6lm/jRUHvXNIxkPqlU8WoHkkXZjzh9+5rXyScQ09CNCwxA3Hnug7wd9cTqCbB5V9ceUsXTOtg7W0pz5XXpm3RiEU5oJV3YsuCgMmHcdcOJ/YnOUUDskAIXDfqh6eOtIKq+RNp7BG0rxXbEccFsNYyh4FlizsUIzNtyWJOelpnOZ7r+PfabBNhOD1sd+gW+Guu+mzohnUAHOGywaDUOG3WAfZNssCYiT5EVLhPcPWg4g1v0ESUJmEaToM0KvZ0t
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c06b83b-8125-41db-59ac-08d7f717b9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 08:29:16.9896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1V6xbLMh6hENLIF2MkVnNRef35aI8yuNZ887M5yp3RxcZowO1/5k8aT7+rRjPevwfSYFkgUF70pg0dU1FJ0FHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4168
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_02:2020-05-11,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 cotscore=-2147483648 bulkscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=821 suspectscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130077
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=906 bulkscore=0
 cotscore=-2147483648 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe NTB=20
Documentation/driver-api/ntb.rst

1) Basically PCI bridge between to root complex / PCI switches=20
2) using out of OS memory is one solution but then this memory is
Limited for usage by other stack, ex: get_user_pages on this memory will fa=
il,=20
Therefore attempting to use it for block layer with (o_direct) will fail.=20
=20
Acutely any generic stack which attempts to "pin" this memory will fail.

Leonid Ravich=20
> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Wednesday, May 13, 2020 10:14 AM
> To: Idgar, Or
> Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org; Ravich, Leonid
> Subject: Re: CMA enhancement - non-default areas in x86
>=20
> On Wed, May 13, 2020 at 07:00:12AM +0000, Idgar, Or wrote:
> > > For what type of device?
> > NTB (Non-Transparent Bridge).
>=20
>=20
> Very odd quoting style...
>=20
> Anyway, what exactly is a non-transparent bridge, and why doesn't your
> bios/uefi implementation properly reserve the memory for it so that the O=
S
> does not use it?
>=20
> thanks,
>=20
> greg k-h
