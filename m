Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28E5C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 04:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06812051A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 04:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgDDEXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 00:23:46 -0400
Received: from mail-vi1eur05olkn2087.outbound.protection.outlook.com ([40.92.90.87]:22656
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgDDEXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 00:23:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+vpqtVPwyNtXYBzufi0E7ChqjBHeS+DS20uPY4GMitrZcKdOgSeut0WgrZvAI04ZhdSYUTAyjbwAkCrYD8ZPZMo91UYp4Hcdn0Q8f+h/q8PShiKEK/zyGHn/XKhlyW5LfhxjlNWTecrcv4GIxlLevuWnTIWoutxm06xCK9YwAPctUUiDtuckRo0yNJCY05lecZ1QGUnWuUAkLQ5ZhDxhf2sz3zhEqkTnIO6ZC72sZqFfFUW5xDJvLT8TOMHmw3tm9jyH8OS+3xW+DGvTHWnFTWcOPB88zJZlqMdNZ5OolaZD3fYnza+u9pfcJ198iq7h48YfyO9AC1czSx7cJvL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/B7bBW62Yy7RGHjVgMPiK/4wu2Jz4njwuzLNXRAnbU=;
 b=VOTM2Dl2ggWpLSGDD/KwXCwWmJxHGDL6GGc97Gdr4q7ATGcJvIGfiU58weG22C8/h9XevSG5er7T4FlX7qlgUYWq8YkHEKPyS8Til4v8J2m3e7mcWRgHrFKPk1H31AClOAirrckWG6ybSEXKAplG1sU+ynM5qC44B6lNVs1zJVD59zDuN1dlC5UDE2S4wIWpzmwr6EhwuRjX28xRtqAnX8MvF1jEDfcCZdmXzrTOu66xy7FsoToF4aF77RULR5Krqr5EwltPooWpRrGVluxRvrhcJBQCtKjFfsurw7YTn892QCT5br8SFjLJOlqNdCsYC83goHsobRjL5x5jN4gvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM6EUR05FT048.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::4b) by
 AM6EUR05HT080.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::350)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sat, 4 Apr
 2020 04:23:43 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc11::4f) by AM6EUR05FT048.mail.protection.outlook.com
 (2a01:111:e400:fc11::479) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Sat, 4 Apr 2020 04:23:43 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F15397E0514B636DBCB681A702D7457FB562C419986805F194CE3DEACE553067;UpperCasedChecksum:1ABFA233ABD3EDD0FA7306DD1C4FCE748CE0A94D072FCB10DE2AD4B967EA8F42;SizeAsReceived:9676;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Sat, 4 Apr 2020
 04:23:43 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
 <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170EEAA3FC61C1F390C0ED2E4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sat, 4 Apr 2020 06:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::33) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <ad0a6272-5413-6e63-b900-1a671fc8d2da@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM4P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Sat, 4 Apr 2020 04:23:42 +0000
X-Microsoft-Original-Message-ID: <ad0a6272-5413-6e63-b900-1a671fc8d2da@hotmail.de>
X-TMN:  [dpan+zE3EsgNZNhfBOkT8MrVxp+gJ/+b]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 7b852572-0ee8-4d09-2be6-08d7d84ff570
X-MS-TrafficTypeDiagnostic: AM6EUR05HT080:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cjwlscrRHPYKdwNJNONO6+a/RftYYt68Gx+gTv1eK/mZqkWmMVAU21R5CquDz3RxTMvCLbLWKHvA4Q4sSOSh95fVur7thHUUDq9oKY17dStr7hmh65Sbi4ysZH12KZJuxECcxeM6cz0MiLXewbnVaKDA35a7MOy3M4fBVE3VFI/TySBJKYFB0SMFaejxXxK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: YsIFmvyCXHzh3u04Apgd9qFEbMKyzhlNuidDA0TkTvmoTkZCCZkzbap8eSXwOlqmBe+XXRh1XsJgjF/Vjb0mozJVb/5xaZf9/pPsWLOyocEYERe4+3QFTUw2INy+W7Z5OpRgg4DqOQqXhbGM3nFofw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b852572-0ee8-4d09-2be6-08d7d84ff570
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2020 04:23:43.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/20 1:16 AM, Waiman Long wrote:
> On 4/3/20 4:59 PM, Linus Torvalds wrote:
>> On Fri, Apr 3, 2020 at 1:41 PM Waiman Long <longman@redhat.com> wrote:
>>> Another alternative is to add new functions like down_read_unfair() that
>>> perform unfair read locking for its callers. That will require less code
>>> change, but the calling functions have to make the right choice.
>> I'd prefer the static choice model - and I'd hide this in some
>> "task_cred_read_lock()" function anyway rather than have the users do
>> "mutex_lock_killable(&task->signal->cred_guard_mutex)" like they do
>> now.
>>
>> How nasty would it be to add the "upgrade" op? I took a quick look,
>> but that just made me go "Waiman would know" ;)
>>
>>              Linus
>>
> With static choice, you mean defined at init time. Right? In that case,
> you don't really need a special encapsulation function.
> 
> With upgrade, if there is only one reader, it is pretty straight
> forward. With more than one readers, it gets more complicated as we have
> to wait for other readers to unlock. We can spin for a certain period of
> time. After that, that reader can use the handoff mechanism by queuing
> itself in front the wait queue before releasing the read lock and go to
> sleep. That will make sure that it will get the lock once all the other
> readers exits. For an unfair rwsem, the writer cannot assert the handoff
> bit and so it shouldn't interfere with this upgrade process.
> 
> If there are multiple upgrade readers, only one can win the race. The
> others have to release the read lock and queue themselves as writers.
> Will that be acceptable?
> 

Someone pointer out prevoiosly I think
that with the real time linux
the rwmutex are just mutex and we
better not base our desing on that.

To me linux_rt is a must.

Thanks
Bernd.

> Cheers,
> Longman
> 
> 
> 
> Cheers,
> Longman
> 
