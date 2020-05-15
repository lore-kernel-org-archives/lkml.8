Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7606C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D202074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgEOM6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:58:21 -0400
Received: from foss.arm.com ([217.140.110.172]:55652 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgEOM6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:58:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF37E1042;
        Fri, 15 May 2020 05:58:19 -0700 (PDT)
Received: from bogus (unknown [10.37.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DF3B3F305;
        Fri, 15 May 2020 05:58:10 -0700 (PDT)
Date:   Fri, 15 May 2020 13:57:58 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: Re: [PATCH v3 6/7] firmware: smccc: Add function to fetch SMCCC
 version
Message-ID: <20200515125758.GC1591@bogus>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200506164411.3284-7-sudeep.holla@arm.com>
 <20200515120811.GF67718@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200515120811.GF67718@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:08:11PM +0100, Mark Rutland wrote:
> On Wed, May 06, 2020 at 05:44:10PM +0100, Sudeep Holla wrote:
> > For backward compatibility reasons, PSCI maintains SMCCC version as
> > SMCCC didn't provide ARM_SMCCC_VERSION_FUNC_ID until v1.1
> > 
> > Let us provide accessors to fetch the SMCCC version in PSCI so that
> > other SMCCC v1.1+ features can use it.
> 
> Stale commit message? This was factored out of PSCI in the prior commit.
>

Duh ! Will drop that.

> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/firmware/smccc/smccc.c | 4 ++++
> >  include/linux/arm-smccc.h      | 9 +++++++++
> >  2 files changed, 13 insertions(+)
> > 
> > diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
> > index 488699aae24f..672974df0dfe 100644
> > --- a/drivers/firmware/smccc/smccc.c
> > +++ b/drivers/firmware/smccc/smccc.c
> > @@ -24,3 +24,7 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
> >  	return smccc_conduit;
> >  }
> >  
> > +u32 arm_smccc_version_get(void)
> > +{
> > +	return smccc_version;
> > +}
> 
> Could we please call this arm_smccc_get_version(), to align with the
> existing arm_smccc_1_1_get_conduit()?
>

Right will fix that. (I may suddenly got into SCMI mode where Greg or
someone asked me change all the function names to have verb at the end 😁)

> > diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> > index 11fb20bfa8f7..8dd54dad1ec5 100644
> > --- a/include/linux/arm-smccc.h
> > +++ b/include/linux/arm-smccc.h
> > @@ -109,6 +109,15 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit);
> >   */
> >  enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
> >  
> > +/**
> > + * arm_smccc_version_get()
> > + *
> > + * Returns the version to be used for SMCCCv1.1 or later.
> > + *
> > + * When SMCCCv1.1 or above is not present, assumes and returns SMCCCv1.0.
> > + */
> > +u32 arm_smccc_version_get(void);
> 
> Can we please reword the last line to something like:
>
> | When SMCCCv1.1 or above is not present, returns SMCCCv1.0, but this
> | does not imply the presence of firmware or a valid conduit. Callers
> | handling SMCCCv1.0 must determine the conduit by other means.
>

Sure

> With all that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 

Thanks,

-- 
Regards,
Sudeep
