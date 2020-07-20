Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8DDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B6CF20758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g0AOzeb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGTE7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:59:17 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:27144
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726419AbgGTE7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:59:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3cjN52KBZ+YJtFPekO2IChhslMSdgin64yvdSfC6msj73imFcKvYvhTq1BUsgn3MAY4KrRA82s4knJjv4NmZq+bpB+UpGYikJUlqmiTlMFr+vEqahb0N11vN7j/LEmM9SXD3wjG4zsweMDPsay3QIe0CPu2D/9tVE9bKn4ALrJdEFQiOyWAXxQV8xoWRDm/YqBms7Diiy807AVbdkdfi9A4jCLKgYkvlF/AzspyW3cv4tpaSHHxeSTYQydXoowtKSSlvIEupqLOi+1o5s4QzOZhOlFSmZFeamvzfRA5byC3qfp/u1zd13vUD80N29CkBqv89ueDgQQ4CE14VZrDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8rLW30wvx0O7d/VWwxVU/kQEomeAcdcsNT1OwVc58Q=;
 b=W99XtXqth+AegJpivE3IHDb/Ld/7goGUlOLi7aIF7maBX3Y5Y6RXez9XzkYfwo9UgmgdXIc1Ba7W00eHaIn+lE1Ewt/xsQuOx0c7LY8I9+JUzbaH/wyNtjYtNsBoNsGuPVLTj+7TdHyP3++q8SZYUsl2Biamd1FvM9lhyzTRMvoDC9pV5fW37xhzzFd8HSEh7C6plAIWc6pZnmnxINc/KJ07UeCDSov9H2YlmC4fmf58lBvAxdLs53hVD6LqOZ6mh7yqH836/ANkmG88rZVG3QCDVOKpPH/+1n4WmbBJ/vRWwe5A22csFQSpWZvU+59b0w8iMdTBeFkv6TdDwx/m9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8rLW30wvx0O7d/VWwxVU/kQEomeAcdcsNT1OwVc58Q=;
 b=g0AOzeb4a3C1rIjw6oKXxOG8nliXX7+vqfT+GhaZHVdrRYOa2CYurpPJQDqveKC54yvulr0GyrOWV+m9Es39YUNyBY3dxpSZmsv1lAlijVd2uOZ5AJ+KyGAQYzc8mZr6akNiPGi/eNo1WDPHy2ntF03twC0ioPJidg/stVXGJak=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1454.namprd12.prod.outlook.com (2603:10b6:301:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 04:59:13 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 04:59:13 +0000
Subject: Re: [PATCH 2/5] clk: x86: Change name from ST to FCH
To:     Stephen Boyd <sboyd@kernel.org>, akshu.agrawal@amd.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200713010001.18976-1-akshu.agrawal@amd.com>
 <20200713010001.18976-2-akshu.agrawal@amd.com>
 <159486017478.1987609.16233541356940866738@swboyd.mtv.corp.google.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <cccfd007-1801-f289-2730-b831d9494a08@amd.com>
Date:   Mon, 20 Jul 2020 10:29:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <159486017478.1987609.16233541356940866738@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::21) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.105] (122.171.179.172) by MAXPR0101CA0059.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Mon, 20 Jul 2020 04:59:10 +0000
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa1c9b09-bf24-4eda-0d3d-08d82c69a512
X-MS-TrafficTypeDiagnostic: MWHPR12MB1454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB145400114E69A70B960D1C9CF87B0@MWHPR12MB1454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HoI8wZy2nXM2FfH7aj0wEYkUQwN2pPQ6JJvepqupx1s+HhWIhR06qv50qDGOrhIw07BwRnX9MIlqc5b60Q1Mj/BtUKPuKgJtSmyAmxuOK3u3f18F3523yzUv3NBEaAFNz1B9FFV8I8JjiddwB2VTJ9zi4ug6cRyPiTOphu0IinavRMETspd8Du7K7rNLhHR8qiU+M8D8h5YHkttpP0X0jXYa8nRsMZgzdtMGLPna1y4536fcMt+iS6ONB/A5OtuJrqgsffQ1C2vTBppZ9VQ+WrpVujyqWEfaygE/+37XCjveoqHt6ipo5R769W784mH/j2nYPERWTjdsIaJFPal1tC8zI3JwCtcmFfmdpfGkPtJ8qp702mZvdvoJnqeZ3pYo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(53546011)(2616005)(16576012)(26005)(31696002)(956004)(36756003)(52116002)(478600001)(54906003)(31686004)(8676002)(6486002)(316002)(8936002)(2906002)(5660300002)(66476007)(6666004)(66556008)(4744005)(6636002)(16526019)(66946007)(186003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SU7+5Q8ybNWx1wymk2qtR2E0GnNgx6FJa9R1L5ZbVAOqr12RqUT26rtJhmbe8MMlFs585tx8qwHXg6rAwRSttUYkaU4CLYzGKe1KKJLrP5FhZpnB5xeauFwhyGrFEUEj/K33IKI1W+hsY3g3VOikXgNjCbuipYtY79TxV/jgCAX6TmUiSl9q4LR1l0Ji5Y63iMfbpmTEb29ZllOXRPcvcr8HeJNABFfDMI/fmc0ajXs7qrqV/Dl/nh262/ZLrJA3ugSvOmXEGJX6DbkI8N/yv8T4B8Nz4XHs7wrtxSSpiJ1FdRvyCWMi48VDQOaQtCjhCQWbaedGoldGTGS2udO5daujmrZxgIgK8ukrqe20DtflRHLo7nQPg0b2c7gLTPHSX0kUi9cvS76qo0HfjXoXCATIEuFivVzFIr8Q5c03vHKQVE0Gszr/Gb71KpFwEhPnuluLsnXWiq9zwmo3TnoifD3Ut/3QBMJk2nxfPix44vk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1c9b09-bf24-4eda-0d3d-08d82c69a512
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 04:59:13.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Reof+hLw8zs2UApSPcLJT0YjrydG4goVeedkrr5fBGUtRzRQFzJuwDAw/fV2P6xUo4SjN7vj1CV79dltI+Mig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/16/2020 6:12 AM, Stephen Boyd wrote:
> Quoting Akshu Agrawal (2020-07-12 17:59:50)
>> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-fch.c
>> similarity index 73%
>> rename from drivers/clk/x86/clk-st.c
>> rename to drivers/clk/x86/clk-fch.c
>> index 25d4b97aff9b..b252f0cf0628 100644
>> --- a/drivers/clk/x86/clk-st.c
>> +++ b/drivers/clk/x86/clk-fch.c
>> @@ -8,7 +8,7 @@
>>   #include <linux/clk.h>
>>   #include <linux/clkdev.h>
>>   #include <linux/clk-provider.h>
>> -#include <linux/platform_data/clk-st.h>
>> +#include <linux/platform_data/clk-fch.h>
> Is this file moved somewhere?

Renaming it from ST to FCH in previous patch of the series.

Thanks,

Akshu

