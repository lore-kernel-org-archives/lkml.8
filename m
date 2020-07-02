Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506E02077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 06:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EkQi5U+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgGBGOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:14:10 -0400
Received: from mail-eopbgr770087.outbound.protection.outlook.com ([40.107.77.87]:30939
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbgGBGOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 02:14:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqa9CQUqzElOYF/uVuDNpLAx0/bIgSBFTs0HmVTlH/vd8ZTfXa0s9N6efRaU3wzBr3SqYZ/PSl8kx9ExYby7sennZFWz/vmB9MlW6D7pwV1vSEl7ZlLmJC5n1F95D9nA92XwjmKBz6MrY3wyjVTEl3fCXcMHFHJ5/ozADgyiY6kEKYY0n07nIw2cFO+1CdiEhdeuuwyXjvJ2RBdbKK/s1JqgdIdYb783KZ4H6C/fkFDJMj/NluuXyu0toizC7PI4Trnqohveo94SUzsBWgqL0uTIo+FlQ8B8NUWrP2Dn+cQQDZjKyGHPxov3Yos53/UPs3ovD9inWObNvL/oWe1ptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqyk4bsMZpJrNzineLWjPZRf49P2QAoa7WYuDMYWOVA=;
 b=fUnublM+2AkQFYNuHFTfcyAIzE6l7f+ls3aZE9d6479LzQQnFGTf9nxUcp9a9PKNagDVOlJ2QIPwEiO3zlWOw7TVMst9sIe3xWiCXfuWWbH2/IOWvHeechmh2opDpmPRYxiE8Fl86NX/xY1mBe2sm2BuaaEKMqin9EyfQIW002Ccq50S6it9PzEC54cMrUaZsCfZNrHYGOZczhdvNj9PAgglbuRPnBZujukfrJjZZ4jmFSdSKU2ZeqVBScLs0dcN6GZ9rXFyPY5CwZ58+9UFAN5BZ3Gj0Ba2h+HMMvQzpB30Vfxi8176UYZ6msWnpxSjksNn/vlP+TykZW0go0DtLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqyk4bsMZpJrNzineLWjPZRf49P2QAoa7WYuDMYWOVA=;
 b=EkQi5U+uPyrhf1Q81vkV/uX+QL2Jhsx6m1yiInX6yXLO4jaYRKdbyq+8JdJt/KtNBE4bdT2PQekgFNAZ7dUfmsZ2FnaZfyvEb/R/vslP9z/3ETGUUAxCgCgyWdI9uanc6UF37I4OjwVy4YX4g17dX4CEc7Tn65OkMJltKvkfWVQ=
Received: from BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11)
 by BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Thu, 2 Jul
 2020 06:14:06 +0000
Received: from BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::a866:94ec:65f:8015]) by BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::a866:94ec:65f:8015%6]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 06:14:06 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: UART/TTY console deadlock
Thread-Topic: UART/TTY console deadlock
Thread-Index: AQHWSLrNQSoW9cNjzU6HnyviDkQV1Kjk5iMAgAutxQCAAGshAIAACVwAgAAYb4CAAAv+AIAAUxSAgADUzoCAAWC4kIAAKGYAgAAA8kA=
Date:   Thu, 2 Jul 2020 06:14:05 +0000
Message-ID: <BY5PR12MB37789152C6311FDE04759806F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain> <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <3b665cbd-7afb-b72d-22c0-7dc1543ac42e@amd.com>
 <BY5PR12MB37780DF07B437B9FFD1BB344F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
 <20200702061136.GA679876@kroah.com>
In-Reply-To: <20200702061136.GA679876@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [124.123.104.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c0d81be-51aa-406c-be53-08d81e4f2004
x-ms-traffictypediagnostic: BYAPR12MB3286:
x-microsoft-antispam-prvs: <BYAPR12MB3286C33C37C42BE97937E5C8F26D0@BYAPR12MB3286.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X79I/MiSU84nf+8BA+dxA+cLVb0SDL4bPWtMcCwvV/1an+WCTcgQwutjmnHeGXKbg18NeqXuXJZJulk7CY8PeH0k8dAB9A6ceOzwiEm8r8ZzhqBtT0r5VfowxedSLD/Pt+Z4Nppuq4aoS6iAQOknpr++obF1LFHKLWOwNJFRGfs2NoxfQctUq7GawsBdQ563QeSN8++iYMqFXMSlUFvtOWjdiqypdPUFDtnukAywWGyVd5pCGBqSvg6rTMwUIe/IcYvu82PDfK2X14XRE5YD13crSj2VTQALeyhbWmrxtksnR2rLYStRBhCC+h2pb2auheQexmvcEljBmEWYPmr6ZXh1yBqgviKt3leKGG1U9ZxN+A9o23GQKvc7utlRzOAy6nKQ21I3uHIjRK24mvV2fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3778.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(7416002)(53546011)(478600001)(66946007)(26005)(966005)(186003)(6506007)(4744005)(54906003)(66476007)(316002)(76116006)(66446008)(64756008)(66556008)(86362001)(83380400001)(4326008)(3480700007)(6916009)(71200400001)(8676002)(8936002)(55016002)(33656002)(2906002)(7696005)(9686003)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2f8//NGFymweLa1K5ragbhXsSHYGjFvf7bzM51uDvp/6O9gphQNehfkrTzISPQvt+UuB27TdFIkBCC7lL8BEBOIgRzaBOfRVOw8pwVtYYN0pMaOByaIMPcsYFhQDVX3QchCS6EPlcL0ha/3SzD4PK9GFr+Te+MtGzqf/eHWxT8zcnwDM4nI9AxrUKitOX0jJM2UrHCiDH+lkYrbHp312Fj+g4bT/FbP4oya/HIdvI0xeY3uhd7dRXv9JxDdANNrmrsehhuzENbrOzi22nDmGgeM6ivtaplsIUWECGE7rMKdzZ1ru92GMh15TlPUK0zK+Y3VDfJhBLVB+Thr0+1Nqx1gQZKr7qOzv6r29RKsi7QKXcp6cchB352/Ga7FCMkbn9YDhSPcoUv9ZPvfK/nHUZEDV5utOA/5ToKdjqUz/kR9rkhRgdyw2YpnkT64/ApxhRR4I5pnPf2nC6Kq+GGvgmc3ae15SL92teyWixAqH8Cpw+xjETXjIoXvoJKu4vdR5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3778.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0d81be-51aa-406c-be53-08d81e4f2004
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 06:14:05.9427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V1VqiQXZKBIVNHnweXCmsdvCv5Adbaw/pFoWsuDz3SRU6ACcor3n0EwRCouZY3sH9BGEXupUidUeYI3EfGk8tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3286
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one:
https://lkml.org/lkml/2020/6/30/394

I did reply to all, not sure what I am missing while replying.



Regards,
Shirish S

-----Original Message-----
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=20
Sent: Thursday, July 2, 2020 11:42 AM
To: S, Shirish <Shirish.S@amd.com>
Cc: Tony Lindgren <tony@atomide.com>; Sergey Senozhatsky <sergey.senozhatsk=
y@gmail.com>; Petr Mladek <pmladek@suse.com>; Andy Shevchenko <andy.shevche=
nko@gmail.com>; Raul Rangel <rrangel@google.com>; Sergey Senozhatsky <serge=
y.senozhatsky.work@gmail.com>; linux-kernel <linux-kernel@vger.kernel.org>;=
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>; kurt@linutronix.de; P=
eter Zijlstra <peterz@infradead.org>; John Ogness <john.ogness@linutronix.d=
e>; Steven Rostedt <rostedt@goodmis.org>
Subject: Re: UART/TTY console deadlock

On Thu, Jul 02, 2020 at 03:48:43AM +0000, S, Shirish wrote:
> Hi All,
>=20
> Can we land this patch upstream?

What patch?

> Feel free to add my tested-by.

Please send it in a form that I can add it, to the patch in question.

thanks,

greg k-h
