Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5120EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FF924125
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZUg49nI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgATOyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:54:09 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36156 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgATOyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IQQh1EuG8rT98HIU2bd1ZIWkgxvuduUwivstT4Pdcsk=; b=aZUg49nI1Tr8vfYxcjzHRMUBs
        K/pOlxv2efoh5pdb+F1kFfGfma6KtTCSoWNhIDV+YYyRkeMVKWMrM7M9q46Vqvn8lEjeEejAyb2Zw
        d7NwYjsirc21PrCMJYnMYGXqMARNzRJonS+i83hYsxDLHCL+4FqwwWf0Co32bRtzpCB7qdKFCvjrr
        OSqCTCR5qJJxJqRuQGjYJ+4ZgYSlW6ygs1HdmkZJ0WYhRx20oVwKYeiS2TUvITkMOkvrrZI2zKuID
        LAouG07u4318b5vJpk2jndYurOno2CsxSqO+YhlpQZTDxksJAgSKSY6ztaeoAYrjeT09u61U1aEEI
        2yvj65Nmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itYRG-0007Dh-QP; Mon, 20 Jan 2020 14:54:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 818CE305FEA;
        Mon, 20 Jan 2020 15:52:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3115128B86E60; Mon, 20 Jan 2020 15:54:01 +0100 (CET)
Date:   Mon, 20 Jan 2020 15:54:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC v5 11/57] objtool: Abstract alternative special case
 handling
Message-ID: <20200120145401.GB14897@hirez.programming.kicks-ass.net>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-12-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-12-jthierry@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:14PM +0000, Julien Thierry wrote:
> diff --git a/tools/objtool/arch/x86/arch_special.c b/tools/objtool/arch/x86/arch_special.c
> new file mode 100644
> index 000000000000..6dba31f419d0
> --- /dev/null
> +++ b/tools/objtool/arch/x86/arch_special.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#include "../../special.h"
> +#include "../../builtin.h"
> +
> +void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
> +{
> +	/*
> +	 * If UACCESS validation is enabled; force that alternative;
> +	 * otherwise force it the other way.
> +	 *
> +	 * What we want to avoid is having both the original and the
> +	 * alternative code flow at the same time, in that case we can
> +	 * find paths that see the STAC but take the NOP instead of
> +	 * CLAC and the other way around.
> +	 */

That comment ^,

> +	switch (feature) {
> +	case X86_FEATURE_SMAP:

goes here >

> +		if (uaccess)
> +			alt->skip_orig = true;
> +		else
> +			alt->skip_alt = true;
> +		break;

> +	case X86_FEATURE_POPCNT:
> +		/*
> +		 * It has been requested that we don't validate the !POPCNT
> +		 * feature path which is a "very very small percentage of
> +		 * machines".
> +		 */
> +		alt->skip_orig = true;
> +		break;
> +	default:
> +		break;
> +	}
> +}
