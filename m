Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DB7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640C2206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="j4jZnXQW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="qbGdGI2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgENNJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:09:59 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:55222 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgENNJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:09:58 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7250AC0096;
        Thu, 14 May 2020 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589461797; bh=PqY410pparINKO2Cwe0BlHT+uN+eXq5NOBzg5cEHjUA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j4jZnXQWBh2PvJ0ak1QDbqShZzgCwwLW0bvfKtc26U9Tqml9/S1ER/9tlcGfcyqc9
         iz1Szr3uf60k8gNh2HxIQBsHCTRgK7yQRHY9j6hkgXOVEReoCRbJzhRgkLoxuP/Z81
         ivHsuTeK5crIl7QfpxZtyTSqYagmJc3jMjkVCfrpURkAdHN70WhfMyxa0bkJaeGiwP
         ZaQ/0CCZo7+3/HNi3kDC2PJLlGnOnVG1AaLQWKJvsAozChXj3EIpCcpCmop3Cl2HLp
         puWcgBUOFZX3C1BRWg7EQKOv2YB5JWpJH67C6gTgWxlKXUafrWqFEsDE/8+UcOvT21
         9NMIceb+Lv0QQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7F113A0071;
        Thu, 14 May 2020 13:09:54 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 14 May 2020 06:09:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Thu, 14 May 2020 06:09:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaONgcY9Gf67gWIjPFkxsc1BnUOa5S5ZYIlWPZxhZFu0v/Zj12x4Adx2tSKNJm9805A6qHbeXNxB/VDXkunaCGPBy1wLlXB89TKGBljtguTVhjDZJO1wqpmytkSUVfEff0y4IsTUB2w5Pq1OvYNmBhIewLxVIUL7kAZHtKmitzLPdTdZ5eqAWsuQOIgfP9tOejJBbAwSaDAMTmWj/joR9OcaVh2Bs3yAH9+8Z0sfmuVum+If2M+b62bS3jZPeRB5Ja7l0OuSkX4P/9ETi5iOUa/rHYostCmbz/dVJx9Gt3NcCxgjb5PcJAZLV0n1WUTAIzU8QVfn0QCL1NS9Nktxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUwIrsZFMQxmveJTY9Qdbs2HOo94xevG0fxqbrKQe7c=;
 b=XrxDSKfTIFG6AhlqRRemqiRL1W1iZQpyGLunHOPU1x28N9rlO0HZgYsj+Tr90TY8QzmXgATqZHdDlxD0KkcQjKStD/Yz60RSKI4qYOqbwGrgj1ffcnYd75+aq+A02HReB20hK9e+SwE8izcR9yBf1TF/Mqi4o49+pZ4e+pJezXkKajGfCD5XuHJhLTb1MVZi6UfWBnMCk15TI2lj2h72aGMGSoHua893pg8RN3Hg4EVdu9T5y6DWJw1ezmsASAi4S+JX4nFBM4UHcKK6UKSNIH4hgQtj/9fGmxCnlOcoGU/S1/UHpmJtmIrSrL3F3dGJff4YV/S8V2I04WirelxeMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUwIrsZFMQxmveJTY9Qdbs2HOo94xevG0fxqbrKQe7c=;
 b=qbGdGI2fLUIGKly8Qk+JfDbyfeF3MoDaaMvxilqUQAqplqnPs2SsIsJkkyJDJUVuGRj0AicjVm4tFAoYx+oiYUnx7ZXaNuvx2sxY8lnqUNfUu/81RGd2H7Eh5/Ju45oY3jgWgD2kV06f2bNk/pk6AVpO9UxBJCDFG67Lm0FDrGw=
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 (2603:10b6:910:1a::19) by CY4PR1201MB0053.namprd12.prod.outlook.com
 (2603:10b6:910:23::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 13:09:51 +0000
Received: from CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09]) by CY4PR1201MB0136.namprd12.prod.outlook.com
 ([fe80::8d22:7d25:8892:a09%8]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 13:09:51 +0000
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Claudiu Zissulescu Ianculescu <claziss@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [RFC] ARC: initial ftrace support
Thread-Topic: [RFC] ARC: initial ftrace support
Thread-Index: AQHWBFAKr4qHDPVDOEWWdR2Z3ElRlKhcrJAAgAhjooCAAHODgIAAZgeAgEHt42Y=
Date:   Thu, 14 May 2020 13:09:51 +0000
Message-ID: <CY4PR1201MB01364BE5CD799059DF7B2257DEBC0@CY4PR1201MB0136.namprd12.prod.outlook.com>
References: <20200327155355.18668-1-Eugeniy.Paltsev@synopsys.com>
 <20200327131020.79e68313@gandalf.local.home>
 <fe7ae84c-745a-04b4-dcc0-5df8cc35ee0c@synopsys.com>
 <CAL0iMy3i5+_owqJcUKWzGNFakVV2P=oFdyAWCY2LP7YTusKP_Q@mail.gmail.com>,<CY4PR1201MB01207268EA87209A55C31D44A1C60@CY4PR1201MB0120.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB01207268EA87209A55C31D44A1C60@CY4PR1201MB0120.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [5.18.247.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fabca5f6-1469-48cd-876f-08d7f808167a
x-ms-traffictypediagnostic: CY4PR1201MB0053:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB005324386D1937F299257AB2DEBC0@CY4PR1201MB0053.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 040359335D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ssKPxeiKZfZHXuOlxjpPfJr92bvu3W++LppK7HH6P/lj5Xuh78e+gX9BO2gREO8Dz/3UoKmNwQO1ACSLPTSC7XtbuwiViokHe5sXzaxl30fwiSMMP6ViH/XZwZAQMmJkJ4I/yyKrr429fpfOYm4btKgsEZix6PtyvqZ/kckmK6TvUn07y+4h4ln1qXegU2t6mEz+TS5aT67QCsNR7AoRhoMIt7BOfSvjc68QeTHRGoBW/CX80/e523RsjiMXc5QYvmQtSPRBCtrnEQ2UOdTQGcIHRd/oYCVCwaSLOIPHqDQboQKjG8P+UoDwSwUF8VPTIa9xOl38gbVE06TaiPMUGbDdMEkMN6HYNnusVD8di7aGhuXmH3XTcyALaXIKrlDZY7UIUcIO+hmrqA39tXyxqJ0554aSisjKuOhUcGTXyu15ZXbVLFfGY/4ZmwW6YRH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0136.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(86362001)(9686003)(55016002)(107886003)(71200400001)(33656002)(2906002)(4326008)(316002)(53546011)(478600001)(8936002)(5660300002)(8676002)(6506007)(66446008)(66476007)(52536014)(7696005)(66556008)(76116006)(91956017)(66946007)(54906003)(26005)(186003)(6916009)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: oY/aF912f9T8YMYzMteo6WUKRFUxleLFj+01ohpNUrPk5ZCyhYwyNREE3UJbpoi78u4kgQhCH8iNaExgSkfdrEnniJJfmn9Yh7UB5V9OSdHg/p16UIVQuEUZPtIoXKswwIloGujFr0WaqS51adnT1XAyZUj8hos+rNnAaxIG75jquvE4v6x1xrGMYB0QVbR3vGAr0Lq3L9KN/vOn640zRQLi65RF1jXDH9+0APY9006Dvhb3l5rMtMzh0AA0sC2Fdw84wesk6IilaF3sST+eJyDzDD4M2D+dOXDI+2U/veF7YbrjrMkCws6kizGNw3U/5aTQKzOSogcmDcVS6KrBBq8o+EUqOd2gYJUULTgGYS8MN7DDEB5QsbgDZGWISZ9mBG8+4bwPK6ywO+StsW8ymi+oCnaiyYnRtXNocswcik6kM0eV0RrUNOL03c0ow7mJfKcXKmWLcon4b1ZS4jl8J/F3aFJQGgBGo1GkI7CVrWk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fabca5f6-1469-48cd-876f-08d7f808167a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2020 13:09:51.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BVY9xR7MHrbASwkTfQTIXWoq2XuHggrE9draW8S0dWCC2E/vtGHzNB2KIx32MiB8ISn2bSsrV7L/KabPDz/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0053
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claudiu,=0A=
ping!=0A=
=0A=
Is is possible to switch between mcount modes (Linux-style <-> baremetal-st=
yle) via command-line options for ARC GCC?=0A=
=0A=
>From: Alexey Brodkin <abrodkin@synopsys.com>=0A=
>Sent: Thursday, April 2, 2020 17:15=0A=
>To: Claudiu Zissulescu Ianculescu=0A=
>Cc: linux-kernel@vger.kernel.org; Steven Rostedt; Ingo Molnar; linux-snps-=
arc@lists.infradead.org; Eugeniy Paltsev; Vineet Gupta=0A=
>Subject: RE: [RFC] ARC: initial ftrace support=0A=
>=0A=
> Hi Claus,=0A=
>=0A=
>> -----Original Message-----=0A=
>> From: linux-snps-arc <linux-snps-arc-bounces@lists.infradead.org> On Beh=
alf Of Claudiu Zissulescu=0A=
>> Ianculescu=0A=
>> Sent: Thursday, April 2, 2020 11:10 AM=0A=
>> To: Vineet Gupta <vgupta@synopsys.com>=0A=
>> Cc: Alexey Brodkin <abrodkin@synopsys.com>; linux-kernel@vger.kernel.org=
; Steven Rostedt=0A=
>> <rostedt@goodmis.org>; Ingo Molnar <mingo@redhat.com>; linux-snps-arc@li=
sts.infradead.org; Eugeniy=0A=
>> Paltsev <paltsev@synopsys.com>=0A=
>> Subject: Re: [RFC] ARC: initial ftrace support=0A=
>>=0A=
>> Hi,=0A=
>>=0A=
>> ARC-gcc has two modes to call the mcount routines. When using elf32=0A=
>> configuration, the toolchain is set to use newlib mcount. When=0A=
>> configured for linux, gcc toolchain is using a library call to _mcall=0A=
>> (single underscore)  having blink as input argument.=0A=
>> So, using the proper linux toolchain, your patch should work.=0A=
>=0A=
>=0A=
> Is there a chance to switch to Linux-style mcount in Elf32 toolchain with=
 a command-line=0A=
> option?=0A=
>=0A=
> Otherwise I guess we'll need to implement some warning which explicitly s=
ays why Elf32=0A=
> toolchain is not usable for building the Linux kernel... at least in case=
 with ftrace enabled.=0A=
>=0A=
>-Alexey=0A=
