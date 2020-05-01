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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC405C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FE9F2071C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Medlh0VC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Medlh0VC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgEAKs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:48:27 -0400
Received: from mail-vi1eur05on2082.outbound.protection.outlook.com ([40.107.21.82]:6195
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728268AbgEAKsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh1yA6bW0tqiCq+6XqSZNhQoKWILURrWvGCybsuHQK0=;
 b=Medlh0VCJv5WcKGr+sfQM5juEy9/QBv2i1MGvRUwR/82WzVhjnET3cYBY0agObs4g44grg5YIYgqudgmZQA6cYHGFqjlcSc2CsK/QdN3JfMpHP2WeDqTiQ4v3DE1vdx0fQRwp8p9PfmkqMInh16r4ixPoRcxny5l+miqGDVvIOc=
Received: from DB8PR09CA0036.eurprd09.prod.outlook.com (2603:10a6:10:a0::49)
 by VI1PR08MB3870.eurprd08.prod.outlook.com (2603:10a6:803:c2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 1 May
 2020 10:48:18 +0000
Received: from DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::98) by DB8PR09CA0036.outlook.office365.com
 (2603:10a6:10:a0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Fri, 1 May 2020 10:48:18 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT048.mail.protection.outlook.com (10.152.21.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 10:48:18 +0000
Received: ("Tessian outbound 5abcb386707e:v54"); Fri, 01 May 2020 10:48:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ace794c896e575e9
X-CR-MTA-TID: 64aa7808
Received: from d50e0cb3ed9b.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 52253187-6C53-46F4-80C7-420BA8846822.1;
        Fri, 01 May 2020 10:48:12 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d50e0cb3ed9b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 01 May 2020 10:48:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHFltqjI+joSC/TXJUNfKmvsDOX5nOtwPwrsIcbRsCO70kEV+fcYizRYJIkOZSRBKhNmTkf5/iHkKcpIYhhMYEG91/d5FrgWsvIPHKbWJZO9HCGDCq77lTED4zkZeu1bGjWT/fUtbjxl9j47UMgGJ4pijzE5p/x7+JWja2HVOK+N41fa+eBzXHM7ZiOZaIHHwUkVE1PUg0HF48ioTwYp5L0yXCztJKls89XeG+Sot2gDcqTH8k/bcNi0jtFLOtD3Op8hBt66FTVg2mrI648J3GtGvHvH2risNxE0QhUfbAi6fibKWemPAy/0zTZkvmu/v++kH4T6IsMGqy12WxNfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh1yA6bW0tqiCq+6XqSZNhQoKWILURrWvGCybsuHQK0=;
 b=ZYVNk0CaYlbcGuhmG78ExVpB8vN5WqqDjgs/TXH+CY9QeRtlfG98wcN6gBLLDHrDTHNyMAsL0uxB1RJlWvuywDodC9/0k9aS3/vBLlwVpTLIQ68JiCmm2By4FNjzyelAXls16Q43ywmjBC6q37HCFgzjWe83epZe28uFClNdMooJZVFDs3LW92j0CLOAUo2MOb0DxLZNtekRlujW7gobiKu5UeegWxlBV280BrmL+hsL5SKtbHyJL8iDA4LZzv6FT/UACWKKeF5YjCCGljgDfaTRpZ8/dYEC20gc2g6CoUTrdVZdnIlD2f7w4SSORFwbJ1E5MsA+M2u8ni5cCsDIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zh1yA6bW0tqiCq+6XqSZNhQoKWILURrWvGCybsuHQK0=;
 b=Medlh0VCJv5WcKGr+sfQM5juEy9/QBv2i1MGvRUwR/82WzVhjnET3cYBY0agObs4g44grg5YIYgqudgmZQA6cYHGFqjlcSc2CsK/QdN3JfMpHP2WeDqTiQ4v3DE1vdx0fQRwp8p9PfmkqMInh16r4ixPoRcxny5l+miqGDVvIOc=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (2603:10a6:20b:85::14)
 by AM6PR08MB3814.eurprd08.prod.outlook.com (2603:10a6:20b:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 1 May
 2020 10:48:11 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::78d3:4ffd:f7da:b26d]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::78d3:4ffd:f7da:b26d%3]) with mapi id 15.20.2958.027; Fri, 1 May 2020
 10:48:11 +0000
Date:   Fri, 1 May 2020 11:48:10 +0100
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
Subject: Re: [RFC][PATCH 2/4] mm: cma: Add dma_heap flag to cma structure
Message-ID: <20200501104810.v6oa2yhawr4iki67@DESKTOP-E1NTVVP.localdomain>
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-3-john.stultz@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501073949.120396-3-john.stultz@linaro.org>
User-Agent: NeoMutt/20180716-849-147d51-dirty
X-ClientProxiedBy: LNXP265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::30) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-E1NTVVP.localdomain (82.1.208.173) by LNXP265CA0018.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Fri, 1 May 2020 10:48:10 +0000
X-Originating-IP: [82.1.208.173]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a1d3636b-1ec6-40a0-e5ee-08d7edbd28bf
X-MS-TrafficTypeDiagnostic: AM6PR08MB3814:|AM6PR08MB3814:|VI1PR08MB3870:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB3870AF8ED4BF371F597AF3D5F0AB0@VI1PR08MB3870.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;OLM:3968;
X-Forefront-PRVS: 0390DB4BDA
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: dCOXqjnSJInXM7LEHWSFiAJTR88Kz+TNIxAWI6wVx4kifiF20nq/8dpV2wgFqtjjNoScawbYRWDd9XFQbBOQbgBaDxC+i1OOXo8TrS/6IA76BmlWKBqVN7L4dOa/Wn/5MxOu0JT8RD71n0NyCPBVDgrl5mCRPt00yrCipSNh6dq29RSl+jEMo0SB+IGxBNQGYpueIXKQOanW3hgOsrKILrIZG8mwRJNInYaahvxCqOF+z0eUZ1C7pyHQbC3/R4/HdNvMdh740n8HPdz+Mxu4NXSN01S2xwHiRYQtOxfpVvbhyOkRL+H/bGxNkTjPAoLBfnJ7fddINY+jw/ji2aFN0hu4MsjoxhPxC7PYVP1UiG4yX/RU36dz2+yS1C4+rjwtLTQYXxHJw50PYqqsDkrBd/0XqEgJuqDsA4sFpus1VE/GGb+P4nkYwYWoStAFPViZ8z+jVtBQlaDaj5Nugg5EtMRklA1bwNoYCOsqtcmleA2bj97jhQeKRAuRG+FeZtVo
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3829.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(16526019)(186003)(26005)(1076003)(86362001)(7416002)(2906002)(66946007)(66476007)(66556008)(478600001)(6916009)(4326008)(316002)(6506007)(52116002)(7696005)(956004)(8936002)(8676002)(5660300002)(54906003)(9686003)(55016002)(44832011)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ueeBzt04V6IIRF54QtBP/VkSybsnx5f0r4af/K1njxt+s83LtQiw4d/9CUBjEqXK+uWok+7hQMIyxBEVzLUatX6jMG0GymzNxjONg4xT5vNCeeAt8nHy8TAIUh12DXeN3cfRgz6X/QsJZT17NbRfSgQ6oNrnbraCaAghOBHBJ1Lu+XgbrPIBw/5zBDlH8pjlcekiXrSBpQ/PQ3LbbSwPbGiF9WG4GaOsSiEQxCalC1i5QxH9knyWlOSakb0oCNxpXaOOvkbmsQ5ccwCV9k1mdQcprefTmKJtOxWetnklA3k1mmgECO+GUPy1JTMFXTeBU/+lD53EfuCkxee85eVHGGXZoRUrbvbFcsUqjsNL7wHABBKlpo16gRvDKbZYmEIu2e1drQh9Ev7h6heGf+AdeO7Z1G09wM5dyg8MIb2y3PyeFeORkCp6tNqwp/ZdLy41w2i1dijPEUirGwaw0juIpaLGlS1KoHvcvx51XFd0+vgHF2hSQhkM+R+QTjQ6a9N0orFlBVN9S4nY82xCTtF2L/AqLKbatBkmYjxukjPBOigpZHIM7GYom7ZY9wEkMLvmZjX26DHm+WMa/T3dG/Wpovl9QBOKZtXsWzZrgOS5y1W4p8HiTV5uSVDLbTHPePTu9bQw0wBOquguqbLW81jcrkP0J0YiFjqEHumPcUm+J/iTmyQn0APQPQf03EA9GAAE8VJoFwonvPy7FVPT1D5N6xpHKmFm+zWKOxEBGivHCbKmbkfzMXLzxx4tfqn+bzkhOHWwwwdvURqKGG8cOR8zT0s0NjtgtJPEui/Mo7E7tOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3814
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(46966005)(70586007)(47076004)(9686003)(956004)(55016002)(82310400002)(8676002)(336012)(478600001)(356005)(81166007)(2906002)(5660300002)(7696005)(82740400003)(54906003)(16526019)(1076003)(316002)(186003)(70206006)(8936002)(26005)(6506007)(4326008)(86362001)(6862004)(44832011)(450100002)(309714004);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 41b179f4-05d7-428c-3c6d-08d7edbd243c
X-Forefront-PRVS: 0390DB4BDA
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngjgnS+QPuPwIjeLttky9zusOeeCjC6Skowd9bClKNa/LSuodrSqCi7JeuuqqyAmSqiJ9k0an+RnbsVjtM3GzPSq9GesgL6NVpUOIe4aLo8493yPAVskUbtWVgNz5hDhFSMsjgOa4TAlAFHlSD8Y8F3bB6zPlzbetCIwDe9BNnbCzm0YQ9IhkYNFY2gT4pbEkAgAKYE6s/rvB6TZ2qCtXKF00BYPKEqB4w4Jy+pNwznrxu8V+57vcFqXhoSvLMqs614nCz+Sx5TnLYVa3kXlr7bSMb4QdA4kl8hUx5W4Um22+8JxQHScOI12TSe1qAkOvR7gQgV2z4H0lAmf4+v2AUWg+AY8+B0aExAb57Ernufk9yerNqajDa/mZSAMWiRZsZW9Uz6jnE6atMaqvML2YTaZuBE5SDVgBHmwZHP7ffHI7ZuSVDVSKA95F42fgNTAh4eU4NflHDdBfhqfXJhG3DO8BJMbi/Rf5e4hrz6anpmDMkgruvRmNT6+CSgJgBNBHiexO4DtR0WLiVm+/B0gsjcYHu4KCHbB027A0PrXX3A=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 10:48:18.4051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d3636b-1ec6-40a0-e5ee-08d7edbd28bf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3870
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 07:39:47AM +0000, John Stultz wrote:
> This patch adds a dma_heap flag on the cma structure,
> along with accessors to set and read the flag.
> 
> This is then used to process and store the "linux,cma-heap"
> property documented in the previous patch.
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
>  include/linux/cma.h     |  3 +++
>  kernel/dma/contiguous.c |  3 +++
>  mm/cma.c                | 11 +++++++++++
>  mm/cma.h                |  1 +
>  4 files changed, 18 insertions(+)
> 
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 6ff79fefd01f..d8b8e6ce221c 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -25,6 +25,9 @@ extern phys_addr_t cma_get_base(const struct cma *cma);
>  extern unsigned long cma_get_size(const struct cma *cma);
>  extern const char *cma_get_name(const struct cma *cma);
>  
> +extern void __init cma_enable_dma_heap(struct cma *cma, bool enabled);
> +extern bool cma_dma_heap_enabled(struct cma *cma);
> +
>  extern int __init cma_declare_contiguous_nid(phys_addr_t base,
>  			phys_addr_t size, phys_addr_t limit,
>  			phys_addr_t alignment, unsigned int order_per_bit,
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 8bc6f2d670f9..f667fd51daa2 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -303,6 +303,7 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>  	phys_addr_t mask = align - 1;
>  	unsigned long node = rmem->fdt_node;
>  	bool default_cma = of_get_flat_dt_prop(node, "linux,cma-default", NULL);
> +	bool heap_exported = of_get_flat_dt_prop(node, "linux,cma-heap", NULL);
>  	struct cma *cma;
>  	int err;
>  
> @@ -332,6 +333,8 @@ static int __init rmem_cma_setup(struct reserved_mem *rmem)
>  	if (default_cma)
>  		dma_contiguous_set_default(cma);
>  
> +	cma_enable_dma_heap(cma, heap_exported);
> +
>  	rmem->ops = &rmem_cma_ops;
>  	rmem->priv = cma;
>  
> diff --git a/mm/cma.c b/mm/cma.c
> index 0463ad2ce06b..ec671bd8f66e 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -55,6 +55,16 @@ const char *cma_get_name(const struct cma *cma)
>  	return cma->name ? cma->name : "(undefined)";
>  }
>  
> +void __init cma_enable_dma_heap(struct cma *cma, bool enabled)
> +{
> +	cma->dma_heap = enabled;
> +}
> +
> +bool cma_dma_heap_enabled(struct cma *cma)
> +{
> +	return !!cma->dma_heap;

Stylistic thing, but I don't think the !! is really necessary. It's
already a bool anyway.

> +}
> +
>  static unsigned long cma_bitmap_aligned_mask(const struct cma *cma,
>  					     unsigned int align_order)
>  {
> @@ -157,6 +167,7 @@ static int __init cma_init_reserved_areas(void)
>  }
>  core_initcall(cma_init_reserved_areas);
>  
> +

nit: spurious newline

Cheers,
-Brian

>  /**
>   * cma_init_reserved_mem() - create custom contiguous area from reserved memory
>   * @base: Base address of the reserved area
> diff --git a/mm/cma.h b/mm/cma.h
> index 33c0b517733c..6fe2242c724f 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -13,6 +13,7 @@ struct cma {
>  	spinlock_t mem_head_lock;
>  #endif
>  	const char *name;
> +	bool dma_heap;
>  };
>  
>  extern struct cma cma_areas[MAX_CMA_AREAS];
> -- 
> 2.17.1
> 
