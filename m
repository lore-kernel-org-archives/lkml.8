Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B173C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84D220658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="y8N3TaIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbgCPToT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:44:19 -0400
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:34880
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732413AbgCPToT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:44:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBUwuJ3y7CvkXAyJHPbCvDSkKBCtLpb3tGnOahXqtbKlTM3TbHYLJX75bMp7qva3g/fDwvLqdVj7ulB1HsyKfLgOwoodCNzYd8vGQ4Kb7NEu3NJ1vyENHGt+ZTIVaTQR5FS6eL5heRMbeJxXpvqs7186zq+yHKAf1FTcYSzcgpTENdcls5oerRmVjrojtwv79SwS1CtPGVg0HZIJbRV7Ah5GcNwhX3Ng89KBLEN52C3AfXYkxIPjKv6S793Ykn6vBO+R6+vWW8EyZTz/aas/ZfN8sO6g0V/v/IR6K3KpodXOgXgu1meLkwR8EeNWDgIuXQsKKpvSuC/Ltk+3kEh0GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6OXg11napf4pQQife4FYxYba4GHjM/7fUT4FwPj38E=;
 b=TEUJlLdiaILFmq1zoSxpNsM28VoKudXsp058t0dlyaUIu2g+xlSPjWl3WDhzlWXdc9oqY0oa7uG5rN6w/vviRYgbXUbJEdomUbTo95AHNUdxFGfIqVdmvYYjKnf80k5hFl3AuzUrgMm8zqt/uAX4dHStvt0lVLS7J/NnpqmePQeegSXvmka4QJdfI+7ePawzXqCzukYaCZ+XrOmSVSR1sASJb3Dah+4z4FB6ifcHNs+vOPFSaGUYR4Uv/YBN9VXAVwvA8HkbooM3zzBzAGSoEe/rc1hl2citXhk3RIzqKV1fr1IJcrlv5nOJcb9trLrX3rAXHxpA64//dxAsbVpLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6OXg11napf4pQQife4FYxYba4GHjM/7fUT4FwPj38E=;
 b=y8N3TaIGVXRBYjm1SfwqyoHeRTXfX7F+ffRzd068RDhFHkyl7Z9ld8jtkZ96mnKSqDI7M8r0PBQeYXWiYd9jSIiFPZTtQqZBMtbzdWPd3n3jBVAlUOuSBNCqnLyKxEUuA7Q7wxENW9gKovIGStKVc2PMENlPqcmZsL0mygzeBQ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 16 Mar
 2020 19:44:16 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 19:44:16 +0000
Subject: Re: [PATCH v3 2/2] dma-mapping: Fix dma_pgprot() for unencrypted
 coherent pages
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, x86@kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200304114527.3636-1-thomas_os@shipmail.org>
 <20200304114527.3636-3-thomas_os@shipmail.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0621306b-b564-0d8e-9dca-cceca71a9a99@amd.com>
Date:   Mon, 16 Mar 2020 14:44:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200304114527.3636-3-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN2PR01CA0040.prod.exchangelabs.com (2603:10b6:804:2::50)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN2PR01CA0040.prod.exchangelabs.com (2603:10b6:804:2::50) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.19 via Frontend Transport; Mon, 16 Mar 2020 19:44:15 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31e945b2-87fa-48b9-b3ed-08d7c9e26933
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:|DM6PR12MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35153C694F2C3E5E55E6C4E0ECF90@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(4326008)(110136005)(8936002)(7416002)(81156014)(81166006)(2906002)(8676002)(36756003)(31696002)(16576012)(186003)(53546011)(16526019)(86362001)(52116002)(2616005)(956004)(26005)(316002)(66556008)(66946007)(66476007)(5660300002)(31686004)(54906003)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3515;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T03KbGR4VEN4aXEXaFGwMG06ogw5LUHpD8WiJDSFSPalEOlFPz5OIR1aiYGqO9IJx6Cngr0Rd6bVzdBXSOc8nVyeTmxzgoJuTW+JyWN5Cx7IvAYoa0KC0SE8atebMnIx8eoiByOGxB+j8rvjlp4A3gF5DwFY0LecPM8g+BF+ZFnMao6mWQDIFY8bp87J9FRyuP9TrwSHkdHfkkm69pUhSlOST/rAlRcPr8MH8wgBnPExfSsWd/kcVl4fQ6V+ew1ztUk11foC2CeQEcbSq7+VIaG+5iLESq+IP7uajdsWV1SjNyNJs9t4Cyx5Y1P6ZxrEpG4oZQopqojjmYAPlh0kwe3RO+Ooufk3NiCY+Qir/hghm6GrkCQ2NSWyF6fYS8MGJDGg/sdiwx6IPAQshNbHYd7RIkoqqndcMmDOf6z47sI5X42bLPxEGFkk/ENt31nz
X-MS-Exchange-AntiSpam-MessageData: UAzKEzRmy1EkQeN6dV0HcWK0EFW9YeJUTYXDYt1jlJGx2+gYfMy6YjskslVltHMJ+c7vPqFGcmbIiAkPhmdcNgvjhKgaakZj6M1VLr+1M/mQSNqiy6114V8fS23K+MJxloLC4W3rlOKCCNjgqTFdhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e945b2-87fa-48b9-b3ed-08d7c9e26933
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 19:44:16.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpxDZR9WxIpJmi2KJz0faKOk9PUNsxG4czWZeQAmwXWjQQ5FqaG+w9LamvZFFQBXK3Bx2zjTBA1YDrRQ8KGECA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 5:45 AM, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> When dma_mmap_coherent() sets up a mapping to unencrypted coherent memory
> under SEV encryption and sometimes under SME encryption, it will actually
> set up an encrypted mapping rather than an unencrypted, causing devices
> that DMAs from that memory to read encrypted contents. Fix this.
> 
> When force_dma_unencrypted() returns true, the linear kernel map of the
> coherent pages have had the encryption bit explicitly cleared and the
> page content is unencrypted. Make sure that any additional PTEs we set
> up to these pages also have the encryption bit cleared by having
> dma_pgprot() return a protection with the encryption bit cleared in this
> case.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  kernel/dma/mapping.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 12ff766ec1fa..98e3d873792e 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -154,6 +154,8 @@ EXPORT_SYMBOL(dma_get_sgtable_attrs);
>   */
>  pgprot_t dma_pgprot(struct device *dev, pgprot_t prot, unsigned long attrs)
>  {
> +	if (force_dma_unencrypted(dev))
> +		prot = pgprot_decrypted(prot);
>  	if (dev_is_dma_coherent(dev) ||
>  	    (IS_ENABLED(CONFIG_DMA_NONCOHERENT_CACHE_SYNC) &&
>               (attrs & DMA_ATTR_NON_CONSISTENT)))
> 
