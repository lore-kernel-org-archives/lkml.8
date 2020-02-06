Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44464C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2577F20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgBFPzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:55:20 -0500
Received: from foss.arm.com ([217.140.110.172]:60212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbgBFPzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:55:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10D961FB;
        Thu,  6 Feb 2020 07:55:19 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2533F68E;
        Thu,  6 Feb 2020 07:55:17 -0800 (PST)
Date:   Thu, 6 Feb 2020 15:55:12 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     peng.fan@nxp.com
Cc:     viresh.kumar@linaro.org, f.fainelli@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: mailbox: share shmem for
 protocols
Message-ID: <20200206155512.GA55006@bogus>
References: <1580993966-17757-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580993966-17757-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 08:59:25PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When shmem property of protocol is not specificed, let it use
> its parent's shmem property.

I had replied already to the thread without ALKML you had sent earlier,
please refer them.

-- 
Regards,
Sudeep
