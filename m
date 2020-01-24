Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDAC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E6C2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g5PbUPCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgAXXAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:00:22 -0500
Received: from mail-dm6nam12on2088.outbound.protection.outlook.com ([40.107.243.88]:37728
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729182AbgAXXAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 18:00:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBgSPj/vOQm4CbBU2zx9tdx/woB19QG18jJceaCDl9lHKFxcBMeT5AhhSekRw5827PT09RYPQ/aLhb43y9OdDieGW7OZ5nAgk+OGJogXGUrivNH2pM67xOGSuF33T2xqWsjqV+h0+bhB0lIrCtdOY+w+kznYkQI/k4WAo0Npka9U6vfMOxF13zd7yuQUORpvvmckjZMv/AxvmJU1BmiP0OEFYV9datUDEzlKJW+TkpGIFt8RwMSUnogMRmFkenExycblrJqUK4QWUFoChkTcS/RInUV56vu/9fSdFmfYUUpBRknqsjwcI3d+i2ScIpwx0fRnF2vQXtvWthKCLt8FNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iufXTS2Uj9UWZwbH+CLlFiDHcJ4Q29OEwpNmwrt1NQk=;
 b=W7DC+abDACganVqGtX0mKSxvqpC/ojk8Voxj+JXYLn5jLxS28SsU33LSwU+YTfqQ2kexwe4ih8zrL6XLrANjdtG91eMzOihPvBXsgQ5LxV9xcDLev4MHjQzjMBwsiRww46QyWKybr5o27IWvBhWFB/9ANVj2ZRLiGZvUZgaPvFHVoJgXylwuisrpFjA3jS/lfOeGgJuPRq9KX1AWL8DBCvVFoxHesKxu6KSGwSdLlrOb+Wsgxwam9PyfE2/Zq+2uMiOaWgXxNMGYJquKbpWnu0z81bLxknUkVRNf320WtcYYTyJI+N/TmhYwvMfFG9h9X4BC97pHLuXe+dX1iq+mSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iufXTS2Uj9UWZwbH+CLlFiDHcJ4Q29OEwpNmwrt1NQk=;
 b=g5PbUPCwm1hORTvB8QjE6htTR5NXRU4GTcIt1bST8BX8IYMCZgZPeRAtuqNoWYY7NgsDRqPdu7L4SY90g+kpl3ee+cMqbJsGUGzNSXanE74kOH7jqT7yn5T/ayxmjcygXAPtUdJTep7Nm7Ctd0gEdHvPTdOyK3cDKHsyU6FFPuI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (52.132.196.33) by
 SN1PR12MB2479.namprd12.prod.outlook.com (52.132.196.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Fri, 24 Jan 2020 23:00:19 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::fd48:9921:dd63:c6e1]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::fd48:9921:dd63:c6e1%7]) with mapi id 15.20.2644.027; Fri, 24 Jan 2020
 23:00:19 +0000
Date:   Fri, 24 Jan 2020 23:00:08 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200124230008.GA1565@ashkalra_ubuntu_server>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121205403.GC75374@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: SN4PR0501CA0083.namprd05.prod.outlook.com
 (2603:10b6:803:22::21) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
MIME-Version: 1.0
Received: from ashkalra_ubuntu_server (165.204.77.1) by SN4PR0501CA0083.namprd05.prod.outlook.com (2603:10b6:803:22::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.12 via Frontend Transport; Fri, 24 Jan 2020 23:00:18 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 392330bb-a5a0-4ca6-ea8f-08d7a1212ef5
X-MS-TrafficTypeDiagnostic: SN1PR12MB2479:|SN1PR12MB2479:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB247951045E12B2637FCFCB5C8E0E0@SN1PR12MB2479.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(199004)(189003)(52116002)(6916009)(26005)(33656002)(6496006)(478600001)(44832011)(1076003)(956004)(66556008)(66946007)(6666004)(186003)(7416002)(86362001)(66476007)(4326008)(316002)(16526019)(5660300002)(8676002)(81156014)(81166006)(33716001)(55016002)(9686003)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2479;H:SN1PR12MB2528.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPpsIO6T9x6peEphHvN93nifh6HlMHahPt/xg8NKMpQ+vTwIlu8b3exfk2nyuADSwB6BO8u6RnqpgaCbhgov0RkIXciwwzjrJLpiW/BBNNlktDoRhjJSaX5Qy4zHP3EHp1LcMzCaIyJvO+iuvlQEUI6Hwzqp2WA+c0mW6a0zGhazH2TIjEvxkLiUhpfA5c6169qL5+KL13CDGh48fM9K8uwmBcaqxqTknrpETq0bnFeJSwA4aC708GkhLapuLgzaqlQxXwJw0MHH5okR89ZJgKyJigS0uEpJM3WjmIU1psgbYXJWwoKYLurGhfPBH99p7rAtipyptqXdDHgK53xyfjbm3MD+0+/UcDoz5VTZQGQZrRHkhbVkT5obqsfTesbE0B1OvgkcO4nSPvA9e0xo0PvXpWdCfUXlTtK9V/1qkB4Cqq8JIBudfMW6Exkgij8G
X-MS-Exchange-AntiSpam-MessageData: oPDQ3+rksDW++5eTk/K+aUUR8OCsNqVr9nJ25E+zs3tq3Q3RutmjIvMgNSjvp1sCT3+/GDDmE4cKuT6OYpeUtEMU+zEUfvTkTx/01VLoQafE23l/yqw4Xss7FEwBQ0cf0M4uJaOYGxa3QfZfksdZUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392330bb-a5a0-4ca6-ea8f-08d7a1212ef5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 23:00:19.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJj0NAhkLBUsBQpj2dnaSi3a9G9sXdehjjzgkyisV3lL6OxuUUsnrg4qKlE9/qzEObbk/CQMy0erMMVpWRhtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 03:54:03PM -0500, Konrad Rzeszutek Wilk wrote:
> > 
> > Additional memory calculations based on # of PCI devices and
> > their memory ranges will make it more complicated with so
> > many other permutations and combinations to explore, it is
> > essential to keep this patch as simple as possible by 
> > adjusting the bounce buffer size simply by determining it
> > from the amount of provisioned guest memory.
>> 
>> Please rework the patch to:
>> 
>>  - Use a log solution instead of the multiplication.
>>    Feel free to cap it at a sensible value.

Ok.

>> 
>>  - Also the code depends on SWIOTLB calling in to the
>>    adjust_swiotlb_default_size which looks wrong.
>> 
>>    You should not adjust io_tlb_nslabs from swiotlb_size_or_default.

>>    That function's purpose is to report a value.
>> 
>>  - Make io_tlb_nslabs be visible outside of the SWIOTLB code.
>> 
>>  - Can you utilize the IOMMU_INIT APIs and have your own detect which would
>>    modify the io_tlb_nslabs (and set swiotbl=1?).

This seems to be a nice option, but then IOMMU_INIT APIs are
x86-specific and this swiotlb buffer size adjustment is also needed
for other memory encryption architectures like Power, S390, etc.

>> 
>>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
>>    perhaps add in this code ? Albeit it really should be in it's own
>>    file, not in arch/x86/kernel/pci-swiotlb.c

Actually, we piggyback on pci_swiotlb_detect_override which sets
swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
forces swiotlb on, but again this is all x86 architecture specific.

Thanks,
Ashish
