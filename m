Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9581C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7629120720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ijV5DwcU";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Lluw0UN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbgGFMqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:46:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5104 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729043AbgGFMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:46:03 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 066ChpwH006602;
        Mon, 6 Jul 2020 05:45:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0NHFFgB5h8ICqWmJDa/yBfjm1VBnPzEuNWoZhQoAjmw=;
 b=ijV5DwcUWs83Ba1ZU26x1cf1LETgFrO2P70ZuuwuUO3F2iANE5204upJISFIc+THzJ2e
 8AC0a1jVhgL82yWjMvyIELc6hel8c4pP2ClJvNdHDzIoV/N05dun+h8FIWg4cY2aQXiO
 dSwWAdcv+kbIVZg8xVlT4URq8kxw51jQrHE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3239r9bxbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Jul 2020 05:45:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 6 Jul 2020 05:45:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVqmONaPa656VV5dMurW5TRbGOL2zJYskaUXBkrebghFwQEP80dkN2l+YKQ/DL6ZwAHCndqxTkHcCmnR3DHWbs1ibW+h8OgDoZAMOdlruwUNI2zXnxHgoAcG2CsefnGMhMjKENcd35XXZPnlBmz0d5iGluwzMZkIcNPb5VaZOgJVGD5+jrU2Dd2K8mo6NvjAMeM7ZuhpQL/gqYk3ROAWRa6OxA81VdJwRQaNPv6vgisehdo/v2vZYn3Z/G5UwZIZWQnTNAopfjq/FcXNNDnO+Rit78ef5goGc/h7VZK+G/shIfyxNbZk0VMlh9X/nsSsK0dmgsl38A+USznyrs6Axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NHFFgB5h8ICqWmJDa/yBfjm1VBnPzEuNWoZhQoAjmw=;
 b=ODZu40Zd74T1JtExw/OGiSOiXIMYth9vV1flWXhSTR/8B0gnYBN72CHItj3uZq6K27K/BSkM7EzKJCqtEAvdthZiz++q18MBWzqbNceNuU9x6N4GMRhPzy88/tX/HSqMQwcIJ2kAAls7CVFlhcybh7OweUZQixyaVjtEv4uBslvcjYnE8MaSMmDBxkjSIlgNubNNReoioGdB444ZSkURNHO7zP3tqQDSEDJw2fjLthlsbx+ialyElHrOunPJK6bmKkn2PDgB0Ic9Pnke/uQsFy+Q6wiNpyPmF9YmUuqezQZLLNuVS0klfrU1raD5fMYczbQoKA4aTSfAdIQfapr3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NHFFgB5h8ICqWmJDa/yBfjm1VBnPzEuNWoZhQoAjmw=;
 b=Lluw0UN/WoHt9xylXfBMTEuGRfIbqoGmSWCx6y9l5MMPZXGv532pIxU2GW3R3UBQGAMiGiI+CIXevg8OqQwWYxnXKxHSGBTl9dPprwWIBw65lT7tBDEouM4F2YgSSXyAfD2nKBG6E/A7ZYP3aRFJHxxyZoCu1kuu5nj36e82Aw4=
Received: from MN2PR15MB3582.namprd15.prod.outlook.com (2603:10b6:208:1b5::23)
 by BL0PR1501MB4131.namprd15.prod.outlook.com (2603:10b6:208:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Mon, 6 Jul
 2020 12:45:34 +0000
Received: from MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::e9ef:ba4c:dd70:b372]) by MN2PR15MB3582.namprd15.prod.outlook.com
 ([fe80::e9ef:ba4c:dd70:b372%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 12:45:34 +0000
From:   Chris Mason <clm@fb.com>
To:     Willy Tarreau <w@1wt.eu>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CodingStyle: Inclusive Terminology
Thread-Topic: [PATCH] CodingStyle: Inclusive Terminology
Thread-Index: AQHWUkBiuI9YYVhC60GHlqhklDtDWKj4bGSAgAHNCAA=
Date:   Mon, 6 Jul 2020 12:45:34 +0000
Message-ID: <798B0FBF-D7A8-4631-8581-5D199DA50FF9@fb.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705045505.GA2962@1wt.eu>
In-Reply-To: <20200705045505.GA2962@1wt.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: MN2PR15MB3582.namprd15.prod.outlook.com
 (15.20.3153.029)
x-mailer: MailMate (1.13.1r5671)
authentication-results: 1wt.eu; dkim=none (message not signed)
 header.d=none;1wt.eu; dmarc=none action=none header.from=fb.com;
x-originating-ip: [172.101.208.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10a04e3f-343c-4625-ad67-08d821aa79ea
x-ms-traffictypediagnostic: BL0PR1501MB4131:
x-microsoft-antispam-prvs: <BL0PR1501MB4131745425A78316185AF9DED3690@BL0PR1501MB4131.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SAXF7hOlCWCZoOlZWLFAQ0Tw77+8H7nqlgGLvjtvWh8XKrDeZ22UCGF6RwzJi9vEpnFWrkUJe2/dlNfMQZs+nB3wCB4iQNEDTSJJq1xtFAt+i6AY6NongzXCH8ej96G9FR8G3iOeGuXzeOsBnPkSDxvBd2T5d2TmwrOVfw86ILf9E8qEr1TIoeRRbXqURebZPIyE2tcILpQZXkKnrbEw5hE7hL70H9mxsdjuQ8DZzsC6QVXlHaPvTy/xE8qRox0j35ZWHF3LILgMjHTKdFsjt8z2axSbMaizz+tMaHpIQ29aHg98eQaEtsMSCYmjBa8MCIH4Hssn7aWI5YgcFrlJKQzIgy1z6jR23ldBv8jFfTfT7Xiixezy1VQXF/Hd8Dwy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3582.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(39860400002)(396003)(136003)(366004)(8936002)(478600001)(2616005)(54906003)(86362001)(7416002)(316002)(71200400001)(6512007)(8676002)(2906002)(6916009)(66556008)(91956017)(66446008)(64756008)(36756003)(76116006)(6486002)(4326008)(6506007)(66476007)(53546011)(66946007)(33656002)(186003)(5660300002)(26005)(781001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kDbzzc8iNcH+FXfEvvSblj3lP9V8EymvjeE+TNV+SL2syKjxxpqDRQ6Wxgg0Q4L+8Ku+MOahdlvlEHRatdxaaPb1YyPMlw3hzvTBU0inZSPIDWqpOc3gUkKafzyJcfJ+uonSncwQwValp75Ub1NpSmIu0lASOqbkMDxmRo1cXTLFHmUahiWIB3AL/RhRutmY5qbZOqaEfRJWPj7SWlZ5XcQaQ8QqtUsll1e/YsMdFdG4BqWh/4HINRqjWuxAR6zVEhVwhKZyfSfmqCqWTHM/jboKXciNGZbdL8nMhQGrd+TntetbCorJ3P6SfsN+3eg6HDpYvgneAuquP2g4lLzEZfUV1nY1ioLR5AjS9ddsIsiESPuQuuPBwP6etiuU5U1+IA1WuPwmRudZIBhXOULcjIrcMOx4Y8QNMFUF4PE+fgARZLVNQP7MMb2/ASNVXk5CXlCyehxmtbJyTvp34EZu2nsPgs32TSmB9AyEqybP3sI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <35CE96BBE7FF8F4191DDC042AA4A4E83@fb.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3582.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a04e3f-343c-4625-ad67-08d821aa79ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 12:45:34.5355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OO6EAFYWFDtmgv9a2uIuSVTV1TqN9RQ6N7UuQf9H5/bRkgeKDcOu93A+4x1Lm79h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB4131
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-06_09:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 mlxscore=0 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007060098
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Jul 2020, at 0:55, Willy Tarreau wrote:=0A=
=0A=
> On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:=0A=
>> +Non-inclusive terminology has that same distracting effect which is =0A=
>> why=0A=
>> +it is a style issue for Linux, it injures developer efficiency.=0A=
>=0A=
> I'm personally thinking that for a non-native speaker it's already=0A=
> difficult to find the best term to describe something, but having to=0A=
> apply an extra level of filtering on the found words to figure whether=0A=
> they are allowed by the language police is even more difficult.=0A=
=0A=
Since our discussions are public, we=92ve always had to deal with =0A=
comments from people outside the community on a range of topics.  But =0A=
inside the kernel, it=92s just a group of developers trying to help each =
=0A=
other produce the best quality of code.  We=92ve got a long history =0A=
together and in general I think we=92re pretty good at assuming good =0A=
intent.=0A=
=0A=
> *This*=0A=
> injures developers efficiency. What could improve developers =0A=
> efficiency=0A=
> is to take care of removing *all* idiomatic or cultural words then. =0A=
> For=0A=
> example I've been participating to projects using the term =0A=
> "blueprint",=0A=
> I didn't understand what that meant. It was once explained to me and=0A=
> given that it had no logical reason for being called this way, I now=0A=
> forgot. If we follow your reasoning, Such words should be banned for=0A=
> exactly the same reasons. Same for colors that probably don't mean=0A=
> anything to those born blind.=0A=
>=0A=
> For example if in my local culture we eat tomatoes at starters and=0A=
> apples for dessert, it could be convenient for me to use "tomato" and=0A=
> "apple" as list elements to name the pointers leading to the beginning=0A=
> and the end of the list, and it might sound obvious to many people, =0A=
> but=0A=
> not at all for many others.=0A=
>=0A=
> Maybe instead of providing an explicit list of a few words it should=0A=
> simply say that terms that take their roots in the non-technical world=0A=
> and whose meaning can only be understood based on history or local=0A=
> culture ought to be avoided, because *that* actually is the real=0A=
> root cause of the problem you're trying to address.=0A=
=0A=
I=92d definitely agree that it=92s a good goal to keep out non-technical =
=0A=
terms.  Even though we already try, every subsystem has its own set of =0A=
patterns that reflect the most frequent contributors.=0A=
=0A=
-chris=
