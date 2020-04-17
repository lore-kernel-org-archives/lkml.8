Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C293C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5ACB2078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HaSe/lW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgDQTVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:21:17 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:6219
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728192AbgDQTVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:21:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dyr7Nb+Jtj6cmeKn7SMl8i8PKO0R3INypxsJuPLQORYExEuqYKMDtdCJXQz/6Zsvd3hZPTOMbUwB/YX5DhvVB2BeWmiFLALa2AzOChKsGjADDepajltONpdS68Bb/xLj1AIbd3IIb7PyPk8WnP9jmX5IzikEDv3CNR/whRShUPiNCR1jDYXS+xVEL4Kak3P9dOSipC02BmJ2PeXPQUhmDH2mpr8pD3M14g/ygsa8nJACIrnG6wiccP1JzeDJuSYMnyBBA26FChE9ADN4pqaleUXHzbCpIr/AwA382b5d3QUmzJQhLhhfVg7Plc5S3kBOV3uAhMEy5iajf2KBNc60Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5TXQaAaUheBv4usEsw0bry48IJMs/rJpQrcBTJfjE0=;
 b=KoXyLjFgUriea/W/bXfJhkfjXv6ZgyDPpHZTXp4fMEPPuPqtb+YoMkTGhWvXFx/NKBIRh8Ln0rfSn9sUBiFh0/9FUEkdXGOcgWdB4btZfO9dzyh3AMLA4RFzNx3NRotI/Es/a1wS7VgZ0BljyOg9w6pDPD6CzphP4Rb0j+Hz3TAYm0AsdYjjb/7YeGzu7HcFO0gOERbwRdW4YzycMDZ/q9nzT024QEGflJy3SrL/iMANSeQ8KeSl5Fri9UNvppQn0ISeLQq3uWxjPPXHY7VXwH+Hppv6fH7jY+4nrnV0snPySKs9J6mZE9kNyFh+Qrik5u5rETQdyDd7ys/6kmYJqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5TXQaAaUheBv4usEsw0bry48IJMs/rJpQrcBTJfjE0=;
 b=HaSe/lW36Pd2ARL7Of0ZroWlaZX2/o+1DhdtLP8irCTtHhG0tI8BAu3e6GC48vA3xituuSeAj8criiwClby3oOVtwGI2Tu5ZMmcx8fg1QYC9RNIEdlktbetsLrNgoJWlpx/4aoQUEqxK1f7XIo3ouC9D+ALduyG388ybyq/Mzz4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 19:21:12 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 19:21:12 +0000
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: checkpatch.pl: WARNING: else is not generally useful after a break or
 return
Message-ID: <064ada88-9fa3-6f6d-967c-00d4e2d325ae@amd.com>
Date:   Fri, 17 Apr 2020 15:20:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::33) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.131.176) by YTXPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 19:21:09 +0000
X-Originating-IP: [108.162.131.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f32ee956-31aa-4406-722a-08d7e3047d8c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4434:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4434BD4C2842FB95FFAACBAF99D90@DM6PR12MB4434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(478600001)(26005)(86362001)(8676002)(81156014)(8936002)(31696002)(6512007)(6666004)(36756003)(2906002)(186003)(16526019)(44832011)(110136005)(316002)(2616005)(31686004)(956004)(55236004)(52116002)(6486002)(66556008)(66476007)(6506007)(66946007)(5660300002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1KYrTuz6Bg0mo2KutAm6HVJsAgF6nAMNhWk9X6sTlSPYZwefB/SCXiz5gSjUkyBqxXmIGKBsXcevRxN1WLKRKee9EwQ2VFM6Aj84eVIgoAZ/ZIXjYYPexHR444cVE6hYFh2e88LZz0TrVb8uzPLBUZhKPTsL/HDaAZ988ce2JLkjdg4XKD/VY5bxjEe9e7X2QbtUZvnd7eBkBd1KxQ0HM4IotGDOJ+CwU0m5yDmbLlXQp9xLQSsVXZ+SuoX0wipSumqeJVLt5ZwOc+kR8sPr+UOLo79ENR9sXs9tY8i2/GWfN0syLljI6bh/xfD5lXVSec/hUZcmhh1cvP4/RLfthiXKpDZb0J79JpMFzNiOLf4IW0bNTeHT9Lv+cmPcngpFRlhnkI9XQ0XcbX6GfgfG40lX8vCEIDS8UIGbiCdgVJxzXFqN77m1W8H8Zw+AYx02
X-MS-Exchange-AntiSpam-MessageData: TNUSxArlVeyr6qzPQZ8VKECK+uVgAy9YxIpb0aDw1iyuuobmeFIytdJXSYnyHspHmFvcTjLQW7VmxyMZyn50zIH0lzzlZPPWgbzssPADJuZ9jdetPfgV8LGczDpuU8OtqhZhiFsk3/AevIDhci1iviNtSBI2++mXzPLIprOb0ciG9/YJKfR4CZzvzkTGfwGdMOsWBD0WIy5Cqc7PAi3c5zq+RnFrcJF8ECd8gudFmVADxfJMhAGdVk7lnUy2Q4GIHYoH5aDx3rh4C2gVUlG67SjDP54OTwJZo6Wz1Xtjb31VHDiKQWoHbmzp0kKR1ojH2y6M1M2fsxtBG9Tes1GPX9+8E2HHIDtzfsv5nfZPbizgliW7m3T1s5XWZQd4TIbjU0A3mTSHSEMVck2sH4M5NvNXFoHOzJUHOq3HezXwmLtRJl71Al/JRCSWt1x9Sgm8ZS6c7tfLIQQj5m7ued8Cd1HuyX/5EtY0/1gzkkFjTwv5JRKI21iZZ/Y/M+pR7CC8HSdICxl7dCgwrY8CJmFk9qvUD/QzR45IpoYpnlOdkxCh1RAQ+u8xTpwpHJv4G0jxjPgsLYb9gO8unp9bzVujwW1kTyjvXDilRDkjGT9oD2bwE17t7xmpY0ZxDIEzjdsbQ1CDoNarLxzqj5Mh54dJS/1vagJgbqpwkZ4n+YX1rdwkZ+nvTw3lr5PPRg/QCoO+K6qZIwwdeLiVl1sxbcwdeqvmwVfuoRPr2rdhtfWfwE4DvunFTkgXqLQjimJc8/yvpg3oHcsKLLzgi/cJAwXQn7z6rAe6ifs8k2cxHH1THi/qPD688C2WsUMydNBcH+Yu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32ee956-31aa-4406-722a-08d7e3047d8c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 19:21:12.3764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +b6leHJVji+DnF+FHL7jk+S4c8xTlCxO5PJ92fTxGm5PYVLyiXXZlnW1vuo22E5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting what seems to be a false positive in this case:

:32: WARNING: else is not generally useful after a break or return
#32: FILE: drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:55:
+		return 0;
+	} else {

for the following code, at the bottom of a function:

	if (amdgpu_device_should_recover_gpu(ring->adev)) {
		amdgpu_device_gpu_recover(ring->adev, job);
		return 0;
	} else {
		drm_sched_suspend_timeout(&ring->sched);
		return 1;
	}
}

Which seems to be coming from commit:

commit 032a4c0f9a77ce565355c6e191553e853ba66f09
Author: Joe Perches <joe@perches.com>
Date:   Wed Aug 6 16:10:29 2014 -0700

    checkpatch: warn on unnecessary else after return or break
    
    Using an else following a break or return can unnecessarily indent code
    blocks.
    
    ie:
            for (i = 0; i < 100; i++) {
                    int foo = bar();
                    if (foo < 1)
                            break;
                    else
                            usleep(1);
            }
    
    is generally better written as:
    
            for (i = 0; i < 100; i++) {
                    int foo = bar();
                    if (foo < 1)
                            break;
                    usleep(1);
            }
    
    Warn when a bare else statement is preceded by a break or return
    indented 1 tab more than the else.
    
    Signed-off-by: Joe Perches <joe@perches.com>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

While I agree with what the commit is trying to do,
it doesn't seem to apply to the if-else statement which I quoted
above. That is, the "else" is not "bare"--to use the lingo of
the commit.

I suggest that no warning is issued when the "else" is a compound
statement, as shown in my example at the top of this email.

It is only natural to write:

	if (amdgpu_device_should_recover_gpu(ring->adev)) {
		amdgpu_device_gpu_recover(ring->adev, job);
		return 0;
	} else {
		drm_sched_suspend_timeout(&ring->sched);
		return 1;
	}
}

instead of,

	if (amdgpu_device_should_recover_gpu(ring->adev)) {
		amdgpu_device_gpu_recover(ring->adev, job);
		return 0;
	}
	drm_sched_suspend_timeout(&ring->sched);
	return 1;
}

Regards,
-- 
Luben
