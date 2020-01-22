Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A236CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DB2217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgAVOWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:22:33 -0500
Received: from foss.arm.com ([217.140.110.172]:57076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbgAVOWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:22:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A210328;
        Wed, 22 Jan 2020 06:22:33 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 08C9D3F52E;
        Wed, 22 Jan 2020 06:22:31 -0800 (PST)
Subject: Re: [PATCH v2] sched/fair: Optimize select_idle_core
To:     Mel Gorman <mgorman@techsingularity.net>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20191206172422.6578-1-srikar@linux.vnet.ibm.com>
 <20200122135509.GW3466@techsingularity.net>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <0813a57a-093b-2aae-b037-f0a4955c716a@arm.com>
Date:   Wed, 22 Jan 2020 14:22:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122135509.GW3466@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2020 13:55, Mel Gorman wrote:
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> 
> I'm a bit surprised to not see this in linux-next or tip. Did this get
> rejected or did it accidentally get overlooked because the subject is so
> similar to 60588bfa223f ("sched/fair: Optimize select_idle_cpu") ?
> 

Most likely the latter; I also had completely forgotten about it and had to
retrace where and when I reviewed that...
