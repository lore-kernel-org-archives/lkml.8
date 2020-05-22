Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB29C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6B82065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="CgxfAEaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgEVKh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:37:27 -0400
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com ([40.107.94.49]:17944
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728703AbgEVKhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:37:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6Eo1VLd8ile22mqyhB/6sYRvMSXEHQAsA+vxGYnWkpv63bFCXsP9Bd+5noJeA2ehb7t5mYn6bkMm769gl+YxPxDvRiBYq0raH4u8tcECwt0iwGrIJ2PGf4SFSO/iAUu7sYiVtW6jS2lCWhRBVNu/7k+eqvh5nIND5aSn62umsQ4H0q76sXpEoGt7uriFg2RIBAT950DLT74ranFmfUO6oWHjrAHncLN6YOZfR7KFFa0c+CMh/q5e+ju4lYYK8mreC8Ab597nWC2C+CRCmWwHJlCg6b0bi/YxBLtKyphD+NGGKxoGuMagtBkx0C+lUfFbdixG9VEIdFLjBgK7Brlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/QxymufbDVtZ0PoPhOAfXWG/yRGzJqXA6PeBwTA5no=;
 b=njXC15gNhFr0+4LgQNY+fXe8xw6T4VBxh/bmynf1GI0Ks3B081BfK1rgOxa3lCI4tRKH15kN9cm/uDVhHhDc4Itg3jNkbiEONVp0Pn4cnsT+bZEEL897AiTxBcBQ7n10Ph0XNbwKqcpGzjrC2DCkr1uPiqwgqH/mSUGHStThu1sMLKjRR2lx2swRb7ej2aOoviKan+JmEW3iQjnmX9mQJ8rgf2DRs0Hb3bu6FwFhTQ2YJIiFe2n5vkacQsWcZoU7hlI/X+ynZWIxQuHkeYuV30n+nQ2UzF6s9wBs5YO/We4H47jorWflYaDK7OVk6sFiBbrp99PsO9/Pa/G4flDi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/QxymufbDVtZ0PoPhOAfXWG/yRGzJqXA6PeBwTA5no=;
 b=CgxfAEaYggsgxcgExmKFxM8WjhVrS7msuyBvBTBBz3zwa417ST/rXmOw9voOldEqUdaW4fuU9w/dxWj/UADX1sgTbGkMajm5bRFBQpcl5e3df+FEVh4h9VdgWVM7ci4aD0uSlB/QjgyoJF8eKyx6EZB+TQkTpnmndjhQJDHUkXA=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB4151.namprd03.prod.outlook.com (2603:10b6:a03:77::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 22 May
 2020 10:37:21 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 10:37:21 +0000
Date:   Fri, 22 May 2020 18:36:57 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        SoC Team <soc@kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 06/15] ARM: berlin: Drop unneeded select of HAVE_SMP
Message-ID: <20200522183657.00b33079@xhacker.debian>
In-Reply-To: <CAK8P3a1qu-E8XKPiaBF0PqgGfBjNHbcONz-tgby3jt1X1X8Ymw@mail.gmail.com>
References: <20200505150722.1575-1-geert+renesas@glider.be>
        <20200505150722.1575-7-geert+renesas@glider.be>
        <20200522181118.36de5dd9@xhacker.debian>
        <CAK8P3a1qu-E8XKPiaBF0PqgGfBjNHbcONz-tgby3jt1X1X8Ymw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR02CA0063.apcprd02.prod.outlook.com
 (2603:1096:404:e2::27) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR02CA0063.apcprd02.prod.outlook.com (2603:1096:404:e2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Fri, 22 May 2020 10:37:17 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4491e6b-14f7-4e9c-fc49-08d7fe3c1b5b
X-MS-TrafficTypeDiagnostic: BYAPR03MB4151:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4151A9EEB0D7151F8E348EB8EDB40@BYAPR03MB4151.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFqFxdON/HrZk6dSD/f7Dn1R9qf5SC2WMt6dCI8P5jYNe0LXqE7Worwnd6djAR1GXk0bZGwRsF8wU5cOZj2K3UAERiJn2WLGH2qKuicGlbPF2SkXzLQEi0xHoHWcNWSA0DZq9lYfxEPrMTaTzQNQ0xEvlrtWaIxoo6KVsDI2a/S+GP+39eDbH4kV921f7EhJm4jFNtf9BHyM3hE3wTjyvqPx2hiMegdNdSxhdQq5t/72EPoAnuKc11ZPigH10NZXjxqH7e4QCYUIT88AEhFSywEcAZj7QMkUT8CcO1GxgOhbKuhxH3JEqV8HauriyBSiQ7MHyDROI1RW9Onj4mpBNK6F+E88J984HuJwN+IyzNcwmG8JyO8sdYaiYxGi4RX/7IYXLtGJQOgd5SMHQ3YCQQ9HWPq2qb72oXSkjM1wGh9OxcS+LeduLA7Hoiw8aMEV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(366004)(396003)(376002)(346002)(6666004)(54906003)(8936002)(55016002)(8676002)(53546011)(4326008)(6506007)(6916009)(52116002)(9686003)(7696005)(2906002)(16526019)(1076003)(26005)(5660300002)(316002)(66556008)(86362001)(66946007)(956004)(186003)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hKKZeWuO49Z/OIKdQlB8X2ZnR4GHYhKSIcP+nthcipnL70RfwKasyMdjttoTQwshy/5kTAFSW1Q/F0uNOueE389Jam69cY36yGhYddHInHnYObyfI7mZ1uAMhAZ+VBp34FT2kT4swG14opPS9SJVfNXJNVL0XUQ/VTvBeix/yV0FoDPCvp/KnzYmyLB0smx87ZbmDqsUPpn7uUaM38w0dLWPGwsVqrw0jvm8CpJ+xbOQHESTX1/m0MU85gFI4aii8+enk+Lt25nrAE6nUCuI8NhDEGZttZi7TeJ7uO27DOEI1pLXHMneECMcmv64KY8rJMcfn+TniSN61FfAmIIjyZ/HZzPmRX4Q7YcpUbBBG46WRzcZinwQ6XLmphOTzZT68OXCyp3lpoiwINg6kLhUs2gINM+KVZJr9rNRuIK1W3nlakf5E6+8YiXSBabtBwkgY9QrfjhBVK7zIV2HCIaFkrlcNjGHBO6NLPBimBOPuIy+R/skrdoyb+NXsQYxuj5d
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4491e6b-14f7-4e9c-fc49-08d7fe3c1b5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 10:37:21.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rz3KnTyyjNEKHy7P2qVtTNUXnirvAsCZrOVcQEGkbrZfuZ9sZ2l8f2EBovo+zap/9C3U/4jzd+Lv7ys+uM9Ylw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 12:34:43 +0200 Arnd Bergmann wrote:


> 
> 
> On Fri, May 22, 2020 at 12:13 PM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > Hi Arnd, Kevin, Olof,
> >
> > On Tue,  5 May 2020 17:07:13 +0200 Geert Uytterhoeven wrote:
> >  
> > >
> > >
> > > Support for Marvell Berlin SoCs depends on ARCH_MULTI_V7.
> > > As the latter selects HAVE_SMP, there is no need for MACH_BERLIN_BG2 to
> > > select HAVE_SMP.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > > Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>  
> >
> > The patch looks good to me. I want to know what will be the mainline
> > path of this series. SoC maintainers take it then send A PR to arm-soc?
> > Or each SoC maintainers ack it, arm-soc will take the whole series?
> > If later, then
> >
> > Acked-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> >
> >
> > This is the first time I see a series touch different SoC platforms.  
> 
> I have already merged it. The normal way we do this is that platform
> maintainers can choose to merge individual patches when they
> are happy with them on the early review, or provide an Ack for
> them to get merged as a branch.
> 
> I picked up v2 of the series as there seemed to be a sufficient
> number of Acks and everyone that commented had agreed
> in principle.
> 

Nice. Thanks a lot

