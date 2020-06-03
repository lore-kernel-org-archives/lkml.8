Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B004C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F98820659
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFCRFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:05:36 -0400
Received: from foss.arm.com ([217.140.110.172]:35806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgFCRFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:05:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8347931B;
        Wed,  3 Jun 2020 10:05:35 -0700 (PDT)
Received: from bogus (unknown [10.37.8.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E33B43F305;
        Wed,  3 Jun 2020 10:05:33 -0700 (PDT)
Date:   Wed, 3 Jun 2020 18:05:22 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [PATCH 0/2] firmware/psci: PSCI checker cleanup
Message-ID: <20200603170511.GA23722@bogus>
References: <20200424135657.32519-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424135657.32519-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 02:56:55PM +0100, Valentin Schneider wrote:
> Hi folks,
> 
> This is a small cleanup of the PSCI checker following Peter's objections
> to its homegrown do_idle() implementation. It is based on his
> sched_setscheduler() unexport series at [1].
> 
> I've never really used the thing before, but it still seems to behave
> correctly on my Juno r0 & HiKey960.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
