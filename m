Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E125C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E130920776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gCMnvlGC";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="gCMnvlGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgE2O6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:58:40 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:49543
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbgE2O6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGFuXhr5k01jQrnm8x20Uxrfo293zxbJkC2MSelhQi8=;
 b=gCMnvlGCdufNYFw/z4y05TpDtZwPW8EN5oE651T+HxmXSidaNOlK5EqLuPdrOy4bJpIlpHwtOttjqGj/ESCoIsqNJn1fru8+1PHOoVe5er/ShuonYQiye5KfDezogoON6KMwrN8cAKOgo3OLnht12ZwYzvC/2tG8AGEjhd3IxA8=
Received: from MR2P264CA0066.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:31::30)
 by AM4PR08MB2676.eurprd08.prod.outlook.com (2603:10a6:205:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Fri, 29 May
 2020 14:58:33 +0000
Received: from VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:500:31:cafe::a2) by MR2P264CA0066.outlook.office365.com
 (2603:10a6:500:31::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21 via Frontend
 Transport; Fri, 29 May 2020 14:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT041.mail.protection.outlook.com (10.152.19.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.23 via Frontend Transport; Fri, 29 May 2020 14:58:33 +0000
Received: ("Tessian outbound 952576a3272a:v57"); Fri, 29 May 2020 14:58:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 764973754e6a1542
X-CR-MTA-TID: 64aa7808
Received: from d0089fa8eddc.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AD825346-518B-43C2-8EA8-2881A86F301D.1;
        Fri, 29 May 2020 14:58:27 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d0089fa8eddc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 29 May 2020 14:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGQpj73k2GapxSi9mlBZ9mDp0akDwhxlhGQYDdVsFwxhyDz9PnsEtiV20NlToW9wCBfaKrdWe4tnODO+QtHK6sHOZ6D4zaO6MJwXlpvGuf017PpOF2Wv68fIfil2HSJ4jV2RWBvmqYRNqoDxHMvMKZ73iCQ2XIQqhuej/NHUxFhuH3eQcLND9wsLhEzY+J2ZZDikYVgivSFpiEpIVEfhMh4KX2BV7apcLU2+LJjSGa2ninA1IiIUhLvYlOmbbcptZMH8FiS8YDaqADvG4jpqn44XxO2XflfhY7viv1APK7RGbd6PpjqZzjmfY9PEbLwVh3ZiJEhiWeDH++xRK+ci2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGFuXhr5k01jQrnm8x20Uxrfo293zxbJkC2MSelhQi8=;
 b=LgDd3HA5ym55o+Q6nnHzRxzX87NgClfAsFA0dSsR3ndE2+I+EoMfUlFPKvU4lTaJ5wRaPuZ6EiVX2z+0sw0Mz3bIrmE7IOd9gslB46lIwILGwUOv5DNFOF3nvv26NHxln1YKRojdmpgS69aLtb1k+DNZStQAhDCRzqYGpuuOdZANV3KfMVXYS0Jpebb84bqoxDYHcS84HVSaubMkN4xVjGQFkGpMqgwgvB3oX6TvtFRT1KOldDdE8vd1Ojf3Cho1NDmNwgJ7vV1Wn2qGcKOGnUaUZIb/6cMLcKwHkii/P5fGZYxxl1P1CBQeuagHyjzX8LFJVRqIp8Pd78yK5VJi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGFuXhr5k01jQrnm8x20Uxrfo293zxbJkC2MSelhQi8=;
 b=gCMnvlGCdufNYFw/z4y05TpDtZwPW8EN5oE651T+HxmXSidaNOlK5EqLuPdrOy4bJpIlpHwtOttjqGj/ESCoIsqNJn1fru8+1PHOoVe5er/ShuonYQiye5KfDezogoON6KMwrN8cAKOgo3OLnht12ZwYzvC/2tG8AGEjhd3IxA8=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB5019.eurprd08.prod.outlook.com (2603:10a6:10:e0::21)
 by DB8PR08MB5451.eurprd08.prod.outlook.com (2603:10a6:10:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 14:58:25 +0000
Received: from DB8PR08MB5019.eurprd08.prod.outlook.com
 ([fe80::1c60:ea21:1382:c81b]) by DB8PR08MB5019.eurprd08.prod.outlook.com
 ([fe80::1c60:ea21:1382:c81b%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 14:58:25 +0000
Subject: Re: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
To:     Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
References: <20200504115625.12589-1-leo.yan@linaro.org>
 <20200522030919.GE32389@leoy-ThinkPad-X240s>
 <20200526102602.GA27166@willie-the-truck>
 <20200526104337.GA7154@leoy-ThinkPad-X240s>
 <20200526195438.GC2206@willie-the-truck>
From:   James Clark <james.clark@arm.com>
Message-ID: <3a80a66f-b991-ec55-77a5-a8fc4fa69e5e@arm.com>
Date:   Fri, 29 May 2020 15:58:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200526195438.GC2206@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0029.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::17) To DB8PR08MB5019.eurprd08.prod.outlook.com
 (2603:10a6:10:e0::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.46.28] (217.140.99.251) by LNXP265CA0029.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Fri, 29 May 2020 14:58:24 +0000
X-Originating-IP: [217.140.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f905520-0f17-4c47-37ba-08d803e0c1fc
X-MS-TrafficTypeDiagnostic: DB8PR08MB5451:|AM4PR08MB2676:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB2676E97BED3ED714727DD0C8E28F0@AM4PR08MB2676.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: IRCSmuVX1yAaHGWOAU+8MkTisQTCJ3SZzRkHskihfprsyHSko/UZ5cXZPSSjIJBM6KYhAGJqSq+XBLHGRduzNPXuKnkOGSHWGV4q2ywUhtoQ5zbvWAjXY0lR4WjcoP3+BeGFJZVkUuBMCzLBqMfcJzWfxgkOf99hs2vBVIB1WbSkshuYpOORwjVN16FU7yYGUEYWfbbSNla18eLiS4gEQ4ytpPK8Bzd9+wwX1AkFlXa2if3GDOBKX+lLF7+Kn1QMsp6eTJAwidUQGZYL6eIym8mV5q3VOljF6zJ09lIa7adpbaJ7bHRFft0rMqhap3QLpjzP86pitD8Fbyxk8Qwjt2pOESEfroUD/dwAKhS594aNvP8dFtd1lxP7vR11lRLt
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5019.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(52116002)(2906002)(36756003)(4326008)(956004)(316002)(54906003)(8936002)(110136005)(44832011)(478600001)(86362001)(2616005)(8676002)(186003)(26005)(16526019)(31696002)(16576012)(83380400001)(7416002)(53546011)(31686004)(5660300002)(66556008)(66946007)(66476007)(6486002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8X6MQuHf3zbAMwlh0vZsYoL1znld2GSbmYFYybY9MxsWyAWnYkaStRiEjacdgO8/lEny1NxlIu141onyi3E0WOF9B5EN/1kRhyLekgwkJyaMLnlZJ0MKMlQg3VCkaaORcZjVVTYn/hm5ECvxVX0GnetaRh+1rTjQyD4BaGRMMwmPSjhG3kdaJKcxXFk9sqW2NhJG2Y2bXMGgjLzBA7qzf98GU/LNn798EG/g8/sYoxmWUCljRzbR1Wo67GyLGSUX+EbwqRQvSrwHXVvrk2aBTYyjqRRCuhgqHJtdpVndz8O9FD8VU1ggr5XQ7Xm46Op54AmpIxq93xksJAEIrl/QE+CHJK84B6ibsnNwesqRucM0P7tHlGb8gReGFrmlMgEbLlwYJQ768ya0jQ9GUKZMda0NwIlIhFm753WuiB2Y7/AMalxGmMko1v/ZXCBCjqIJ2SU0Q3hOqUOe/dquJBiYhWJNYa86Fhe1lgCPcVSDgs0UwCMy/YTbm3ud3/FYA1D4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5451
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(31696002)(956004)(6486002)(47076004)(356005)(36756003)(81166007)(82740400003)(82310400002)(4326008)(26005)(336012)(54906003)(8676002)(2616005)(36906005)(16576012)(107886003)(5660300002)(44832011)(8936002)(70586007)(186003)(53546011)(2906002)(16526019)(31686004)(478600001)(316002)(110136005)(70206006)(86362001)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7efdd61f-3436-4195-2d7d-08d803e0bd1a
X-Forefront-PRVS: 04180B6720
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkDrcvjPLuuLyj7v9nIi/9S/UI8FYK2Xj40B1VPJL680OVFA38YgXAHTt8GzYPF1v6yrS3/6SBaJ1XfGR5IOXbTilWUpLFV+uyn7Zzhze3gyFIF8zWzmuZHUe9yNZnw6w28yATW53k0q5bJR4806j4+oABwfRWQP0hlcPQFoxMlTkifZF3JC27u2ggi7z/qAHkDAINqu7q58dUGZRF+YzzK/LgTMqIoi7Vnhyw4SiHDcEnvdW28SN8dpPpU7qfd0NtAbtKbPgmhZldBu81HbkDi21npRO6iirB3uF/AkU+KViHv6+8/e4a9fjJF3BvaNPl8nPlR7KuXMwKRujbfrDyOEBgI1l3c15rILQC+i9UmuiJcI+dZ5SiX6L0Nzcy8GPjB2diR4LkSL13hC0sjDiSjMXoxHZEFpnTmsbj+OtWFL/rWlexzrxguahM79Z69Z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 14:58:33.3945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f905520-0f17-4c47-37ba-08d803e0c1fc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will and Leo,

I've tested this on an Arm N1 machine and it looks good to me.


James

On 26/05/2020 20:54, Will Deacon wrote:
> On Tue, May 26, 2020 at 06:43:37PM +0800, Leo Yan wrote:
>> On Tue, May 26, 2020 at 11:26:03AM +0100, Will Deacon wrote:
>>> On Fri, May 22, 2020 at 11:09:19AM +0800, Leo Yan wrote:
>>>> On Mon, May 04, 2020 at 07:56:22PM +0800, Leo Yan wrote:
>>>>> This patch set is to support synthetic events with enabling Arm SPE
>>>>> decoder.  Since before Xiaojun Tan (Hisilicon) and James Clark (Arm)
>>>>> have contributed much for this task, so this patch set is based on their
>>>>> privous work and polish for the version 7.
>>>>>
>>>>> The main work in this version is to polished the core patch "perf
>>>>> arm-spe: Support synthetic events", e.g. rewrite the code to calculate
>>>>> ip, packet generation for multiple types (L1 data cache, Last level
>>>>> cache, TLB, remote access, etc).  It also heavily refactors code for
>>>>> data structure and program flow, which removed unused fields in
>>>>> structure and polished the program flow to achieve neat code as
>>>>> possible.
>>>>>
>>>>> This patch set has been checked with checkpatch.pl, though it leaves
>>>>> several warnings, but these warnings are delibarately kept after
>>>>> reviewing.  Some warnings ask to add maintainer (so far it's not
>>>>> necessary), and some warnings complaint for patch 02 "perf auxtrace:
>>>>> Add four itrace options" for the text format, since need to keep the
>>>>> consistency with the same code format in the source code, this is why
>>>>> this patch doesn't get rid of checkpatch warnings.
>>>>
>>>> Gentle ping ...
>>>>
>>>> It would be appreciate if can get some review for this patch set.
>>>
>>> I was hoping that James Clark would have a look, since he was the last
>>> person to go near the userspace side of SPE.
>>
>> Yes, I have offline synced with James and James has verified this
>> patch set at his side.
>>
>> I don't want to rush to ask Arnaldo to merge patches, so just
>> want to get wider reviewing if possible; otherwise, I will rebase this
>> patch set and resend to ML.
> 
> One thing that might be useful is if James could offer his Tested-by or
> Acked-by on the public mailing list. Neither Arnaldo nor I have details
> about your offline sync!
> 
> Will
> 
