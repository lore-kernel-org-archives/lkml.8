Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3BD20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgEOLuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:50:01 -0400
Received: from foss.arm.com ([217.140.110.172]:54688 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgEOLt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:49:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EFCAD6E;
        Fri, 15 May 2020 04:49:58 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.24.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA17C3F305;
        Fri, 15 May 2020 04:49:56 -0700 (PDT)
Date:   Fri, 15 May 2020 12:49:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: Re: [PATCH v3 5/7] firmware: smccc: Refactor SMCCC specific bits
 into separate file
Message-ID: <20200515114953.GE67718@C02TD0UTHF1T.local>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200506164411.3284-6-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506164411.3284-6-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:44:09PM +0100, Sudeep Holla wrote:
> In order to add newer SMCCC v1.1+ functionality and to avoid cluttering
> PSCI firmware driver with SMCCC bits, let us move the SMCCC specific
> details under drivers/firmware/smccc/smccc.c
> 
> We can also drop conduit and smccc_version from psci_operations structure
> as SMCCC was the sole user and now it maintains those.
> 
> No functionality change in this patch though.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  MAINTAINERS                     |  9 +++++++++
>  drivers/firmware/Makefile       |  3 ++-
>  drivers/firmware/psci/psci.c    | 19 ++++---------------
>  drivers/firmware/smccc/Makefile |  3 +++
>  drivers/firmware/smccc/smccc.c  | 26 ++++++++++++++++++++++++++
>  include/linux/arm-smccc.h       | 11 +++++++++++
>  include/linux/psci.h            |  2 --
>  7 files changed, 55 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/firmware/smccc/Makefile
>  create mode 100644 drivers/firmware/smccc/smccc.c
> 
> Hi Mark, Lorenzo,
> 
> I have replicated PSCI entry in MAINTAINERS file and added myself to
> for SMCCC entry. If you prefer I can merge it under PSCI. Let me know
> your preference along with other review comments.

> +SECURE MONITOR CALL(SMC) CALLING CONVENTION (SMCCC)
> +M:	Mark Rutland <mark.rutland@arm.com>
> +M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> +M:	Sudeep Holla <sudeep.holla@arm.com>
> +L:	linux-arm-kernel@lists.infradead.org
> +S:	Maintained
> +F:	drivers/firmware/smccc/
> +F:	include/linux/arm-smccc.h

As per the above, I'm fine with having this separate from the PSCI
entry, and I'm fine with sharing this maintainership.

> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h

> +/**
> + * arm_smccc_version_init() - Sets SMCCC version and conduit
> + * @version: SMCCC version v1.1 or above
> + * @conduit: SMCCC_CONDUIT_SMC or SMCCC_CONDUIT_HVC
> + *
> + * When SMCCCv1.1 or above is not present, defaults to ARM_SMCCC_VERSION_1_0
> + * and SMCCC_CONDUIT_NONE respectively.
> + */
> +void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);

Given we only expect the PSCI code to call this, could we avoid putting
this in a header and just define it within psci.c?

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
