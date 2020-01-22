Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F43CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EEE2465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uYyHpBHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgAVIuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:50:52 -0500
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:58808
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgAVIuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9xxZMOHRmc7EjCKZv//AiQDJap7mNfqwsI1+MRXMaSLZOgZLNUtHMIK4cwD8sxQFLe3ymTIKlKpsXdyJZf3kxWacEHrgWA/XTocw9iuQnvxmekGyRV90f7shoJ5tooTi/uGwJCw+ffN4J5SEJ+mCTELxOYVLaRQWM17ppoxABSyjrZ23Pr5EHARZzpansrXlAHWMKnkC++nJLRMBIaHTes43GQhbPRWkV3QDht0kFsay3EHcK+fW2l0NDJiQjn9hppuaJEC5/DEfOgkibfXrKzDz2175dDUKDT9C8dD3hnvRHvF8Jl4fPZHM61GG5Cwa8/SpLpccwLiKCniwOLKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF8Cfp88SdEpQHvuOp+YtdFYTjlGfGlX/kQ3LfLFg1Q=;
 b=LGs2hF1xdQxs5SSsBLVubx6xYNbtVZFx3twPQRjs8zklj9wZW1DGFQRuspBxlfmLYB/TxYiLl0n2C9ti1NK56X2dqxSsxTKxI/kegWFcWozC1CGcL1lWxvO2zays9CLxc1+9h1qwg++G0Iwdl01Tfpbou5swZySA3qmUacNm/u39OeTOxtSgRaDdlzGjfJCk+v4Jzi+WmcCYcOugguUFT1dnFRl8cHzV20YG3msPzUStZzkm8jZty+kTYnKat7vUMhbZUZ/Qo2jOssQywA/fOYkjYZ+jAZqAPPFFdfBcA9tUSJvyQ4Lf/hqPLD70J+dvLPbYXYfcVzL2njVmDXyDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF8Cfp88SdEpQHvuOp+YtdFYTjlGfGlX/kQ3LfLFg1Q=;
 b=uYyHpBHeCGq449+pPCQcSlafbwRHdW6V55WVC25uqCfqsPL26/qKlyXJ267/PH2E88pZqF+jF3HoIIoszGWraBxn05S6fbbzMrqsj5Cjq21sZbl2uFip9nM8n+fHx0AZpy9R3eH0w736bAoY4+IgyLU21/NQQ3JOLwgzH+3NxAc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 08:50:48 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::b13a:2561:f1ed:c80f]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::b13a:2561:f1ed:c80f%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 08:50:48 +0000
Subject: Re: [PATCH] ASoC: amd: Fix for Subsequent Playback issue.
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Alexander.Deucher@amd.com, broonie@kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1579603421-24571-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <87d0bcmjob.wl-kuninori.morimoto.gx@renesas.com>
From:   vishnu <vravulap@amd.com>
Message-ID: <4a0d03a0-8cf8-8b55-0db2-4bbcb606454c@amd.com>
Date:   Wed, 22 Jan 2020 14:18:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <87d0bcmjob.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::15) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
MIME-Version: 1.0
Received: from [10.129.9.175] (165.204.159.251) by MA1PR01CA0121.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:35::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 22 Jan 2020 08:50:44 +0000
X-Originating-IP: [165.204.159.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fb91b55-e0ae-4d25-fa79-08d79f182cd3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3241:|DM6PR12MB3241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB32419258DA83F6A331E9677BE70C0@DM6PR12MB3241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(189003)(199004)(110136005)(5660300002)(66946007)(66476007)(66556008)(81156014)(31696002)(81166006)(54906003)(316002)(16576012)(2906002)(8676002)(6666004)(6636002)(4744005)(52116002)(31686004)(16526019)(36756003)(4326008)(53546011)(2616005)(26005)(186003)(6486002)(478600001)(956004)(8936002)(43062003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3241;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGs2nD0iN6ThwcX8ynXDDz8GfmuHITDygB+vvkqbnL1NMgWqFjrFRXIe5pdX+1NmQjafNavwbcb6usAtGLevqpuRvKIn2kiHGholsGfL0iOqKiivvolbMClHHuFmbv2XJTqHp293KZ/NnHw9H74EpTSf166O7hflLJq3487OCLl8TI9ifwp+iz9g/ZvQ0QVYZbR6ESnAFJMVIs4jad8bydP5mg2SjfqGPCI6Z3kVmvtvGThP5AHreMmv8lqdlUl3mpQrxwZET4fDSAB4MP+bs3qZltfdxYYYVUw3z4q8b66m+gncAJfIjiIDO/dLn4Qqhtff/3ieCAi5f8uMUCoAWtjxQ9h/JZZ1N/2GUIRQTAuDVwvkA+cB343tKzBVb6mOF0XCoqtFoOVnFmFaSVfDcljMgnsV5R7H4zfzAPDL5ZB8k9FmuJpkc/NjpE5C1n6cF6U71C2gNqME1TbwaRDWzc4cElxviqOqlEEKWqamgGve5fubTT8Wqp+Q1GqswQPw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb91b55-e0ae-4d25-fa79-08d79f182cd3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 08:50:48.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JZKWE9/IRoMXJoduNU+I6qNUYJW1tfZIlFETLPmY3q0fhmsYTiLC8wFSLiEECv2VkZyE8jp7dWsplgISNUn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/01/20 5:44 AM, Kuninori Morimoto wrote:
> 
> Hi Ravulapati
> 
>> If we play audio back to back, which kills one playback
>> and immediately start another, we can hear clicks.
>> This patch fixes the issue.
>>
>> Signed-off-by: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
>> ---
> (snip)
>> +	kfree(rtd);
> 
> Please double check soc_new_pcm_runtime() and
> soc_free_pcm_runtime() at soc-core.c.
> Because rtd is created via devm_kzalloc(),
> and has many related resources which need to be cared when rtd was freed.
> Just kfree() is not good/enough, I think.
> 
> I think you want to use is snd_soc_remove_pcm_runtime()
> instead of kfree()
> 
> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
> 
I will create a separate patch for kfree and separate one for subsequent 
play back issue.
