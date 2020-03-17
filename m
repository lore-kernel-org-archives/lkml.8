Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372BFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDEDD2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 02:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=biamp.com header.i=@biamp.com header.b="SMVjoAKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgCQCSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 22:18:21 -0400
Received: from outbound-ip13a.ess.barracuda.com ([209.222.82.180]:42726 "EHLO
        outbound-ip13a.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgCQCSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 22:18:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106]) by mx13.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 17 Mar 2020 02:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRjbshJjl/dcMDqbq6sG6DfCh2e0egAKS2PUCugYZVl0w2N0E/9vNAn1UY2U7QRuD+mERh3roVr5N9nOcjNWzEtTajVD+dekXK8iWqXMHIEVcj1UJB1zkVxxJ667v7TUmh/sG7w17GUK5PwgNXnDUoey5+TWBGut98Oq+T+H7dbxKFxwSz0rnU08QFWny4QZvijBxMYEFHRobmd9FAN+61zTmD8y7DSBCyPETXo0CzT1RvP7YjKsLbNUoR/SSlHs6PwQztcS4SQ+LJhzbh4ucq8jnJem2+iFTTTvzQ51Use3t+KChaTEaJ89vstIsljtr35XSNa4A6pZ24jSuFxq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQBuRqhmMKIKxn5QRROq9qN9dT7ei6DZY/MCiYQ1Y/o=;
 b=FgeK7S0OuQOW+/pQvAtFxZWweTKLuw++eIdRJ4Xkx5ng6LorALDye6AKBTrRCflXHeG2v4ER2jVJiGGj3pZ/8nMABIIuFjV7wbd+SVzYgbK3dehRtKydK3PcNgDdA/LQvnqNZcYo5qoQ9Z0PP8UF/HVZoZ4q+fp51epU+JlNyqvM1pQJwS9mcjXSdsxWC/+h8WkdIvUrOD12uOo6U61/C1TE5Ss/rUHoYw0o0nshZPG806kRA8SU1T4ro2yBhZyTP9pgYG736COk+Axkho4uG9g8DTSb1YOwp5xgM9Ed4SAUlqZKfMdQQ0rZ0GBLfQmteInLQ8B2WaBaVSCh42bggQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=biamp.com; dmarc=pass action=none header.from=biamp.com;
 dkim=pass header.d=biamp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=biamp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQBuRqhmMKIKxn5QRROq9qN9dT7ei6DZY/MCiYQ1Y/o=;
 b=SMVjoAKJIb5uX8rZDQpmNjJd3DxgVHpV2P2H9esSBampqiswpLyxVWmVCtNC06QA88b3rZYX65/vkGg3tcO9eGKniDNUBnZ3nBecoRLd36UhcMd8HJdx5Ip4Wyf71gkz9O4L6hbQzJKQaDwrFiZ2rGDWwhLUM0+dtaFRcKE68Qs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shreyas.Joshi@biamp.com; 
Received: from MN2PR17MB3197.namprd17.prod.outlook.com (2603:10b6:208:136::33)
 by MN2PR17MB3567.namprd17.prod.outlook.com (2603:10b6:208:192::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 02:17:46 +0000
Received: from MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::31e3:fa7c:d1c0:ce24]) by MN2PR17MB3197.namprd17.prod.outlook.com
 ([fe80::31e3:fa7c:d1c0:ce24%3]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 02:17:46 +0000
Date:   Mon, 16 Mar 2020 19:17:36 -0700
From:   Shreyas Joshi <shreyas.joshi@biamp.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "shreyasjoshi15@gmail.com" <shreyasjoshi15@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20200317021736.syreot6rs5rtqsh3@shreyas_biamp.biamp.com>
References: <20200309052915.858-1-shreyas.joshi@biamp.com>
 <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200316213900.6b1eb594@oasis.local.home>
 <20200317020144.GB219881@google.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200317020144.GB219881@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ME3P282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:80::18) To MN2PR17MB3197.namprd17.prod.outlook.com
 (2603:10b6:208:136::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shreyas_biamp.biamp.com (203.54.172.54) by ME3P282CA0008.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:80::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend Transport; Tue, 17 Mar 2020 02:17:44 +0000
X-Originating-IP: [203.54.172.54]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5ba5f7c-85dc-4559-73f8-08d7ca196216
X-MS-TrafficTypeDiagnostic: MN2PR17MB3567:
X-Microsoft-Antispam-PRVS: <MN2PR17MB3567441FA3E049DCFF36DF1DFCF60@MN2PR17MB3567.namprd17.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(39850400004)(366004)(376002)(199004)(52116002)(7696005)(16526019)(8676002)(26005)(86362001)(66556008)(186003)(6916009)(66946007)(66476007)(81166006)(478600001)(6666004)(55016002)(81156014)(8936002)(54906003)(2906002)(316002)(44832011)(956004)(1076003)(5660300002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR17MB3567;H:MN2PR17MB3197.namprd17.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: biamp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jIJigYVNTH1UAb1OL6sQhllcrY4o1wDoInHCxg0XseXVly45ATNr1hiw5+70EMUyKNn3QToNMbN+qy0ARN5a7p4s+/XgEG5dC420KTX5Bh4bzfNfB7DLMJqL6tot2PoksWVvuyngqJjkfZ0ziH0raGD3juZLSCU07HZumsPfH692D+zTlXzbi9MxR+fGFgfEgKrcoifsfR0gJEBO6pxv3Mach/vQHkml6JzRDvjSpUxXoZEpUkWoFdRLrZ7178Jbi1/g90Os7mzv/rTsEkCSJnBF7eafH74lCTHAvT7YIhFvFLVE14Hv5BIYKb+6P191FLxOxlFc23mMFSOgTu8ZoR6pX0JIhcdeIuT1TRn9dqeqbhBw1F+3AMoYZ3pDL5MFDzBi0sF3m4L0dPU2Svh8+FJSK0TRF6pMDoBDA2Dp5ZGal0i1efb8U+Si/UjP3NDK
X-MS-Exchange-AntiSpam-MessageData: zmAmK244+AKs2rQgZ9AsFqoMq3N1UMzOZqDSw1mhf+3y4CxsHMksVeg2zR7Gm8dnBFdEWHdrEf4n9enHIu060UvUF8YoMsnjGEseXmf5eqncllGkVdjbQKAu6m/cgZ9l2PMdHzNgZCWi/qx2EaORgA==
X-OriginatorOrg: biamp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ba5f7c-85dc-4559-73f8-08d7ca196216
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 02:17:46.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 341ac572-066c-46f6-bf06-b2d0c7ddf1be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIGbBRqODRQrqa/XoUMyf9U+eAGXMtBwqG9uxIhy6ABelgkv+m4tpYfBxc3u1va1y13YzE1DyNhAHcMHpGcYhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3567
X-BESS-ID: 1584411468-893024-22912-8243-1
X-BESS-VER: 2019.1_20200316.2111
X-BESS-Apparent-Source-IP: 104.47.55.106
X-BESS-Outbound-Spam-Score: 1.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.222890 [from 
        cloudscan13-5.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 MSGID_FROM_MTA_HEADER  META: Message-Id was added by a relay 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        1.50 MSGID_FROM_MTA_HEADER_2 META: Message-Id was added by a relay 
X-BESS-Outbound-Spam-Status: SCORE=1.50 using account:ESS74049 scores of KILL_LEVEL=7.0 tests=MSGID_FROM_MTA_HEADER, BSF_BESS_OUTBOUND, MSGID_FROM_MTA_HEADER_2
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks! I thought If we put a warning there then it won=E2=80=99t print any=
thing.
Please advise. I will send a new patch with the line wrapping to at most 75=
  once
I know if I need to change anything more.=20

On Tue, Mar 17, 2020 at 11:01:44AM +0900, Sergey Senozhatsky wrote:
> On (20/03/16 21:39), Steven Rostedt wrote:
> [..]
> > >=20
> > > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c index ad=
4606234545..e9ad730991e0 100644
> > > --- a/kernel/printk/printk.c
> > > +++ b/kernel/printk/printk.c
> > > @@ -2165,7 +2165,10 @@ static int __init console_setup(char *str)
> > >  	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
> > >  	char *s, *options, *brl_options =3D NULL;
> > >  	int idx;
> > > -
> > > +	if (str[0] =3D=3D 0) {
> > > +		console_loglevel =3D 0;
> > > +		return 1;
> >=20
> > Hmm, I wonder if this should produce a warning :-/
>=20
> Hmm. Maybe the warning can seat in __setup() handling?
> There are 300+ places that theoretically can receive blank boot param
>=20
> 	$ git grep "__setup(\".*=3D\"" | wc -l
> 	307
>=20
> I'd assume that not all of those can handle blank params. At the same
> time, do we have cases when passing blank boot params is OK? E.g.
> "... root=3D/dev/sda1 foo=3D bar=3D ..."
>=20
> 	-ss
