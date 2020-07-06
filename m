Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17033C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D796F2074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Kj3THlCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGFIEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:04:31 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:30752
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728300AbgGFIEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:04:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYeoi7mEUawO4aTxw25iNvrbYRXJqgO2DH2oEArHNLAvVAgry1YZ7QiGYuxcmxiZcAgg6FBBX7od9ygOC2liLENBsUsL9ZwkAjP+hvejZa/lv03B7VZjbO8jd7/x5LicfXrHy/P5LiB05SLFhrCNKRzkathnAiUnkDoKR6f55NU6kFdAGLo9Wl93mToqakybnA4u05fzaveV5y0SngggZWNW0QQP6RVSOu0McZaA4DAMLIhs+RS3yV+4cPkl89rla/FOkl8gF5zqHskPDDQcFy0TQcSCauGhpGKAlqP8BEsYVhCqlnHGzL1hduHrAKcVDYAq50yI0DOwV8KwEhH6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jn4t2RKrnmol0kl0/pF2b4qW3Q793dNkidnyB0XxPs=;
 b=AVbmtYHJhRvmMNFSoJDlxFFJ5fqpRBTTj50j4gZdk87aweCQTp2dWPXo2Y/rYihawtYCOW5oHeTebn6X4CO317+D3hUwITYvJjrtVYOmUAKhmMApI+YgCBH5LWC/9lgzVH/oAkDXzj+tVIgfzlmg3LVzEwAlTlpFwU5R+TvYk/odkvUPKPZ/kapYvXgCSWbfnW+BwhPU+qBGUhNPg0LXYxT+UbA2Tkk5m2SuAEeA8Xuph17XURLazM/g00gHOdWs9qB3BhtI4XzxTO+IUy5WwKC5bzLQt2+Diz+ccUM2hJLLd3hY5yRsHPjhEUYpbCkun+ZRl2psLgwb5j2p4/KejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jn4t2RKrnmol0kl0/pF2b4qW3Q793dNkidnyB0XxPs=;
 b=Kj3THlCBYfaafRJ4/N1g1OFWT6CoDuV1yN0cvebLloq5J0xkwDuOQxm3c/7Yia65jpO2t4V7CiZunCq5zFZakwlIDGsrBcrAFDik8uCEZ2gVZJP0WYGAEnmP/rSIhS1ub3e7zHDhUgZD1rB32U9DsNKmIVV2oVHWSwbppq/F9kk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3749.namprd03.prod.outlook.com (2603:10b6:a03:6b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Mon, 6 Jul
 2020 08:04:27 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 08:04:26 +0000
Date:   Mon, 6 Jul 2020 16:04:11 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: perf: add support for Cortex-A55/A75/A76
Message-ID: <20200706160411.19d91904@xhacker.debian>
In-Reply-To: <20200703123346.GB18953@willie-the-truck>
References: <20200619184423.5e61a838@xhacker.debian>
        <20200703123346.GB18953@willie-the-truck>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0002.jpnprd01.prod.outlook.com (2603:1096:405::14)
 To BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYCPR01CA0002.jpnprd01.prod.outlook.com (2603:1096:405::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Mon, 6 Jul 2020 08:04:24 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4afbf8af-8255-4c75-4272-08d821833385
X-MS-TrafficTypeDiagnostic: BYAPR03MB3749:
X-Microsoft-Antispam-PRVS: <BYAPR03MB374983A13F92D652E35553D4ED690@BYAPR03MB3749.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbGXAupL14yl0wr/vK0L3xDWbJbM5cIuGi1w1QiCCN7LGiEVMOPh1O6P/KJDEeOVxgNTzm9gDeykW8L3XcEAlksx0CEiPdH9pBLqtVdy6AZ2+pW0xOPafHS/2TvKSuz6cwI3DJTd6Boay0NO/pofwV7CjgLskvDyR5GY43OW6yt5CM3KJUEoUN+GKS4n4Fmk1/v9q7TybOr/n9q1uriHKl6aEc7IWre+s156Psq/MShD9mUdy5x3SyoUJvEL2+D4eUdbRFHWg2T68mvcojhD8goO7gJAC4LJBdzp3HJq4zCeeLa5yIvViWSO6s2VkQ7K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(366004)(39860400002)(376002)(396003)(8936002)(186003)(16526019)(6666004)(6506007)(478600001)(26005)(55016002)(4326008)(2906002)(6916009)(9686003)(83380400001)(8676002)(5660300002)(86362001)(956004)(1076003)(66946007)(66476007)(66556008)(52116002)(54906003)(7696005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: STHMby97wEEW3LTOL3YhfWnmK/7Ra8q3VufgZI7ztPxXocJ+QcYG+yJgCU67VQfKDvOPgt5k2ytfLpf5wHJ3y/9KEzoPa5tGEQEZx1PTcmAVJ4iDvTg1S4WenEH4tnJsfvtCQiARmUtcne6Ry2y00w82uxjEtSb0Z3C2/55rx1yD1k1Y2u+U2RSbA6/5/42q5vbYpI5e9tPXkmHn61LDuqkGmU+J+si/8rhD+G1/eYEAQmP1dREbItqNdvAY5lmDoUwErBzlKwV3shM4hMd9e28yLi4dT0TzvXvxThIcjDUWGQF9exO2Jlic1TKuah2PEOFYyY2QAkxZSkjgriEMO2hPGxsLjQ/it5jwbbX7ETDH+2UpgJ2nTCSg3mic5+PgZnTyiKVnlPAHbr8MKURhJ3tY5X7WRIhA2vBp0qV12/+4+WaRzt8tOBmAymLosp5eumdl0M+jmzcXTEFymWD43TDEL8JHpSEIJ5YUWkvLLWE99eZ+M8zO98hboZC2OGjU
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afbf8af-8255-4c75-4272-08d821833385
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 08:04:26.4857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdlQzg2Dn9bREZiYkOOldN3xjveozEi2uYCxwvFqS8UW5mIjhJvpJxbacWq9aKRX0JdzosOSWgiYa6plOtPbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, 3 Jul 2020 13:33:47 +0100 Will Deacon wrote:

> 
> 
> On Fri, Jun 19, 2020 at 06:44:37PM +0800, Jisheng Zhang wrote:
> > The Cortex-A55/A75/A76 use some implementation defined perf events.
> > Add the support.
> >
> > Jisheng Zhang (3):
> >   arm64: perf: add support for Cortex-A55
> >   arm64: perf: add support for Cortex-A75
> >   arm64: perf: add support for Cortex-A76
> >
> >  arch/arm64/kernel/perf_event.c | 49 +++++++++++++++++++++++++++++++---
> >  1 file changed, 45 insertions(+), 4 deletions(-)  
> 
> Do we really need this? I'd prefer for this stuff to live in userspace

IMHO, this stuff is to add a relationship between linux standard
HW events and ARM PMU events, take CA55 for example:

w/o the stuff, perf -e PREFETCH_LINEFILL

w/ the stuff, perf -e L1-dcache-prefetch-misses

But indeed, we also need to add json descriptions in perf tool, I'll submit
patches.

Thanks

> now that the perf tool has supported JSON event descriptions for a while,
> and the in-kernel driver advertises the architected events advertised
> by PMCEID*.
> 
> Will

