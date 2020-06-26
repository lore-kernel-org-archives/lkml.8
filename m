Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EECC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E83021556
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sknfyfor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgFZJpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFZJpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:45:30 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C830FC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oGMIMXlIlCUxBQEVDocoCkzxsIEfyIRY9Aj5R1plPtE=; b=Sknfyfor34r7Xi+MJY/BouCu0w
        ZL1fVw+zVjAajorw4AsXlSKf6jdNN25PoEwzEber3uWmJpXVYlIB1dAH+YVpK/xFH63MhHtio1Qlg
        qt83BqUDObvW/PVxquYsBNzUtP1HPEPt2800r/lBYLe4hBJ9FHOHltb7bzYDXQ17v0nWHNDYOiQ+g
        8enV6WQqgeFxiHfWNfA3z1NI1QMiD9RPXTNDxrXMRHVp0LfdCZeJDf3ZbUC2kH/cxIh6a1lMRdgpG
        7DM1L2MF7W6RSMtG96vjQqfklke50DR25+fLPQ6d4+qkfclyRkFdw+nZlxc6k1CJpZZ+kJh96aVok
        Qa04xpzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jokui-0000wC-M1; Fri, 26 Jun 2020 09:44:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B76A301A32;
        Fri, 26 Jun 2020 11:44:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D6F529AD694F; Fri, 26 Jun 2020 11:44:50 +0200 (CEST)
Date:   Fri, 26 Jun 2020 11:44:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradeed.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200626094450.GJ4800@hirez.programming.kicks-ass.net>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
 <1593116242-31507-13-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593116242-31507-13-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 01:17:22PM -0700, Fenghua Yu wrote:

> +static bool fixup_pasid_exception(void)
> +{
> +	if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
> +		return false;
> +	if (!static_cpu_has(X86_FEATURE_ENQCMD))
> +		return false;

elsewhere you had another variation:

+       if (!IS_ENABLED(CONFIG_INTEL_IOMMU_SVM))
+               return;
+
+       if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
+               return;

Which is it, and why do we need the CONFIG thing when combined with the
enabled thing?

