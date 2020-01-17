Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F93C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A149C2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fXwq7S3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgAQHwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:52:01 -0500
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:23109
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729005AbgAQHwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:52:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjdjwrcsTts2fsxrInZzGyPiaKwM2QyTOsaAd/ws7WxGAues9e0QRG4HRYBEcCBzRYFMetos4sFwyWU637ctnJZkzUXNDTSUkVt+g+TXkaA0ou1RuC8F9AdLlfXHdFIHopxthf712LKCiWmG4MjGNfBAf6fdtd1nFH5v0SQRPQdxRKlqKp0ZsB2eSlVgsrjXIQU8s3NSxLnzkRLua/91JC/vCg7syUD0wbCHGJg6122/Ps01bp88TKfqOY5J48vTBDZaz7hzx+e+rC8lW5HBRzwxF1LGH99ZfkVle/fuVFx7fWBWFsYlfG7zVR9bOS1N4PwD4j9Tx1htbTbnqoNilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuwDMazDwoJWizUHMlozqSs/vISsA65Rf+8rVWjGdEI=;
 b=S1kziW8V+AJX7yzpW8ddqQ05bvkuV63lMRkn6g7jPCmtCyYThJYNQzDe9VuV3uIZfPlZrwnpm4rL6pOA6nK8o+wa1FvA/WTdSLjf1T30Y0DpWSye4bdRNZgJp1xkkWGaDROx8VMLtedNygyLTOcpu1jcSEdG2JD2/t7BgRPPcE8gqvuibPVS+kXtXAGhaMWPkCooEze7gyyRLyuYEk6F9x7BKryMu3iQ6wvtlqkDkV6Fb0po+3JLxwr/agAPOhcvBafSWiaS0sPmpq1BwRMPCeLbtbmZDd8W+TLRiKaSdI+rfTNnLqUODhcYfTxhCSCN+GtDg7aZ+7K1zR4hjkHLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=lst.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuwDMazDwoJWizUHMlozqSs/vISsA65Rf+8rVWjGdEI=;
 b=fXwq7S3WgOCl67iU12QMxHEk0S/cj//rTdhVZggmTXRrmNLSYvjW3qzapGkvvqLWU5q6FcsDCTBRauFJenLv+VTzKeqGYwKMcVhdhRH6f2/3GhiTiTzEH0yWjPmJVmBXTA9YIxsuXOP9YfYgcIv3KaCYiIjW6kV16UpT52Ilr8M=
Received: from MWHPR02CA0014.namprd02.prod.outlook.com (2603:10b6:300:4b::24)
 by CH2PR02MB6822.namprd02.prod.outlook.com (2603:10b6:610:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Fri, 17 Jan
 2020 07:51:58 +0000
Received: from CY1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by MWHPR02CA0014.outlook.office365.com
 (2603:10b6:300:4b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Fri, 17 Jan 2020 07:51:58 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=bestguesspass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT017.mail.protection.outlook.com (10.152.75.181) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Fri, 17 Jan 2020 07:51:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1isMQ9-0006aE-7E; Thu, 16 Jan 2020 23:51:57 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1isMQ4-0006Oo-3l; Thu, 16 Jan 2020 23:51:52 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00H7pkbF028398;
        Thu, 16 Jan 2020 23:51:46 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1isMPx-0006Nq-OY; Thu, 16 Jan 2020 23:51:45 -0800
Subject: Re: [PATCH] microblaze: Wire CMA allocator
To:     Christoph Hellwig <hch@lst.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Manjukumar Matha <manjukumar.harthikote-matha@xilinx.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Will Deacon <will@kernel.org>
References: <1a1a4c1e0f930e4fc0dfc785dbce57c07303f1a6.1579003045.git.michal.simek@xilinx.com>
 <20200114154744.GB7194@lst.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <4a347d18-9ac3-4141-77ae-9bd2ce7eb4bd@xilinx.com>
Date:   Fri, 17 Jan 2020 08:51:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114154744.GB7194@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(356004)(9786002)(81166006)(2906002)(8676002)(8936002)(31686004)(81156014)(36756003)(186003)(31696002)(70206006)(44832011)(5660300002)(478600001)(26005)(70586007)(316002)(336012)(426003)(7416002)(2616005)(54906003)(6666004)(4326008)(4744005)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6822;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01156220-5285-4c31-6ce1-08d79b2220dd
X-MS-TrafficTypeDiagnostic: CH2PR02MB6822:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR02MB68221674FB0292A8BD3D86C2C6310@CH2PR02MB6822.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0285201563
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYE6etDfnSZKvATAkfKSaPO2pUJX6aoouleohvJgLBOSzMr6i/LUJvqSc39RDk++sRZnAtyZaDjg+SjVNzwfQoWZCFGLsP+SH7kXSf3MkSYRYQhWh7kWKtwyaib4nTK8oQ30rHa83/WGAWaWDbKsWZAJEeBnVz1N8Av6+tmfFEkHtDTO/GleNa83bRUDBsHKk9GVG/4/B5DBydc0zOP29SlbteGIaVw3XaQytmV1wRrbHg4AhAHuNOpJ3S3rxG4mdUjttR8CoQ37Cguuc9d7wQNubkElKsp5/NVJRdIQi5tvwxXyxg10Ug9HDvpOH1o0wWe4OeSvuXGYR6DlXFyAOpwUAqwbVHCia5Tsnnd8nh/ptPyrXvp2+UVoEzaNqHYen48EvhG2J9NhkdYz4KADma0yeI+paiiw/I5XG921vGO+fHscnsHzg1TjLfrmDXFg
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2020 07:51:57.7509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01156220-5285-4c31-6ce1-08d79b2220dd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 01. 20 16:47, Christoph Hellwig wrote:
> On Tue, Jan 14, 2020 at 12:57:28PM +0100, Michal Simek wrote:
>> Based on commit 04e3543e228f ("microblaze: use the generic dma coherent remap allocator")
>> CMA can be easily enabled by calling dma_contiguous_reserve() at the end of
>> mmu_init(). High limit is end of lowmem space which is completely unused at
>> this point of time.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Christoph: Can you please review this patch?
> 
> Looks sensible to me.  If you touch this area anyway I have a request,
> though:
> 
>> +++ b/arch/microblaze/include/asm/Kbuild
>> @@ -7,6 +7,7 @@ generic-y += bugs.h
>>  generic-y += compat.h
>>  generic-y += device.h
>>  generic-y += div64.h
>> +generic-y += dma-contiguous.h
> 
> Can you add a prep patch to add a
> 
> mandatory-y += dma-contiguous.h
> 
> to include/asm-generic/Kbuild and remove the generic-y in all the
> arch files?  That reduces the arch churn a little.

Sure not a problem.
M



