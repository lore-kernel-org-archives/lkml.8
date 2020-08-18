Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658D820674
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="GKDS8REJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgHRK0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:26:49 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:13857
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbgHRK0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:26:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJXxJ4ERmxk2cNFI9MtBHBCCauIcGAofgTWzOOKJLCa41YvnS/jBduqVM72Ph6kjiaY4AOuSXgkVaUhZa85GihCUhkRcnmiuLG0JLsUw9BVvWeeD8uNwHFC9VvHR29oBtzhInyHnWrilZo9MO8ZPzLgg9Wpkf7ukqrF61GCyJ+3r7qqz8eZJ57BEOEsHgjffxZ5JdzGAngfEf7oE3Icy09KLlcluGBs2pv5QKOFwdlqeSicL0FBn+p44M0qFgVRTJCWI9iVAcHMKWpjZ7QMJ4DEKFdODnlBphOYO6jaLAPowZy4XA0+XfH5AKFpZWrcX9v4n97HnyYO+DyE4L/+y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCNhZvIk0BEmvB2qVuoKO06tjJZRW9d3j1Ffo6nO/1A=;
 b=BhHUYrU7in4M0mgggwe4rJ7sgylwM9Ef1V5H3R009AztQGbSTaRE0jI8WxZuUANdZDy013Fuvky4YXG7mEyzvush3YDT3v1ggfQIaEGP6dFwbr7iD2d/5YDq5bMRg7t4t9Fu8/7nuusFjpFwIXBWtkpkI3pYLlcEC1PN6K1ma4K0lU9yifvk+XfqZ982xxW5E7pZ2HC36dOWTaoRsyiX76vbhJGDkwWdugD/MwfK8n1bq8P6MFF6FcMOYpNO9Y74iGjDV7I0wsR9G1DPF+DFrOK1SQuNo+srnvO3vVvTxOHABUEkDO72cBJxOfvvH2lzR2/WoWGkEHl7MUlyIrBcsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCNhZvIk0BEmvB2qVuoKO06tjJZRW9d3j1Ffo6nO/1A=;
 b=GKDS8REJfR9xFmSiaq49O6UwO5ld9ICBa+2k1RjFDaOR7TjXUU/E6ALk9kHekDLO8knjYnIh9kyMsubQ3q26st/5xQ6j094DGs0v+OuL7RG778SkUPsegjNS8NyieT2V1mdazK+8S1iY0CBspM+yH62odzXgl8NaSC2cye7Dxr4=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3557.namprd11.prod.outlook.com (2603:10b6:a03:b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 18 Aug
 2020 10:26:42 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::8d64:f85b:1cce:a1c0%5]) with mapi id 15.20.3305.024; Tue, 18 Aug 2020
 10:26:41 +0000
Subject: Re: [PATCH] mm/memory.c: Correct the function name in comment
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200818072910.27068-1-yanfei.xu@windriver.com>
 <0eb405b4-a9a3-1840-0ca6-f9a801ab701c@redhat.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <2b9b69bd-cbf8-55f9-72f7-b3c3d24b14fa@windriver.com>
Date:   Tue, 18 Aug 2020 18:26:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <0eb405b4-a9a3-1840-0ca6-f9a801ab701c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:180::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13 via Frontend Transport; Tue, 18 Aug 2020 10:26:39 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5319f00-d340-4d01-b452-08d843613286
X-MS-TrafficTypeDiagnostic: BYAPR11MB3557:
X-Microsoft-Antispam-PRVS: <BYAPR11MB3557266C9FC1FEE02EE901A7E45C0@BYAPR11MB3557.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3w5bbYbdg7rWq/NnYcJEyiyzILgtdNdoJz4/k+eqoHLQc62gDYPP6zbSl9+dkC4exkD/d7gL3abwb/heau4LrrPT/S4PNZAyBYFBXq0KP4v486Ao0HXMGRGbIdbOQzz2ZJf23Z4AyMpwJVrvoLovvrTcfMmhyxKeXRW7VGXkg2ztlX8Nq7KwLSaJTw6snYKXqwsDQjvM4probpGFqkohhEbcQDnrxSuwVF+I6WMgdRH1uGlTREl3afARAZBsngKc3Fg2zEv6XH20qwsRE+OnKZ2pN/1oiiRcE4stvRoSuMYlyLT+RYLc4OFHJb2MIHVBWh2JQvktfZ7gRFYAnJdaQZqNO61NefxJZ2nX6fBZWLkjbmDL0/KvQfkh3TVHnJBcii955RByfycCTwLJfWPi50bwUyUJaslf464Mmpw4F74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39850400004)(376002)(110011004)(66946007)(478600001)(6666004)(31686004)(86362001)(31696002)(16576012)(4326008)(316002)(83380400001)(36756003)(53546011)(66556008)(66476007)(956004)(52116002)(2616005)(2906002)(6486002)(8676002)(5660300002)(186003)(26005)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xYA3jz8pjyhCUvvbivv4FoVkZENcZluGxugstHd/ON4z1Kb98lsOuN+39zKe1r43y00kuUfp5v+q9l+tWxkCDn8tjNq9aFR4ACs6iUbC65XgSZXpQjB/J7gBAQv8gcgY9ZK7m5fCM55THaA0danPLGddVDpLZ3Z7SQvk8rKae+orGNF0pYDyFPXt4VlRGI/6RvStClT477fjR3J7L0YU1vNq3D3rBow2QrPDHz0726EgFs4ugrAerhA7zcoTXV6pUJj8MEmgJ2gcRU1gnGIu+ferYTfcfeJAs3prhI/M5pHcSU7ZROtBfRVR6JKD29UQGnYVBBR9q38OxBJcg6Z3w7npTjDGddn9esu4wnWNq+J6OUlININVf2pNQyZ6kwqkSVAyfik34xqmb4DyLcj/5lhK3rvPHMT6UQ67KrIasV+8963zvOsgW8adm/YVk+et5U5MJAHXFjwSwSby+PaE1pUnHFgm7W6RzmwKtPckpO9gUFoQeu0hyU3XaKGtqVE9p4gUeFUGKdeiDoAgZ0p3lpxZBZuJ0C0sXtdk/WlhFjBgvq4bEHLPGQYZeI0a+en8fi8PjASvnxAq9estY5Ub58aH+S4lnc7S/6WDDmx3FmWpG1v3KhuUF3qQJd3ZHfJt325ktEcxNUli+lx5AETUVg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5319f00-d340-4d01-b452-08d843613286
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 10:26:41.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NxTOSFdHMNr48yjgyE17E0SiK6i3i9gyrhzVnLTxsWV3NrxSlwVVL8AGOWwfnWe1OmuA3TRkFv39YZCmwA+/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/20 3:34 PM, David Hildenbrand wrote:
> On 18.08.20 09:29, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> Correct the function name which is "pte_alloc_pne" to "pte_alloc_one"
>>
> 
> I'd have phrased this like
> 
> "mm/memory: Fix typo in __do_fault() comment
> 
> It's "pte_alloc_one", not "pte_alloc_pne". Let's fix that.
> "
> 
Hah, yours is more clear. I'll send a v2
Thanks for your suggestion. :)

//Yanfei

> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>>   mm/memory.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c3a83f4ca851..9cc3d0dc816c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3446,7 +3446,7 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
>>   	 *				unlock_page(A)
>>   	 * lock_page(B)
>>   	 *				lock_page(B)
>> -	 * pte_alloc_pne
>> +	 * pte_alloc_one
>>   	 *   shrink_page_list
>>   	 *     wait_on_page_writeback(A)
>>   	 *				SetPageWriteback(B)
>>
> 
> 
