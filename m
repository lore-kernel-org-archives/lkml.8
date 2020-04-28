Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF3AC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E5B206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aCpdTrXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgD1FxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726258AbgD1FxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:53:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1EC03C1A9;
        Mon, 27 Apr 2020 22:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=9XovULq8rJCuWXmFB4aDWCVuT48qS2yZ0ltStjBj4hM=; b=aCpdTrXL5xBMuDBIgagmp2g9ZQ
        9aord42KwraiUSaEVoMLiPpaH6zjsWyRuEDa2eNLtNNtFecX9lc9xnoKg/elNnxSmtyjht7evkfqp
        5jhC9NxXS4u/e94nSa87KnXf7J/TlD6xFel1PGwXXqepI6XDXwQ5dNJrsJhMVSdMD7JyV1x5La7P3
        fv6FJMXX2dWE/kk3Zs1Intp9acSgOVu4GpSw+HZcRpNqs1DFT+3WF0Oh9KPJYcFjkFmPdt2b/XkGf
        NaRhjRbDUCsfOfLmFkrgUapwKQvl12tG7ca329qjaeptall/qjs0VlzIFEOiI2c8bJLII0FEIUuZ0
        f9FJAP/g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTJAw-0001r9-SN; Tue, 28 Apr 2020 05:52:58 +0000
Subject: Re: [PATCH v2] module: Allow to disable modsign in kernel cmdline
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, jeyu@kernel.org,
        corbet@lwn.net, mchehab+samsung@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200428050523.47253-1-tianjia.zhang@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aff03dbb-a1a3-c95e-1c24-60279b14970a@infradead.org>
Date:   Mon, 27 Apr 2020 22:52:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428050523.47253-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/27/20 10:05 PM, Tianjia Zhang wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7bc83f3d9bdf..00ed7566959f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3190,6 +3190,12 @@
>  	noirqdebug	[X86-32] Disables the code which attempts to detect and
>  			disable unhandled interrupt sources.
>  
> +	no_modsig_enforce
> +			[KNL] When CONFIG_MODULE_SIG_FORCE is set, this option
> +			allows to disable modsign completely at the beginning.
> +			This means that modules without (valid) signatures will
> +			success to load.

			succeed to load.

			succeed in loading.

			load successfully.
I prefer this one.....  ^^^^^^^^^^^^^^^^^^^^^

			be loaded successfully.


> +
>  	no_timer_check	[X86,APIC] Disables the code which tests for
>  			broken timer IRQ sources.
>  

thanks.
-- 
~Randy

