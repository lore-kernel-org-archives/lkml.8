Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB7CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0F7207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="ng8REdbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgE0BdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:33:12 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:48325
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgE0BdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:33:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUu8jYoUsgM65ZPFT/brrq722mYHHjNvrFdctaeQ0jxRQzKrzc7gKmI9Z0ICnjGVQvzssFQAgY801MdgK1B8m50LfOGJaJ95v71rX9WVDi+Q6xFIRxxI7UrsiCq24W/7i4OL7VaGnWlU0auhDpvxRQpKXQJooX1F+55aYq1GXx6iskEgZ7fWX2h8DuqrcjeYP8rNUl37TSzEOevv2dTn6NmQ6aEfFLUpFiyHorDdvXbWU8U0niBfp/8rwINHqqCFoP9Cu0bW9O7ucvvpfS2jg3rILbkO9O7odOj10tpiqOTDPJzn2KDry4LipcOD8NK3y/7YQQKn9h1+dOuo584znA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jc4yEdORqFbCoo1t/+tRCJYrax4yWEHmkEOf/cOuOg=;
 b=mxEbMw7060s6c+msnj4eH469ik1hs9f3GL21g4WdXX2pqshK0XKY7ht9jToFQXXyXHVivLsZffzO+x6OyAQRR1dQ813GCDF0OqGV3Y8PboH4W4vW7TgJg8/w0r4YBbNyYwaNrQwo6LwhsZufditREVD+O0Ae8NHBC+BXV+D+zTwQjGgyB121MgKcFXTvodewxRkwXNW4k8Q5erzok1Qw+xjbPS5wmKL0kBjFruYtAcSPE51jCu+AovbVvJuS6D3vh0z6zEIP5QDYXaGtYORAloI5BSVZ7cgcs74CCYtpB7VEPxpAYC8ADsHIX8TRzRGX7oPelZYfvgWKObCD0QxGJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jc4yEdORqFbCoo1t/+tRCJYrax4yWEHmkEOf/cOuOg=;
 b=ng8REdbJPdCUDf+vCmXwRh4r6PUXradRb4mKs4DSc09/T7PgtZfJ+O2OvQMAUe6uDlHl/aIs0nq0+PV0oZkKVcHGcDgjVU3GP4EsAYJsyNhyNk7XigCU4JzxOyay2LDHYp9FnS5373nVrd3102ukTPFX+gkm/RB1zwKRdcsrB/w=
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2747.namprd11.prod.outlook.com (2603:10b6:5:c6::22) by
 DM6PR11MB3932.namprd11.prod.outlook.com (2603:10b6:5:194::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.27; Wed, 27 May 2020 01:33:09 +0000
Received: from DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8]) by DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8%4]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 01:33:09 +0000
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     will.deacon@arm.com, paul.gortmaker@windriver.com,
        catalin.marinas@arm.com, bruce.ashfield@gmail.com,
        yue.tao@windriver.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
Date:   Wed, 27 May 2020 09:33:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <20200526102611.GA1363@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To DM6PR11MB2747.namprd11.prod.outlook.com
 (2603:10b6:5:c6::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 01:33:06 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dce7b5be-72bd-4bb9-63f7-08d801dde9bb
X-MS-TrafficTypeDiagnostic: DM6PR11MB3932:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3932BC9D0B0CDEB4A43C11B4D8B10@DM6PR11MB3932.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nM9E3bE3vcbBkI6sUIrHbbiourvfLxXT/qvMF29AVxzbpLtimtpCLLA8y4lLOI8U9oWwji+Eknw6EiqVkeUQsPOl/xCrkFfez7lg0zlfE3KVcCYmzP3qJ5vN2+Nbq6ajh8FHTbAPDLzO7oAoAIAkgVXOYvjHrkxdXJprPlwma2Z8cd2H8HTadVWuawVvnaVo4R38nGd6lu7iIxY5xz7gvLjGRlHo9WBysB31rxHCGriA1fudELoBKQiZQBMzA4kTpPXyKfy+b7kVkBxK2UlNuLEdYGbIvydtRuQ7kWdcjye2UmMrTSmRZCP4TbIKjBC5Jb0plwbKrAl+iXEPkVX+7bSMg5WMUVW4WQCkIveIHiSdQ+tYQGNFLO8fMwRl2/zMdIMkqzaEnycDx5/FiYJ/gA8fZCN5gZ6ilx7KADm37FCoipLa+mCCSjEX4+wWt+eWAc9S9dwa07QZcjRx/nMvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(366004)(376002)(346002)(39850400004)(6666004)(6916009)(52116002)(956004)(53546011)(6706004)(31696002)(36756003)(478600001)(2616005)(86362001)(186003)(66556008)(66476007)(16526019)(26005)(6486002)(2906002)(66946007)(107886003)(8676002)(8936002)(4326008)(316002)(31686004)(5660300002)(16576012)(78286006)(15583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R7z2saHfm9SGaGDshCg+MpXX+XuagJQIx5NJR1bX7kiNrGyWJmUqhaGQko1T9FJXxqqyL190RTsmgzfeClaai8717TJRlk1A/JViL7mX76uGaE0o/f4+yDLubuv9rjFzEOVoITyYaKKAluULnIz7Whi0++KGRyUKW4cJzmiPRXcCFyQFGNfAoTMgJROQWZgXPrNjny9nRAy5m1Aq7jT92EdNny1ZviCJ/fkiOoOehNW6fDqmwsW7s01EYYq/M/zu2S7JTi2ZD50sorocs/D81q6tvBt5ufOUyJStihNe+V3bHapb21oKrYu25xXK/47rVHTPEqSSI1Pf/uP99zLOnphXgSUYa8nZwiOWVOL/Gsm/S6Lu0q38Zk3H0dUwgWBniBZrmMSyltijFo/kDPrqWKy73Hqfk5XCZ57z2LPJTX63As7SVFx9rPQFJetZ7PBkHQ0J4Mm4eEnn9l2x0qVq9YnRlpnxc3vwScS5DE5lCXc=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce7b5be-72bd-4bb9-63f7-08d801dde9bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 01:33:09.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyG+UQBNpm7C5luc8HPJ9jE3Wcu9l6UYf/9XfcgcL1v6hHZUKMt5QmqfuETbuK602H9BRk3hvK0zbrcC1A0gDrudMIXXBoTRl8cgYOIEqdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3932
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/26/2020 06:26 PM, Mark Rutland wrote:
> On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
>> Modified the patch subject and the change description.
>>
>> PC value is get from regs[15] in REGS_ABI_32 mode, but correct PC
>> is regs->pc(regs[PERF_REG_ARM64_PC]) in arm64 kernel, which caused
>> that perf can not parser the backtrace of app with dwarf mode in the
>> 32bit system and 64bit kernel.
>>
>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> Thanks for this.
>
>
>> ---
>>   arch/arm64/kernel/perf_regs.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
>> index 0bbac61..0ef2880 100644
>> --- a/arch/arm64/kernel/perf_regs.c
>> +++ b/arch/arm64/kernel/perf_regs.c
>> @@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>   	if ((u32)idx == PERF_REG_ARM64_PC)
>>   		return regs->pc;
>>   
>> +	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
>> +		&& idx == 15)
>> +		return regs->pc;
> I think there are some more issues here, and we may need a more
> substantial rework. For a compat thread, we always expose
> PERF_SAMPLE_REGS_ABI_32 via per_reg_abi(), but for some reason
> perf_reg_value() also munges the compat SP/LR into their ARM64
> equivalents, which don't exist in the 32-bit sample ABI. We also don't
> zero the regs that don't exist in 32-bit (including the aliasing PC).
>
> I reckon what we should do is have seperate functions for the two ABIs,
> to ensure we don't conflate them, e.g.
>
> u64 perf_reg_value_abi32(struct pt_regs *regs, int idx)
> {
> 	if ((u32)idx > PERF_REG_ARM32_PC)
> 		return 0;
> 	if (idx == PERF_REG_ARM32_PC)
> 		return regs->pc;
> 	
> 	/*
> 	 * Compat SP and LR already in-place
> 	 */
> 	return regs->regs[idx];
> }
>
> u64 perf_reg_value_abi64(struct pt_regs *regs, int idx)
> {
> 	if ((u32)idx > PERF_REG_ARM64_MAX)
> 		return 0;
> 	if ((u32)idx == PERF_REG_ARM64_SP)
> 		return regs->sp;
> 	if ((u32)idx == PERF_REG_ARM64_PC)
> 		return regs->pc;
> 	
> 	reutrn regs->regs[idx];
> }
>
> u64 perf_reg_value(struct pt_regs *regs, int idx)
> {
> 	if (compat_user_mode(regs))
> 		return perf_reg_value_abi32(regs, idx);
> 	else
> 		return perf_reg_value_abi64(regs, idx);
> }
This modification can not fix our issue,  we need
perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32 to judge if it is 
32-bit task or not,
then return the correct PC value.
> Thanks,
> Mark.
>

