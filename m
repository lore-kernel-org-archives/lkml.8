Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E572C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7ED20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="YClEZYoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgBDHoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:44:06 -0500
Received: from mail-eopbgr70095.outbound.protection.outlook.com ([40.107.7.95]:18126
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726566AbgBDHoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:44:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLjYXduR8aMwbr/Gu9sYII9a7EAj4fsaVBx/ppax5by5TJtVyAiygbTAvYj8l+2B31vBDye6Zm8l772aDiV6f7Q1zk0dkA1yw1SQjXilJDO4lfN0sTwgr3S2NJHo5hOLw7byZLGWLN4mGaVKDVwTT/04UW2nQyzbiFhBVy7iDCBa75nvT8V4zWGBv27aehG8n3rGie6Nz8Unw3nHAyqPLjHzne3xkIcL/+M/fKMAFjF6dF7OQukuwv9GjajZjoQGpXQhvGX0ngnLa0QF7rI5t60uR9DkemK1/5BxMy8BBsgIIwXNSLMWIDyTIOcLniMSTLg7wZjq7c5idt3f7uzANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCiQnU5/fgCQHJSkmeTJdNlSMVxPByFWw1aIs18BNI4=;
 b=eAIv+VaxtvK03fr7nHMlJv6r9mQP8o2Q+VF+qFdl04usyYA2i/8lMOGczgx8dxmlgdMfXKu74rMC/FFJGKGRS13k+Yoeu8i6dZerwkexpaXH+f0hWseLWgv+mc/RNBO8Yv8/grgb3Xy3Aim1HvK9LtbQ895tOkK1ephpNkUZ700Qy1eSA6AMdswRnpR6VkpnGFRpWepEaDYOUODrhv0IzoUBqhoJ2sVVvYNYEgKMzz5NZIyRdcJ5ZVcvaL++5uEKIOM6/aecWrfpx1ZE7IhPULwlimEnjrKJgP8kxEGVaE08niJ/K5tttw76tKEry0mU+r3tdNNC+q+Q3pIwALWZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCiQnU5/fgCQHJSkmeTJdNlSMVxPByFWw1aIs18BNI4=;
 b=YClEZYoMQ4t0kptoIOvScnWQ9ccI6OVB13cPHECgEWJCts6fOncvNjDiTMIDplXC/5Z2+aiXDgrjXe6SfUN8dvcMsx9X8YaGm4+P+/PJNGvZIPo6CmRDJlW0CRyMQURwbVR67YDsSnD9WHpy0EJNP0jR1gjKVJ2MvR3azmTr4bU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=matija.glavinic-pecotic.ext@nokia.com; 
Received: from VI1PR07MB6048.eurprd07.prod.outlook.com (20.178.123.204) by
 VI1PR07MB3296.eurprd07.prod.outlook.com (10.175.244.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.18; Tue, 4 Feb 2020 07:44:02 +0000
Received: from VI1PR07MB6048.eurprd07.prod.outlook.com
 ([fe80::dd1:76b6:26ca:e2e8]) by VI1PR07MB6048.eurprd07.prod.outlook.com
 ([fe80::dd1:76b6:26ca:e2e8%6]) with mapi id 15.20.2707.018; Tue, 4 Feb 2020
 07:44:02 +0000
Subject: Re: [PATCH RESEND] cpu/hotplug: Wait for cpu_hotplug to be enabled in
 cpu_up/down
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <d950a169-941e-7caa-608a-df97a127c95d@nokia.com>
 <87o8uf1r3w.fsf@nanos.tec.linutronix.de>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Message-ID: <77570af6-733a-58e7-6975-b533a42daa4c@nokia.com>
Date:   Tue, 4 Feb 2020 08:43:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
In-Reply-To: <87o8uf1r3w.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0502CA0007.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::17) To VI1PR07MB6048.eurprd07.prod.outlook.com
 (2603:10a6:803:d7::12)
MIME-Version: 1.0
Received: from [172.30.9.6] (131.228.32.166) by HE1PR0502CA0007.eurprd05.prod.outlook.com (2603:10a6:3:e3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.2686.32 via Frontend Transport; Tue, 4 Feb 2020 07:44:01 +0000
X-Originating-IP: [131.228.32.166]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a92eb17d-20ad-4abf-1b71-08d7a94600ac
X-MS-TrafficTypeDiagnostic: VI1PR07MB3296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB32964FF2323833C6447FB993FF030@VI1PR07MB3296.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03030B9493
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(6666004)(66946007)(66556008)(66476007)(86362001)(8936002)(81166006)(956004)(966005)(31696002)(81156014)(2616005)(16526019)(5660300002)(8676002)(186003)(31686004)(26005)(53546011)(6486002)(316002)(2906002)(52116002)(478600001)(107886003)(16576012)(4326008)(36756003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB3296;H:VI1PR07MB6048.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIAiWZfuzfVO82Cvyn/Q15ZM3PPVyyv8SEBE0fJUfyc9JZAyskkWR0RQZsvwZ97ovrx15/8noDBdV5ErcGX/Pi07Ze+2I8YV+c3wLGHUOXIwir3Z7dMhtQbK6bE1OC3r/4Ps2puL/+E/9JQYGeYI2qOCO2EYyy3Xlu/Vkgz6Tei4FAoT+VxYgMnVD9KIV4J8GcAsyR15mKAhwIzuxhGFodCblmDGYzsWyTcTMcE8Rg/a6yoGCxVX22FV7WagAQTWjW5jgPIhkEtO4SBUp6qwhVy5MQfXpI8nBB7Pj7H4uK6PZW7oELh/YcQ8cL/rqSJuyoAplWZEmokXeMNRsxje2UXUiHJaCBxKledsk+6DtHI5OZbOGRIi2VhQMMUmrNsWIaOpYrh5SRVKlHQ35fiBUu9Dd6C7gpJO3zegj9eq9aMhaiObZqCJF+O8Mgp6cT48bn27mLw19PAZp5DMz0EsdTOMpvM0Sil3Veqn3xqZMbs6KSOsupOwWWwTRFLeU4nrCHL78AidGJEs2zM+wgZ6lQ==
X-MS-Exchange-AntiSpam-MessageData: RJjn6imIGLTPhREPr4r8k5g+Vv3YY1ZIGLkvOQmC+eKHPOxB2VYK41Z8O/rPN1z7qVjbNNpbkIGHNZhrcb79bf10Iy6rhyFCo6WTiWQY6KQXeaLiJ3WzDEorhM2lKoDVruMkVgT8KsQFr9ZsfOz1VQ==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92eb17d-20ad-4abf-1b71-08d7a94600ac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2020 07:44:02.2537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X8SGTVVOYuk4AcWmbY8IGc2X87V98Y0tLeN7lCTviy94O+KZQAgVTzQ/1tnGoBuCnVlqGl3yTtjCyY2XJzvI1YEDbWHrYG4mr/sXPfiqUAp2XK5hfrrFS7b9jEOARBW7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 02/03/2020 07:08 PM, Thomas Gleixner wrote:
> So what?. User space has to handle -EBUSY properly and it was possible
> even before that PCI commit that the online/offline operation request
> returned -EBUSY.

> What's confusing about a EBUSY return code? It's pretty universaly used
> in situations where a facility is temporarily busy. If it's not
> sufficiently documented, why EBUSY can be returned and what that means,
> then this needs to be improved.

It is true this was happening before your work in the pci subsystem, I 
should've referenced original commit which made cpu_up/down returning 
EBUSY, I agree there is nothing to fix in your patch.

EBUSY existing and being commonly used doesnt justify it in every 
situation. We do not have problem only in userspace, but kernel as well, 
no user of cpu_up/down takes into account of possible temporal 
unavailability. Going into extreme, we could start returning EBUSY 
whenever we have resource/facility taken which would made every 
interface candidate for returning it. As I see it, EBUSY has its place 
in nonblocking APIs. Others should try (hard) not to return it. Handling 
it is further topic of its own. How large the timeout to quit? Let's say 
that we know that for cpu, it is 10 seconds which I proposed. Passing 
responsibility to select tmo to the users will spread out that policy to 
each subsystem of its own, yielding to situations where it will for 
someone work, for others not, depending on the tmo chosen.

These kind of waits I do not prefer, but I wasnt able to think of 
anything better to try to improve this situation. I still believe it 
should be improved, and once/if cpu hotplug will be able to remove 
cpu_hotplug_enable/disable, remove it.

> I have no idea why you need to offline/online CPUs to partition a
> system. There are surely more sensible ways to do that, but that's not
> part of this discussion.

I'd be happy to make it part.

We are using partrt from 
https://github.com/OpenEneaLinux/rt-tools/tree/master/partrt, 
cpu_up/down is part of it, AFAIK, it is there to force timer migration 
and doesnt have any other (known to me) usage. In the meantime since we 
started with core isolation, we changed how we treat isolated cores. We 
are now starting with isolcpus=cpu-list nohz_full=cpu-list 
rcu_nocbs=cpu-list, and we are atm at Linux 4.19. Earlier we had 
different setup where we wanted to use cores in the startup, partition 
later, however that showed to be problematic and not in line with how 
things are going in the area.

Do you think we do not need toggle them under these conditions?

Thanks,

Matija
