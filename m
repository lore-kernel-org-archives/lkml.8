Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212D6C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B692184D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="McN6Y2zi";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="McN6Y2zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgEAKWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:22:00 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:52389
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728430AbgEAKV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bFt/YSuPZ1GdsBCmdZ2CeasT3vR7OsD9EdH0NLeQEg=;
 b=McN6Y2ziAclg4vIIQe/dZ59Zyq1IvtmHnqWZNVqP50HV+ztkNv1tc8h8HC+Y+2goGEUCwjL+YeIC568Cs6+9PaJ3vrmIBY88yyPiksSwOaSS2vEuiOxlnjE+IsskVvDaT2oW3KFRsEkI7LXo+YlnYfZaQrYBRuwplRfRAaqVHAU=
Received: from AM0PR06CA0079.eurprd06.prod.outlook.com (2603:10a6:208:fa::20)
 by AM0PR08MB3779.eurprd08.prod.outlook.com (2603:10a6:208:101::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Fri, 1 May
 2020 10:21:53 +0000
Received: from AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:208:fa:cafe::b2) by AM0PR06CA0079.outlook.office365.com
 (2603:10a6:208:fa::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Fri, 1 May 2020 10:21:53 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT057.mail.protection.outlook.com (10.152.17.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 10:21:52 +0000
Received: ("Tessian outbound e88319d7ccd0:v54"); Fri, 01 May 2020 10:21:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 29a0d038b367c97b
X-CR-MTA-TID: 64aa7808
Received: from 6f3b2fe72522.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9708DBC2-C762-4AD2-9BC8-608F74154E3E.1;
        Fri, 01 May 2020 10:21:47 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 6f3b2fe72522.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 01 May 2020 10:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqYENF8SoN6XEcOa4Tw8PLnfFFGI9hK9x/kW5LCUCnK/TGPk9naIgje/UN8UZp09GbYQFDjXl43kHKmVyJau0093YzAjmS13+Pu1wokUhfRfnL9N3UHitph7wVUUaWFxFvwg5wjX/LXuSTNbk1xHGh2yzf/T99kvK0Mx16J2a0xA5l3EcRRCq+Rnr1h40NoFgT4x1+uqxoiXeESDH9ZTCdvsw6EpH4HIOUOLaMeN3b7Rq3O0sU4VmJKICPnAu3EtL5NQBfHbAKSAo/DUV+IEiGEAvqZ4pPIotOQUE0OR3dtpImsqIQDSzRXNYMputXiVRbkPtAcuRt7PfPklgpEFmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bFt/YSuPZ1GdsBCmdZ2CeasT3vR7OsD9EdH0NLeQEg=;
 b=CaDf+s0Ey3wh8zUJWiB0g0QcPse3boeqGXSMX2C/EfHiomkrTK/BO3hmdUP9QGpqhuY/3XC2sR4Pz1/nkuFpacPTdbwXD82qdMSZ0WNr4kldm+iry8e3SgsFODUAd5LKB0VXHg2flWrVfKAqbch03iiz4t1GO1DNVgzCoYwDHW8x9Ix68TAoVLGZlIPS6NVdZ/yLVzi98c1AzoAE/rT/nIj65ZbSkQojR/NCewv1SywbtPaTHOZGR1teqcUU+yz+nKtcSFUa7Z8QJiY8nIae3WaVtjCIzPxmSAFAB/W4Q0VUK5SEDa1SBLtoXiw8BRPFZp5HMUDgZGefp9MnyLDxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bFt/YSuPZ1GdsBCmdZ2CeasT3vR7OsD9EdH0NLeQEg=;
 b=McN6Y2ziAclg4vIIQe/dZ59Zyq1IvtmHnqWZNVqP50HV+ztkNv1tc8h8HC+Y+2goGEUCwjL+YeIC568Cs6+9PaJ3vrmIBY88yyPiksSwOaSS2vEuiOxlnjE+IsskVvDaT2oW3KFRsEkI7LXo+YlnYfZaQrYBRuwplRfRAaqVHAU=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (2603:10a6:20b:85::14)
 by AM6SPR01MB0041.eurprd08.prod.outlook.com (2603:10a6:20b:29::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Fri, 1 May
 2020 10:21:44 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::78d3:4ffd:f7da:b26d]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::78d3:4ffd:f7da:b26d%3]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 10:21:44 +0000
Date:   Fri, 1 May 2020 11:21:43 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, nd@arm.com
Subject: Re: [RFC][PATCH 3/4] dma-buf: cma_heap: Extend logic to export CMA
 regions tagged with "linux,cma-heap"
Message-ID: <20200501102143.xcckvsfecumbei3c@DESKTOP-E1NTVVP.localdomain>
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-4-john.stultz@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501073949.120396-4-john.stultz@linaro.org>
User-Agent: NeoMutt/20180716-849-147d51-dirty
X-ClientProxiedBy: LO2P265CA0293.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::17) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-E1NTVVP.localdomain (82.1.208.173) by LO2P265CA0293.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 10:21:42 +0000
X-Originating-IP: [82.1.208.173]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a5db13b-b8c7-4230-33b1-08d7edb977a4
X-MS-TrafficTypeDiagnostic: AM6SPR01MB0041:|AM6SPR01MB0041:|AM0PR08MB3779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3779E2493EE4E4F5F489F3B9F0AB0@AM0PR08MB3779.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;OLM:5236;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: gEbRJMvyaSoud/C1/IHSIHIinS+A0QpoNgC7nbMVWBT+EojWxI0VphW7gHktIc3jYwM7uZKvUNFNAxwnFr2cF7haCJDUyg/Hd2ZUZxWVkVMMriu1aMe00zL85Pp08hQnZoUGVSJFhRxpdthOAsTYsh5AuAoDAPwaRNrqC5L5uKTVWSEOoMGT+P/t0WF2TiNnagKJHcKhzf7eHBhFrGxfFyGEzHvDs6kcZ2p7PxjzZv1VahOO8L+PQZQRXESIHW0qvORnYZEwiHpfwYCM889QXf7teQNumIWAWC0XeX9LHK+G/5cCwrNEjqODzsGp1olJV+HPGghw3ix/Cd/yZOeOl16M655yDF04XNkEU+dFEf/RZDMofb1dTJL7v+/PBljjsb5lypafh2R7Hbn8D1BM5+uHNyepUPryLLgtEskHjwtw0T3GbjU3Q7eYjUC3/N5dQW+3rFct/af+88Kd+JNgkVeUpH2ZSPFq9a90cb9SMhi1Lm2K5Bd8KuQ5BDkMvpLM/ijNn7P5p54tGSglVDsg9A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3829.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(16526019)(44832011)(26005)(55016002)(66476007)(66946007)(66556008)(186003)(1076003)(5660300002)(4326008)(7696005)(316002)(8676002)(86362001)(6916009)(6506007)(52116002)(7416002)(2906002)(8936002)(9686003)(966005)(956004)(54906003)(478600001)(142933001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: n8aSPr1PZZoXnwqv3uvcu2gpzeV/ytbmejNje8WY0bWDioh4dNJDzh6MT7E5AWrwM8SA+W9NGqtGTtuyLlgMkf9yK/HNG/ZNLk71qXLCsyldK93QfYIksuJBsc2zvETpJu68laKcjhD7Li/oSxNH5LCBz6PmXRJvpqQhlFI2oPHgPxLbI6DtXJqPkthoTlYrZiWu3R0z1ZqrMFwyIMJ73rt/P4XbnERmRb6G/HF1FDpWkbRl3uq3UAAhq/PPxx7ffj+2QpyxJNWM4Fk7vB9QqeL7LeOXjtXdCyPVXnONblkRG3hwHHm9N/fOVMCqTfn6eU46spjHDqC2wwq4k6FrD3O+7+6cvjy/5JDqiyKhx9omYxyGsj0h+Yzi6y//laRJMD2ruiaJVOiliQ1pqSfy2SIK0LTn3KC+tg6sLJZ3XvNNcjFbaDfXGbPGWkSwLghMVHaH9SyLlz3+LhI2JXCH71gkb/l1VVV81qVpltIs84SkHVUwIhGaeTeb2dsGeJA+S1e6mu5E2K8NS3YQQOYdUmQ2jOvSOVHZUWHUDhU/zpqIp16Jl7ziU5mnLNA//HXZXCu+mfxflzJiiphFSJDoA4bjZDBK4Wvkl4To0yym8imApZhy1g/wFI7XTEYH9z4dYa0aM0kyWuTmHr7b/fv181pYa2hefqF0AbLEiqRTG3b+cI3fAObwSs+eeFHzuDhR2NYVYC9a6RLPI4pteGxpJbNv56uaUyCZQ48Zc+9FeNXwQbx7bh9k6I4MrDzFd3QP9o7bTB5EYcJhKBgyAR6152iwvTCvgNHhn6Jao2Vaafg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6SPR01MB0041
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966005)(70586007)(44832011)(36906005)(82740400003)(55016002)(450100002)(9686003)(4326008)(966005)(6862004)(47076004)(478600001)(82310400002)(86362001)(8676002)(70206006)(356005)(956004)(336012)(5660300002)(8936002)(6506007)(54906003)(26005)(7696005)(81166007)(2906002)(186003)(1076003)(16526019)(316002)(142933001);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2aedde36-fd95-4d7b-a561-08d7edb97227
X-Forefront-PRVS: 0390DB4BDA
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGmXU+69NBEz8wGNq45QS0axY/iwCCWNJBo+ufgtkPe1Irv0nUxjpjc6AOqvkQYrr6iIiGQihkRRc9wIaUffrOgMf4JlOqb1fCENRj6VbVunpjkJmJIXsZ683CXVRrLepBuzJY4p3xiquURMzWKvn2mj6ZjMehS33lnF41YHCc1w6640b0dkVSfkaosQ3Cl7WeEP8bRgz5lUTUkQZ3bVihNEPxImYxGLAbuKtTtFb+ESjmdPPI+06KgIvH1t7bx7ZAeNuPjd7yGJjp7zrQB3I2HLoWybsPYDJYT5CJTQEWwSfGOaS2hULhnMkWd2FVMNps9cKZse67xhg+kMwnHgNah4oDaVrjfyPNBE+o1G4IaZ2SnZlxWFngKmRQgIM1U9SSMvbygxV1jLDX0395KlEOQFUAa+zKfRpBWkVDnyuodMmNxKR9XZNit2C1ClN3JC1GEq/3SrSiuDd6RZM7U95+Jmd7hsGUmQKdX7PEpeyKFFsEYuMgS8BifZg4oxMjjxBlWb/j8KVRhrW7pP0Rykzti1SEmAW+I+F7cESb9KNpwJgUogEkJbRN14pA3dhUPjmQ4gjj0QBFzd5dAApaVpNg==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 10:21:52.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5db13b-b8c7-4230-33b1-08d7edb977a4
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3779
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, May 01, 2020 at 07:39:48AM +0000, John Stultz wrote:
> This patch reworks the cma_heap initialization so that
> we expose both the default CMA region and any CMA regions
> tagged with "linux,cma-heap" in the device-tree.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: "Andrew F. Davis" <afd@ti.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/dma-buf/heaps/cma_heap.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> index 626cf7fd033a..dd154e2db101 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -141,6 +141,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
>  {
>  	struct cma_heap *cma_heap;
>  	struct dma_heap_export_info exp_info;
> +	struct cma *default_cma = dev_get_cma_area(NULL);
> +
> +	/* We only add the default heap and explicitly tagged heaps */
> +	if (cma != default_cma && !cma_dma_heap_enabled(cma))
> +		return 0;

Thinking about the pl111 thread[1], I'm wondering if we should also
let drivers call this directly to expose their CMA pools, even if they
aren't tagged for dma-heaps in DT. But perhaps that's too close to
policy.

Cheers,
-Brian

[1] https://lists.freedesktop.org/archives/dri-devel/2020-April/264358.html

>  
>  	cma_heap = kzalloc(sizeof(*cma_heap), GFP_KERNEL);
>  	if (!cma_heap)
> @@ -162,16 +167,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
>  	return 0;
>  }
>  
> -static int add_default_cma_heap(void)
> +static int cma_heaps_init(void)
>  {
> -	struct cma *default_cma = dev_get_cma_area(NULL);
> -	int ret = 0;
> -
> -	if (default_cma)
> -		ret = __add_cma_heap(default_cma, NULL);
> -
> -	return ret;
> +	cma_for_each_area(__add_cma_heap, NULL);
> +	return 0;
>  }
> -module_init(add_default_cma_heap);
> +module_init(cma_heaps_init);
>  MODULE_DESCRIPTION("DMA-BUF CMA Heap");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.17.1
> 
