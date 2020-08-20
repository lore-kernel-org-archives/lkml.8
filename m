Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17819C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC16207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BQxMf6zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgHTUPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:15:53 -0400
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:54048
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726908AbgHTUPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:15:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdEVZlx4Ua3TgArMWxpMsqwCVJcm0ZaA+T/nzUDTc3odoZ7ApiT/4c+1oNMm38GR9Pl7fEqIwVZw3Co/PiNGh/b6DlvxyJImp6nvz1a1eEf1nb310SKSnZwgPdfNRX5w1sgxsWM2L5Kj5T+CVFAAQLQSh5ck4yvK90wh3XBT1fqD0M3dH3+azU+AQrc5kVjJT1aTReldFTCUssStz4jjK3m36k3h1BY0IA5RwJGT+xxap9f7l+trAcx9rsh4y04q4zGuxMxun6rvHFdS2nmQa9/FcuLEnfoCv+Z2JfANuMNq++/+no1UrSWWvb5Nzuw/zoUJFaK1vBmdv3Iyopemcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qUWXv+tNoDxTpOtcAYJKFPqHH5QLUC/dbFKLLgiVsM=;
 b=XJZPfSLMIPt0pkecU9SzO32e3BUbMsq4II9lSIHob+MPx2J+zQBVZzQ8SpVfI7Sg5sOllxdQId1sHgvLRc7JR2Efg/CR5wYjgnxP29BdX50oqPsw2fEFPGB6n6f2U5A7r7UnT7zEkP7NIWHyp6umMQ/HecNXkzKdeEWyuR+JZKPtQJUFaE3WIrniFmUH9kLxN4jvBgs74gxQomFTKlRlzon51A92fODfWfhdjSUr3k2Znv4ejq3iY7wVtyMm0tqnZDR2w/cZjU4IDbwuI938dCgp9NFHJUm3+C6lcrLauP6gMInK8+EbvgJ2XCxUiAz0trv4hCqNzcENbn3r8Z60PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qUWXv+tNoDxTpOtcAYJKFPqHH5QLUC/dbFKLLgiVsM=;
 b=BQxMf6zpAREvPPk63O8SBCcmu27pTEqwCxXVxHTB3rQGLlSim+NmuIVZVxi/oB6PRwjVYoSu+vnjY3y9lggtQUuf1EF+hTBDM5MOZTOPE4a6mvS1OXynKUFNO9zavh8AY1n9eXiQrQSW5JC3Q+3wOs88AO0XBtkAocPXeQnnDcM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3082.namprd12.prod.outlook.com (2603:10b6:5:11b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 20:15:48 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 20:15:47 +0000
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Dave Hansen <dave.hansen@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com>
 <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
 <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
 <20200820151049.GA26595@sjchrist-ice>
 <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
 <CALCETrW8SWgWxDdMXuMPD-A1avztvNcpwLAKKRQ4ojmcz07B6A@mail.gmail.com>
 <45e16c5c-ce99-33da-99c8-ea52ef0945db@amd.com>
 <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
 <68478297-ff21-fa38-a37b-2e1e515fdc5e@amd.com>
 <CALMp9eQDuwzxdLXndnq9FZfDXaNS7U36WDW7CqixjVBareYAwQ@mail.gmail.com>
 <CALMp9eRXvM9un1LVsuMZqE6aKSzdxp+UXAMrZS1RD-jxEdZqZg@mail.gmail.com>
 <50e7c7f6-d212-4e90-09b7-2c568087084e@amd.com>
 <c4cc63b5-2861-5370-781f-5d664b6ffed5@amd.com>
 <e8b3f80e-3c5a-7a03-97f9-75cbdbbb023c@amd.com>
 <c3170164-8b89-621e-59f8-999e4149e0a4@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <f6694ee6-d672-1cf9-deaf-4d600bc4e9eb@amd.com>
Date:   Thu, 20 Aug 2020 15:15:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c3170164-8b89-621e-59f8-999e4149e0a4@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN2PR01CA0025.prod.exchangelabs.com (2603:10b6:804:2::35)
 To DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN2PR01CA0025.prod.exchangelabs.com (2603:10b6:804:2::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 20:15:46 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f984a151-0898-40e8-ee6f-08d84545d37f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3082:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30822E330C8944063383BC3BEC5A0@DM6PR12MB3082.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNE7iYCMCuqjN8xiF/JpkztTH9UErm83pkr970qbRBgjITNRry3KbY6VIqFs6DvCqbNjEJYeC776b4E0pdB/Xnu6EMmFPMsATpuHvKVHpyc/xjg0R8w/zuhVooDklQMwZhy59wCPatcZlN0lyohmMYHPtfY2O90t0/08hJWor2vtbnnuULP4NXp6s7OAEYh08fyeoprv+0N0L9GAIp/h8l6t+PInezikxVo4vH85FBJe1eWpkp2YB5h8sWBf8Dg2qTo7hEmtDjgKPpyTzDNXIzpHcbbx8ZvhxOEb4f10kzJUfmJlJ1un1/AmDwu7ij85nRHymqEioKNtvGcwD8WhiAbNkItseQUBzF9yg/7TwSBdwYoMGSDXSy9hIhA1TTgXlNoHdmpSavmQTpXmr6xR9JtKzBOR4a7kW7DnwrXYAug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(54906003)(110136005)(6486002)(86362001)(16576012)(53546011)(110011004)(7416002)(8936002)(4744005)(4326008)(66946007)(31696002)(2906002)(31686004)(316002)(83380400001)(66556008)(478600001)(52116002)(26005)(36756003)(956004)(8676002)(186003)(5660300002)(2616005)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xRLPWquuPx+E1LCerMz/IijUrYItSc0WAuLbmzIx19zteB8lLb3Cwl1tQG+7z6qEpeoAQi1/JluyN0RyXYGPjT+q9YLFA1/2J2LsOFS/uF8VG4DRUhlAOIi4qQ7B8cioesI4Y87hQ0IQhqhTiTDDJZ+oIXs9ucO7ndCNkSGkiNLhC2QADU11lIVy/t9eZojR7H/tSgt66AA0giKcnnsUy9O1SOTN/Xw7px8wKThsuDhZUjF1PktiI8AooaVipjXm7TZGhrDa8xFwA0OsY+29bMeyPaHlwI3rcw597p/66S4m3MpYT4FLYjFsRUih10IC+X8C+7bcEY1H30dSVtABz+fvklJ3sFNSzZvdihyBKz/MeHDcJ1K+kOjRiNsgOW2HowsV1COtwZ/1GQtuIskkbTaoNnzu4Yr202gPHQ37P67CrS2w6grBfWc6wOm2rsGR5566lkCEcwKs58RAeVnMXFiil0uBbL5chAlNvw+xqlWwyA3p7KDLh79xt1MzMMDhNhs7wm6jAi55vhedWRyPIEHc9ra0hhToKS8XsBz8mmMINrFtOuar/BlBPuvOiiOg6b9R+f7I6o/XlcgmT3K/sSzLfgSRkAvVIf0OyMl9/JS3V1PZX6qOL+XJB787zyvHfNTIk5fccSKHuj0jo5JTnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f984a151-0898-40e8-ee6f-08d84545d37f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 20:15:47.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWwHlw+d1FqbVj8B6tEQI3vqbKlObW3gqop9XMLH/qLiXVRwWCl90I4YB+oOGncouiEqkvrQoCNy0mdUND/Xpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 3:07 PM, Dave Hansen wrote:
> On 8/20/20 12:05 PM, Tom Lendacky wrote:
>>> I added a quick hack to save TSC_AUX to a new variable in the SVM
>>> struct and then restore it right after VMEXIT (just after where GS is
>>> restored in svm_vcpu_enter_exit()) and my guest is no longer crashing.
>>
>> Sorry, I mean my host is no longer crashing.
> 
> Just to make sure I've got this:
> 1. Older CPUs didn't have X86_FEATURE_RDPID
> 2. FSGSBASE patches started using RDPID in the NMI entry path when
>     supported *AND* FSGSBASE was enabled
> 3. There was a latent SVM bug which did not restore the RDPID data
>     before NMIs were reenabled after VMEXIT
> 4. If an NMI comes in the window between VMEXIT and the
>     wrmsr(TSC_AUX)... boom

Right, which means that the setting of TSC_AUX to the guest value needs to 
be moved, too.

Thanks,
Tom

> 
> If FSGSBASE reverted is disabled (as Tom did on the command-line), then
> the RDPID path isn't hit.
> 
> Fun.
> 
