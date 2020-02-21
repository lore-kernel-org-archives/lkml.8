Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB5FC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D40E207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgBUJ6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:58:20 -0500
Received: from foss.arm.com ([217.140.110.172]:35496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBUJ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:58:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F951328;
        Fri, 21 Feb 2020 01:58:19 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 548103F68F;
        Fri, 21 Feb 2020 01:58:17 -0800 (PST)
Subject: Re: [PATCH v2 0/5] remove runnable_load_avg and improve
 group_classify
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com, valentin.schneider@arm.com,
        hdanton@sina.com
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <827f745e-5afc-88b1-0a93-b5d2dfd796db@arm.com>
Date:   Fri, 21 Feb 2020 10:58:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200214152729.6059-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2020 16:27, Vincent Guittot wrote:
> This new version stays quite close to the previous one and should 
> replace without problems the previous one that part of Mel's patchset:
> https://lkml.org/lkml/2020/2/14/156
> 
> NUMA load balancing is the last remaining piece of code that uses the 
> runnable_load_avg of PELT to balance tasks between nodes. The normal
> load_balance has replaced it by a better description of the current state
> of the group of cpus.  The same policy can be applied to the numa
> balancing.
> 
> Once unused, runnable_load_avg can be replaced by a simpler runnable_avg
> signal that tracks the waiting time of tasks on rq. Currently, the state
> of a group of CPUs is defined thanks to the number of running task and the
> level of utilization of rq. But the utilization can be temporarly low
> after the migration of a task whereas the rq is still overloaded with
> tasks. In such case where tasks were competing for the rq, the
> runnable_avg will stay high after the migration.

With those small things I commented on:

Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
