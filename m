Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F309C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038712076A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEOMq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:46:58 -0400
Received: from foss.arm.com ([217.140.110.172]:55420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOMq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:46:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28A061042;
        Fri, 15 May 2020 05:46:57 -0700 (PDT)
Received: from bogus (unknown [10.37.12.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DF343F305;
        Fri, 15 May 2020 05:46:55 -0700 (PDT)
Date:   Fri, 15 May 2020 13:46:48 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v3 2/7] firmware: smccc: Update link to latest SMCCC
 specification
Message-ID: <20200515124648.GA1591@bogus>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200506164411.3284-3-sudeep.holla@arm.com>
 <20200515113744.GB67718@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515113744.GB67718@C02TD0UTHF1T.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:37:44PM +0100, Mark Rutland wrote:
> On Wed, May 06, 2020 at 05:44:06PM +0100, Sudeep Holla wrote:
> > The current link gets redirected to the revision B published in November
> > 2016 though it actually points to the original revision A published in
> > June 2013.
> >
> > Let us update the link to point to the latest version, so that it
> > doesn't get stale anytime soon. Currently it points to v1.2 published in
> > March 2020.
> >
> > Reviewed-by: Steven Price <steven.price@arm.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Changing the link is fine, but could we also add a line to make it clear
> which version of spec was written against, e.g.
>
> | This code is up-to-date with version DEN 0028 A
>
> ... as that was previously implicit in the documentation link, and it
> makes clear what the code is aware of and what it is trying to handle.
> Iknow we'll have to update it periodically, but I think that's
> worthwthile.
>

Makes sense, I will update.

> With that:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>

Thanks.

--
Regards,
Sudeep
