Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85545C8300B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B232072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="M18fEnzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgD2EwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:52:06 -0400
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com ([40.107.244.61]:6083
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbgD2EwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:52:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHa7aR5e2biWYAzdNwcK7hdM6aTwh7FDOY6XIeY+dqpaQRzx+1Ro1E8o5S5qvkDbSrUV3KobxtO8q/nn6rwr9JwtHGgLCm/HZQ0+Czt96Q4W6s3M+TBL54mQNwqsiJeQNM6tOn4W9785oUX3OKBYNaE7q9Q4V8WuJpfFfdhkUAtdM7wJ8wgOj5zdxbTYdMOVpf2R6gl/1iyn85ujxu3IJah/bPw2ZG6pliXT7zIxqmmAmAtwPYlT7Er9xbcM69WoC1bDR31J/sdw2/0fjGyaQtQ/hFyxWo4j2+DrVAhIvUrZlybJPyR3gZ5kv7kZ8yrHksMyfRG0y7x5uD4dFmnp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZthqLQTk3WoLNPbzfQm5ebCUDkyag79vT8INTOozvao=;
 b=VAujawwuOlBAw+8ARD1rCgF16T9IlIbDhmH/VB/uGJf2++gl8ixv07yQKASAYCY+bNpNShjbccsblmwqm1zs7btZaFmAJsEbj8LgDPQKFectFmncqxm4FyUfp5j1WoDoVk1gqFoxBMuGe+NDhz2h9zMPpP7abk64Dwq0VPeuk/3wGCMd2XQ7YB/0uDMPB5g+TPeX0bRsU4CKiCTDijRPPrxOEsG3509aLJaT38rU24JcT6TAiR2Ie1aUEm8Qd27DQIASbl25i8MUtP5+JyVAlf/dhjlie/ZUhXHZZDa+RtNwMFVfUQh6MjW0KDuCUNr8HYovAAVf9ftdSlqd/waR8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZthqLQTk3WoLNPbzfQm5ebCUDkyag79vT8INTOozvao=;
 b=M18fEnzUq6qWdu2lcA5BPzqtz9dPWkuxhW6kfRmN/1M9s1srfvtSBcVplYBA7D6Ic8FNBBVirUSHFhgMO7KKtXYIbrgDrFPuVNZKJXLA+dnH5hBMQ2T6wTKvY5IZr57FqlJ6knfoHUuyysywyDtT+4jbJG7cB2mskNat9S3707A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CH2PR11MB4215.namprd11.prod.outlook.com (2603:10b6:610:3b::26)
 by CH2PR11MB4392.namprd11.prod.outlook.com (2603:10b6:610:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 04:52:03 +0000
Received: from CH2PR11MB4215.namprd11.prod.outlook.com
 ([fe80::48e7:73e7:ca6d:c32a]) by CH2PR11MB4215.namprd11.prod.outlook.com
 ([fe80::48e7:73e7:ca6d:c32a%3]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 04:52:03 +0000
Subject: Re: [PATCH] perf: perf can not parser the backtrace of app in the
 32bit system and 64bit kernel.
To:     will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1588132911-64901-1-git-send-email-jiping.ma2@windriver.com>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <32a473bb-2760-b967-5d54-a22677b8018d@windriver.com>
Date:   Wed, 29 Apr 2020 12:51:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <1588132911-64901-1-git-send-email-jiping.ma2@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HKAPR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:203:d0::26) To CH2PR11MB4215.namprd11.prod.outlook.com
 (2603:10b6:610:3b::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HKAPR04CA0016.apcprd04.prod.outlook.com (2603:1096:203:d0::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 29 Apr 2020 04:52:00 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 653e200b-cb5e-4da3-9ef5-08d7ebf90ec6
X-MS-TrafficTypeDiagnostic: CH2PR11MB4392:
X-Microsoft-Antispam-PRVS: <CH2PR11MB439265743E614CD1CD7EBBFDD8AD0@CH2PR11MB4392.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 03883BD916
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /mupf5z2gj0c95vM9Qj3BWT5LREoEs8htz88w6bN8UKV4U5GRI1uiYWaO8oZfSrZvze0OUHnBK+SEY4/kONYCcrSFkvCVKBeltSPJKyiXX4kkhCkC56tpFW5ETHqTJA2u2B+bmwZxRQT7idoO5RdaM126eYnBda5rpuXqNZjhPuQhhaIcZdzTSpl5PFiv8jeGpqEmXAECWFRTynNRDEQoDpw6KCKqU/PlUv+fCvnJo8yM/lPhpCj9SKAehzx/HGWxp+S/DwSekw7XH1GiZ97BBNGyjkwX6k9f85ivnN3jBFu3N/9IG/zQxjgwOLoDFqzx/0FilN89UTshEcnlhAnVqnbRhR/Jqb0Ua8gih7HNlLLcDK9ETi+SOHIDvqDIE++VXIy2uyS5AwCsyGW6VWyFSq3PfnEiJ8UKcD2hCKSZwISVqAgKKNEE8k8oSdb4koSbELYjcuQ4DQFyV0OB0JWHsPPr7cpFQ+W9o9G38sfqiJTEVTYiiJaHyGDIMiH7wkmIsCZZjWpEcxYp4AvpHRuoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR11MB4215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(39850400004)(396003)(376002)(346002)(5660300002)(31686004)(66946007)(66556008)(16576012)(66476007)(316002)(4744005)(8676002)(36756003)(26005)(2616005)(31696002)(2906002)(6486002)(52116002)(16526019)(186003)(8936002)(4326008)(86362001)(53546011)(6666004)(956004)(478600001)(6706004)(78286006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Xf/+QeL6pHBc048kL19mu0MTQKpljve8D4G/uP9fJz56hF7tvOsnTh6c19BJbMbMvdeF3hor6VFe4C2bV6AJRx87OhJwtz/gqkqdVeoNKC4aZNH2zNJOktSwbWJ48WdwVVJz387g9pNPiHdzWLS+Zi7ZvA5yOQatQrURXy9PzfVACXxZ+iNn9wtq5juQ+EaA1iMWmSLH61YekLUCgj3TfmnV+PUTzEa8toTokAwGYBMTnRiEJ78k13fCxBWAh32x6FEckDkWZhpwzDaJWSk4vvg48rKXIOHcNcEg5XLNMq1gULZZEaU8vQ3MWrY9A11G3lozaiXu+IDGsoFxr+YvhyoqEFXn4iATDRuf8tQCw89D1enK1EHTgSe4RNjzHMctbvtZVCpWtlrEhtGPvtDF/Hcc3sl2zgCmUjGTmhymFX5iwdBsHUJcSmD46ioKYVMWPWoi00AEfIhW+COujhkJq8qf5fa2ToklnlQxwehwxIPwoaauXnlD78OZUEK5DTzXcZotSeYomuS1i2eCuwI1SJr7i8eRD0q66590uO+w9q+WmEedyaVHi9dhH/zNO3+Xo/bapSiFZ37pLMOoGyWdCSIdb2Cekdk+xizfg1qgoVPEEDxcHGghjDoQKZvTKszcmQF4tejJ/RY53Ry98zCUYKF+v876dKB3fAy8mlvC2ngCO146Kf3oqWSlYA7JT/j/HJRoIrckL5hnXE8jYXxHxk4pmP+qHqjPp0FpENDERe5JkEAt/5AQze95eay/aR7oU4qL0G9zvt4V3TGleAv+VbY82opTvyYMYnE80BuNsNg=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 653e200b-cb5e-4da3-9ef5-08d7ebf90ec6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 04:52:02.8293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCrqYddevwHvwG1AujpCHFEbRurnMbG8SqYkR99b0LBtt9cN6bbmCSufVK6le8M87u54qFf88eK18hlxuC2hFQTKwr+Phwfs0KvTBvc+2/Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We test it as the following steps.
# gcc -g -mthumb -gdwarf -o test test.c
# export CALLGRAPH=dwarf
#(./perftest ./test profiling 1; cd ./profiling/; perf script)

Thanks,
Jiping

On 04/29/2020 12:01 PM, Jiping Ma wrote:
> Record PC value from regs[15], it should be regs[32], which cause perf
> parser the backtrace failed.
>
> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> ---
>   arch/arm64/kernel/perf_regs.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> index 0bbac61..04088e6 100644
> --- a/arch/arm64/kernel/perf_regs.c
> +++ b/arch/arm64/kernel/perf_regs.c
> @@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>   	if ((u32)idx == PERF_REG_ARM64_PC)
>   		return regs->pc;
>   
> +	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
> +		&& idx == 15)
> +		return regs->regs[PERF_REG_ARM64_PC];
> +
>   	return regs->regs[idx];
>   }
>   

