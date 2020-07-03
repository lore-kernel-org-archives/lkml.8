Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA369C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2FB206BE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGCOuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:50:13 -0400
Received: from foss.arm.com ([217.140.110.172]:41056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgGCOuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:50:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B72DE106F;
        Fri,  3 Jul 2020 07:50:03 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF21A3F73C;
        Fri,  3 Jul 2020 07:50:02 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        lukasz.luba@arm.com
Subject: Re: [PATCH] firmware: arm_scmi: Use signed integer to report transfer status
Date:   Fri,  3 Jul 2020 15:49:50 +0100
Message-Id: <159378739973.7506.1185547126081306222.b4-ty@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <159378750699.7612.3747943343943399740.b4-ty@arm.com>
References: <159378759580.7741.1360234334350850998.b4-ty@arm.com>
 <159378764840.7835.7289029317816454363.b4-ty@arm.com>
 <159378754443.7674.9124886575137501969.b4-ty@arm.com>
 <159378750699.7612.3747943343943399740.b4-ty@arm.com>
In-Reply-To: <20200609134503.55860-1-sudeep.holla@arm.com>
References: <20200609134503.55860-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 14:45:03 +0100, Sudeep Holla wrote:
> Currently the trace event 'scmi_xfer_end' reports the status of the
> transfer using the unsigned status field read from the firmware. This
> may not be easy to interpret and also may miss to present any timeouts
> that happen in the driver.
> 
> Let us use signed integer so that error values are emitted out after
> they are mapped from firmware errors to standard linux error codes.
> While at this, let us also include any timeouts in the driver itself.


Applied to sudeep.holla/linux (for-next/scmi), thanks!

[1/1] firmware: arm_scmi: Use signed integer to report transfer status
      https://git.kernel.org/sudeep.holla/c/bad0d73b65

--
Regards,
Sudeep

