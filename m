Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E047A20656
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mQ2VxRzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgDQUoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:44:10 -0400
Received: from mail-dm6nam10on2062.outbound.protection.outlook.com ([40.107.93.62]:6082
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbgDQUoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGoIUJ2gh3zINCgpsDWOE2W9jqVnzkPHKdKlYsCLmHOEy0vv+ajh6rPFQ+pgb6TCZb+YksyiyxiZKT0aIy3QVPSLEmjiw5CpII9Pd6opzr4l6AfIvkeEg7mxPnQIYC/fCc38QF8QCjMAX1/DpSXcMKM+p2sg78o+5rIdi00W5df9Mi1uH5rYgCn42T6OBsvGr1ms5xmrjFrXFAt8TRRiT7M8JGMLYW/vqpYNM5eJ4MnizkwJZFENvtArSltQkz0Jv/KbEej/d5srZPL++RoFOtAmvs8+QzM4oe2PoAlRvyFq58F1v2eVSSLNCFcvJcQevEZqz7i8mZnCbMHQRll6vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lhpW8vUXDKVW52p+Hw216uDrfRqCnOqea1D3MldTkI=;
 b=fl4Psu4FRvMYIY8T1S7qnqjq1kzFWFK3QIolDNsc7XCvktNW3cyWJN/oK7PGAZ7QSD93sBHNi2jAt6eXAl0CTol01lbXSIT7aK8Rhy+UYrdB6gtj9/rrGH5lsEtrlB6TD0NRyXS40zd2dvLDmHGbaaTeBOXbZ6TU8l0prSTBsUtAJM7TUNlzuGC3OvAI4QSOif1vsJvs7R/yRgx2MLkTfkLbyrZ8un8sv9swqPij34pfa0gCAnFoyGgVwOVyt3rXeiTYeYv1fyjBddwxxfyL+Uug5tkbrI4ZyX9Um/5Atn1iWW4giOBxt1FIgBqX4atVN3TspSis0wikVasifHtvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lhpW8vUXDKVW52p+Hw216uDrfRqCnOqea1D3MldTkI=;
 b=mQ2VxRzCH09WUUVRWjmseUY7ny142l6ZEQ4JElWXcFVUyRx/w4hJ+zL+D7EjJdNGpfpD7/aT7gt/OSzTyBIErsWpnk+OqOncTCxe9y64lhKugJeWWJ/pJlm3x42Y4ojKTXYd8puO/ni6i9KoqNQhka2iunnVICqT0zZDWYarIgE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 20:44:04 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 20:44:04 +0000
Subject: Re: checkpatch.pl: WARNING: else is not generally useful after a
 break or return
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <064ada88-9fa3-6f6d-967c-00d4e2d325ae@amd.com>
 <51793346cd065247886af6d54c32691e94c9b843.camel@perches.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <54cef727-b637-a738-3c5a-a25d36b9fae5@amd.com>
Date:   Fri, 17 Apr 2020 16:44:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <51793346cd065247886af6d54c32691e94c9b843.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::30) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.131.176) by YTXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 20:44:04 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e944d53-422c-45b5-c055-08d7e3101160
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37700C126F95A2BF9C53A6DE99D90@DM6PR12MB3770.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(8936002)(81156014)(5660300002)(8676002)(478600001)(6512007)(6486002)(110136005)(2906002)(36756003)(316002)(956004)(2616005)(26005)(53546011)(6506007)(55236004)(66946007)(66476007)(31696002)(66556008)(186003)(16526019)(31686004)(52116002)(86362001)(44832011);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GAhBjC+zFDus4AB9uq+9UvMSKRCvnILwE1vfmgVwI32oQ6CNbAneMZkHg3J1idXvio+ed5n0z0/kIHRGdCpGFuHfUsniqeD6dXZgqKsrbUkR/khU9AILn/BLvARmZtQvkC8/Lbv69xKzvlaiK/GVmuehw61fLKPMDKc4Sj5quVN/81eXUpIBY/l5TfpW/CJ9Y/EuBjGVHlLL7KU/th1usbNcIaTfazzIOMqneaHvMDhbbzj2KqXUoaQOFc7VP0TDosM8N+gyXCdfqFsUzhS8F56ypbeYgizGEOOw698kUwrOnUXoA2BtF/xv7eG6YytYdPpP6zUSx3DZ6+rYcfwVkrEr6u7SDHyxi0pp2x8jFw6it9QgZVHsXnYxuP6x8J1HJ+IceDEYSyHx9BQRZrX1aFXztdMtTWsSEfgX4EvhZ2hNF2hj/Xq+7KbSDwJDktv
X-MS-Exchange-AntiSpam-MessageData: XwPgk79wGYJxu/4Ktrkiftf23H/HqIVs6MVM4XtUMi6bBdGelPKptETpFTGv1L7JlpIWlJ4ip74QyhaAyVcsAY7C9bCLdzeCXLC03Or/RFpm5QSsKE+8gM1aKJd1P65sfQkNuanJZWZagNm7YwqjEqDxdUQ5yKKnZwPl3IIDXJBneP4lLB5ZYBwDK0ydETj85matvUexlXy7ZqX9TEx4xn8/79yUpqdD+LXAwFtRegzBv8xugEUvmEs9d6tz43+HrdPYJrha40k4DjdOO21Pv1ePLUYtjNJGrRKPz5xXDE3VjXiUHe5+62MzOfquDVyXMYo8Vo7UHSUE+2IsSIe+QLN/9LEAqJvFIBJDUICFxUPCuMWtViWF10dZU6KyFgJABQgQnNXH5C9QfCEf+YS7ikRCyDY+Buu8lTJqzZEmy0so2GyGAR9SNh2YpCaLcpdpY8OBkP3YYCZ9z4uucCftqXvnWzlvC9y4qNNHxVVSiYKPJYrUlEDHxnLVoZP5dCh3ATVf/D8affxVmuMLiaVhWQsb4GrSfCV/RlKJk/D9DczJ6whOJ2ktxAFhjkBihufzktJtIMHyP7rkFJXrCFXiIgBxTDVJZcoYZlbjj4tr6o+Hcxa2X+486HRKEkkrVe7x190Xx1QghI83p9RTQWy8fXEfOeud7o2E5W21vqHNLJ+FUzO9D5CaoEqCBn0luKW4xj1rU4BfOJJI/Xq3ZUWYeYWbkh9PZyb2c3undZcJvOeENulQcCRkVW94J5OinaA71GUxWXR9IZQvAQbp/8y8+XSnOm6OCEQhroJzcS8fM3+C/elbNT58wzUV33OmcSjD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e944d53-422c-45b5-c055-08d7e3101160
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 20:44:04.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tf4vbEaPGxEWi7W6nT7zOV2ysJwphyUQFNnOmUSPVgj/qOyRY/KscmPwlzF+2gXq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-17 3:56 p.m., Joe Perches wrote:
> On Fri, 2020-04-17 at 15:20 -0400, Luben Tuikov wrote:
>> Hi,
>>
>> I'm getting what seems to be a false positive in this case:
>>
>> :32: WARNING: else is not generally useful after a break or return
>> #32: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:55:
>> +		return 0;
>> +	} else {
>>
>> for the following code, at the bottom of a function:
>>
>> 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
>> 		amdgpu_device_gpu_recover(ring->adev, job);
>> 		return 0;
>> 	} else {
>> 		drm_sched_suspend_timeout(&ring->sched);
>> 		return 1;
>> 	}
>> }
>>
>> Which seems to be coming from commit:
>>
>> commit 032a4c0f9a77ce565355c6e191553e853ba66f09
>> Author: Joe Perches <joe@perches.com>
>> Date:   Wed Aug 6 16:10:29 2014 -0700
>>
>>     checkpatch: warn on unnecessary else after return or break
>>     
>>     Using an else following a break or return can unnecessarily indent code
>>     blocks.
>>     
>>     ie:
>>             for (i = 0; i < 100; i++) {
>>                     int foo = bar();
>>                     if (foo < 1)
>>                             break;
>>                     else
>>                             usleep(1);
>>             }
>>     
>>     is generally better written as:
>>     
>>             for (i = 0; i < 100; i++) {
>>                     int foo = bar();
>>                     if (foo < 1)
>>                             break;
>>                     usleep(1);
>>             }
>>     
>>     Warn when a bare else statement is preceded by a break or return
>>     indented 1 tab more than the else.
>>     
>>     Signed-off-by: Joe Perches <joe@perches.com>
>>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>>
>> While I agree with what the commit is trying to do,
>> it doesn't seem to apply to the if-else statement which I quoted
>> above. That is, the "else" is not "bare"--to use the lingo of
>> the commit.
>>
>> I suggest that no warning is issued when the "else" is a compound
>> statement, as shown in my example at the top of this email.
>>
>> It is only natural to write:
>>
>> 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
>> 		amdgpu_device_gpu_recover(ring->adev, job);
>> 		return 0;
>> 	} else {
>> 		drm_sched_suspend_timeout(&ring->sched);
>> 		return 1;
>> 	}
>> }
>>
>> instead of,
>>
>> 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
>> 		amdgpu_device_gpu_recover(ring->adev, job);
>> 		return 0;
>> 	}
>> 	drm_sched_suspend_timeout(&ring->sched);
>> 	return 1;
>> }
> 
> This is continuing an email thread sent privately to Andy and me.

To which you replied to the list and snipped some portions.
In this thread, I include your commit which shows the intention
of the check, and add more clarification as to what the problem is,
with more examples, including your example from your commit message.

> I disagree and do not believe this should be implemented in
> checkpatch as an accepted typical coding style.

So you'd force everyone to write:

	if (amdgpu_device_should_recover_gpu(ring->adev)) {
		amdgpu_device_gpu_recover(ring->adev, job);
		return 0;
	}
	drm_sched_suspend_timeout(&ring->sched);
	return 1;
}

Instead of the more natural,

	if (amdgpu_device_should_recover_gpu(ring->adev)) {
		amdgpu_device_gpu_recover(ring->adev, job);
		return 0;
	} else {
		drm_sched_suspend_timeout(&ring->sched);
		return 1;
	}
}

I believe that checkpatch.pl shouldn't force to break
up a natural if-else as shown immediately above, but
allow a user to use that type of expression.

The intention of the original commit is fine, and it gave
an example of what it is trying to fix, with an example
in the commit message, but it gives a false-positive
for the code snippet above. All I'm asking is for this
particular scenario to be fixed in checkpatch.pl,
so that people could write, at the bottom of a function:

	if (cond_A) {
		do_A();
		return 0;
	} else {
		do_B();
		return 1;
	}
}

instead of the more obscure (forced by current checkpatch.pl),

	if (cond_A) {
		do_A();
		return 0;
	}
	do_B();
	return 1;
}

In your commit message example, you have a jump statement,
"break", in one path, and a non-jump statement in the other:

    if (X)                  if (X)
        break;                  break;
    else           ===>     usleep();
        usleep();

However, in the false-positive example, both paths
have a return with a value:

	if (X) {
		do_X();
		return 0;
	} else {
		do_Y();
		return 1;
	}

Which is slightly more complex than the "break; else" example
given in the commit message of the original commit, and shouldn't
generate a "WARNING".

You cannot blindly apply
	If "return" followed by "else", then WARNING.
rule. It is slightly more complicated than that.

> btw:
> 
> Even in your example, amdgpu_device_gpu_recover has a return
> value, can fail, and likely should not just return 0.

Joe, that's work in progress. How do you know if amdgpu_device_gpu_recover()
wasn't modified to void?

Regards,
Luben
