Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07ABC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 05:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ACA2064A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 05:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgDDFtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 01:49:03 -0400
Received: from mail-oln040092074066.outbound.protection.outlook.com ([40.92.74.66]:13134
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgDDFtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 01:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPmG1iXa7pBxqSg9ZJhXsznOblvJyQsxjdHSK47noTY8r8yl/sTn960KfMnCirvpTutjTCpaYYR2KnaD+oiIsC61MvWYCFDuIYbmlRlZUBmWs6MDtaZIQ2EgW4UJcmr02V2TMPZC6yOW97zqDUVYz0F6il8hwxL4nGPPB1gtK59wLcFLiG7ZkbC8Pwz97qMqEXvJU5Yn9CLgDfaHDfHtKGnRJM6j+PlIZNHNlrnnTG42pCsb4Vr7NLK21TJQYErkJ/+wuTDklui92yYXu3bZznmbT1RskDZ6NSQ8h5MeFZqgPo8wcEvpvyufAXkUQYiaWSv+O0g3xCVDfXBMhaJ3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilpiw4ZOdQ96sqww8WSoB+2yDgftBZX69GnyjhyeJ6w=;
 b=Uwu8tBf6vq85jW+3xerlipWt+dbD9xQjR/PSJ1ybK7viSAbI5TI65ZzarqQHfl5lHBZuMK/z8SrMHrnZkhKRUUEBB95CRMLSXMUQVkDDPWzQhYs35XZy50FzSe1FBDmhEKcoIoSQOCxDfP/V8o0PBC5Nxr0zMGwfq+RR534JFRiZUtXatFpc93SbICgTu2RqVIJ/bZgfyrWIJ4aLTHb2VyOlptd2YSvAf2oyl2FfyJkcor2p8RmtB7xplvOuRlIOftTtpbFKtJ+R02NrHonqzuwjb4aqq7O9DbLdInUOEeZkQoH02hT2n0nkC+FMX5AnU50/142RZOnDgSacy/uwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from HE1EUR04FT035.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::42) by
 HE1EUR04HT236.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::421)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sat, 4 Apr
 2020 05:49:00 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0d::46) by HE1EUR04FT035.mail.protection.outlook.com
 (2a01:111:e400:7e0d::294) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Sat, 4 Apr 2020 05:49:00 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:E6D0B5D8FF45F68D283B262BABCC7D52247E2D9F43E91208FBA230CE3EAD3835;UpperCasedChecksum:AC3C8B9CDEDE4E5DED57CDBE99676092C742CC9F66AE9696692F5C6F4602D233;SizeAsReceived:9247;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Sat, 4 Apr 2020
 05:49:00 +0000
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
Message-ID: <AM6PR03MB5170DF7DC6986CC3759B041AE4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sat, 4 Apr 2020 07:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <AM6PR03MB517004C9D4F4E39816E926D9E4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0018.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::31) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <89bba8ce-c141-d161-5542-2cc5b822e8a4@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR06CA0018.eurprd06.prod.outlook.com (2603:10a6:208:ab::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Sat, 4 Apr 2020 05:48:59 +0000
X-Microsoft-Original-Message-ID: <89bba8ce-c141-d161-5542-2cc5b822e8a4@hotmail.de>
X-TMN:  [XPB8BnrohAGnSuXZTMbvPqYy6ykVC+pN]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 6c5d3fd9-14c9-4739-e804-08d7d85bdf49
X-MS-TrafficTypeDiagnostic: HE1EUR04HT236:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e8QgodTdWyN1xXPRf8D7+rHrOrDINKxbEzZ8OX9mhLziY0SWhWWtGuouNqjtpIuONhvd27MglXc4ONiMo1ZYhcq/WFrak0OPZ9F2N0HB6Trg+eIUmbBpbvavZbIFLX18O3Pmu3HoNVsPu3lcWpydQqp42JAtMIo8PMlE8d92Fefnj1kkF+Pmq3qXC13S9qzF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: uotUi8wYc8sIYdPNADCexAL3E8EHxhdiKec88xo8AT7xFPQkPJemFy5ajwKgGPbyVKgJBwcReTeJrydlCupnukJlP84dAvcV6NFBpKgdLjW4pwGZVyyABXqwJyQAlyzEdM01rEKl8EIEu6Hwyzw0bw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5d3fd9-14c9-4739-e804-08d7d85bdf49
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2020 05:48:59.9478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT236
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/20 7:43 AM, Bernd Edlinger wrote:
> 
> 
> On 4/3/20 6:23 PM, Linus Torvalds wrote:
>> On Fri, Apr 3, 2020 at 8:09 AM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>>
>>> On 4/2/20 9:04 PM, Linus Torvalds wrote:
>>>> In fact, then you could drop the
>>>>
>>>>                         mutex_unlock(&tsk->signal->exec_update_mutex);
>>>>
>>>> in the error case of exec_mmap(), because now the error handling in
>>>> free_bprm() would do the cleanup automatically.
>>>>
>>>
>>> The error handling is sometimes called when the exec_update_mutex is
>>> not taken, in fact even de_thread not called.
>>
>> But that's the whole point of the flag. Make the flag be about "do I
>> hold the mutex", and then the error handling does the right thing
>> regardless.
>>
>>> Can you say how you would suggest that to be done?
>>
>> I think the easiest thing to do to explain is to just write the patch.
>>
>> This is entirely untested, but see what the difference is? I make the
>> flag be about exactly where I take the lock, not about some "I have
>> called exec_mmap".
>>
>> Which means that now exec_mmap() doesn't even need to unlock it in the
>> error case, because the unlocking will happen properly in the
>> bprm_exit regardless.
>>
>> This makes that unconditional unlocking logic much more obvious.
>>
>> That said, Eric says he can make it all properly static so that it
>> doesn't need that kind of dynamic "if (x) unlock()" logic at all,
>> which is much better.
>>
>> So this patch is not for consumption, it's purely for "look, something
>> like this"
>>
> 
> 
> Just one suggestion, in general It would feel pretty much okay if you
> like to improve the naming, and the consistency in any of my patches.
> 
>> @@ -1067,7 +1069,6 @@ static int exec_mmap(struct mm_struct *mm)
>>  		down_read(&old_mm->mmap_sem);
>>  		if (unlikely(old_mm->core_state)) {
>>  			up_read(&old_mm->mmap_sem);
>> -			mutex_unlock(&tsk->signal->exec_update_mutex);
> 
> I was trying to replicate the behavior of prepare_bprm_creds
> which also unlocks the mutex in the error case, therefore it felt
> okay to unlock the mutex here, but it will work either way.
> 
> I should further note, that the mutex would be locked if this
> error exit is taken, and unlocked if this error happens:
> 
>         ret = mutex_lock_killable(&tsk->signal->exec_update_mutex);
>         if (ret)
>                 return ret;
> 
> so at least the function comment I introduced above should be updated:
>  * Maps the mm_struct mm into the current task struct.
>  * On success, this function returns with the mutex
>  * exec_update_mutex locked.
> 
> 
>>  		put_binfmt(fmt);
>> -		if (retval < 0 && bprm->called_exec_mmap) {
>> +		if (retval < 0 && !bprm->mm) {
> 
> Using bprm->mm like this feels like a hack to me.  It works here,
> but nowhere else.  Therefore I changed this line.
> 
> Using !bprm->mm in the error handling code made Eric's patch fail.
> 

That does probably work better it the boolean is named
after_the_point_of_no_return or something....


> 
> Thanks
> Bernd.
> 
> 
>>               Linus
>>
