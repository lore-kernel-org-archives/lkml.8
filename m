Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7803C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4FF2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgEOLht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:37:49 -0400
Received: from foss.arm.com ([217.140.110.172]:54376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgEOLht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:37:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B66CD6E;
        Fri, 15 May 2020 04:37:49 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.24.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF53F3F305;
        Fri, 15 May 2020 04:37:46 -0700 (PDT)
Date:   Fri, 15 May 2020 12:37:44 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: Re: [PATCH v3 2/7] firmware: smccc: Update link to latest SMCCC
 specification
Message-ID: <20200515113744.GB67718@C02TD0UTHF1T.local>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200506164411.3284-3-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506164411.3284-3-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:44:06PM +0100, Sudeep Holla wrote:
> The current link gets redirected to the revision B published in November
> 2016 though it actually points to the original revision A published in
> June 2013.
> 
> Let us update the link to point to the latest version, so that it
> doesn't get stale anytime soon. Currently it points to v1.2 published in
> March 2020.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Changing the link is fine, but could we also add a line to make it clear
which version of spec was written against, e.g.

| This code is up-to-date with version DEN 0028 A

... as that was previously implicit in the documentation link, and it
makes clear what the code is aware of and what it is trying to handle.
Iknow we'll have to update it periodically, but I think that's
worthwthile.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  include/linux/arm-smccc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 59494df0f55b..6c1d1eda3be4 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -10,7 +10,7 @@
>  /*
>   * This file provides common defines for ARM SMC Calling Convention as
>   * specified in
> - * http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
> + * https://developer.arm.com/docs/den0028/latest
>   */
>  
>  #define ARM_SMCCC_STD_CALL	        _AC(0,U)
> -- 
> 2.17.1
> 
