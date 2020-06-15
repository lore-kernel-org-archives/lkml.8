Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF92C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A105B2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AlyICsaS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgFOHx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgFOHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:53:57 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB9AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NFpMfrG9hSicO32ZjKxBqJx63rGzA3U+MKaGGKR/+vs=; b=AlyICsaSytn6UKQYHxgxKALtpV
        davZqqhBuoT/RALUO6rpXUvSYemJAE7crjXLyGQz3wbtvJTFfNaoi1Rglp6dVg2CZH9x4sLqemnu+
        JklbibNrlyLTx/g+gc6cJqZ8uENDkmFIgntMBecpf7QJUgDOcc4+Tj7zectWHzIWlHd3EuG7t814g
        +HYj3pC5QDAkoOzs/dcpjIJjYIHYvoTsSP0JEPJ1TUnTQ4+WpbTcVnJyVT/SF1TFsWwxusgVOJ9RB
        tHGz1xreZFmg2kBRIxtz3nKYW7EGfKHYpY+Xt6vG7x6b7wJGzxfsH3whAUU2bWyLmRByvFylgrVdv
        DZNY7+/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkjvi-0005ii-KF; Mon, 15 Jun 2020 07:53:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28ED530604B;
        Mon, 15 Jun 2020 09:53:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 107F021059BE3; Mon, 15 Jun 2020 09:53:13 +0200 (CEST)
Date:   Mon, 15 Jun 2020 09:53:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org,
        amd-gfx <amd-gfx@lists.freedesktop.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 12/12] x86/traps: Fix up invalid PASID
Message-ID: <20200615075313.GJ2497@hirez.programming.kicks-ass.net>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592008893-9388-13-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 05:41:33PM -0700, Fenghua Yu wrote:
> @@ -447,6 +458,18 @@ dotraplinkage void do_general_protection(struct pt_regs *regs, long error_code)
>  	int ret;
>  
>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	/*
> +	 * Perform the check for a user mode PASID exception before enable
> +	 * interrupts. Doing this here ensures that the PASID MSR can be simply
> +	 * accessed because the contents are known to be still associated
> +	 * with the current process.
> +	 */
> +	if (user_mode(regs) && fixup_pasid_exception()) {
> +		cond_local_irq_enable(regs);
> +		return;

OK, so we're done with the exception, lets enable interrupts?

> +	}
