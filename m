Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C410EC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF67207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sOX8sFPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgG1GhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:37:11 -0400
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50]:30302
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728076AbgG1GhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=le14bF07sQTpc+bNjv9YHMpLDJm8LxnId07/9LTssv10oUyJJSD8uYc/ExNx/ilrzq9wQIHCunzH/7jvwIBunABnaq5uzBkyPZ138TwqJJD8AsiX47jrvjHC8ENfw/nzTU2cQFiI0ImnhiVI1Ltc9sWZAs8/snc5QrVJPSeQ3WS8FNgGdd1yATwG/DRqbq3htEpLzm1GQETjR1z6X8Osq0COTt9Th/tM5kuPC6Zolv0OIiAEV50Gwo/h8G3YZvDuueJVLBphBpTlzc+rrxhyXCznOmnS47Gf8aMnUmnbwu2YWoq90BDefGfBua1MqsiG/eQ0X41qLGClw7CDJ1BQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip34MjHFNJLdMQWa3jpqzBFI3gGiF5JlfSKYWQAb9ec=;
 b=h9T4eoA1bpENSg6mkp2h01Jo6b7bPMzzfy5AAkTAB5CeRAk2IMDnhVxKvgL3PCIbGJ9RcuHEbhC8IWOSVY3BFy31cJs6iT3RWFpvmR3rYj3q6er8UQJRVI5hqhvumVrFlu2efsF/A6+pqsmH/fwQsfI8UAHC7o5MHlnIU1eMXBa8G1isnj4zURR7o5+NnaGsY0qMLBjRGoIJXGGQbejEAD5nICdqZETLMefDM2wJG1TW+xIn288gpUJhsMh6pDyp244vLYZSeNxhEB/H+NGyeqmfaWUxlyWD0xBfj4IG999DkSgJEWLBH68gO9ApnqReEWwSbIQwwRm/VwH5WkVTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ip34MjHFNJLdMQWa3jpqzBFI3gGiF5JlfSKYWQAb9ec=;
 b=sOX8sFPUWDFvnFgp71yUimRAFJxBw4UsNKgwcSruCz7b0eDN1Qb/93f3n4Mqj0MopGY6NDLaaf2Q+CNhhcC7NnpNcWG5seiWPK62p7QK5nZHZOVGjkS4hUJujcEtC5cAmyTVT+O5Io5zeVqHW7Wet9zIxCOj4CQm7bb8969AxSU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com (10.174.107.12) by
 DM5PR12MB1899.namprd12.prod.outlook.com (10.175.91.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Tue, 28 Jul 2020 06:37:06 +0000
Received: from DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e]) by DM5PR1201MB0188.namprd12.prod.outlook.com
 ([fe80::41b7:b11a:c6d8:1e0e%10]) with mapi id 15.20.3216.033; Tue, 28 Jul
 2020 06:37:06 +0000
Subject: Re: [v2 4/4] clk: x86: Support RV architecture
To:     Stephen Boyd <sboyd@kernel.org>, akshu.agrawal@amd.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200720050500.23357-1-akshu.agrawal@amd.com>
 <20200720050500.23357-5-akshu.agrawal@amd.com>
 <159531874995.3847286.4010361856630371541@swboyd.mtv.corp.google.com>
From:   "Agrawal, Akshu" <aagrawal2@amd.com>
Message-ID: <807b3eec-cc11-dbbf-7d35-0086df12f52b@amd.com>
Date:   Tue, 28 Jul 2020 12:06:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <159531874995.3847286.4010361856630371541@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MA1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::11)
 To DM5PR1201MB0188.namprd12.prod.outlook.com (2603:10b6:4:56::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.105] (122.171.179.172) by MA1PR01CA0071.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Tue, 28 Jul 2020 06:37:04 +0000
X-Originating-IP: [122.171.179.172]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 588a44cf-e899-486a-6cc6-08d832c0a543
X-MS-TrafficTypeDiagnostic: DM5PR12MB1899:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18995FEF2F798F1F4D284808F8730@DM5PR12MB1899.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVWvivYuCrnvkgm/FmSsG1/nhfz9/GcZoqXkFLcPIsmMlGG1BXjzC+IoG712ucL/HW2D0W1CG3GMsh4s5+k3aC/VbEj0e10fO2xsCFn0dz2IBC/DvqT3uQPSsbVRkJSRnF2Zphl0AAUkC0P3kvZX1vvzH/OpNUcH2qVPJzruRcd9aSUBN6Fdnx5pN3hk5wPMPoeUPubP6hRa+wMfaf9xEw/WgSxZt6PrZwnaEZmmYSEXkFSpKwzO5KShZrCUuAal2u1rqwZ/9KjjoG7bocUXhp505a4WkgNwKOICD3K/s4D0ZVnV9D6FRHmww8gt+HIgOekV8IXGHMpThaLP2Aa1LOFFMJTmrmoUHB6BuK3o26jhD/4x2y9iZf/aWIiYuEdY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0188.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(5660300002)(31696002)(31686004)(66556008)(66476007)(66946007)(4744005)(53546011)(52116002)(26005)(2616005)(478600001)(2906002)(6666004)(8936002)(4326008)(8676002)(6636002)(16526019)(16576012)(316002)(956004)(186003)(36756003)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HMdjg96KHevKKnbk8d0kwFFx1g8gblN5yZHnSC94xdEArzjhXgRAYgkVz03czsfUsvv9q88rkkgRECWVyIZO8KYJH+0fztyZohu11GvblKYqdd996bXvkQ5lwwysGMPPOz374tPYWRmC1q1D8POOh4CnJzpVngviCdPy/0R4cEIO5EUIJoU2X/pBuusgivhA7aWGXQAc/ooAgNjTMNAihsbV2gj+yyB+9/KszoSpuLFIOJ/Ckgy5Ot3S5oBlVOfIrnt4wq0MJMX1w7/fDglj9/gdIAK1BrZbbqpIJ4nrkBLnESGXlAgJoofa/tQDUKIG7xFeL7VodxTiSgur9fg3WOPIo7OOuaZbKb6qjGn8kaTXElH6dDqBAMRR/IRdS8glWUVL9mmBm9LTE1EAoACn0qq6SPlHm5vfw3vFWC1GHTNi5+5qVhfvwGtlRYEQ+4Vdm5vqyVNYHAGrStHAejoM6NxlbyRSy0U/PAnBZBUGQBk39qUqo873zCGFRc/Paq4j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 588a44cf-e899-486a-6cc6-08d832c0a543
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0188.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 06:37:06.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42r5Up0LiFnGF+m8hqKyeeZmh4Pa/6vAiOtvfN9RocbRNnFCTnN4chNlSGi5WBIJevaDLYyNSAM/DtrGQrxf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1899
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/21/2020 1:35 PM, Stephen Boyd wrote:
> Quoting Akshu Agrawal (2020-07-19 22:04:59)
>> diff --git a/drivers/clk/x86/clk-fch.c b/drivers/clk/x86/clk-fch.c
>> index b252f0cf0628..d68bca7b213f 100644
>> --- a/drivers/clk/x86/clk-fch.c
>> +++ b/drivers/clk/x86/clk-fch.c
> [...]
>>   
>>   static int fch_clk_remove(struct platform_device *pdev)
>>   {
>> -       int i;
>> +       int i, clks;
>> +       struct fch_clk_data *fch_data;
>>   
>> -       for (i = 0; i < ST_MAX_CLKS; i++)
>> +       fch_data = dev_get_platdata(&pdev->dev);
>> +
>> +       clks = (!fch_data->is_rv) ? ST_MAX_CLKS : RV_MAX_CLKS;
> Useless parenthesis and negation, just write:
>
> 	num = fch_data->is_rv ? RV_MAX_CLKS : ST_MAX_CLKS;

Sure, including in the next patch set.

Thanks,

Akshu

>
>> +
>> +       for (i = 0; i < clks; i++)
>>                  clk_hw_unregister(hws[i]);
>> +
>>          return 0;
>>   }
>>
