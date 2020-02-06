Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670DC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23707218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lhfXKn28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBFUB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:01:26 -0500
Received: from mail-eopbgr700108.outbound.protection.outlook.com ([40.107.70.108]:46432
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727703AbgBFUBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:01:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CazPA5CJqBtX54b3URvM6vWLqBPaEX7AIoP+VT6RLq1d3k0UP6paWojb+k1w5lYHEc/DZhRUcGmikGnTcP4qeuRltgAMHcN3NVJeNX4VmeiCOCOjmwAGdxtiF9UGxFmR/IdoJwC+25xJlmHbP283ZjalmhxaQma4jEtvormWcucJsxVk3BxDY6HjSy9kRViuVVZH1pL+NaZNiRy6TMGrIZDkKR89IRIEikBdo7zON53gDShyouoR1zmSW2nwhe1P/evOdU116+f6IeeXB3J1BiczXLEhWpeLA3cNKfdGtTPw7qSNoS+cUI/YHCh1ypRT8BT3s64ptdMIBSW+9ZFdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCkEDuNPxXyoUb8puS3lidEq+LR/opn1kJCrFr/R9CA=;
 b=KWnReVmFItjetO/n8LE8z8O8S7mMjYkHJE8qnHXqbZJIP4P+FpjQgnx33kpY0d4s8tnWWiLY93MJnNQoCqVrdTusDg53Eild3JDdNDzcN38rR/rG3uw67Kmg4cAPu2rvJfhGWFyjxuoF2NJGwntiWU9rrY3uo07yVt+SFuertmMIsnV1VLKBcitSjeybknFx8hd/aaKI7T8LObUw7zkw48XNQ7r0IdjNauWNoNb5rum/MWXS0GXVizqbSEL62uImUrD8f+M0ry1eui0cIYvFdeyWMOqDTfu/FiWoiYwJiGcy+xw+rFwVix89RB1DGRl1whDcjsbYJn2VZktoomcuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCkEDuNPxXyoUb8puS3lidEq+LR/opn1kJCrFr/R9CA=;
 b=lhfXKn288O1YpfVLhMM54124+jVJj3n8UhgQnhbvUOix5I/OXm3RnMZlhEiQXczbIbt9RX/ypddBi3BV2WqPtzLS6UxFT39PiBjZLbKIlpR0n6peeh0G/En6pGKCGR8Ss8Mk7lZU3rY1nHdLksi1HB+BC32bOi2v94iTSCFeQnU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=hoan@os.amperecomputing.com; 
Received: from DM6PR01MB4090.prod.exchangelabs.com (20.176.105.203) by
 DM6PR01MB5769.prod.exchangelabs.com (10.255.9.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Thu, 6 Feb 2020 20:01:23 +0000
Received: from DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::e148:5333:b3b1:b153]) by DM6PR01MB4090.prod.exchangelabs.com
 ([fe80::e148:5333:b3b1:b153%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 20:01:23 +0000
Subject: Re: [PATCH] arm64: Kconfig: Enable NODES_SPAN_OTHER_NODES config for
 NUMA
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@os.amperecomputing.com
References: <1580759714-4614-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200206102340.GA17074@willie-the-truck>
From:   Hoan Tran <hoan@os.amperecomputing.com>
Message-ID: <c85dbc06-a72b-9c98-fe41-b25069114b2f@os.amperecomputing.com>
Date:   Thu, 6 Feb 2020 12:01:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
In-Reply-To: <20200206102340.GA17074@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY4PR1201CA0020.namprd12.prod.outlook.com
 (2603:10b6:910:16::30) To DM6PR01MB4090.prod.exchangelabs.com
 (2603:10b6:5:27::11)
MIME-Version: 1.0
Received: from [192.168.0.184] (67.161.31.237) by CY4PR1201CA0020.namprd12.prod.outlook.com (2603:10b6:910:16::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.23 via Frontend Transport; Thu, 6 Feb 2020 20:01:22 +0000
X-Originating-IP: [67.161.31.237]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 681ef895-454b-45c8-4cc3-08d7ab3f5719
X-MS-TrafficTypeDiagnostic: DM6PR01MB5769:
X-Microsoft-Antispam-PRVS: <DM6PR01MB57699707EF403B528B89BF79F11D0@DM6PR01MB5769.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39840400004)(396003)(136003)(346002)(189003)(199004)(4326008)(966005)(86362001)(6916009)(478600001)(31696002)(66946007)(66556008)(53546011)(956004)(2616005)(107886003)(66476007)(16576012)(5660300002)(26005)(6486002)(31686004)(8936002)(8676002)(316002)(81156014)(81166006)(2906002)(16526019)(52116002)(186003)(6666004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR01MB5769;H:DM6PR01MB4090.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
Received-SPF: None (protection.outlook.com: os.amperecomputing.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaJyHS/8m/90oEp3EfdmXhiQDNvh+st2lNMpR68hsFCq8iPC7eKY5GFhOdpeEIkT5msm2tv1rE9NpAGkw++VCZhMBExLznc4th6Xk+aCsdislDUJF+gmJDsE5pkTzYld8dU9qApLyQw/RgFBBf9XELmHeFaIxXkh6DKcikiPbKzL8yTnaOvLBBuacZ3mShljn0jiHVyR4D0N+zWf86BcH0YsRHmewDU/akJDUXh4xrQcAwJam+fgozuYOfTEPo1rygBPE8sSJwkwvQhfECF1Bd/rh/d6kn/KVsMfjPXQoZjhwh2nwyAnfvINP+D637bh8WwEBPZgPsXBVLo5vkxtajXCGZaPDn2IPIA9RYvwCJN/yNjdIL0kSTlEFzOa12J1xMqTrAm81SbBo4KvsS468F6p4UMw8vjrKcerS6fFdqftimOqdRKrtrYGtSmHDpHjfVVKMz5KrIVAYL0U3u4OT5L5uF5+o8wWQ9XbeXu7h8DwjYF/DX4lZMz2FU+ei2Hum9JyQnINg4kctcKX/eH3/Q==
X-MS-Exchange-AntiSpam-MessageData: 0IQLWH/mIsvZNftRnfN+FCij/KJAvk5Zu0P4i8eCAwkFIjo8JlSwx2kF3/ZdlQVamE9gLeNnQubCX6g9pgDBuu+tZraNPhB7Xbt6zafIlrj44zDf69XhfiyykLBzzlPM2aunxSdPnVqaas9npxB19Q==
X-MS-Exchange-Transport-Forked: True
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681ef895-454b-45c8-4cc3-08d7ab3f5719
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 20:01:23.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jb//zUTzLLVW5GP/VUA6kCpn7VI6j6CjD59hT5xmyQPW85o8TeC0X8tgICeKcaGHPPdXHNizP2OMWzhwSgmtnGreU++B1FN1usRW90BiFgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB5769
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2/6/20 2:23 AM, Will Deacon wrote:
> On Mon, Feb 03, 2020 at 11:55:14AM -0800, Hoan Tran wrote:
>> Some NUMA nodes have memory ranges that span other nodes.
>> Even though a pfn is valid and between a node's start and end pfns,
>> it may not reside on that node.
>>
>> This patch enables NODES_SPAN_OTHER_NODES config for NUMA to support
>> this type of NUMA layout.
>>
>> Signed-off-by: Hoan Tran <Hoan@os.amperecomputing.com>
>> ---
>>   arch/arm64/Kconfig | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index e688dfa..939d28f 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -959,6 +959,13 @@ config NEED_PER_CPU_EMBED_FIRST_CHUNK
>>   config HOLES_IN_ZONE
>>   	def_bool y
>>   
>> +# Some NUMA nodes have memory ranges that span other nodes.
>> +# Even though a pfn is valid and between a node's start and end pfns,
>> +# it may not reside on that node.
>> +config NODES_SPAN_OTHER_NODES
>> +	def_bool y
>> +	depends on ACPI_NUMA
>> +
> 
> I thought we agreed to do this in the core code?
> 
> https://lore.kernel.org/lkml/1562887528-5896-1-git-send-email-Hoan@os.amperecomputing.com

Yes, but it looks like Thomas didn't agree to apply this patch into x86.

https://lore.kernel.org/lkml/alpine.DEB.2.21.1907152042110.1767@nanos.tec.linutronix.de/

Regards
Hoan

> 
> Will
> 
