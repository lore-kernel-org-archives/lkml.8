Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E24DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B0120674
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="IYMJ2BPI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGGP40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:56:26 -0400
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:54809 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbgGGP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:56:26 -0400
X-Greylist: delayed 1874 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jul 2020 11:56:24 EDT
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067FdIG9001192;
        Tue, 7 Jul 2020 15:55:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=YdgyI8KPty+2G/AtwV9/PVUg1oF+1DrqEbjypIAJh+A=;
 b=IYMJ2BPIWjmuornZqYGxiQ7kubA0BeSmYFTHHi2R4vbyippWv1iwc9prjCAcXwGr9S24
 C+oueBnRCZCn/8HqBCS4SOr+VdGrDOcA4FUYarjDNLIciHYrMVfMKfm4weOoLpl05Ggn
 agI9xEWyctZ8CxcrgFfzimKCPjOX4F3gDZpP9ciTmhuDbM9YT7JUNxbTLkQ1UtzqIMTb
 TbeAVS0nV3hoYix3sp5lg/hJ8wsQAVwIaX/Yq0B4h9lse6aVP8dbizUGP8cpHA8zhb+s
 ayehkeOzrEtTm0CvML1hbsdXfUAbmEH+jVPay54RD8Jw4K80GiWBmPwFytf12hrcw+Gr cA== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2054.outbound.protection.outlook.com [104.47.46.54])
        by mx08-001d1705.pphosted.com with ESMTP id 322j5qsbv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 15:55:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ex2Eve3Cl7kk3ufYFAJw0l8aq29zunic+2ZUPpGZVysZRBGq5p3/0zraK6Je24tg+hss1qDjc4fXrWtdWu6S9gbJVsVvXK2K4Lq3rycnwvnKN85Y3JsBSd8N0PDOmMDaY7xo3LjMcfjtPPCSl4eCgTwPGLGxyIT1ieQwp4wMwR31K3oZiB6C0aZfui/WtjTAGlFY6gMxHlty/CzQf3OFyRW/E4yCey7iPTnVDiQu4ExIZnuMHln3sSyV1xSal+whhwAB1O8H7oyNMCoImjaAgxVeui+9ct16NWFj1uwWIAAoes4tsp8HFk72GmjEn+NFZJAC2JCH2Li+AbRbcp+FbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YdgyI8KPty+2G/AtwV9/PVUg1oF+1DrqEbjypIAJh+A=;
 b=oQtORztxpLKuvgI8o6jUh4vJD5VgUuDXNNiVddGwW7Wzg5rh9kGnY2Zptw1f8rlXaeJWVKLMvk/qT0IqzXsdbJK/KIlrhlCoP2zLm/u85eu3aDr5UZUySLXIIFZ9N5SEvP3fVmGyiMs7TDbcI+tX1q/29PnKfDLCu6u9877edYQOFBpRr1L1mo30fcLipZqur6jpejcTRQX4HUccsIm+FnkDNGF094P5biqT+urmIoeqcbN6KQD1LeF8lRqxUisqRSqTEG+IPSfcbDIAYB/Y82SA53wYMmiTSv0qMs6n3IlCd6aVxHMiG1w3IQVcm0j9WA9TyeAvBpYAgsxhDOvGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from CY4PR13MB1175.namprd13.prod.outlook.com (2603:10b6:903:40::23)
 by CY4PR13MB0935.namprd13.prod.outlook.com (2603:10b6:903:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.19; Tue, 7 Jul
 2020 15:55:42 +0000
Received: from CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e]) by CY4PR13MB1175.namprd13.prod.outlook.com
 ([fe80::e486:a4f:7430:536e%9]) with mapi id 15.20.3174.020; Tue, 7 Jul 2020
 15:55:42 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     Mike Rapoport <rppt@linux.ibm.com>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: RE: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Thread-Topic: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Thread-Index: AQHWVGPIwQycxLw5iEauvXmlP6ObnKj8O1FwgAAD2YCAAAJSgIAAAJcg
Date:   Tue, 7 Jul 2020 15:55:42 +0000
Message-ID: <CY4PR13MB11754FCF904BA5C0A31EA7D2FD660@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
        <202007062234.A90F922DF@keescook>       <20200707064921.GA9411@linux.ibm.com>
        <20200707093727.22aa39e2@oasis.local.home>
        <CY4PR13MB117519F548B125CB2F10F50FFD660@CY4PR13MB1175.namprd13.prod.outlook.com>
        <c4aec17f-3ac9-ce17-a131-b186a9b595dd@infradead.org>
 <20200707114151.2d7b0fc1@oasis.local.home>
In-Reply-To: <20200707114151.2d7b0fc1@oasis.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [160.33.195.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4c618584-0f9e-44d6-f281-08d8228e33c2
x-ms-traffictypediagnostic: CY4PR13MB0935:
x-microsoft-antispam-prvs: <CY4PR13MB0935A3072932E0F5D4EA5C44FD660@CY4PR13MB0935.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IckGPx0AjxdzFhGt8ncneNzhjYIBt/zVEFIhSZu5v77CcA1apsmAv7Ha748dLnnIzqxwKoZxG6jb9IL6TxFW4Jiw+p4lTTJ5bzUkjGK+4q/+AytwAnZPlCHVMw9iGsFH7lDG2deOeDLZpixdTloiInn0BeIcZzlsEz+uGBwK7E4pw1KNEYtMEk8F2advHF4oFNDbxQoSzsndV8ChqKWvI8f780k/r5LCAk2Mbp7o454Kr5E+J1qvrtlNMX+986oa02MFM6L2f5pvqpMJgLhlRE8IwMCZb8ku7m9xn2GrWC253JNecZ4NpLAA+RND3IGHrM2mgc4r4TweZ8d8Ct26Fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR13MB1175.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(6506007)(7696005)(8676002)(8936002)(478600001)(26005)(186003)(66946007)(64756008)(66446008)(66476007)(66556008)(2906002)(52536014)(71200400001)(33656002)(5660300002)(86362001)(4326008)(76116006)(110136005)(83380400001)(316002)(54906003)(55016002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qn9dDOISRm2ZMKkqiezCvdp8psc9dMYK8PWT3O0eB0hmfRwl1eviqjOa18EZojrJxhdNuIXmvL+gDWfr6DefTWAgZozYoqENodn82Zk5j1wvzjmYR7IqGE09b9ZulWNmaJcciIxtpifx0znV59nS0h11iDsGR9/RRWFsTlB6iBFmckWPHHi5kPxX+lcpZgMGN1M5t/INqRWj/+0Z8bDHld2sUAcjbLYEydUfDdDwZyBzyeOixaLF2uQfhG1mqq0vMos9zKTQLGCXaPbz4Hp8zQvNHAlk+pLNAOEqm6Q9C3WCrwSxDt61XzVBk+PaOtY+VE1H6KRbk+9U1iQqnVnncRH5fSH8GD/H7OnxY3cGux+TyHZAZipwZsIUD1uGHUxM78DS62x282WaHpshSXyiNk1ijnrf9GQnnWELJLV83xZtSt130CrEKuWlqPwFFqArlB/rN45jRo9Hpm64dIz4YmOlFON23fK3AMUz2oTf76LDokzHneLcoWIDSyfGlBNo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR13MB1175.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c618584-0f9e-44d6-f281-08d8228e33c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 15:55:42.0730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Deq7BCl7fimpoDSMMZPH3oHm/6MhKqfqt8Mh/GzwKLr4c8WDuLeDAYAF67jvTbbk0ZXEeyNqKRTUcqZCEiHUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR13MB0935
X-Sony-Outbound-GUID: HyWKZKdZoIq7jsCSZdZ2_jIDaJaBxDv5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1011 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 cotscore=-2147483648 bulkscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> On Tue, 7 Jul 2020 08:33:33 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> > >> I was thinking good-list / bad-list.
> > >>
> > >> /me that has been doing a lot of git bisect lately...
> > >
> > > I think it depends on the context.  I'd prefer a grammatically awkwar=
d verb that described
> > > the action more specifically, than a grammatically nicer generic term=
.  In other words,
> > > yes/no, good/bad don't mean that much to me, unless it's obvious from=
 context
> > > what the effect will be.  With something like allow/deny, I have a pr=
etty clear mental
> > > model of what the code is going to do.
> >
> > That matches what I was about to say:
> > Just using yes/no does not tell someone what they are saying yes or no =
about.
> > It should be more descriptive, like allow/block.
>=20
> After doing two days worth of git bisect, good/bad is hardcoded in my hea=
d :-p

Maybe I have the same bias, because good/bad there doesn't bother me at all=
. ;-)
Here is some 'motivated reasoning' on my part...

In the git case, the good/bad terms describe the result status of the test,=
 not the action that git
is going to take based on that status.  It's pretty clear from context that=
 a 'good'
result will cause that commit and other commits to be added to the 'good' s=
et.  I think what
git actually does in constructing the sets is a bit too magical to describe=
 with a  simple
verb.

As an aside I just looked up 'git-bisect' documentation, and found it has s=
upport
for changing the terms used ('git bisect terms ..') so you can use words li=
ke 'fast/slow'
or 'fixed/broken'.  That's something I didn't know about. :-)
 -- Tim
