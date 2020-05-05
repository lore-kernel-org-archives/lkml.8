Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92A2C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 909DE20752
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgEER7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:59:08 -0400
Received: from foss.arm.com ([217.140.110.172]:46792 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgEER7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:59:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8B031FB;
        Tue,  5 May 2020 10:59:07 -0700 (PDT)
Received: from bogus (unknown [10.37.12.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 118F83F305;
        Tue,  5 May 2020 10:59:04 -0700 (PDT)
Date:   Tue, 5 May 2020 18:59:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
Subject: Re: [PATCH v2 5/5] arm/arm64: smccc: Add ARCH_SOC_ID support
Message-ID: <20200505175901.GD23612@bogus>
References: <20200504092905.10580-1-sudeep.holla@arm.com>
 <20200504092905.10580-6-sudeep.holla@arm.com>
 <20200505162049.GG24239@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505162049.GG24239@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:20:50PM +0100, Will Deacon wrote:
> On Mon, May 04, 2020 at 10:29:05AM +0100, Sudeep Holla wrote:
> > diff --git a/drivers/firmware/psci/soc_id.c b/drivers/firmware/psci/soc_id.c
> > new file mode 100644
> > index 000000000000..b45f2d78e12e
> > --- /dev/null
> > +++ b/drivers/firmware/psci/soc_id.c
> > @@ -0,0 +1,165 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2020 Arm Limited
> > + */
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/sys_soc.h>
> > +
> > +#define SMCCC_SOC_ID_JEP106_BANK_IDX_MASK	GENMASK(30, 24)
> > +/*
> > + * As per the spec bits[23:16] are JEP-106 identification code with parity bit
> > + * for the SiP. We can drop the parity bit.
> > + */
> 
> Which spec? Could you link to the doc and section here, please?
> 

Sure, sorry since I updated the link in 1/5, I forgot all of it and just
started referring it here.

-- 
Regards,
Sudeep
