Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA52C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C9D20769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="aiPrFn/+";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="TlWJRenS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgEMHAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:00:19 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:58204 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgEMHAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:00:18 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D6qH0v031240;
        Wed, 13 May 2020 03:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lWeHnB+/vgefGqljLYwg1/K2H3pAtNs3V0lXkdzUT5A=;
 b=aiPrFn/+TIbjL0N98bd3HPUJ968skIOHLVaACBPCkC6T9cbCsmBdmWRskugN6hzNnOtc
 pHxdMA3hFcXgUDvqCdI54LfiyzaJIBnCsp9WKr49aV+XfOBiN4sBtDi7Vh+Dyhg4yMkK
 QB6DAFoaYKDDhlHEFFbKScdTzO8BsbIoJa/zXxH8XjjSjpyzlEhTYD7TM4LLAoZoQ/zo
 XX4jkoB/1xiCtLqGMl+SQcHzMNz1VO92Ru0Y3uaWp9ox/oUQKUEjcAMaGrEGhe1kuGUU
 Pr/kvIaJgm6yKcilF/xKeogrTH2C4zCS9zaeAtL7jhg2O2USv3c7o70V3P+hiDbig6PT oQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 31011b9g1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 03:00:15 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04D6wSgo037123;
        Wed, 13 May 2020 03:00:14 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by mx0b-00154901.pphosted.com with ESMTP id 310b13gunx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 03:00:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZx6xt2KCi9wyAf80/QEvr09v3gFm1U2Rhjr/fjQ2UN4z4GRIZ5m9K90My6UOdCVRQfrqsGBmVohMve9Wr7J2S6Y+DYDRonvr2MmunjYiTx7Oi7wNZrJRoxNnb+5dgGDx9Dj5kMWXB3qQ/OsCNFJNrKnUv8lcPJFjbGngP5EXfYMzKmZLZw0Olsv/g8zRfDry+3mejC7TFLcBduf083hRMyeGXPGhnMX4M5tq1ARD+3Q4eF9jja+BcW0DPb5iSmo8HUtzS7/+vfmOvszqZDyB55FK19fTgv7/VdsQZv3U0FfQl9yu7CZvEUyPZwZYAlA7MSZLucuznu3qd+/SFetDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWeHnB+/vgefGqljLYwg1/K2H3pAtNs3V0lXkdzUT5A=;
 b=br3vTU/Z9F57LjNWjHlCVlimCmpEfKXrSvwnZCwI3LRxe3Y3N79ME8XrstOYrpFwnUYwXqSNQ8CRfyGJ+PCeeVZSv8AzjEKRFJ27NcgrhamwckOAVgfzyodyFuS0MtbzoflS5zA/0j2XaNVBn/J213eZjDDaAvxVMkS386BlDGFRrKZoJ7jz9C/tns7udeA2JDkUmXzUwFHwvBgAZutsRASr23/i8E/Qbr3vVLQ4I+ZeuDdumUMkhWATGlp++sH8Jonbh+v8hEtkTEtmbVbtWK0zmlUGclMkHuLCNKbLIdaEeR8L9TSyiqbF1KDnu5F2blQQGT05CLrF9TvXs1qLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWeHnB+/vgefGqljLYwg1/K2H3pAtNs3V0lXkdzUT5A=;
 b=TlWJRenSWam47KyCbOnKt9hUtHnBUHWp7JOHuQge4oDLwTvOpWQCSmCTdwJHnXYshpVP3Od4b0f7jV5qY2KqeH3nQPjcGKkX6FUSGTgJ2Fh+O46MWgDdUs99lAH3HNwNDUi070u17dTwBQoeLllSaaVpnzvTQP/mc1jmp2YKj8Q=
Received: from CH2PR19MB3767.namprd19.prod.outlook.com (2603:10b6:610:91::13)
 by CH2PR19MB3813.namprd19.prod.outlook.com (2603:10b6:610:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 07:00:12 +0000
Received: from CH2PR19MB3767.namprd19.prod.outlook.com
 ([fe80::6463:3b9e:20fa:3c37]) by CH2PR19MB3767.namprd19.prod.outlook.com
 ([fe80::6463:3b9e:20fa:3c37%8]) with mapi id 15.20.2979.033; Wed, 13 May 2020
 07:00:12 +0000
From:   "Idgar, Or" <Or.Idgar@Dell.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Ravich, Leonid" <Leonid.Ravich@dell.com>
Subject: RE: CMA enhancement - non-default areas in x86
Thread-Topic: CMA enhancement - non-default areas in x86
Thread-Index: AdYoj3CyDXSuH7upSp+PFUP6/DQ3LwAYv2CAAABMfIA=
Date:   Wed, 13 May 2020 07:00:12 +0000
Message-ID: <CH2PR19MB376794E120B9B02856DC87C3FEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
References: <CH2PR19MB3767236EDC9BE964FC3AB91BFEBF0@CH2PR19MB3767.namprd19.prod.outlook.com>
 <20200513064755.GA763968@kroah.com>
In-Reply-To: <20200513064755.GA763968@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Or.Idgar@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-13T07:00:10.0854756Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=1518a326-89d9-4849-aa8c-d6108e27c950;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [152.62.109.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2073eff4-4aaf-4dbc-844c-08d7f70b4853
x-ms-traffictypediagnostic: CH2PR19MB3813:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR19MB3813D73ABFA94115B2EF33F1FEBF0@CH2PR19MB3813.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1kdpycAbfWxg73mtZ6JvcurwRNr4hG0tx02wc4KyMg+lLfen2RZXYtzg5uZT95b0jWHZ5HQF1ghHvu9wI/3lF+NwupQ4sVehOQN9+ug4O9k8Pfl9uo1DfxSSgN10Z30dwm1eHV5kx6TdQ8ZnsHQ8mqKA+PV5ryNX91/ReZM1S+Ywmmmu3ejRqXO3kxXU+EReRqKpS02wwgo3fIr1Jnbs2hLXMwtsKJJtIrNcvyqrAJQZdZXj1Gxv/Dqoqmqcz8GMxyEL9/naFbvjhzc7Fg68/Q04olvb+mNdfdBsKBvqdahfI59Ovh56LHCsrahObDnqRci7zkSPt18qUvX4+1DrvsCi1wjBZnoJ9D234mCWIqz8of0PDij6gkLyT2uWwtHTIrToMnwdWNV8/V+63A68mKqQkebh+AK5+6AZESJ2ql/YLvrD9+pOAJsdujI3uWLqpoAGIL5p/NXaIjzkGwIj0wzgQXI+ksGnux1w3yS/JreSjQjxSkKDTxBlpg/cpTyZfX4aLHuXb3Ic5PAXNRWMOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3767.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(33430700001)(64756008)(66476007)(186003)(71200400001)(2906002)(4326008)(26005)(52536014)(66556008)(107886003)(66446008)(66946007)(54906003)(498600001)(33656002)(53546011)(6506007)(5660300002)(76116006)(6916009)(33440700001)(8936002)(7696005)(86362001)(55016002)(9686003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Til79B6V0M63hlcTtHU1m7ZlaCs3krfk1Z+3YsqTGXF0SHK9gYcemcPdbAqRAro8ilZDTve1OjKljPagBvv/wb6ifqRFt+DfgE0w9mtPnx8Gi0I8h9AOSZxf7St5gjy+Um1QawG6AUKS2y8n+KRGyTeawOAsrGdsHUNQBID82qiLsY7U3DNlOeH2zxKDzna0RMDM2GiiNcOfYqCDCfwjy3V4LoXY0t2WWd7oLVQBWES8btIeJiUvVxBjipGZMNnEGVeCFbN6/R1IEg41p4Il+Y2BnCEJYtGXuhH+rZuWeaIlemTH5Y/VVwKo2OxSTtBRXKF0kxxCRLrO2mjXV0tKmIHh4RzzWh2EE6lwAvikzDYWBQGLY21w04QDLqt0YttIpu2LVDFdug9pV9m6UnTw53W1p4Ot3QVQXUo/eUPiAN4Op+PG0zNXR1iST+v6y7GWVsbW3OTATvdSTA24k3V1ySgJTHwnnzMl7381LDkZPaDFJygEe3Urzf4/D9dghJ2O
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2073eff4-4aaf-4dbc-844c-08d7f70b4853
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 07:00:12.5531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0voX2WeWBo86Fo2guVJcsNfI0Y+m2aB+3eNcf6lSrVLDHCH0Zg+WoJOWj65laX/sUhIAHzgyF7qGEWMEN3ku+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3813
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_02:2020-05-11,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130064
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 cotscore=-2147483648 mlxscore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For what type of device?
NTB (Non-Transparent Bridge).

-----Original Message-----
From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>=20
Sent: =E9=E5=ED=A0=E3 13 =EE=E0=E9 2020 09:48
To: Idgar, Or
Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org; Ravich, Leonid
Subject: Re: CMA enhancement - non-default areas in x86


[EXTERNAL EMAIL]=20

On Wed, May 13, 2020 at 06:13:55AM +0000, Idgar, Or wrote:
> Hi,
> I'm working with Linux kernel on x86 and needed a way to allocate a very =
large contiguous memory (around 20GB) for DMA operations.

For what type of device?

> I've found out that CMA is one of the major ways to do so, but our proble=
m is that CMA's default behavior is to create one default area from which a=
ll devices can allocate memory.
> when booting, there were some drivers that allocated memory for DMA and u=
sed CMA memory if exist. The problem is that it takes memory that we need f=
or our device and we want to make sure this area is dedicated for our devic=
e.
>=20
> As I saw, the only way to reserve a dedicated area is by enabling OF_RESE=
RVED_MEM which is available for several architectures but excluding x86 (an=
d as far as I understand relies on device tree which is not in use with x86=
 or at least cannot be configured with OF_RESERVED_MEM).
>=20
> I really want to leverage this mechanism/API and thought about modifying =
the code (and hopefully merge it upstream) so multiple non-default areas wi=
ll be available for x86 and with a way to consume it by mapping specific ar=
ea to specific device.
>=20
> Is it something that will be open for merging if written properly?

We always will be glad to review patches, no need to ask us about that.
Just post them!

good luck,

greg k-h
