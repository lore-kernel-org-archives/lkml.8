Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F89C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B4920661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nYzCzs/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBLNCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:02:04 -0500
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:42497
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726728AbgBLNCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:02:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWaCuWFoplAG4UggT/lRoGvKDcwXLDGUz0GhF0mbnZDfD7rA/vvfEoedUWsoaVILj9rP7C3ImY9ZKzZztsiFkuuo52sd9bJpCLdoanBvFE4YPIWEc4jnz8hJb9Tqtu6KzBtf+PTxdbRjeKPSTR7gVuNoFdjYndNI6oms4w66ls4YvPugYsXkbAGYInilDgzJ68stGyE2U4+CCRvqH8dORtbbDVgQ8dMWH5/3tR99sOcFjC4+xlyldtvPu9NdFdL+twrqQx0CfhhPGsjG1uVZylq7V2FJ22cuAGRPK5n7a8bk1P79xIkmu2PjFuh+iKNTfxubV1KBqq47FekqD7kwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY1bws1pYXW7ooi6PRsIhGo36kcLB1qCjlQLslF9wQI=;
 b=MCHAJgqrUsiLMmX2LnylCeZmrIW389FHdVtioS3o1te73cV4Vrce74Aom54J8HJjnV5W0hfwvLdphu6bm3Thh44U8PyT7mO0LHqXYObdTaYUStS2ROMnOcl8c0dQJRZNC8F7fkbEuwvC3UazYAEd44Pg3uo5dnl7edtiPU8AMj2iMh5XYCGe8Ap/m0UIBB6hp+DJHCyHsoKayLE0b/HwCbAaE8MyW/T8l6xcVt+N7svcMFhQRlvn57h4TnrrGPt4rJUTmLgp/+MuvbkME5wzlX7IofVbLilVs8WoFAmX/Asm175K2zvURUagyB0+rJ/KD2t5IjgTt+tLmKCdiV/XrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=monstr.eu smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY1bws1pYXW7ooi6PRsIhGo36kcLB1qCjlQLslF9wQI=;
 b=nYzCzs/pSRcJ0kjurBNxA12KHNQzPlWTgbUw4KPUyJlp0+O260+Webw1ezIwmit3IyB9PcCM8H91ryhRnz7eNLey02PndE7/9ygXgt5BahmtJTzcg5Hx1xKzA57080zv2nSeFP3DCtiLLQdS0Dm4K61/iO4fVTU4nVhHULF7kao=
Received: from MWHPR02CA0023.namprd02.prod.outlook.com (2603:10b6:300:4b::33)
 by BY5PR02MB6212.namprd02.prod.outlook.com (2603:10b6:a03:1f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Wed, 12 Feb
 2020 13:02:00 +0000
Received: from CY1NAM02FT023.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by MWHPR02CA0023.outlook.office365.com
 (2603:10b6:300:4b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend
 Transport; Wed, 12 Feb 2020 13:02:00 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; monstr.eu; dkim=none (message not signed)
 header.d=none;monstr.eu; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT023.mail.protection.outlook.com (10.152.74.237) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22
 via Frontend Transport; Wed, 12 Feb 2020 13:02:00 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1reR-0000iM-Ig; Wed, 12 Feb 2020 05:01:59 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j1reM-0003oc-FV; Wed, 12 Feb 2020 05:01:54 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j1reJ-0003nh-HD; Wed, 12 Feb 2020 05:01:51 -0800
Subject: Re: [PATCH 06/10] microblaze: Add sync to tlb operations
To:     Arnd Bergmann <arnd@arndb.de>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
 <c3d70f467907944e2680678f8aacb6d04def3f20.1581497860.git.michal.simek@xilinx.com>
 <CAK8P3a1r5SCc_Gi=ymN4ToRU08nx9omkJU3Xy9B2GoJF941vmg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6585498e-fbcf-6bfe-ef40-b24f5fde7719@xilinx.com>
Date:   Wed, 12 Feb 2020 14:01:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1r5SCc_Gi=ymN4ToRU08nx9omkJU3Xy9B2GoJF941vmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(199004)(189003)(8936002)(8676002)(81166006)(81156014)(9786002)(110136005)(54906003)(316002)(5660300002)(107886003)(4744005)(4326008)(31686004)(70206006)(70586007)(36756003)(31696002)(478600001)(2616005)(53546011)(2906002)(356004)(186003)(44832011)(26005)(426003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6212;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54cb1118-fc74-429c-d589-08d7afbbbf8b
X-MS-TrafficTypeDiagnostic: BY5PR02MB6212:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BY5PR02MB6212654D09A5402D916D753CC61B0@BY5PR02MB6212.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0311124FA9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUj7AI9122ccJfmPNyLEWC1Qvy2wPSIWNlArCHqAHGsre4jiXU5SQj3VSGI8xHKQ7zgqsM/1WXyLLrk/lOmHnLvuKXLCXu1PqQIINsFQ10jHBknz1gXeb3B6D0xSosSVULHCRvTTCYMriaxwyJrI05i7tz1XyyEOFLa1O+P3x60VSiwscXSV4wJkrERGoj80GZCFytwZuR44ulleZXlIEjavD7yuYYpibhCM/Zu8LvnnF3ynrJM4iMywCPV12Vky63HZtKtMiY2qJ4aLv+fFo/7+FkszA1lkQBH+YOW3gkDnHNqpqpuwGR1otXdtLlNu2bLkyYrfF/Wp+AF2VBvGVrsPSei3by1+rTXv3RK72IjcSr6KyRSWd4i/ee8qmIVejLDprNxr8sZAL3/YvxXw4W1mG9hp7txCcy8BJgupnoDC9aaNVTh9LlupUg5S1VPm
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 13:02:00.2281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cb1118-fc74-429c-d589-08d7afbbbf8b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 02. 20 14:00, Arnd Bergmann wrote:
> On Wed, Feb 12, 2020 at 9:58 AM Michal Simek <michal.simek@xilinx.com> wrote:
>> diff --git a/arch/microblaze/kernel/misc.S b/arch/microblaze/kernel/misc.S
>> index 6759af688451..1228a09d8109 100644
>> --- a/arch/microblaze/kernel/misc.S
>> +++ b/arch/microblaze/kernel/misc.S
>> @@ -39,7 +39,7 @@ _tlbia_1:
>>         rsubi   r11, r12, MICROBLAZE_TLB_SIZE - 1
>>         bneid   r11, _tlbia_1 /* loop for all entries */
>>         addik   r12, r12, 1
>> -       /* sync */
>> +       mbar    1 /* sync */
>>         rtsd    r15, 8
>>         nop
>>         .size  _tlbia, . - _tlbia
> 
> Is there any effect on non-SMP systems?

not - it is just nop.

M



