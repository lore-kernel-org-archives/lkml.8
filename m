Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BB2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91366207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 03:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="WXlyULUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgFADLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 23:11:30 -0400
Received: from mail-eopbgr1320072.outbound.protection.outlook.com ([40.107.132.72]:62880
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726555AbgFADL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:11:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntcriyG11iqMSVWRq1Ajnb5GlTordOJPHIbFYCXWCcldvp17Zoc4Eh1SLRCzlKuLghzpP7KOQv+MfIOte09jRVKWrHqvaHWv6GoZp59gG/CxcZjAiW2C+qo0SkUieWggK4aXDUXSNPe5dcSYZ70YmUkW4qi8YMi+ybchx+2fFp62t4ewmabfjDZJYs/OiYBORDsV9dCQaz9Tp6GVDJBHpXfVjMMrr4k7qTOK8XOrQn97XDEh1cvUF5gV+F2Vbubkic/si5SMOqP79mud/omdbkSd5k+2ff6odhRVso5UPQiWVjmkSfXNkUyAms3SQxg3Ep2GeYMJNZ6vgUcYsBYoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGZucJK5RqUImKCOtmtgEQxJi9L2O+Dod7IzRMqU5nI=;
 b=RsX/pv1CmKGsaL68UAD7Fa3y6PFnTvaEFQJzl8aJmhTN/HUMaYBOFzX4KC5FNSXDZQbFOH8ymR7PcBHmM7RIjSxQW6vrB45o1NXPffpfjhOSPDrCLK5rmGkLPLqwuUK7ydV5lqoS0Kvdr4FsAOLIKJnvqwjGappW7dhLL75KIkjC71vgHl18c9+Nl4tFALNmyX9qOJlnJm2OqXUWnwJtdghzqGGdl49KYaPAASkuT8xjRgwB/ilEqRoPqDNO2aRmYptc2HFm//vOaS24DH8Pg+TGPn3cjxJ1wJeJgKrs04jaQczdbhibzLv/Hhl6zvPWaLQrp7uyXnf20hy67m9JCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yGZucJK5RqUImKCOtmtgEQxJi9L2O+Dod7IzRMqU5nI=;
 b=WXlyULUgDmMasOpD1yrOVLmQnUMgN6h9NNE98KM+JEteonuql4jezTE3vQGHioE3UrHJawEiWS5RochHsNzP8Rhp54Aj4GFbY2h3WSp1pK+4PKKdloIIP1NmXwZEtm7MXzLpNy0db0iFvauFV2uuEZoehPV6L4dugGG7pP2+BoY=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB4041.jpnprd01.prod.outlook.com (2603:1096:404:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 03:11:25 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 03:11:25 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
CC:     Wetp Zhang <wetp.zy@linux.alibaba.com>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] mm, memory_failure: don't send BUS_MCEERR_AO for
 action required error
Thread-Topic: [PATCH V2] mm, memory_failure: don't send BUS_MCEERR_AO for
 action required error
Thread-Index: AQHWNkTpD4yFFGEaokaMUIMyuwXASKjANcSAgALiWwA=
Date:   Mon, 1 Jun 2020 03:11:25 +0000
Message-ID: <20200601031124.GA5418@hori.linux.bs1.fc.nec.co.jp>
References: <1590817116-21281-1-git-send-email-wetp.zy@linux.alibaba.com>
 <CAM9Jb+jWnAPUYpJ-QrUR1oBCj+RwdAZMLyO4GCmAq=8V76VQTw@mail.gmail.com>
In-Reply-To: <CAM9Jb+jWnAPUYpJ-QrUR1oBCj+RwdAZMLyO4GCmAq=8V76VQTw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9aeb5c6-553d-4016-a0c8-08d805d97811
x-ms-traffictypediagnostic: TY2PR01MB4041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB40416CFCABB56592D720DEABE78A0@TY2PR01MB4041.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yZcYTZi1hA4RC6jsuv9TwEWjCU7nrqitgEbFEmpP1P3/bpFhuJr46TksStIDpzPyEsbSpgji8TUkies2MR4gHDDaoFej6XMEbjxzWEArgRYGUeYrjnBnDaAX7hd678kK6K4b0dOuJjuBYinAGjh8uEifNuOnQ9576AnvsxD188JBTN2yN/PSU1b4SN1doaEvGSVN/le/ln/ksgzoX/GuldPJTkCiBIuT4jgv/n9KwUgfcigjKBcReNl7eMw83eAt7+9AxgolvRaBAUt1z2IihIMmvoSwtDWfE4JkaAz0QJwumGdhw+s27G5MmTq28WA/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(1076003)(33656002)(86362001)(6916009)(54906003)(8936002)(5660300002)(9686003)(6512007)(66556008)(66946007)(85182001)(478600001)(186003)(64756008)(66446008)(66476007)(2906002)(6486002)(76116006)(6506007)(55236004)(26005)(71200400001)(83380400001)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PU2ukoISlZQimHKD/E/f5cLIoXCFh8qpP/fwj+A9kFYT/EfPbDkawQEx3EcgMPoe3IFpT1h9407rpOWLrRwXt0zfRtNwMyhzMK4zbo0ZPVWVA8u9vU+SX3KooEnymxjlHrmBigQsFNP4eN3KRxg1DSO/hw/5FEx0+du/nEk9O9sXC0rHogsy9nlVDsJSy1CdqcseQcimGqTf7xXss7otugz8v6WayFkPdt5Ye2KnJRUuMlYvL9HE/kH12Ae8FCmKaVV3SGXr5Vwj8/CciPhqe6uW8rvz8DdMyP9YiHVwUzRdtGaiOoqH7IPRAxJytDR0SD2lOyxX4AiyUjiB3pMWR5lAikV13nsRtS0dwaQOug5DyGuo+wKc101jwwWEDbaKGZo73vgBb9gWPBTJ/+ovKgjGQsrpCJcWBPP0oSlgs3xolbQX5ZZNwS3H2cRJiS9Cl53nCtIT0iUqIlr2QQy5HEviCNHUSGhXOfrEz5xIKaQrahsafzXiRYRcZ28yLtBC
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D904765FF01F1D44AB15687C82A06DD2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9aeb5c6-553d-4016-a0c8-08d805d97811
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 03:11:25.3108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QR7dD4J2rRRdayv3E0xQ/j29KtKPhkiLoBjou91xrYjahfDaeEXdXasShbDdiFj012C6JXTnEwSdTAPwP6HP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 09:08:43AM +0200, Pankaj Gupta wrote:
> > Some processes dont't want to be killed early, but in "Action Required"
> > case, those also may be killed by BUS_MCEERR_AO when sharing memory
> > with other which is accessing the fail memory.
> > And sending SIGBUS with BUS_MCEERR_AO for action required error is
> > strange, so ignore the non-current processes here.
> >
> > Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Signed-off-by: Wetp Zhang <wetp.zy@linux.alibaba.com>
> > ---
> >  mm/memory-failure.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index a96364be8ab4..dd3862fcf2e9 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -210,14 +210,17 @@ static int kill_proc(struct to_kill *tk, unsigned=
 long pfn, int flags)
> >  {
> >         struct task_struct *t =3D tk->tsk;
> >         short addr_lsb =3D tk->size_shift;
> > -       int ret;
> > +       int ret =3D 0;
> >
> > -       pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to ha=
rdware memory corruption\n",
> > -               pfn, t->comm, t->pid);
> > +       if ((t->mm =3D=3D current->mm) || !(flags & MF_ACTION_REQUIRED)=
)
> > +               pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d d=
ue to hardware memory corruption\n",
> > +                       pfn, t->comm, t->pid);
>=20
> Maybe we can generalize the message condition for better readability.
> Thought a bit but did not get any other idea.

This odd condition might imply that we could have better fix in
task_early_kill(), but that should come after fixing priority issue of
early-kill flag, so let's go with this fix for now.

> >
> > -       if ((flags & MF_ACTION_REQUIRED) && t->mm =3D=3D current->mm) {
> > -               ret =3D force_sig_mceerr(BUS_MCEERR_AR, (void __user *)=
tk->addr,
> > -                                      addr_lsb);
> > +       if (flags & MF_ACTION_REQUIRED) {
> > +               if (t->mm =3D=3D current->mm)
> > +                       ret =3D force_sig_mceerr(BUS_MCEERR_AR,
> > +                                        (void __user *)tk->addr, addr_=
lsb);
> > +               /* send no signal to non-current processes */
> >         } else {
> >                 /*
> >                  * Don't use force here, it's convenient if the signal
> > --
>=20
> Looks good to me.
> Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

Thanks!

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=
