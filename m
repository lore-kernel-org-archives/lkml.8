Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2298DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6BD2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgFCRjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:39:40 -0400
Received: from foss.arm.com ([217.140.110.172]:36130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbgFCRjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:39:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80FB331B;
        Wed,  3 Jun 2020 10:39:39 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805C13F305;
        Wed,  3 Jun 2020 10:39:38 -0700 (PDT)
References: <20200424135657.32519-1-valentin.schneider@arm.com> <20200603170511.GA23722@bogus>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH 0/2] firmware/psci: PSCI checker cleanup
In-reply-to: <20200603170511.GA23722@bogus>
Date:   Wed, 03 Jun 2020 18:39:32 +0100
Message-ID: <jhjimg8hwvf.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/06/20 18:05, Sudeep Holla wrote:
> On Fri, Apr 24, 2020 at 02:56:55PM +0100, Valentin Schneider wrote:
>> Hi folks,
>>
>> This is a small cleanup of the PSCI checker following Peter's objections
>> to its homegrown do_idle() implementation. It is based on his
>> sched_setscheduler() unexport series at [1].
>>
>> I've never really used the thing before, but it still seems to behave
>> correctly on my Juno r0 & HiKey960.
>>
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks!

AIUI the plan is to have the base in for the following version, so we
can wait until then - or I can rebase this on top of mainline, and
whoever will be on the receiving end of the merge conflict will be
slightly annoyed :-)

I'm in no particular rush, and this isn't very hot code, so up to you.
