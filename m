Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2168C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41732072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="f8AKwBzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbgDBWLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:11:21 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39474 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgDBWLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:11:21 -0400
Received: from zn.tnic (p200300EC2F0A0E00AC3E2C93ADB62CA9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:e00:ac3e:2c93:adb6:2ca9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0CA41EC0BF2;
        Fri,  3 Apr 2020 00:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1585865480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=61DkwClXCHZinnBsHgcGNiaGAnBYPU+s2tSXg6FKgFo=;
        b=f8AKwBzNXodUakPNBjyiZ2GRUvx9OJmXfDgdmtC2p1hlyRsafTGyc8LScKiijzJwZduZGz
        OeU3XfSVP8WRLlq5XVe75cY+lnYwJx/r4+r5XS4HXI1rRr5sQjmS0bbGy1fP7U7Pmblv5l
        a5rKNSbcAjwKAR0Si0kXAdKMmde3nws=
Date:   Fri, 3 Apr 2020 00:11:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, keescook@chromium.org, x86@kernel.org,
        benh@kernel.crashing.org, dave.hansen@intel.com
Subject: Re: [PATCH 3/3] arch/x86: Optionally flush L1D on context switch
Message-ID: <20200402221109.GJ9352@zn.tnic>
References: <20200402062401.29856-1-sblbir@amazon.com>
 <20200402062401.29856-4-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200402062401.29856-4-sblbir@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 05:24:01PM +1100, Balbir Singh wrote:
> +int enable_l1d_flush_for_task(struct task_struct *tsk)
> +{
> +	struct page *page;
> +	int ret = 0;
> +
> +	if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
> +		goto done;
> +
> +	page = READ_ONCE(l1d_flush_pages);
> +	if (unlikely(!page)) {
> +		mutex_lock(&l1d_flush_mutex);
> +		if (!l1d_flush_pages) {
> +			l1d_flush_pages = alloc_l1d_flush_pages();
> +			if (!l1d_flush_pages)
> +				return -ENOMEM;

Do I see it correctly that you'll return here with l1d_flush_mutex still
held?

> +		}
> +		mutex_unlock(&l1d_flush_mutex);
> +	}
> +	/* I don't think we need to worry about KSM */

Pls use passive voice: no "we" or "I", etc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
