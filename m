Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52C6C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC2F2223D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oIsxMzbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgDQSwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:52:38 -0400
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:6160
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727840AbgDQSwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:52:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU2ga4vbs/aijmnu59bqYns5XBXThfairKiOqdbapnalt3abqYXfWOCFrIci/JlEe49AcZIN7Zh0KjdhDSyjHme6q6K7M/fWH+ew73SfnWxX6Lfw/qIOTjWFOjo6QME5G5+/RwT4ouPlKv1SS5Jt8y4cy0RBLbVa8zMH4H68CZtGtxC+mQn8z1g5iA7aR/6bXxlA2H5VINUAy5Lcv+JZrRKPUl+/WYaUZixQvuAMQWRlPMYxskH6UfE9x2+DNGlbfLYdgfijQrzgafKW2EWD0Qjg6GA4b4DNS8vFnHdSCkPLOGLzRL/aR0TEJFA9KwJQVj0+zu3xwVhLsdl5uD7bVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNn4oIxUx4+Kil5Tegoho2MjFXI7IdrkhSZzPqFY+8M=;
 b=AK8lie2oBfjRVYx7qXH7+mby+MvBMiCxHsOZZYJ0o32XYMgMt5duieK79lXRDhzBpWLTPqXPG0qCuUo5ZiCyDZmCPBwrsPEhfLZyhmp4VWOKP72HU0mvRLA+MMV4k4+kYCKBwL5LyO5jrAUQinzncae/t5zuHc5ME9NbWSWLrVddsvQ66LbdtLDi6mF5Fz1SAAYcJW9zhJhWrohNFGdYRDjDq7PepiKKKfNVJRjXCmoH/f2/ixRYNJtzvd1rsJQPHj+HFR3S+6umW9RWDokYx1w0BpJIfb1MOQ6yhY/8XKhvT1GmBtb7zx8wBhV5665ZL6nlBRnV3+hbnKf2e0/XJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNn4oIxUx4+Kil5Tegoho2MjFXI7IdrkhSZzPqFY+8M=;
 b=oIsxMzbFST7ykM743lmesdFQPXdxgwX1fHo4eGYq4qQvslkM5AuQI90IUxkpTg1zFr2s40BX5szg8uS5bu3Xm+/XG9GKH/y4jK2YVMC69JI19nHp4jxvJeZkvWAanjOlrjrMMKyqG8oVBrN0lTFE/3FoQm/pHSida5HS9RYSIDE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB2650.namprd12.prod.outlook.com (2603:10b6:5:4a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 18:52:19 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 18:52:19 +0000
Subject: Re: checkpatch.pl warning for "return" with value
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <a1eea414-2422-3a9f-b9bb-1ab7d6113dd6@amd.com>
 <1a47c5c428968a0e1d0ac5b92ce7ebdd4014fd38.camel@perches.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <8859753b-c7c9-78ec-20cc-ce424b436b13@amd.com>
Date:   Fri, 17 Apr 2020 14:52:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1a47c5c428968a0e1d0ac5b92ce7ebdd4014fd38.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::16) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.131.176) by YTOPR0101CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 18:52:18 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2e805cc-7926-469b-9548-08d7e3007468
X-MS-TrafficTypeDiagnostic: DM6PR12MB2650:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2650D3DF06599394D704D97E99D90@DM6PR12MB2650.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(86362001)(31686004)(31696002)(36756003)(81156014)(8676002)(8936002)(66556008)(26005)(6506007)(66946007)(53546011)(52116002)(66476007)(55236004)(110136005)(2906002)(316002)(5660300002)(956004)(2616005)(44832011)(6512007)(4326008)(186003)(16526019)(478600001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0VESOrhmd6g+FiTWD4Dm9nLygGO15NjFtoI0JbZK+YfOml/9Tl5dslOYNyBdUY5wDR5zL5aSXjhtr6VnK54v0Io+31wwA1VH648bNFWkn4o+e0mofVsJLVua3/hABAz5sEoXnhbd98JtYAU7i9QFLWTGn5rnmCLfqepKyC42JNGDF+eaGGkB2WbF26pF0YPVW27cm9QWSWI/15WUW56fQmVVWnGUCGyUi+5VIpuiRKiSiBBNOJmv8b+B8EG9INbkdSoQfheKK1lmg/243d+0pKvGHUcVCKgDizxJF/pkmXnulwJH8TP3krINU/wKN5uEgt7FKDvpvxcb6HvA6wsCwB0Cb+y02K3tgI0zj/FdE3fi6+s1HmWZ6uzUT5eTVJS/qOU4ldvExBPGII1ihY8LkzBN1VeOlS0gxuQbwPv+ijvWJTFZ5WmFPEAC9tTDNH6
X-MS-Exchange-AntiSpam-MessageData: sYw9rPKzYQL+gKyLAzP4Q9Ayy0c1Z6MklcH/c3t785OZpTS8G9z4znWpMi3mq0BjLGlFxr2l3xcL7dtYJp+KT6NvC9IqTHVM+xU4YUfjNef+XaoIuYB/EbROAwi740SH+5O8EtDIW3pn2x8ymcX3xO1uycpec/nxCie2NI+/sBFNtesq9h8mw9Cl6xnMHfSDo4yHnJh/2Rhaatk/4Q8y18lfgvCaNhgnI+7/l7l2QqUT1TGsDGZXZaGRyE+yQK9qrCgnKF+IJXv7zxO4Sn+10CsXuBq4dQv+iJVYC3OfLfvIm9XGftDtKS3ftFY4Lf7UYLIjvwUQICne+Lnf4MFZXJJ56RAFL6QhvpcC92bmiMFpfJdf3yOyPcECwUX3ZLqN0EheOZ7mB2zi8ejmSrUZE1jxU9IohF40RUvbz65MIM9GwfzPEDCsNM122e+UvDT48qKD92q3R5+ZjtHASBJN6g4/yXY8Nhbb77pfkgq1pBP2rcQBV6f7Jl7ixg5sbXhVVHeSZY8OZpoWM7r6mwirDD5O2brHZd27Hwra+jd5ctBSbkx46j7sKuTBJ6dJzAdJHKQUSqCLCXdNiZc9c3IeHzrvgR1kUMcxntzCnAePM5S8x0aD9TgENlIP/ngVkUGhkNqgmRCIwjjrQvTk/RjjV8kLXcUROsEUz/41+K51strJS+oX7l961WotSC/YKRW1hARmYNIx6sKUhrhcZ4rd+zVAp1MWTQqfs3cAs85dUyUxFJ5pNzvKMrGwsVDYRihULFXdZVnWGklSsFjMMaO0mSXgOR+wbvCJYxspCANUZCYMIqskMG9A7fexSxO0x3lb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e805cc-7926-469b-9548-08d7e3007468
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 18:52:19.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44U7vEJE5MMORdJmUcIMLi8CdfnJIqWBiNU2VbFPnty+81Yt5KLbn+/RrDrGIsBi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2650
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-17 1:32 p.m., Joe Perches wrote:
> On Fri, 2020-04-17 at 13:20 -0400, Luben Tuikov wrote:
>> Hi guys,
>>
>> I get this warning:
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
>> It seems like a false positive--I mean, if the else branch was
>> taken, we'd return a different result.
> 
> There is an existing checkpatch exception for single line
> if/else returns
> like:
> 
> 	if (foo)
> 		return bar;
> 	else
> 		return baz;
> 
> because that's a pretty common code style.

Yes, that's true--and that's what I have above, except
the braces.

> 
> But I personally don't think that your example fits the
> same style.

Why? Linguistically, it doesn't matter if a compound
statement is used or a single one. (I mean, one could
use a comma "," too... :-) )

> 
> I think when unexpected condition should be separated from
> the expected condition which should typically be the last
> block of a function like:

I couldn't understand this sentence because of the "when"
and "which".

> 
> 
> 	if (<atypical_condition>) {
> 		...;
> 		return <atypical_result>;
> 	}
> 
> 	...;
> 	return <typical_result>;
> }
> 
> If you want to code it, and it works, go ahead, but I
> won't attempt it because I think it's not appropriate.

For error checking, when the 2nd ellipsis is
a long, long body of the function, so that the error
checking is done at the top, then long body,
then at the bottom we return some computed value.
But in the case I have above, it's a compact if-else
at the bottom of the function.

In the example I gave above, there is no "typical" or
"atypical" condition--it's just checking a condition
and deciding what to do, all at the bottom of
a function. (And that condition, samples
an external stimuli, which cannot be predicted.)

Also checking and returning from a function, doesn't
always have to be binary. It could be,

	if (A) {
		...;
		return X;
	} else if (B) {
		...;
		return Y;
	} else {
		...;
		return Z;
	}
}

And interestingly, checkpatch.pl doesn't complain for
the triplet above. But if I remove condition B, above,
it does complain.

Since we're returning a different result and since
it works fine with a triplet, could you fix the binary
case above to not complain?

You already seem to have an exception for it, as you stated
above.

Regards,
Luben

