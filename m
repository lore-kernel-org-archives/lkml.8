Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96374C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9D20719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDFGlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 02:41:36 -0400
Received: from mail-oln040092070045.outbound.protection.outlook.com ([40.92.70.45]:54338
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbgDFGlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 02:41:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvsDbH+oQP9ybWoVtle/UR2qDdJbOF9V+LJ9PbZ4OkbbT2gy2XzC20bC/LL6+2zQI6SqbfmahriKBOLLkRDCsAmB5KtGtjrow71GpOC+O2E+QSl2IsOXL9wb7t6/u+nu1LTDotX4rUPIsS7o5jv/wtuqz8ZjbSWCBYPO1ekbKWtQsdGGprfPWiiM+vIDola3oUxhlvUO8JE3tGLt8jiIxCWCCpGxp9UcAGsiDsmzZGH5P60xty7BoWl3K84a8iPGE/dZwsW4F/EpIwhZc6vrePwRUyyRzlt2zmozupb4CPN7aC1qPRy7AcGrFg7zFVtbSNDSd34022Kzc5jXTO+5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umkjpq1FSYIAGozRpINAjXlPVXlmDh/7i45uKEJkE/Y=;
 b=OgezRT1WvFFshUtEDaQJm7R6Sdeo6uDNcv8ymLoE2Oj23vDW/H6mV0pGSAU+XNxoU5hosH4zO7zz7nbWPhMY8d4+jR/8De00t/xJ2YULFJqgEiRpAFqIcg+DhfEepot6T61jcBXoAdZzI7vg3rt2ok7jqXKfozuXyg8TszVt2CxFKBo8+pwq02BTHWC6VYLM4vuZ34WpU7aTwcISZgQJ69QJwdnQ4b0l1WxE2Vx0X3EW6TfFRNqD5FVw83crG+FHLPX/NM4yZjH2U77aWMUzRB+waOIN3dsl8DTWwJ9G7MMIRW8fQxf4kmbC3XSgE7ru+nnE6mLVvzhe975ruDHmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VE1EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e09::44) by
 VE1EUR03HT115.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e09::268)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.17; Mon, 6 Apr
 2020 06:41:32 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e09::45) by VE1EUR03FT009.mail.protection.outlook.com
 (2a01:111:e400:7e09::92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.17 via Frontend
 Transport; Mon, 6 Apr 2020 06:41:32 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:8D1C898E88B538FF0AC7FF59116A711CE885582F57723A3579D902AE015418D2;UpperCasedChecksum:2DCD1467586CF306CBD206EACAC5A2CA9A6BA44249D439F1B7172A7F29DABF42;SizeAsReceived:9334;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Mon, 6 Apr 2020
 06:41:32 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB517026CDE64EC57DE37C6080E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjqNnpsBJR1xM_Ce91cNh=24CDt6ibpL2G=vDUbSFGR8g@mail.gmail.com>
 <AM6PR03MB517004C9D4F4E39816E926D9E4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <AM6PR03MB5170DF7DC6986CC3759B041AE4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Message-ID: <AM6PR03MB5170CFC06260511B79C81E71E4C20@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Mon, 6 Apr 2020 08:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <AM6PR03MB5170DF7DC6986CC3759B041AE4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::27) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <9d330a9f-593c-e371-23e7-c1edfbf6fcbc@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 06:41:31 +0000
X-Microsoft-Original-Message-ID: <9d330a9f-593c-e371-23e7-c1edfbf6fcbc@hotmail.de>
X-TMN:  [ot9qlohUNOneCO85sCFvhNWoMYPwz+Bj]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c48b7832-cb79-41f0-db41-08d7d9f58ac1
X-MS-TrafficTypeDiagnostic: VE1EUR03HT115:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/RR/w1TTnhW0qbDP4Fjt5XAACKA/B+mhcjosvny0M/I+jjKPiHYyESCZTsvg5LymY6t9mToscr/v1A9fjj1hmmRQ6LRmgE9HQ5g4DN0I/gvpL6UcrLHpo6PVcd3Y1HI6xFicRTsAPThI+7ypN+5DhPLfaO8FBRngwlQaOX19j70/nJQRua9JQYvvbFOcNIx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: V9YIcr1KUExSlUsOGmwSfPMgCWLqNXu37ehvA2U2HEYcpvDz1C6DAd3vZ9R0ug6bCUjdpjNI4IgIWs4xYJluuSRLaHHY1FBwz+x6MgIFG8RfCfEtHai7tTbxQYeiDydSFobfl2WymvgEb1AQsbQyhQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48b7832-cb79-41f0-db41-08d7d9f58ac1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 06:41:31.9866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/20 7:48 AM, Bernd Edlinger wrote:
> 
> 
> On 4/4/20 7:43 AM, Bernd Edlinger wrote:
>>
>>
>> On 4/3/20 6:23 PM, Linus Torvalds wrote:
>>> On Fri, Apr 3, 2020 at 8:09 AM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>>>
>>>> On 4/2/20 9:04 PM, Linus Torvalds wrote:
>>>>> In fact, then you could drop the
>>>>>
>>>>>                         mutex_unlock(&tsk->signal->exec_update_mutex);
>>>>>
>>>>> in the error case of exec_mmap(), because now the error handling in
>>>>> free_bprm() would do the cleanup automatically.
>>>>>
>>>>
>>>> The error handling is sometimes called when the exec_update_mutex is
>>>> not taken, in fact even de_thread not called.
>>>
>>> But that's the whole point of the flag. Make the flag be about "do I
>>> hold the mutex", and then the error handling does the right thing
>>> regardless.
>>>
>>>> Can you say how you would suggest that to be done?
>>>
>>> I think the easiest thing to do to explain is to just write the patch.
>>>
>>> This is entirely untested, but see what the difference is? I make the
>>> flag be about exactly where I take the lock, not about some "I have
>>> called exec_mmap".
>>>
>>> Which means that now exec_mmap() doesn't even need to unlock it in the
>>> error case, because the unlocking will happen properly in the
>>> bprm_exit regardless.
>>>
>>> This makes that unconditional unlocking logic much more obvious.
>>>
>>> That said, Eric says he can make it all properly static so that it
>>> doesn't need that kind of dynamic "if (x) unlock()" logic at all,
>>> which is much better.
>>>
>>> So this patch is not for consumption, it's purely for "look, something
>>> like this"
>>>
>>
>>
>> Just one suggestion, in general It would feel pretty much okay if you
>> like to improve the naming, and the consistency in any of my patches.
>>

I mean it, I could not imagine a greater honor, than You improving
one of my patches.

Just please consider what I said below before you do it.


Thanks
Bernd.

>>> @@ -1067,7 +1069,6 @@ static int exec_mmap(struct mm_struct *mm)
>>>  		down_read(&old_mm->mmap_sem);
>>>  		if (unlikely(old_mm->core_state)) {
>>>  			up_read(&old_mm->mmap_sem);
>>> -			mutex_unlock(&tsk->signal->exec_update_mutex);
>>
>> I was trying to replicate the behavior of prepare_bprm_creds
>> which also unlocks the mutex in the error case, therefore it felt
>> okay to unlock the mutex here, but it will work either way.
>>
>> I should further note, that the mutex would be locked if this
>> error exit is taken, and unlocked if this error happens:
>>
>>         ret = mutex_lock_killable(&tsk->signal->exec_update_mutex);
>>         if (ret)
>>                 return ret;
>>
>> so at least the function comment I introduced above should be updated:
>>  * Maps the mm_struct mm into the current task struct.
>>  * On success, this function returns with the mutex
>>  * exec_update_mutex locked.
>>
>>
>>>  		put_binfmt(fmt);
>>> -		if (retval < 0 && bprm->called_exec_mmap) {
>>> +		if (retval < 0 && !bprm->mm) {
>>
>> Using bprm->mm like this feels like a hack to me.  It works here,
>> but nowhere else.  Therefore I changed this line.
>>
>> Using !bprm->mm in the error handling code made Eric's patch fail.
>>
> 
> That does probably work better it the boolean is named
> after_the_point_of_no_return or something....
> 
> 
>>
>> Thanks
>> Bernd.
>>
>>
>>>               Linus
>>>
