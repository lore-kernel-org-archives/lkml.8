Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F82C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBFF20740
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgCSKZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:25:27 -0400
Received: from foss.arm.com ([217.140.110.172]:32900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgCSKZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:25:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27E0F106F;
        Thu, 19 Mar 2020 03:25:26 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D322D3FAA0;
        Thu, 19 Mar 2020 02:06:16 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 1/9] sched/fair: find_idlest_group(): Remove unused
 sd_flag parameter
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org
References: <20200311181601.18314-1-valentin.schneider@arm.com>
 <20200311181601.18314-2-valentin.schneider@arm.com>
Message-ID: <a8570edc-7c34-fe90-aeac-f2fc1576823c@arm.com>
Date:   Thu, 19 Mar 2020 10:05:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311181601.18314-2-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.20 19:15, Valentin Schneider wrote:
> The last use of that parameter was removed by commit
> 
>   57abff067a08 ("sched/fair: Rework find_idlest_group()")
> 
> Get rid of the parameter.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

[...]

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
