Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1395C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E0F206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ne0pGvO4";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="gjGez+WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbgIHQaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:30:08 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:3548 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731947AbgIHQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:26:20 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088DtdCP027328;
        Tue, 8 Sep 2020 06:57:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=0xCgDXvubvq4R0DhXqBhqzvbnRa8Xx6jIq7Fd73Lw/E=;
 b=Ne0pGvO4Q45+fD52G1WSz1z5aM3n7OCuAhEnNbjX7pc1TjIDm2PbunJsswN5DMGrewGl
 78NC2F/avOzskO+P3ZL3GilKNFIqxZWYvuC5wEaLHqxY9JjrfWZFTPjJEeuuShVeG/6M
 QBpVBf7e49kfE8nmBfeQKjX6vzvv9lcM5aDQluMoeezp6ggbu/4dWyufDriHbKnHN5Ga
 koIb3avTfNO/OngjB3O9sBour99HpSIrzh0YCCdyNRTkydV/PQ2uE1QyyzB7/aVKh/s0
 wXnxUxVRp+gcTLEUzU5osV/yE9R8jiVC1CRt29ku++DhNuILHV0tasaZvZ2hJ+TNn0OL rg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33c68whq59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 06:57:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KilSO6b7i8GKrfNhTTFWjJtVxO8D8mFFTqUKT9YFD10MOWU6iBfu08lRU/t/eK/eZt4FfXdR7hFr9i0HXlUEZr3AazTp3HuSikUZ6S2URMCn8VetZigGClZfuMuq20//djh1KpKicL3t2nFETCmwRE6xrFTckftDGroKg9CT3v8XtVsKbg3aGIZOz3XuV+doW+7v03ZfK/IrH1PH7YWnTYQ5FSO99+zCdVY27dv9T1Sc4isWzg+fjkY40jv5NkLmk4FQeh2HOZuX+zgkUmmLIwElIRE2Ypxe5wy8sP1b3dTwk/FAE9nDvue9javxtiKmY70UR1qWQsLJ5zknPYBkMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xCgDXvubvq4R0DhXqBhqzvbnRa8Xx6jIq7Fd73Lw/E=;
 b=jCiFRdboLlqemf4rrPCIfVQvlpk5vXDCpLUmZSWEqR06+8HKb1EP5/B93eR9BoK3htlE0by2OaTZzgh2EHqlMTg4MvJOPYmcSPJQacfeW/0JCbspEOQGQt//Hokj2tUW2MfML2js/1oJmRfrOWfrUuxYtBzImlSNT1cm9OO0mCU+NTUAqNWUJzuOlZb12Uh6PX+XSREkBJNnfZO2ratLWbr+PSWL2pnXX/sJu95GC/x+N1y3BHanmj6y2RrWIx0J3RPgf0aNECZLA42tTGwDhNsnTZtxjxRO2n8E0CbIFMVz5Y1Z2V1rTNHG2XC2tGL77xa1NIEmmM2ye6/apyEp3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xCgDXvubvq4R0DhXqBhqzvbnRa8Xx6jIq7Fd73Lw/E=;
 b=gjGez+WOVbAy6TwfRUaC574m+rxIoCqVX5FhxYy2Uy5hwHNb/8/HgBhGWkgSSwU0fkA/tx3cUmtFhWxXbXEhXJaDMyG3mFOvwL6vIDPzJdNv/s7cBHotz3IO7xcodUpDRGjeypZhvWK/5SS74SMH89nnKTPtSz+Aq+CWUkctpAQ=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB7017.namprd07.prod.outlook.com (2603:10b6:5:1e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 13:57:55 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6%5]) with mapi id 15.20.3370.016; Tue, 8 Sep 2020
 13:57:55 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v2 0/7] PHY: Prepare Cadence Torrent PHY driver to support
 multilink configurations
Thread-Topic: [PATCH v2 0/7] PHY: Prepare Cadence Torrent PHY driver to
 support multilink configurations
Thread-Index: AQHWfHYF12exyhh3oEWcahnhwHvk/aleQnCAgACUHsA=
Date:   Tue, 8 Sep 2020 13:57:55 +0000
Message-ID: <DM6PR07MB61543BF71CE5CAE3611A7A31C5290@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
 <20200908050533.GB77521@vkoul-mobl>
In-Reply-To: <20200908050533.GB77521@vkoul-mobl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00ODI2NmM1NS1mMWRiLTExZWEtODUyYS1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcNDgyNjZjNTctZjFkYi0xMWVhLTg1MmEtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIxNzYzIiB0PSIxMzI0NDA0NzA3MDg5NDAzMjAiIGg9Ii9RcG5ScElyamNlZWpvdk53d3NQY1lhMjhTRT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49231b4f-5cc0-4c24-d2ca-08d853ff2fe2
x-ms-traffictypediagnostic: DM6PR07MB7017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB70178F8487FFA8B64DCC72F5C5290@DM6PR07MB7017.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2n2G+xoj0svr+wTGJ6FiOTnDv/MAx+NG3XpAEG7zan8+V7Z/YQI/nRZW8zL7EoSGXqb7W88ZRSv/aDeOq0mKFDM+fiO98+kae0I1wABQ/sBMP0/ivAHoOJAlLT23kRcjH+uuo/RTi9DLPvgFUfCgW2IBBCUy6BoJLj+5tYK5MlmkW/vAPyGaTz/R9Vs9pJ7jGT1d84aToSkgiDFYiLpd21fn6fGDaK39rc2A87RU48rDUnOYlWuA6IlotNzAjrrgbuiGnWqU0k6HkmDD4e6ZvPl4KpBgV69PC2tSXNsbs6g3Ytb59Blfs2hIEjxuR84OHF4X3q1JYoFQn3p/sMSITrolnU1wvB6+CJ54yzY+SRbOQrtuzN78d1vxEjzxPh5F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(36092001)(86362001)(5660300002)(33656002)(66476007)(66556008)(53546011)(6506007)(26005)(54906003)(478600001)(52536014)(83380400001)(2906002)(186003)(4326008)(8676002)(71200400001)(6916009)(7696005)(316002)(66446008)(66946007)(55016002)(8936002)(64756008)(9686003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NUmPXU6nfu3jgUO0OGY87p4RQQR7SMwa1BRyTHjWsD7fubQRSruuEOlZmoCaIizYEFb5M8RjHXYr1dJiIfdbfKmW2bmCSDEX5JYEtB+NDo6iPDcBDeAcQ6+WUhpeF0PSZvlMIndUlQP079+Um/U3jwmOSd3q3jVxXmImcaakhK9cI3Ee1xLgEzmsh4quCfn2m8pjVgm40aT4gqGJWm2VZam2iwSDqDmQ0z/+Rvy9s98SlQP6ARdjKWPb3rJsUGwUCQGnmTk/BafaqxA8UFS5Cl3H3ESiLp75KsonFK6fLvzTQZKqysVXXxA5jZuowrw4jnQntYYkNux6Vu5WCqAcAXqPoZ22ASEQop2A8gImcHnonHM4Pi4Dbh+EhTyP3Jd22Zp1to6bxaycps0kMNGMn32J17rtpxh70q2dPHIFyYK/uTev4eZaP4gutTEQ15SOf04ZMSr9Hzc0wkCIVM8Cp3Ha6swNoNVwRmawnZDYp4h6F+Du1Cu/IiD/i0NS2iVJtMsKFkuXnI0mV9/maiR0n1EaQFrs08ohXv4OeQxFj7OgOEsApq3XvnD6aMJnQ+mnQQeDMQ9I8umX85urX/3Z7t2lTzNM86ZBwdGmg1BHm4ba6217EbKm02AFxFNNqskaKGp0GfeccqnA6s53quHZtw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49231b4f-5cc0-4c24-d2ca-08d853ff2fe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 13:57:55.6176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xliBL0VuHi1PRNy1teeonYEIuZTi4ez1M+myfqaIJ1TqzJ8aYLju3KufXdu3Ivdkymbww13TfBUUwdkUelSwBtCVy7ayfcsHOQ62dzsJIxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_07:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=671 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009080132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

Thanks for the review comments.

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, September 8, 2020 10:36 AM
> To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; Yuti
> Suresh Amonkar <yamonkar@cadence.com>; tomi.valkeinen@ti.com;
> jsarha@ti.com; nsekhar@ti.com
> Subject: Re: [PATCH v2 0/7] PHY: Prepare Cadence Torrent PHY driver to
> support multilink configurations
>=20
> EXTERNAL MAIL
>=20
>=20
> On 27-08-20, 15:28, Swapnil Jakhade wrote:
> > Cadence Torrent PHY is a multiprotocol PHY supporting different
> > multilink PHY configurations including DisplayPort, PCIe, USB, SGMII,
> QSGMII etc.
> > Existing Torrent PHY driver supports only DisplayPort. This patch
> > series prepares Torrent PHY driver so that different multilink
> > configurations can be supported. It also updates DT bindings
> > accordingly. This doesn't affect ABI as Torrent PHY driver has never
> > been functional, and therefore do not exist in any active use case.
> >
> > Support for different multilink configurations with register sequences
> > for protocols above will be added in a separate patch series.
>=20
> Series looks good to me.
>=20
> > This patch series is dependent on PHY attributes patch series [1].
>=20
> I did not see any obvious depends in the series, if it is not maybe good =
to
> rebase and send without dependency
>=20

Sure. I will resend the series removing dependency.

Thanks & regards,
Swapnil

> --
> ~Vinod
