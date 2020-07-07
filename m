Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8394C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA0020674
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="TcBR6wPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgGGP7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:59:09 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:42765 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727079AbgGGP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:59:08 -0400
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067FDbvr002456;
        Tue, 7 Jul 2020 15:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=GNhRPN0jScFM/a8K61cax34Mt8nOzMPtm56ADx2O51E=;
 b=TcBR6wPZVvIFYoBt5w0QmMCEpeDuIJZu3HvBmGgj3bDL8r21PpQslhJ0kzIY+Z0Z/aui
 7lfgObwe4JvGAJW5UsnKGKde7yFqN5N4W5exkJNrGHus6mQ3W23BGAlbon6EWzgIJke8
 MS8QKfgp8xMDn+KqpvBJ89W2VNVCZ06IKSfsugbVdkYQJaektQGd6mDqnQnqfCJlDAIK
 0iHXXprAThQWSzpbenzE4k8cP0YRglCtedFePD3XrGCteflQha1HMpTKePZxa3yknjlj
 P4hTZPS0Ld6+7D9D+FNFGBGqXcHQ/Nqyw6dIi8A1gmCLWw+n3p9N6W7CGmcMW11clPdq Ag== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx08-001d1705.pphosted.com with ESMTP id 322fnkhcw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 15:24:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBzmnWMMEMHIHgA6ULTPF0/kk2iVnolzsEcmv0TukFXckE8p4do2OBVPWoEpcGewqQWp6tK5uLfbVjKeRqVZ5GgM93QExisifn1dpAd/pPHrHVWYNXJ4aooDuW9tPKCZOaqKwhqRkmtZsOy+7CAXwXmA6rToKohZm1HYGinmtl9OoKnUZ3czuRhRiSt8BlTx5/B/FjUn4xzXiaCfFys4OCMQ5b8eWgspytsoK/7vQmPushyd3ZDb8OAXkBV5SHgkwipZyp93ejCEzmjsYlDuW7s5O2T5JzjRXc1Zj+MSVw1S1vc6FRrG8YOssOKCk1qOVeg71cduZbnZVqhWZZPGyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNhRPN0jScFM/a8K61cax34Mt8nOzMPtm56ADx2O51E=;
 b=DGxXq7BzeKi6QN+soyknJxo0ZXaeqGzAfTTHW8wX0dLJWXNITkgcvHSViHDU6B6+jEOtnjj0RMBDfFqOxo1ePreC2JXD9xFEog4orf95e2wLam8mbvm/auQrzH0qZcekgCKYuY0O6crzKu4ghBSmOOcTw06bbRD4GLagizi14mTWWDhtPB0IsRcl9i+9SnjeZcEji4qprCiJy3r9C66yOb732BIIKJ14DCrh54lXxadik2kbmeaFKSesUZlAsXmo0cl+sVyqa+yi14bsNXV8A4h79xjVkIvPD3cB10RiS/yUQ2qBN1TdH9ut2mEfvde1nD2I2ZY1Vy4ukR1/u9tS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR1301MB2104.namprd13.prod.outlook.com (2603:10b6:910:45::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.15; Tue, 7 Jul
 2020 15:24:28 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3174.020; Tue, 7 Jul 2020
 15:24:28 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>
CC:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: RE: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Thread-Topic: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Thread-Index: AQHWVGPIwQycxLw5iEauvXmlP6ObnKj8O1Fw
Date:   Tue, 7 Jul 2020 15:24:28 +0000
Message-ID: <CY4PR13MB117519F548B125CB2F10F50FFD660@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
 <202007062234.A90F922DF@keescook> <20200707064921.GA9411@linux.ibm.com>
 <20200707093727.22aa39e2@oasis.local.home>
In-Reply-To: <20200707093727.22aa39e2@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ce181e0-2d3b-41f4-4b80-08d82289d723
x-ms-traffictypediagnostic: CY4PR1301MB2104:
x-microsoft-antispam-prvs: <CY4PR1301MB21044967A0B000F827CC8B4BFD660@CY4PR1301MB2104.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yiPHviudlVkioMR/bgSogmLvX23WguBHizszXVO+0JsVL9K5HIFq/xxf8g2cqJhryxvgu38/zyn2GEXkxx8hYLIy1smw1C8Lfd77Vp7h1vEcg1VUTP4dyCjEmpY8IzZIwVGcwauSJWotIFB510Pw1A0gPDlS+3bYf2kLMX3/FVuj3MwR2BmS7MuFXEf12RpC/nxpNEQmr9TFzWXnAuMBgDMzti9yjwvijLqs9c9prE8e0S2pvIseDNZOdl/qM3Mf0N0epDXNww3bVyK/vYp+yat4RDUPOLYzqBl6nt8qrU/HYEwS84VeryWAwy++Ac8q953mLzF1aF/3p/yzzBo/9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(9686003)(33656002)(55016002)(7696005)(86362001)(6506007)(478600001)(8676002)(8936002)(186003)(26005)(2906002)(54906003)(110136005)(66476007)(4326008)(52536014)(66946007)(66556008)(4744005)(76116006)(64756008)(83380400001)(316002)(66446008)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t89wEvtNbrMzzDsPEAAZSzo4b6XTF1nR1jheqmu3NCOTwYoYWQgn6VG9FJbEMPNZzbyfKcXYk8BATYEwqneAVlrJCzs+vazn5LSUGeWdQMC7TbJQmBovjogqwJ7ascpA54UpAxD3Ur49peiVKDtB3qx7rC0Tv2crSJdeeihoCQKCNeNRFPDXm1MtEOSmRKJuU+6e7R9YVJEiFSZss25xzYzkayW45KyeGElRPUMLg2akuKbSox4m9lbDbQIBeEeDPP8Q2Atr/nepQEXmMxVxIImz2bxsS9zAnIxuNCu5skQf1kf5HiBRvcCenUCEFLmVAwEJoxKSnJmtjhVQy5elgOf1RT+Vs5lqxfqWJ1TvAIX73AfC428C+r79LjxmKPNbujDidGH9honTQH7xswMqGRQzteQbzq+1MpDXvHBlB2eAUeRj4b4DO+evWLGBQFHrY7boHhfuQ01V7cNHbSrWqSyDsLNY91x8cXcmaYiNcgMrjgMvnZmiJMAi0rSqpZOZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR13MB1175.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce181e0-2d3b-41f4-4b80-08d82289d723
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 15:24:28.6604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Et63W4+weARoAQv13XH0oqTO+nzrsM6CLWN9uDw1SJiORm/ihVpV1jTvC3+giZnK1fS8KiI7lGs1+TSoAvBXDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1301MB2104
X-Sony-Outbound-GUID: aNzJF2sxxi3l0y-sxPLvNqdO2Gpz9q1-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 cotscore=-2147483648 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Steven Rostedt
>=20
> On Tue, 7 Jul 2020 09:49:21 +0300
> Mike Rapoport <rppt@linux.ibm.com> wrote:
>=20
> > > But that's all fine. The change is easy to do and is more descriptive
> > > even if I can't find terms that don't collide with my internal gramma=
r
> > > checker. ;)
> >
> > How about yeslist and nolist? ;-)
>=20
> I was thinking good-list / bad-list.
>=20
> /me that has been doing a lot of git bisect lately...

I think it depends on the context.  I'd prefer a grammatically awkward verb=
 that described
the action more specifically, than a grammatically nicer generic term.  In =
other words,
yes/no, good/bad don't mean that much to me, unless it's obvious from conte=
xt
what the effect will be.  With something like allow/deny, I have a pretty c=
lear mental
model of what the code is going to do.

 -- Tim

