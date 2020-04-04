Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C593C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 05:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E30206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 05:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgDDFnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 01:43:52 -0400
Received: from mail-oln040092073077.outbound.protection.outlook.com ([40.92.73.77]:60798
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgDDFnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 01:43:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiwA2qkXG4tNv7C4kcyhu74wGPBfqaCnhHH1k8u9s98nqoC7P/tn2QsNa1hzuyP2cxvOPau8PrZddPVoUTG9PE6yMf9dqan77LMRT6Q2u+ZAEoj6fjwdoAIsLKvXcpnSD6GvQdBTt72Mr15TKiJHxtMieut2N0UQrhXI8EgCr7jEkMjjh+h8bad7/sHw6Q3npmHJD08n+Z8tBAKQSIPeRSnkw04W8OavTPUjwV4EbYsYE0+9mqAuoi8IWYFsQe9QWF6peal8wT66XJnU4dTXoJ3ZmbUl2paxITHwVHtAlNBi+uYK01mbSXaR/i84obd1qmkHyTIghYm00ivaxZd4Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAhQs5SOoeSo5w2/hlu4hN6HHLLtKCEB0viZpsICEq4=;
 b=Lc1Rh8Pl4YwmWxpC4CuIrPSb16NfXQmjgvT0UzRtrs6/IiYCrgGSJ6KvcHUbXUQnr1wV4Lz14ukMg1jOHFH9eWBfC4I/Zr8IW2KiBxu1ZDGFblarhacwRqS32uXgqxOp7Rg7bEChbQZJgdtMiCUgozpBBkmg/OEA7pRtpkFCReGLIwOpAVW+FlZMCgp+4Dj/J3nDwT/dd88OXb4LB40chtYHeEjpgoIatqEHyC61pJLbpSRKcXcImmqJ4Dru/YDjI8YTuYyKJ2KwIG5WG9u9Jt53iiVI0+H63NMXD4EjefAohZB7DOWBBx4ibda7V4bBvIN5p1KbzTYIbRPd73k7VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR04FT017.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::4b) by
 VI1EUR04HT186.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::178)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sat, 4 Apr
 2020 05:43:44 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0e::4f) by VI1EUR04FT017.mail.protection.outlook.com
 (2a01:111:e400:7e0e::228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Sat, 4 Apr 2020 05:43:44 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B78D533E6C9E3A781302322884C192D04BD8B1C3524EFEE5E8A1548C5358CAA4;UpperCasedChecksum:AD363FD65D7838F0D6BAA133553B9D7BFD661D951DA249825FA57A23B81946B0;SizeAsReceived:9148;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Sat, 4 Apr 2020
 05:43:44 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB517026CDE64EC57DE37C6080E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjqNnpsBJR1xM_Ce91cNh=24CDt6ibpL2G=vDUbSFGR8g@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB517004C9D4F4E39816E926D9E4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sat, 4 Apr 2020 07:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wjqNnpsBJR1xM_Ce91cNh=24CDt6ibpL2G=vDUbSFGR8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR08CA0044.eurprd08.prod.outlook.com
 (2603:10a6:205:2::15) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <1a0716c1-a00b-e249-1b57-54353fc631d6@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM4PR08CA0044.eurprd08.prod.outlook.com (2603:10a6:205:2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Sat, 4 Apr 2020 05:43:43 +0000
X-Microsoft-Original-Message-ID: <1a0716c1-a00b-e249-1b57-54353fc631d6@hotmail.de>
X-TMN:  [7l4d1z8CT8u2JYeooQGXqocQLXbUSFpu]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 9305ce99-5bf2-4d96-622f-08d7d85b230e
X-MS-TrafficTypeDiagnostic: VI1EUR04HT186:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XvQnBSMf+RAW/R1OWta48cfFM8hYRn0kbIBHlbpLPYLckvjapXEoplkP3mCNrrrEwO1UpkF5q3h/q9rzsbwHTvo2ZEOhAeU5rWv1Q2jUQyiLEv0GU0gKG8JJ6NtOiSxaY1dxb52rr2SrIYKuVoy4ZO9vmzPkgF1442hxFzbfj2uCzk0583qY5dG1pGM6wHRR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: HZRMo2wpuv//7yH4aTOARQ2OIrUg76+XeSHGJZrBtGpLGfVN1NjUdtrlHCu3myhCHSRbfBNsZNFukiqslDb+oN3S+pjWK6atWr78hOqGmFiIIq1calJwEwuoQbbGNSCsIJKS95ckiy17a4iIraOwaw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9305ce99-5bf2-4d96-622f-08d7d85b230e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2020 05:43:44.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT186
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 6:23 PM, Linus Torvalds wrote:
> On Fri, Apr 3, 2020 at 8:09 AM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>
>> On 4/2/20 9:04 PM, Linus Torvalds wrote:
>>> In fact, then you could drop the
>>>
>>>                         mutex_unlock(&tsk->signal->exec_update_mutex);
>>>
>>> in the error case of exec_mmap(), because now the error handling in
>>> free_bprm() would do the cleanup automatically.
>>>
>>
>> The error handling is sometimes called when the exec_update_mutex is
>> not taken, in fact even de_thread not called.
> 
> But that's the whole point of the flag. Make the flag be about "do I
> hold the mutex", and then the error handling does the right thing
> regardless.
> 
>> Can you say how you would suggest that to be done?
> 
> I think the easiest thing to do to explain is to just write the patch.
> 
> This is entirely untested, but see what the difference is? I make the
> flag be about exactly where I take the lock, not about some "I have
> called exec_mmap".
> 
> Which means that now exec_mmap() doesn't even need to unlock it in the
> error case, because the unlocking will happen properly in the
> bprm_exit regardless.
> 
> This makes that unconditional unlocking logic much more obvious.
> 
> That said, Eric says he can make it all properly static so that it
> doesn't need that kind of dynamic "if (x) unlock()" logic at all,
> which is much better.
> 
> So this patch is not for consumption, it's purely for "look, something
> like this"
> 


Just one suggestion, in general It would feel pretty much okay if you
like to improve the naming, and the consistency in any of my patches.

> @@ -1067,7 +1069,6 @@ static int exec_mmap(struct mm_struct *mm)
>  		down_read(&old_mm->mmap_sem);
>  		if (unlikely(old_mm->core_state)) {
>  			up_read(&old_mm->mmap_sem);
> -			mutex_unlock(&tsk->signal->exec_update_mutex);

I was trying to replicate the behavior of prepare_bprm_creds
which also unlocks the mutex in the error case, therefore it felt
okay to unlock the mutex here, but it will work either way.

I should further note, that the mutex would be locked if this
error exit is taken, and unlocked if this error happens:

        ret = mutex_lock_killable(&tsk->signal->exec_update_mutex);
        if (ret)
                return ret;

so at least the function comment I introduced above should be updated:
 * Maps the mm_struct mm into the current task struct.
 * On success, this function returns with the mutex
 * exec_update_mutex locked.


>  		put_binfmt(fmt);
> -		if (retval < 0 && bprm->called_exec_mmap) {
> +		if (retval < 0 && !bprm->mm) {

Using bprm->mm like this feels like a hack to me.  It works here,
but nowhere else.  Therefore I changed this line.

Using !bprm->mm in the error handling code made Eric's patch fail.


Thanks
Bernd.


>               Linus
> 
