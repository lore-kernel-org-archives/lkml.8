Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6ADC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CB2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wC92kDdT";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="wC92kDdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgETPlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:41:44 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:4744
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727122AbgETPln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDWduqOXEVUvS4UUUn0Rvt0fjfR/eJGOgsPIVpoDnSw=;
 b=wC92kDdTyWYYMrhR+NOfCA1UQMY9U2xEPpVunFUO9MllfUHl9Bd8gjMaa2wRf7dAc9Q3KntU/jC2VKZ466HtfJ416TRXdTQEcQ2kLOOjGoYKTqSEJsfcY1epwX2CHWqcPCSQ63j67I3g1BOGGYFMasY7adFIUHVhsYvX8b79exE=
Received: from AM5PR0101CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::37) by DB7PR08MB3257.eurprd08.prod.outlook.com
 (2603:10a6:5:19::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 15:41:38 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:16:cafe::1e) by AM5PR0101CA0024.outlook.office365.com
 (2603:10a6:206:16::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 15:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 15:41:38 +0000
Received: ("Tessian outbound d078647f4174:v57"); Wed, 20 May 2020 15:41:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 07d3f17abcde4edb
X-CR-MTA-TID: 64aa7808
Received: from 5637a3b20d5e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D4E000B8-5320-4A60-80FD-4B494E0C2EC8.1;
        Wed, 20 May 2020 15:41:32 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5637a3b20d5e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 May 2020 15:41:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyuPI6m8o4yb9wJrgiIQ6UmUmmISFsHCpG7a7uB83Z/EAFbK4wZTWSRW/tQuL7lCrP7uJwcKeq9xp8vYkt+1TS9kzFRmD13QV/T9zgrl6dE3ZBwOCgLo066LvIvyfiR+W8SXqFvpLx6jkCwD0kTPNIUkHv8rOhoIzOmI+AbfIBfA0TDH8O56sVIEFXVrS5ZfwE4bUehCU7yGjmV/E2nqKI62QEBrEVdU3X28fTDdU3j139ngQ+4J/Hi8fN4su3b6uQlTwX9+PuVuGoXg9daw5jJQgc7yjDqpU9fqsJcS/roGYMTRf9OkMrDgplqDNVccHxD5fsGHR2OtIewdCdvbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDWduqOXEVUvS4UUUn0Rvt0fjfR/eJGOgsPIVpoDnSw=;
 b=KmPQqiAxGlLvfdRH0gqRlchV/dWu0D89lZHIm+937+g/o2skI8QLbPssQ+Yhs00pn0pY3/qrh+M8aX3J8s7HQ82YhYOyaunTiNcQDbPnnb09CJnPxvL+vCBpM+DQ5HV9WRoxPEAinDy087LUbdKwZWlQrA+A3YlHSCdqZRoJ1F8I0VbdrWhOjxEg5aQ2I2l+LPodanU85JSuRedKvbPXh119Wu1yU41QdkNLqfw2jbuYf3SQsHXS0AqhvEMn1AVECmgV3M+X/Rrp1d2xJ9vvhIllb4s+222MnTv+N5EAIjF6zFsipluu46NbiKUwXxEDLuxJSSMB5ksZbB74KkWdUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDWduqOXEVUvS4UUUn0Rvt0fjfR/eJGOgsPIVpoDnSw=;
 b=wC92kDdTyWYYMrhR+NOfCA1UQMY9U2xEPpVunFUO9MllfUHl9Bd8gjMaa2wRf7dAc9Q3KntU/jC2VKZ466HtfJ416TRXdTQEcQ2kLOOjGoYKTqSEJsfcY1epwX2CHWqcPCSQ63j67I3g1BOGGYFMasY7adFIUHVhsYvX8b79exE=
Authentication-Results-Original: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB4216.eurprd08.prod.outlook.com (2603:10a6:20b:89::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Wed, 20 May
 2020 15:41:31 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 15:41:31 +0000
Date:   Wed, 20 May 2020 16:41:29 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Rich Felker <dalias@libc.org>,
        Jack Schmidt <jack.schmidt@uky.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, nd@arm.com
Subject: Re: clock_gettime64 vdso bug on 32-bit arm, rpi-4
Message-ID: <20200520154128.GA24483@arm.com>
References: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
 <0c2abcd1-7da8-2559-1e93-4c3bdd38dec1@linaro.org>
 <CAK8P3a3fxs+14ZdCRmt_GwJGv3Aipm1r9sAHH6aVj2UrWBNuQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3fxs+14ZdCRmt_GwJGv3Aipm1r9sAHH6aVj2UrWBNuQQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::27) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by LNXP265CA0063.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 15:41:30 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3f561eb-9ef1-4d23-4dae-08d7fcd44904
X-MS-TrafficTypeDiagnostic: AM6PR08MB4216:|DB7PR08MB3257:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB32574645ADFD036DE46AEA90EDB60@DB7PR08MB3257.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: PDABmmGJzZyWj+HXbv5bzHCF1kFCHJlYC4KXmM9SdHdGvN40zV9ItjCvAKibJsnp64NvN9mREnA/MAhEi27Q40vlfKAHfKj5cODZ3KvAgHPBvFlDHh9Sz14plC59e70IkRv8Q2gi7dlKxfESc0inkHu1E9cfEGBioJeYlH4RSCHNKIf3HoyGkdooOQNAw6X1di6NcGvxOmm+vyERFQfpuXftBKYjexxUcRRygGrG8hiCTC9sD8D0b9PlQ/cE1H+RC8KqxuNUuLm7FiogeVJDONuYRGrJHlGmcWp1bcz7iiZoCTMrmVZpPceO/Co9eaFzxclv2rAr1aCMYCFwJMGAA/PUMb6jiUg8mD4NVQaDMKjS7+Xq/nuQ84qmBcjMd7Sj1sbqPXB3ofDhmJ6GEvbMOSzHAT1g+pEdd2QYB9jFgJsYhssJIbvWphbqg1hPlmk3TfKVl09/K3oIeiTo1zVjYprab6hB2577RxJIpYzoU1IWyTdzRG+EPaGGgWRsIEXJrfDhgzoLMCJwxPn5Oy0KHw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(36756003)(5660300002)(7696005)(54906003)(66556008)(478600001)(33656002)(7416002)(6916009)(66946007)(52116002)(966005)(86362001)(2616005)(8886007)(956004)(53546011)(4326008)(1076003)(44832011)(16526019)(66476007)(2906002)(316002)(8936002)(8676002)(26005)(55016002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Y6fuyXmh3eBpA7lGtKtTsYYrADjD4qEcF1utA+5YDWzhvWImxp+NaMKD+fXYr3sqfGhnlEPy4KIthKczNBtTrY7dR5SgcTnSQIzrY8Z2JxePt7Q4VwbxKyrQwCAocLs80dahGZyF/NWCbCOCnGxTqBN+ZIgp1gblwQP3ltX54bCqYEvcujG9e1b0UCJJaQDrjQ4+FGa7vsoJpatZtexe+cEEDtVZu5BxQCLHh+GppzlMqtOzLoIAZF29sgAqmCfgjjSrfZE11TkA1Qz/L9KKiwDWoRn8XELn1XsKPYrheB1jvGreqMO+o6OO5n3Z9TU6dQx7MD3ylu2eHrq6CXqr/hm8wlKH502komeube+zmrHBr3fqz7HJgyWi65TCpSK2ynf7+gqxdUh5iYp96eksqrI4tBT3lVWUS7yORgo/FRzn6iLpRLZLqrO3eGt1U6N+0ZNgIUQMSO+t5lrIkDuFXatmK7v49C0ejEubfv/u+uJKpbmybaCfBzZMi0dLGAMT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4216
Original-Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966005)(7696005)(44832011)(36756003)(2616005)(53546011)(55016002)(54906003)(8886007)(956004)(8676002)(8936002)(966005)(478600001)(70206006)(316002)(36906005)(86362001)(336012)(70586007)(16526019)(4326008)(186003)(47076004)(6862004)(2906002)(26005)(5660300002)(1076003)(82310400002)(81166007)(82740400003)(356005)(33656002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: a9d1e9e0-8d48-4a05-7bde-08d7fcd4447b
X-Forefront-PRVS: 04097B7F7F
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yA+h8r2BT5H6OMBYxTKpWbbjRKdWzmKEa7/TLo35rGqAt8Ar5tTZfhwHtRuWdfQe5Uak5WzJgD39vxXNpLQqi8XoaVIb5M7CSxl/RiVLMUy8jRPqmIFyvTP1ExI/I3xXYyRXKxM+PI3tG38QxiG8j+w9t7CmbqahNr127axu4trH9gBg0PFtdc6EPwgHEwzc9rcKKQZ9VamygjOfhe0bpBhuU115SDdckSJleZACkUy7WK5bms0+1/0O6CdINIRz29wFBrIrEVNgPIgPP0iG/kRpsN/Um2i+ILWXhEysyKeT+2pDc9/BmbWrQ+2zEgj8VbynAANSW25WukLo2JCR0tEkxOut5wOZ/U4ciP9wI1BjErCZmXgL83qIpxhoWGPvTT19xl8MagK34PVTXOc6K2fUVtI9naMGxqt8GzetzxOlGXAB3NRSjMA2NAljUY7fBoC87b9aaRGS67tQMqoSNWk9Si8SulzRdRplGeqwmxS/887Vlm9TDFVOmQd9ufqpWvKGQhLxBRyepUKCFkCWU/AejqUR12UsMxyuh/tSfiBQMJncWH+GIW8Lv1QYBywzBd9x1TwiLDJuozWu+r7yYg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 15:41:38.3340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f561eb-9ef1-4d23-4dae-08d7fcd44904
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/19/2020 22:31, Arnd Bergmann wrote:
> On Tue, May 19, 2020 at 10:24 PM Adhemerval Zanella
> <adhemerval.zanella@linaro.org> wrote:
> > On 19/05/2020 16:54, Arnd Bergmann wrote:
> > > Jack Schmidt reported a bug for the arm32 clock_gettimeofday64 vdso call last
> > > month: https://github.com/richfelker/musl-cross-make/issues/96 and
> > > https://github.com/raspberrypi/linux/issues/3579
> > >
> > > As Will Deacon pointed out, this was never reported on the mailing list,
> > > so I'll try to summarize what we know, so this can hopefully be resolved soon.
> > >
> > > - This happened reproducibly on Linux-5.6 on a 32-bit Raspberry Pi patched
> > >    kernel running on a 64-bit Raspberry Pi 4b (bcm2711) when calling
> > >    clock_gettime64(CLOCK_REALTIME)
> >
> > Does it happen with other clocks as well?
> 
> Unclear.
> 
> > > - The kernel tree is at https://github.com/raspberrypi/linux/, but I could
> > >   see no relevant changes compared to a mainline kernel.
> >
> > Is this bug reproducible with mainline kernel or mainline kernel can't be
> > booted on bcm2711?
> 
> Mainline linux-5.6 should boot on that machine but might not have
> all the other features, so I think users tend to use the raspberry pi
> kernel sources for now.
> 
> > > - From the report, I see that the returned time value is larger than the
> > >   expected time, by 3.4 to 14.5 million seconds in four samples, my
> > >   guess is that a random number gets added in at some point.
> >
> > What kind code are you using to reproduce it? It is threaded or issue
> > clock_gettime from signal handlers?
> 
> The reproducer is very simple without threads or signals,
> see the start of https://github.com/richfelker/musl-cross-make/issues/96
> 
> It does rely on calling into the musl wrapper, not the direct vdso
> call.
> 
> > > - From other sources, I found that the Raspberry Pi clocksource runs
> > >   at 54 MHz, with a mask value of 0xffffffffffffff. From these numbers
> > >   I would expect that reading a completely random hardware register
> > >   value would result in an offset up to 1.33 billion seconds, which is
> > >   around factor 100 more than the error we see, though similar.
> > >
> > > - The test case calls the musl clock_gettime() function, which falls back to
> > >   the clock_gettime64() syscall on kernels prior to 5.5, or to the 32-bit
> > >   clock_gettime() prior to Linux-5.1. As reported in the bug, Linux-4.19 does
> > >   not show the bug.
> > >
> > > - The behavior was not reproduced on the same user space in qemu,
> > >   though I cannot tell whether the exact same kernel binary was used.
> > >
> > > - glibc-2.31 calls the same clock_gettime64() vdso function on arm to
> > >   implement clock_gettime(), but earlier versions did not. I have not
> > >   seen any reports of this bug, which could be explained by users
> > >   generally being on older versions.
> > >
> > > - As far as I can tell, there are no reports of this bug from other users,
> > >   and so far nobody could reproduce it.

note: i could not reproduce it in qemu-system with these configs:

qemu-system-aarch64 + arm64 kernel + compat vdso
qemu-system-aarch64 + kvm accel (on cortex-a72) + 32bit arm kernel
qemu-system-arm + cpu max + 32bit arm kernel

so i think it's something specific to that user's setup
(maybe rpi hw bug or gcc miscompiled the vdso or something
with that particular linux, i built my own linux 5.6 because
i did not know the exact kernel version where the bug was seen)

i don't have access to rpi (or other cortex-a53 where i
can install my own kernel) so this is as far as i got.

> > >
> > > - The current musl git tree has been patched to not call clock_gettime64
> > >    on ARM because of this problem, so it cannot be used for reproducing it.
> >
> > So should glibc follow musl and remove arm clock_gettime6y4 vDSO support
> > or this bug is localized to an specific kernel version running on an
> > specific hardware?
> 
> I hope we can figure out what is actually going on soon, there is probably
> no need to change glibc before we have.
> 
>           Arnd

-- 
