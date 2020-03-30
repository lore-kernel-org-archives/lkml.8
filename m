Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F348EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D6B20748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="a3i/dM7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgC3KMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:12:24 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:21281
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728553AbgC3KMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CteJkVFVWSzBMO1YGLko1EgfH7H7EQzYwM7qcmt0UzhWxpnTmUgSf9J7OR8Niyfqszkf1+x/QEP1EuItH2hFkgKKqJmoXtAW8TLZJmyzyHdYVf+qpdwVRlZxPIL59/TkmLocf27sQ0AGx7txcEVo8AX2g7Phbjlexxw9iwLZiQrqjT+8guGx4vZGp+w32Pv4ktbT2GLX5Eh0D0B/ANdojjEveevbtHOYzgRJEse5+z53j5ZWmmvYF3eN2+Foba1voycXI7Og2RdkWihgCCSgAD+I/sPHDK4C9BawT0PYRViLpKi9dL/8kXmGv9UJODx5hoHWrTP0V4iL+lprb5c2NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze7N2PrSNO12e4TD4hk1fUXL3iYb+7S6+fNigW9HBc0=;
 b=Jj/EaMJ2JRz/vCIkMDeKnO7FR+FR5t1EK0CNdV/U5S15TE700a/WvsuNA6EaF2vzb8KgBhge7xN/gr6ozhvKm0KWynRo1m/YX4mFHZ2hVj9n9UuBbLgI19PZ7ZN+FqACX7OQtqUrsMlyxZccjZU4QXsE2KmkAIMKuzjCSZr0SNxXzXCHNxm0Kz4Po7AgoQGYqicfb7uYG38gqas+GlFUqE9FUOkqr1a4aLiIudIg8dx+h+9H+6RPnz+s8E0Vw0m8qly+0gyFFaWl7Yfx+nz7h6rF5nyoZQNzBgbBgGmUZeyvErFlVCfUCULKuS8BQSjlqu7QFL3O3/NiYIOgzJY3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze7N2PrSNO12e4TD4hk1fUXL3iYb+7S6+fNigW9HBc0=;
 b=a3i/dM7SHEb/9lGV8k5KX+msLeHKifNa5XfsytkOpqpdbgtFTQba5728mat4ou8XzjElRbzgySOfqFhWTUruFX5a7ckT6hmpw5dj0TWsIYhqCLtpY6+Xpf9g9bUNIm5eKDRPJdJTZu+byt6N7fefSdlWDm1juMQuTBFlOEDcMhM=
Received: from CY4PR02CA0037.namprd02.prod.outlook.com (2603:10b6:903:117::23)
 by CH2PR02MB6678.namprd02.prod.outlook.com (2603:10b6:610:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Mon, 30 Mar
 2020 10:12:20 +0000
Received: from CY1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:117:cafe::d2) by CY4PR02CA0037.outlook.office365.com
 (2603:10b6:903:117::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Mon, 30 Mar 2020 10:12:20 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT049.mail.protection.outlook.com (10.152.75.83) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2856.17
 via Frontend Transport; Mon, 30 Mar 2020 10:12:19 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIrP1-0007ZV-Ci; Mon, 30 Mar 2020 03:12:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jIrOw-0001dq-9l; Mon, 30 Mar 2020 03:12:14 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 02UAC5c8010225;
        Mon, 30 Mar 2020 03:12:05 -0700
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jIrOn-0001am-C7; Mon, 30 Mar 2020 03:12:05 -0700
Subject: Re: [tip: irq/core] irqchip/xilinx: Enable generic irq multi handler
To:     Marc Zyngier <maz@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20200317125600.15913-4-mubin.usman.sayyed@xilinx.com>
 <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
 <083ad708-ea4d-ed53-598e-84d911ca4177@xilinx.com>
 <085188fea81d5ddc88b488124596a4a3@kernel.org>
 <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
 <ca0f62da-1e89-4fe8-5cb4-b7a86f97c5a3@xilinx.com>
 <21f1157d885071dcfdb1de0847c19e24@kernel.org>
 <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
 <2ee07d59d34be09be7653cbb553f26dc@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a66e394f-3cf8-c102-a810-0c6dc3388527@xilinx.com>
Date:   Mon, 30 Mar 2020 12:12:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2ee07d59d34be09be7653cbb553f26dc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966005)(54906003)(26005)(4744005)(5660300002)(186003)(110136005)(44832011)(6666004)(81166006)(31686004)(81156014)(9786002)(2906002)(8676002)(356004)(8936002)(47076004)(426003)(82740400003)(36756003)(478600001)(4326008)(31696002)(53546011)(336012)(2616005)(70586007)(70206006)(316002)(41533002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa02ada7-0c8c-4a1b-bf0a-08d7d492d4f4
X-MS-TrafficTypeDiagnostic: CH2PR02MB6678:
X-Microsoft-Antispam-PRVS: <CH2PR02MB667818E1D034DDF96CEA41EDC6CB0@CH2PR02MB6678.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0358535363
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2SH/OgiQ4PQiGHhDJtXYtt3HxSorlEgjHZ7dhwmr/4jLsv3VoxaL4enJC0OyF/RZX3HEwLQ9x59kq3zphTD+z9UOaJ8hpABOzOtpziwhLXalqNkZ9hGf/7ieq8GGLrtwuTlnV7RVLvPcW639VyDjev1rMScA/rfjY5q+u/danP60ZwKf+/cAe5YZ1FNsVm80sEdlR/25qpet50EipgyggUk8XjA+pcpLpXwVUt1CHI4UNN9dTibBHkajt1wQbCQbgfBrBaF8QDzjczHcGxY8G3YQqIpMy4RpYAS3S6eVWVcS4xdff/NHG4ax5L7FmO4oWVFgqJPOeYSR5N5iD6OowsEUM4TA71vyHKqj/D/knAaajXl/k8sXYJ3RIANERhMkJC6x/f/Mbl0Ysn65w/qon/ccb3M7OzzHaZOfBfsI+coWSpZQFievSzqS7Icgd5BTCCMmjVyd+lwlmfLsgYX0NDDB8yXBu1X4UpHHmtlvtlI7O1pBz+N75Dyuj9pjswr3iEY3Buw/FugSO5bXA0dls3lLoJqDQqPJxQ5sWamomE=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 10:12:19.8038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa02ada7-0c8c-4a1b-bf0a-08d7d492d4f4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30. 03. 20 12:04, Marc Zyngier wrote:
> On 2020-03-30 10:27, Michal Simek wrote:
>> On 30. 03. 20 11:19, Marc Zyngier wrote:
>>> On 2020-03-30 10:12, Michal Simek wrote:
>>>> On 30. 03. 20 11:03, Michal Simek wrote:
> 
> [...]
> 
>>>> One more thing. We could also get this function back and it will be
>>>> fine
>>>> too. But up2you.
>>>
>>> If you leave it up to me, I'll revert the whole series right now.
>>>
>>> What I'd expect from you is to tell me exactly what is the minimal
>>> change that keeps it working on both ARM, microblaze and PPC.
>>> If it is a revert, tell me which patches to revert. if it is a patch
>>> on top, send me the fix so that I can queue it now.
>>
>> It won't be that simple. Please revert patches
>>
>> 9c2d4f525c00 ("irqchip/xilinx: Do not call irq_set_default_host()")
>> a0789993bf82 ("irqchip/xilinx: Enable generic irq multi handler")
>>
>> And we should be fine.
> 
> Now reverted and pushed out. I'll send a pull request to Thomas tomorrow.

Thanks,
Michal

