Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34852C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B46B21582
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgDWILy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:11:54 -0400
Received: from foss.arm.com ([217.140.110.172]:34710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWILy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:11:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DFE430E;
        Thu, 23 Apr 2020 01:11:53 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6315E3F73D;
        Thu, 23 Apr 2020 01:11:52 -0700 (PDT)
Date:   Thu, 23 Apr 2020 09:11:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Richard Gong <richard.gong@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: stratix10-svc: Drop unnecessary checking for
 and populating /firmware/ node
Message-ID: <20200423081149.GB18538@bogus>
References: <20200421173256.34897-1-sudeep.holla@arm.com>
 <8ca3666f-8ff1-3c3c-d40b-81c024b37bdd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ca3666f-8ff1-3c3c-d40b-81c024b37bdd@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 04:50:00PM -0500, Richard Gong wrote:
> Hi Sudeep,
>
> I tried and couldn't load stratix10-svc driver with your patch on kernel
> 5.6.
>

What exactly do you mean by not loading stratix10-svc driver ?
This patch doesn't change that part, the driver should still get loaded.
The change may affect probing part if for some reason the devices for
nodes under firmware are not populated which I still can't understand.

Do you see any change under i/sys/devices/platform/firmware\:* with
and without this change ?

Lots of drivers removed the code similar to this patch after the Commit
3aa0582fdb82 ("of: platform: populate /firmware/ node from
of_platform_default_populate_init()") and continue to work fine. I am
interested to see what is different in stratix10-svc.

--
Regards,
Sudeep
