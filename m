Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58781C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3135020758
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eblK1ZPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgGTE7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:59:49 -0400
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:32320
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbgGTE7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:59:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6yrPM9Hw6W16xlZd62C9Y76LWqsbIfbvkSCfR5noObs5muJTKQ5IW8btH7l0S+2FdWVzlQpaR2xh/bK/zp0JY/qrY96TFYwWsoeob56w+IdErTihqSNgbB2L/gxtEW/DL8+gIbYmQXZFHLG717iyKe17MVjPqFgjO+Ddl2uoz88UOF/Apqv0qc8Jn/nNZ5nXN4X1/PVu5EqEl/tciloLAWaPQVc5ImL5gq4uD0pl3uLxeUzgARCIjlassFEa5rlaEoVybeZaUcaRYyl/4T21RpSv/8ci8LsJyk+dSO+vSgdXHfmpa+d5XxYhYXpuZaqrEV6DcA/tj91AH0m5dE0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/zEMi3wM+A9ijadGT+ppAIt1jIflzEZTAYlexB8yUo=;
 b=c7f7kaTUJaEFz7NZ7MKPdVZWQ2SRqEdn0KvcgJFCs3rY1CniPmFLJYuPPDcckv5/h0eTtBI6DIrlaAmBiLkDzj6Al1GlO1sCe501ebygpGBgV54888VGHWqjZ9Onk+MrkgP7Uk7aGo69oOWHBukvqTqvlE8gQOhetZfd6XQeMQNJIZQOFxKiYzjsUlg4zLjgGVLJZf0Qp5HTWQ3xZvE5tbiFOBEGRMEjCmgHTZifDxkNveuEcA8CIfMjGvqrKRHAoO+akv0PoN6t8L4cm5mjVSEx3lgU06Yt1snLx1AtOg5XCLwyg4hLPOuZkGI1Ss6K9VFKm5IvmCzodc5RMQkJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/zEMi3wM+A9ijadGT+ppAIt1jIflzEZTAYlexB8yUo=;
 b=eblK1ZPidXNxxFwJkwO7vJVc4z7Q5ZV7EQ1pI3K5SUuFCRBn6zQBXR/uIri0m5i1V7pvPAYjJcfeKwTwbdAOmeDeEFBjks2kLbNx47tAgg9Pg4v14XfoBKOyktY2mKcCsea2Cig2zum95xCF4hr5lLsnLXXVGwdenDiZL31hFWs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1599.namprd12.prod.outlook.com (2603:10b6:301:10::12)
 by MWHPR12MB1454.namprd12.prod.outlook.com (2603:10b6:301:11::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 04:59:46 +0000
Received: from MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63]) by MWHPR12MB1599.namprd12.prod.outlook.com
 ([fe80::25b9:83b0:4b17:2c63%12]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 04:59:46 +0000
Subject: Re: [PATCH 4/5] clk: x86: Support RV architecture
To:     Stephen Boyd <sboyd@kernel.org>, akshu.agrawal@amd.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200713010001.18976-1-akshu.agrawal@amd.com>
 <20200713010001.18976-4-akshu.agrawal@amd.com>
 <159486139638.1987609.10837351469119432355@swboyd.mtv.corp.google.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <c671c1a6-6d4c-f57d-7d60-d62ee84a56ea@amd.com>
Date:   Mon, 20 Jul 2020 10:29:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <159486139638.1987609.10837351469119432355@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MAXPR0101CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::13) To MWHPR12MB1599.namprd12.prod.outlook.com
 (2603:10b6:301:10::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.105] (122.171.179.172) by MAXPR0101CA0051.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend Transport; Mon, 20 Jul 2020 04:59:44 +0000
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74e1e1f4-f06d-4e04-186d-08d82c69b8d2
X-MS-TrafficTypeDiagnostic: MWHPR12MB1454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB14540F3F7702271D482E62A4F87B0@MWHPR12MB1454.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYNs59qX0vsER0KH4dsXtAAplw7uegiX1hFcGNBQHga4pBqs0O4USCuqntNjcTOv3mWMjLTc4Avgu/dX104UzK9GUTN8XnkUGUVSlLHR1ioQaazND2+q7vycmYRZ+SNQZkvgl5/UuKOVV4BHIRJSiooptpC/Y1r/CcpnRfiD5MGRyUAs5PZ7dK25SZwhbWaMdgNbjLHTUnO8dHJ8bu9sJqx0fptd3JSMqApqBEo1BTPSbnd1jtvVceRJ8SPGCokDPIegZS5SlScl3GM0ZQMrVBnrz/Gn8N1a/L5oyZIbpFZpj71tTY192+O05reyvpEd5L9Sj9AZArq299UcR9Rppf/zPdEPsPFGtlTUWs4NjJBDiodA13uTTUefYS3WU2Ei
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1599.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(53546011)(83380400001)(2616005)(16576012)(26005)(31696002)(956004)(36756003)(52116002)(478600001)(31686004)(8676002)(6486002)(316002)(8936002)(2906002)(5660300002)(66476007)(6666004)(66556008)(6636002)(16526019)(66946007)(186003)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6xVf5Zu7Y1xTRz7Xn4R1aVaOVMGfFce40PLaEwI8vqHHdazF64b0QfDJ9ASCbAHvME/tkSJbfLpv5rbMOxZbrH8YUBbgvMJzZg60FOw5O03l82RhmSgNnL9vNKKpyCMu55lNw2EZfqjQmPN+NeLztc1t1AygU1fZ5nEFZfn7nd1gdO7YkJFbSbqDACeM8CHij/hAD31Lgtpg/hCUHhvpubCI/D0BOmtSNABDHtB4A5FAHAnjKdMH0PHNhtGLJUGCy9FF+d1iU1QvzznDfORpBhg+hB4KjIjxHh/tns0eoW8PokcPmkz3LOhJmh6RDRmVSETqUv6ylJRoc/Y6XKPKsDK1KxLiGtZiaFJNQxbz/YchMlm94ws84CsgwyMjHUGO4RfkyNU8+hTGsLQcy6pEADYFPBi6May78UVcWP0GobkOm0Q52IxWfdhpl8D18wpxBmRiHDRZKMDENbm7r5PQXHTc9j/HRjPNFbbcEXIUtZ38OJ+Cauq08jyzQVShghFe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e1e1f4-f06d-4e04-186d-08d82c69b8d2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 04:59:45.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlOdo26QB77Yc4IYKXfv4+WGvaSL2Rtfa92LPb7QGGHHBKm6deJbRLNrKgjtH/cPQBP5Rhoe8m2PeE1p/dDlsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1454
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/16/2020 6:33 AM, Stephen Boyd wrote:
> Quoting Akshu Agrawal (2020-07-12 17:59:52)
>> There is minor difference between previous family of SoC and
>> the current one. Which is the there is only 48Mh fixed clk.
>> There is no mux and no option to select another freq as there in previous.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
> I only see four out of five patches and there isn't a cover letter. I
> have no idea if I can apply this change or if you're expecting me to ack
> it. Please help make my life a little easier!

Numbering went wrong due to another unrelated patch.

Will send another with cover letter explaining the series.

>>   drivers/clk/x86/clk-fch.c | 55 ++++++++++++++++++++++++++++-----------
>>   1 file changed, 40 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
>> index b252f0cf0628..a8aac71a3b65 100644
>> --- a/drivers/clk/x86/clk-fch.c
>> +++ b/drivers/clk/x86/clk-fch.c
>> @@ -61,9 +78,17 @@ static int fch_clk_probe(struct platform_device *pdev)
>>   static int fch_clk_remove(struct platform_device *pdev)
>>   {
>>          int i;
>> +       struct fch_clk_data *fch_data;
>> +
>> +       fch_data = dev_get_platdata(&pdev->dev);
>>   
>> -       for (i = 0; i < ST_MAX_CLKS; i++)
>> -               clk_hw_unregister(hws[i]);
>> +       if (!fch_data->is_rv) {
>> +               for (i = 0; i < ST_MAX_CLKS; i++)
>> +                       clk_hw_unregister(hws[i]);
>> +       } else {
>> +               for (i = 0; i < RV_MAX_CLKS; i++)
>> +                       clk_hw_unregister(hws[i]);
> Can ST_MAX_CLKS or RV_MAX_CLKS be a local variable and then the loop
> consolidated.

Yes, making the change in next series.

Thanks,

Akshu

