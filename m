Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD124C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12D320767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="l2mAoN/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIBXO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:14:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55117 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgIBXOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:14:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599088464; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=BLqR7N9u5o5zI0fu/U8Zok9Q7AX+5yZO+IccQf8/+pI=;
 b=l2mAoN/9dYlUO0j4FCrKjJtnxhm/ib5gl9N/V4yESbjzyjMZHhZLZMlGcBtdwUVqf6DY0OJq
 r/NJ7Dbi9KvXzOTt0xm9WL/SC2IW99F7CmxY6JwECcvyYnGkBb0CR0RpbUI/vCGKH6/kgPfT
 sKQo07fpV13wiqhcAC6GzHyg3CI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f50274d9f3347551f0f399a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 23:14:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4693CC433C6; Wed,  2 Sep 2020 23:14:20 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5C8CC433C9;
        Wed,  2 Sep 2020 23:14:19 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 02 Sep 2020 16:14:19 -0700
From:   rishabhb@codeaurora.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Expose recovery/coredump configuration from sysfs
In-Reply-To: <20200901220542.GA121362@xps15>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
 <20200901220542.GA121362@xps15>
Message-ID: <944061c55a14e28b2a200215c21a9c39@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-01 15:05, Mathieu Poirier wrote:
> Hi Rishabh,
> 
> On Thu, Aug 27, 2020 at 12:48:48PM -0700, Rishabh Bhatnagar wrote:
>> From Android R onwards Google has restricted access to debugfs in user
>> and user-debug builds. This restricts access to most of the features
>> exposed through debugfs. This patch series adds a configurable option
>> to move the recovery/coredump interfaces to sysfs. If the feature
>> flag is selected it would move these interfaces to sysfs and remove
>> the equivalent debugfs interface.
> 
> What I meant wast to move the coredump entry from debugfs to sysfs and 
> from
> there make it available to user space using a kernel config.  But 
> thinking
> further on this it may be better to simply provide an API to set the 
> coredump
> mode from the platform driver, the same way 
> rproc_coredump_set_elf_info() works.
> That will prevent breaking a fair amount of user space code...
> 
> Let me know if that can work for you.
> 
> Thanks,
> Mathieu
> 
Hi Mathieu,
That works for product configuration but that would still limit internal
testing. Since there is also restriction on accessing debugfs through
userspace code, automation won't be able to run recovery/coredump tests.
Only other way for us would be to provide these sysfs entries through 
the
platform drivers locally but that would create a lot of mess/redundancy.

>> 'Coredump' and 'Recovery' are critical
>> interfaces that are required for remoteproc to work on Qualcomm 
>> Chipsets.
>> Coredump configuration needs to be set to "inline" in debug/test build
>> and "disabled" in production builds. Whereas recovery needs to be
>> "disabled" for debugging purposes and "enabled" on production builds.
>> 
>> Changelog:
>> 
>> v1 -> v2:
>> - Correct the contact name in the sysfs documentation.
>> - Remove the redundant write documentation for coredump/recovery sysfs
>> - Add a feature flag to make this interface switch configurable.
>> 
>> Rishabh Bhatnagar (3):
>>   remoteproc: Expose remoteproc configuration through sysfs
>>   remoteproc: Add coredump configuration to sysfs
>>   remoteproc: Add recovery configuration to sysfs
>> 
>>  Documentation/ABI/testing/sysfs-class-remoteproc |  44 ++++++++
>>  drivers/remoteproc/Kconfig                       |  12 +++
>>  drivers/remoteproc/remoteproc_debugfs.c          |  10 +-
>>  drivers/remoteproc/remoteproc_sysfs.c            | 126 
>> +++++++++++++++++++++++
>>  4 files changed, 190 insertions(+), 2 deletions(-)
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
