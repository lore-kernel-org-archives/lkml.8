Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A789CC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 848762087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAQOhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:37:32 -0500
Received: from foss.arm.com ([217.140.110.172]:41922 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgAQOhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:37:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A11911D4;
        Fri, 17 Jan 2020 06:37:31 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 026683F534;
        Fri, 17 Jan 2020 06:37:29 -0800 (PST)
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200114101319.GO3466@techsingularity.net>
 <20200116163529.GP3466@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <4cd0dda0-a944-b0ac-a614-6127b60babe6@arm.com>
Date:   Fri, 17 Jan 2020 14:37:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116163529.GP3466@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2020 16:35, Mel Gorman wrote:
> Any thoughts on whether this is ok for tip or are there suggestions on
> an alternative approach?
> 

My main concern was about using number of tasks instead of number of busy
CPUs, which you're doing here, so I'm happy with that side of things.

As for the simpler imbalance heuristic, I don't have any issue with it
either. It's obvious that it caters to pairs of communicating tasks, and
we can try to extend it later on if required.

So yeah, FWIW:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
