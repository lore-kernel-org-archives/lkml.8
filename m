Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42EC2078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="PwOlE+5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgE1BGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:06:18 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:6266
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgE1BGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ0U9Jbz4sFlfJBtvXCE9eYbY8naLLDBjlvp7CRlqyyK5BdSVjEF9dbr6kIx2tG7mJRAq0IkxxPl2hfbbDXrCxy/K3/TYeZoJz8mw7WEW/lnA12UlyLfIxm9kIY29U9o3EzFaGWJ781uF3Zaim7YJ1gDZjsmjIWeVvdCwoEaakiW794KR7rkErfa8i8a+jMs0ecSEZXtzpAXqudEkCCk/LVvg+CmmU1g/mCKCICo5ImFesaTU5OEOd0h0kOSt89t1BLLgERlbWl3q5KAV8GcJo6yqqWe8f3wGcHLk5234sXntkUEK3YnjQOk+9OxrYLsPH+NEykL8ap7LSSQALVjLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxQjNhveOMGg433wXXc5LqatrAnxfbcJPZMN3e7CucM=;
 b=Yb25nGWt70kt/FDPWnJoNO1UbTVTg1KmPyAPxubfFHrBsSY2RaRol7krwLMddpiehRXfPxkPN+3NwOdnSYXJdpPuFq1dt6Ti2fxmAd2r9L8nPmuGPSHG4qMab++vOHB3ZlF8aT2J9vurrEt/SkyV2FABkdraSxdnVz8UpKlVblp/4XNV2vkuMl4aE0uIlZTx/J5CmOhYvB/6KorIVPi5p5UOr0zG+1hVzRyL1dVgA56v5t2lcUo2f6dyf9lUXYDJgJtZPBuHa1MpCLXvEZLsD4wtvEaIl3NK98K2DlB+1AWFN6KXq9L1K0YVtUqo5K1TqMUJE/bVbCBzsL+WxfrXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxQjNhveOMGg433wXXc5LqatrAnxfbcJPZMN3e7CucM=;
 b=PwOlE+5Lu+yc0lh+VNeZM0l37FLBsCoimOlvLktQAGJJUC33tCs43QLPRaQ01XWZnisjpTGaha4+zy94BJpsHRSueSthLB1SKp2AU+H1fxHA4LLU7SZnZVKzb9LqBtqCHeCW+efSn/gR0ahj3Hi2mP+zYKq+PZRsmq+4LEe01Gc=
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2747.namprd11.prod.outlook.com (2603:10b6:5:c6::22) by
 DM6PR11MB4235.namprd11.prod.outlook.com (2603:10b6:5:205::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23; Thu, 28 May 2020 01:06:15 +0000
Received: from DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8]) by DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8%4]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 01:06:14 +0000
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     will.deacon@arm.com, paul.gortmaker@windriver.com,
        catalin.marinas@arm.com, bruce.ashfield@gmail.com,
        yue.tao@windriver.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
 <20200527151928.GC59947@C02TD0UTHF1T.local>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <cd66a2e4-c953-8b09-b775-d982bb1be47a@windriver.com>
Date:   Thu, 28 May 2020 09:06:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <20200527151928.GC59947@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To DM6PR11MB2747.namprd11.prod.outlook.com
 (2603:10b6:5:c6::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HK2PR04CA0076.apcprd04.prod.outlook.com (2603:1096:202:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 01:06:12 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3edd565b-18a0-4046-8f5b-08d802a351b9
X-MS-TrafficTypeDiagnostic: DM6PR11MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4235C17C44EB37BFEC711696D88E0@DM6PR11MB4235.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Edz4V8kjW8k3WF2Z1pNX7+v+BP5JpgDqKiqZsHueFOl79u36XXRfHaR823hKinghuVOtTIG5VqskE9ZRFvwxVBcT2qc0kbPSC94pgwIolbH0eCzvG4Dsa7hN7Ps91yekyg6BJUSKvpOQVeeumPWzpbjCmTjZCfZTu19RZFGykTU2mmAJmEZWhjcY09KwRbvxM71WNc6tHe80NVMesLk6CUcoJ6asv1MFptTyLbYxPVE9x0alKM6m981JfFljaaOenEF0pBu5HqvmgBX0jBIA7KsDVnDLssOVvwoUNquuam/bxzWVvDmOONfX1t+CMa60kmvkqeLa2lbBYDUyyonniBW3YM0vFNh1bIiaB4T16Chi5I0pB94gwL1tQssPT5RTzJODhOKQVyjR9zX3SGCgTvNBMsuvSQpHZbTtSybieocECARhtys+E6PC5T7QHhigUJYwKDCQHk7fRsP1LMbxNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(39850400004)(396003)(6706004)(66946007)(16576012)(316002)(66476007)(956004)(66556008)(478600001)(6666004)(4326008)(107886003)(6486002)(8676002)(16526019)(86362001)(2616005)(8936002)(5660300002)(31686004)(31696002)(36756003)(186003)(26005)(2906002)(53546011)(52116002)(6916009)(78286006)(15583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: q7wWw697TNg6fUA+zVSwxODi5tMR+H0/20XznNO12kQKpyLkJOo1tGI6/vxd4kW6K9QPnA9iSBJ/DhIOZB8toVkXCXdyGDDfwqfWnk8SUBulSCbLjgsLzoazO3eWuDkAF0HTjV1FagSbamO04bVpQx93FmXGYXENHyGF/g56UBOsjI5NxuTJ6XV4skx30Dtec/z0yYMgdn5tFbpPTxxA92WYZqhcAe0DoefiFPkAVcdtKjlZNJy8Na/fPquOKoIFSYQUvcQid1Ouc4qP4SZoib8pcfC5ZYq5DpfiThvXZ+rriJJ+rEtcOVTXvKmXoqeIDeR5XKyZrWyA+kRh2T+Pwvv61iiWlwwOjbLA3rfrDO+NHHfXEXiMaSTfdPjngwNDVp8/QOg4OgtcRIK/xWLbN+14mrHPv0CEiYDpZbnKp+Zt7zzzi7cKbs36QfH30wYZ9JTNpT8yLR2LZVVb/X8QKhFbS1K+PqtsGUnqentpgMc=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edd565b-18a0-4046-8f5b-08d802a351b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 01:06:14.9383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFdv1umwvCCxNBkYi8asKnQfrvIOjqliiy1LhH32xqOb9SCeywHSuP/bjwkryzVfBFz0wBAUX2hhwim/b/Lwuu5z5IqjWo7JM5sW3kVCpys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/27/2020 11:19 PM, Mark Rutland wrote:
> On Wed, May 27, 2020 at 09:33:00AM +0800, Jiping Ma wrote:
>>
>> On 05/26/2020 06:26 PM, Mark Rutland wrote:
>>> On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
>>>> Modified the patch subject and the change description.
>>>>
>>>> PC value is get from regs[15] in REGS_ABI_32 mode, but correct PC
>>>> is regs->pc(regs[PERF_REG_ARM64_PC]) in arm64 kernel, which caused
>>>> that perf can not parser the backtrace of app with dwarf mode in the
>>>> 32bit system and 64bit kernel.
>>>>
>>>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
>>> Thanks for this.
>>>
>>>
>>>> ---
>>>>    arch/arm64/kernel/perf_regs.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
>>>> index 0bbac61..0ef2880 100644
>>>> --- a/arch/arm64/kernel/perf_regs.c
>>>> +++ b/arch/arm64/kernel/perf_regs.c
>>>> @@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>>>    	if ((u32)idx == PERF_REG_ARM64_PC)
>>>>    		return regs->pc;
>>>> +	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
>>>> +		&& idx == 15)
>>>> +		return regs->pc;
>>> I think there are some more issues here, and we may need a more
>>> substantial rework. For a compat thread, we always expose
>>> PERF_SAMPLE_REGS_ABI_32 via per_reg_abi(), but for some reason
>>> perf_reg_value() also munges the compat SP/LR into their ARM64
>>> equivalents, which don't exist in the 32-bit sample ABI. We also don't
>>> zero the regs that don't exist in 32-bit (including the aliasing PC).
>>>
>>> I reckon what we should do is have seperate functions for the two ABIs,
>>> to ensure we don't conflate them, e.g.
>>>
>>> u64 perf_reg_value_abi32(struct pt_regs *regs, int idx)
>>> {
>>> 	if ((u32)idx > PERF_REG_ARM32_PC)
>>> 		return 0;
>>> 	if (idx == PERF_REG_ARM32_PC)
>>> 		return regs->pc;
>>> 	
>>> 	/*
>>> 	 * Compat SP and LR already in-place
>>> 	 */
>>> 	return regs->regs[idx];
>>> }
>>>
>>> u64 perf_reg_value_abi64(struct pt_regs *regs, int idx)
>>> {
>>> 	if ((u32)idx > PERF_REG_ARM64_MAX)
>>> 		return 0;
>>> 	if ((u32)idx == PERF_REG_ARM64_SP)
>>> 		return regs->sp;
>>> 	if ((u32)idx == PERF_REG_ARM64_PC)
>>> 		return regs->pc;
>>> 	
>>> 	reutrn regs->regs[idx];
>>> }
>>>
>>> u64 perf_reg_value(struct pt_regs *regs, int idx)
>>> {
>>> 	if (compat_user_mode(regs))
>>> 		return perf_reg_value_abi32(regs, idx);
>>> 	else
>>> 		return perf_reg_value_abi64(regs, idx);
>>> }
>> This modification can not fix our issue,  we need
>> perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32 to judge if it is 32-bit
>> task or not,
>> then return the correct PC value.
> I must be missing something here.
>
> The core code perf_reg_abi(task) is called with the task being sampled,
> and the regs are from the task being sampled. For a userspace sample for
> a compat task, compat_user_mode(regs) should be equivalent to the
> is_compat_thread(task_thread_info(task)) check.
>
> What am I missing?
This issue caused by PC value is not correct. regs are sampled in 
function perf_output_sample_regs, that call perf_reg_value(regs, bit) to 
get PC value.
PC value is regs[15] in perf_reg_value() function. it should be regs[32].

perf_output_sample_regs(struct perf_output_handle *handle,
                         struct pt_regs *regs, u64 mask)
{
         int bit;
         DECLARE_BITMAP(_mask, 64);

         bitmap_from_u64(_mask, mask);
         for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
                 u64 val;

                 val = perf_reg_value(regs, bit);
                 perf_output_put(handle, val);
         }
}

>
> Thanks,
> Mark.
>

