Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CFDC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2996A20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgBXJ7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:59:08 -0500
Received: from foss.arm.com ([217.140.110.172]:34716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBXJ7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:59:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0770230E;
        Mon, 24 Feb 2020 01:59:07 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4BC73F703;
        Mon, 24 Feb 2020 01:59:05 -0800 (PST)
Date:   Mon, 24 Feb 2020 09:59:03 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Trilok Soni <tsoni@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] firmware: psci: Add support for dt-supplied
 SYSTEM_RESET2 type
Message-ID: <20200224095903.GC28594@bogus>
References: <1582327685-6316-1-git-send-email-eberman@codeaurora.org>
 <1582327685-6316-3-git-send-email-eberman@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582327685-6316-3-git-send-email-eberman@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elliot,

I have dropped the wrong mailing list you had used. The right one is
linux-arm-kernel@lists.infradead.org. I won't add now as it makes no
sense to just have the response there without the patch.

On Fri, Feb 21, 2020 at 03:28:04PM -0800, Elliot Berman wrote:
> Some implementors of PSCI may relax the requirements of the PSCI
> architectural warm reset. In order to comply with PSCI specification, a
> different reset_type value must be used. The alternate PSCI
> SYSTEM_RESET2 may be used in all warm/soft reboot scenarios, replacing
> the architectural warm reset.
> 
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---
>  drivers/firmware/psci/psci.c | 21 +++++++++++++++++----
>  include/linux/psci.h         |  1 +
>  include/uapi/linux/psci.h    |  2 ++
>  3 files changed, 20 insertions(+), 4 deletions(-)
>

[...]


>  /*
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index a67712b..1959a80 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -37,6 +37,7 @@ struct psci_operations {
>  	int (*migrate_info_type)(void);
>  	enum arm_smccc_conduit conduit;
>  	enum smccc_version smccc_version;
> +	u32 sys_reset2_reset_type;

Why this needs to be in this header ? Can't it be just local to psci.c ?

-- 
Regards,
Sudeep
