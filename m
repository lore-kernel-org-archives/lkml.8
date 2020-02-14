Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3689EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023D52086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgBNSc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:32:57 -0500
Received: from foss.arm.com ([217.140.110.172]:43566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729448AbgBNSc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:32:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 380E5328;
        Fri, 14 Feb 2020 10:32:56 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6F033F68E;
        Fri, 14 Feb 2020 10:32:55 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [V2 1/3] firmware: arm_sdei: fix possible deadlock
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1579145331-78633-1-git-send-email-zhangliguang@linux.alibaba.com>
Message-ID: <2a86cb1b-f8e7-a106-68f2-42e7350a12d2@arm.com>
Date:   Fri, 14 Feb 2020 18:32:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1579145331-78633-1-git-send-email-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luanshi,

On 16/01/2020 03:28, luanshi wrote:
> We call sdei_reregister_event() with sdei_list_lock held but
> _sdei_event_register() and sdei_event_destroy() also acquires
> sdei_list_lock thus creating A-A deadlock.
> 
> Fixes: da351827240e ("firmware: arm_sdei: Add support for CPU and system
> power states")
> 

(Nit: stray whitespace in the fixes tag, the backport tools may choke on this)

(Please include 'PATCH' in the [] section of the subject when posting, its part of the
'canonical patch format', and my scripts for pulling a series of the list depend on it!)


> ---

Thanks for picking up my suggestion, ... it was what I think should have been done in the
first place to avoid this bug.
Looking at your patch, we'd need to take the per-event lock around the reads of reregister
and reenable in sdei_cpuhp_up() too, and sdei_reregister_shared(), ... and this quickly
becomes much noisier than a patch for stable should be. (Sorry, I should have tried it
before suggesting it!)


I've picked up your first version, but instead of duplicating the contents of the
function, I've added '_llocked' wrappers to account for that lock already being held. This
isn't great as we have _locked too, but lockdep should keep us honest.
Because I started with your patch, git has kept you as author.
This ended up as patch 2, because it was also necessary to move those reregister updates
into their callers to fix hibernate.

I'll posted what I have next week, sorry for the hiatus.


Thanks,

James
