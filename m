Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781AEC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D145214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgBGPtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:49:03 -0500
Received: from foss.arm.com ([217.140.110.172]:41402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgBGPtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:49:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1967F1FB;
        Fri,  7 Feb 2020 07:49:03 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 337343F68E;
        Fri,  7 Feb 2020 07:49:02 -0800 (PST)
Date:   Fri, 7 Feb 2020 15:48:55 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drivers base/arch_topology: Remove 'struct sched_domain'
 forward declaration
Message-ID: <20200207154855.GA5529@bogus>
References: <20200207114913.3052-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207114913.3052-1-dietmar.eggemann@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 12:49:13PM +0100, Dietmar Eggemann wrote:
> The sched domain pointer argument from topology_get_freq_scale() and
> topology_get_cpu_scale() got removed by commit 7673c8a4c75d
> ("sched/cpufreq: Remove arch_scale_freq_capacity()'s 'sd' parameter")
> and commit 8ec59c0f5f49 ("sched/topology: Remove unused 'sd' parameter
> from arch_scale_cpu_capacity()").
>
> So the 'struct sched_domain' forward declaration is no longer needed.
> Remove it.
>
> W/o the sched domain pointer argument the storage class and inline
> definition as well as the return type, function name and parameter list
> fit all into one line.

Looks simple and good to me. I don't want to ask you split the patch as
$subject indicates only one of the 2 changes in the patch. I am fine with
it as it but if anyone else shout for that, go for the split.

Either way,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

You have not added Greg who generally picks up the patch. Can you repost
with him in cc and my reviewed-by so that he can pick it up.

--
Regards,
Sudeep
