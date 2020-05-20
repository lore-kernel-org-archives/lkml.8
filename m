Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5886BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F000207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="y7/pMyAB";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="y7/pMyAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgETIgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:36:50 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:61826
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbgETIgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws/K1Mgy2TX5V7i9ckSCSCxHeixYiRo6r8zW/0HhFHU=;
 b=y7/pMyAB52ojAH4b39cu4LiwBOvDMsGSZMhyI9B7JoSWw76KyuTTwse8CWYV1xeiS/ssVFhDERdWY5ThM9fF+PZ74WrysNRWTVzNYJjCE9E2E5v33yOAE6g4D4lUt6YIkN2sGgJow/s64ZEL8tIZf/piKDNdyXNFErDnarcUBo8=
Received: from AM6PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:20b:f0::25)
 by VI1PR08MB4061.eurprd08.prod.outlook.com (2603:10a6:803:e7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 08:36:41 +0000
Received: from VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::56) by AM6PR04CA0048.outlook.office365.com
 (2603:10a6:20b:f0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Wed, 20 May 2020 08:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT041.mail.protection.outlook.com (10.152.19.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Wed, 20 May 2020 08:36:41 +0000
Received: ("Tessian outbound 952576a3272a:v57"); Wed, 20 May 2020 08:36:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9fc3f7b4ebb99852
X-CR-MTA-TID: 64aa7808
Received: from d2f73aaaa061.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0F56CA48-5342-42C3-83A4-1CE18979C012.1;
        Wed, 20 May 2020 08:36:35 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d2f73aaaa061.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 May 2020 08:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3lMYYpXzGEj4NytLk/OgoxnA8EqYPE5giL1BmSDhHAlq8enl0Wc7sOT7SMG+R+8RLNk95r9ZuT/YNEsF8GgMWf74OvNfPxujL1oWfixlROZNqqBCJcT6bIVrnUSKfw9hESzBk7vlr885VzZJULM6Im9zJyNHMcBNFLrQUZzTZNWPmedavW4vWGwhFBeotOEw/eWLNKXMlttZJs2WbXZE+nLBOMP+Uf87RgEihq0K7gzF6I66c6IpLl4TQdrYXMLx9kOkXwxFObmzIC6RNhsBZ2HDT3eHl094yNDq2xaSLkgiMI/hGP/My4I5Z6X6/AR2Bw7hrnj9MYq6ZxmBp9MEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws/K1Mgy2TX5V7i9ckSCSCxHeixYiRo6r8zW/0HhFHU=;
 b=Z34hHWDVj7dVRB+sRvXaPZY2Gz56/ddzzhEnpL+sKSNgEoGi2bPFAnFKpmSft3yK94FuUy31xJ20uVUXrnv3+ixzyyIMdnIakLQ/9L6dXR5IbkIrO4qHIL7KVP3kmMVDOBG/Dx3TAC3AamtRsTA4/Lx6avAcncKeFjjIjjQEKfcVBfKg4fAHZD+xQMlT0ECBvGvhU3J3uRlD5G/RULqkHkNWzDL81A33IEdNezfnvy9aDddHdSIQwi1CS1LF1OqHlZrlkeHWOVn7yPz1rSgmfqLFOFZtV1H6lp+MuXOzj2h/r+FFw2cM9bfXuNmCs3ulVnlMTBgbkOepw62LFh8M5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws/K1Mgy2TX5V7i9ckSCSCxHeixYiRo6r8zW/0HhFHU=;
 b=y7/pMyAB52ojAH4b39cu4LiwBOvDMsGSZMhyI9B7JoSWw76KyuTTwse8CWYV1xeiS/ssVFhDERdWY5ThM9fF+PZ74WrysNRWTVzNYJjCE9E2E5v33yOAE6g4D4lUt6YIkN2sGgJow/s64ZEL8tIZf/piKDNdyXNFErDnarcUBo8=
Authentication-Results-Original: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com (2603:10a6:209:4c::23)
 by AM6PR08MB3975.eurprd08.prod.outlook.com (2603:10a6:20b:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 08:36:34 +0000
Received: from AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862]) by AM6PR08MB3047.eurprd08.prod.outlook.com
 ([fe80::49fd:6ded:4da7:8862%7]) with mapi id 15.20.3021.020; Wed, 20 May 2020
 08:36:34 +0000
Date:   Wed, 20 May 2020 09:36:32 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, nd@arm.com
Subject: Re: [PATCH] ARM: pass -msoft-float to gcc earlier
Message-ID: <20200520083631.GJ27289@arm.com>
References: <20200519220923.1601303-1-arnd@arndb.de>
 <CAKwvOdmH6bMJHzxSs2mVN=P5BBYjYrDs13-oq-Qq+S4ykHSYvA@mail.gmail.com>
 <CAKwvOd=EphyUWNOZ59FkrfDvDwHHU2yrXW+KML-w_6mHowK=QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=EphyUWNOZ59FkrfDvDwHHU2yrXW+KML-w_6mHowK=QA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CWLP265CA0333.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:57::33) To AM6PR08MB3047.eurprd08.prod.outlook.com
 (2603:10a6:209:4c::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arm.com (217.140.106.55) by CWLP265CA0333.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Wed, 20 May 2020 08:36:33 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06aef84f-d30b-4f61-a2cb-08d7fc98eb94
X-MS-TrafficTypeDiagnostic: AM6PR08MB3975:|VI1PR08MB4061:
X-Microsoft-Antispam-PRVS: <VI1PR08MB4061166F56C0966EA9568AB4EDB60@VI1PR08MB4061.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: K6HCjQj5CZzSICNtK2171Mmpz/2IwckVcbso9x6OFHAIxqkrCl6/8Q4bUqDWgJIGi8G0KejCkAUay8aYiHY6qOkfXz8Zk2d/sc9ACmtl3LRZzDGt+pKKTvylPUL2htybbBBebJHmvCzR0i5HUGrWP01QxRWvmx4aqE3hb+lP5+U6vv14UkDOql8j5IQsf0kxyqt4zaQA5qb3HDt8+LlDnnLW2Q3XB3+paOGqk3+8TO6XAuX5L7w1ZD9IQlIeX8F4rK6QWFRec8OuO3HFKPJQPySFH/33pBkF7ArAt16AVzrjMrPRevpV4YorzItkZu8Y7yvXq5DbHQqdMyJPzBobBZlp1HSiOYCPG6XXzI3WCe2ZmgUUpXTdTkT76659eurn4fVFXnhGdEqI7/wC1vS7fw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3047.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(5660300002)(478600001)(8886007)(36756003)(6916009)(33656002)(966005)(1076003)(8936002)(53546011)(52116002)(4326008)(7696005)(8676002)(66946007)(66476007)(54906003)(2616005)(186003)(956004)(55016002)(16526019)(316002)(44832011)(2906002)(86362001)(26005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LAzsBcNpp/hqeZteQRqTD5BXFoaleYX0fMwf8WzOXpm+4aDfjWhgNJaRvHLO0bnFL3u00sLxUtMEQ4H+U427RJOePTKF8rlMoApLAd/NEzMsFsAM3ZodqJI1jmhE56NIM6akE9yqXsJXPv01My10ppbTM3k/mael9HdOWJDOGZa1yjTJM1PCqVDc9pRncWImn2RV348TzQnn1PUMApFaT4s5kKTsGpyx885aATo454NWwR5t4OnIxV5su8onRiyp1+qwVSamAZN6mReZALmyMJ2ZNtExCIelSHRjHTq1QA59WH2NMgW9Y7vnu2uD7WPlgrLGS7fssCVJtRS32bheSYoy5Tr6GJwgoy2owOjc2aROoORH3vua77Nw0bgWUjcYuF81sDXbK/rADRXRxKqpmLzvk+wgZIISsWrCN/vPgF7vtbhIcBIH1JQpWH2jmKRER71FMl1nuZ6gHUXiiT9EN8wtj/bBYUhUbM5xDB9iPH+EPup2h2YZZUiSoVpQIvnW
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3975
Original-Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(47076004)(966005)(8936002)(33656002)(5660300002)(4326008)(956004)(316002)(36756003)(53546011)(8886007)(86362001)(70206006)(2616005)(54906003)(6862004)(478600001)(55016002)(44832011)(70586007)(356005)(1076003)(26005)(186003)(7696005)(36906005)(16526019)(8676002)(82740400003)(81166007)(336012)(82310400002)(2906002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6c1bda35-88a2-442d-53cd-08d7fc98e720
X-Forefront-PRVS: 04097B7F7F
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bBIaj8TFgPSw6GjQYdR1ea7Px7wnizmpuUUEu1CUQS4PBP7ftFx/k+xae9y3xqe/mbeLzKlZGsAQZacNM3DlLN6iJsiZXU8fpBSSMczz2wIrYVuRoQlweToT5dTgc1iW01zqR4QH8fPJJ0iSOC2xN9l8FwQMO00yneI/0wTYzktqX76jgDcpUCjtJ+dT+SSuUcxKUf5QT6fXsKYPtBp66cxA445kr3P3qFjyX48TshICZprozTY/4Cz6ipC4Tsyx/Wx7hOeODVo3EiJ/CVwNajYs+iz0niSUROoUvpfTA2xRbtz9fvWkfyDwakeZbZyK51DpMnmKchwZ37zR5RXxX62wwpD8+9ccq2GGuZ87bFRzLSlK4Y3W6UNTfkuFyHuNqv6eYH6ntWMSCCk98ExpLMBkCRLGoJQCCW1UOiunw+rO5Z0y1dJJNjmdgFC/FF3Y60FHt08WWt45PtVmV52LPYn1Fl+tOVf1ZsjkPuqSz6sIuxb4hG5FZVTUFipRAd4Ij8Eox5LbjSrzyLasSLhdx8EjUylmD7lJK9gUwsHhimkmHVxTHieZSaEyAhoMtWjyT2z0Nxb2kwRYgE8F/Q/rfQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 08:36:41.2730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aef84f-d30b-4f61-a2cb-08d7fc98eb94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/19/2020 17:38, Nick Desaulniers wrote:
> sorry, hit tab/enter too soon...
> 
> On Tue, May 19, 2020 at 5:37 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, May 19, 2020 at 3:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > Szabolcs Nagy ran into a kernel build failure with a custom gcc
> > > toochain that sets -mfpu=auto -mfloat-abi=hard:
> > >
> > >  /tmp/ccmNdcdf.s:1898: Error: selected processor does not support `cpsid i' in ARM mode
> > >
> > > The problem is that $(call cc-option, -march=armv7-a) fails before the
> > > kernel overrides the gcc options to also pass -msoft-float.
> >
> > The call to `$(call cc-option, -march=armv7-a) is th
> 
> The call to `$(call cc-option, -march=armv7-a) is the one that fails or...?

the flag -march=armv7-a is invalid if the float abi
is hard and no fpu is specified (since gcc-8).

either an fpu should be specified or -march=armv7-a+fp
(my toolchain was configured with the latter and it does
not work if the kernel overrides it with -march=armv7-a)

because of this cc-option failure the kernel goes on to
pass nonsense flags everywhere (-march=armv5t) and some
compilation eventually fails with an asm error.

> > >
> > > Move the option to the beginning the Makefile, before we call
> >
> > beginning of the
> >
> > > cc-option for the first time.
> > >
> > > Reported-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
> > > Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87302
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Moving this looks harmless enough, though it's not clear to me how the
> > failure you're describing would occur.  I don't see calls to as-instr
> > in arch/arm/Makefile.  Which object is being built before -msoft-float
> > is being set?
> 
> ... ^
> 
> >
> > > ---
> > >  arch/arm/Makefile | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > > index 7d5cd0f85461..e428ea6eb0fa 100644
> > > --- a/arch/arm/Makefile
> > > +++ b/arch/arm/Makefile
> > > @@ -16,6 +16,8 @@ LDFLAGS_vmlinux       += --be8
> > >  KBUILD_LDFLAGS_MODULE  += --be8
> > >  endif
> > >
> > > +KBUILD_CFLAGS  += -msoft-float
> > > +
> > >  ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
> > >  KBUILD_LDS_MODULE      += $(srctree)/arch/arm/kernel/module.lds
> > >  endif
> > > @@ -135,7 +137,7 @@ AFLAGS_ISA  :=$(CFLAGS_ISA)
> > >  endif
> > >
> > >  # Need -Uarm for gcc < 3.x
> > > -KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
> > > +KBUILD_CFLAGS  +=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -Uarm
> > >  KBUILD_AFLAGS  +=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
> > >
> > >  CHECKFLAGS     += -D__arm__
> > > --
> > > 2.26.2
> > >
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 
