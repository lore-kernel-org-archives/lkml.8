Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A705DC35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713A4206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JJU1PGIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgBVA7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:59:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgBVA7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=7n9xygDFZKB1qJDIUCnXWl1mN8mPEtPMFO+ObKxyP7U=; b=JJU1PGIsZ8fJFZxIQyYqTKZ4bk
        u29aD3YWmu+i5iIERfzW7es3+g7X4Zq8nlfTACh0a60aqkuDiFZBpVNi2YXycAZa5dZvq2RbfoAwW
        P6iJNN3gP2O8jnTsW5SLuXwEmF+bfDQsl7J3nS5X80b74moJUf1gz9F4tffVkBXIDA6t289Fi5/CU
        xZi13mCk7OTKfF/uNoxKYx9hXObT6o2AjAriTTrvnPdzaDPM88U3y1sHGypSfmTnRGRveqpt6tRuK
        u9MsLeX9rrXFY7nnonQDkiB+3yIxuoqTGSfH+5ktYaxdpH7gRuH4zFaFZDncKK/rBG9HXwufVhGCN
        OEzJDSMQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5J93-0006r2-2l; Sat, 22 Feb 2020 00:59:49 +0000
Subject: Re: [Patch v10 1/9] sched/pelt: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <20200222005213.3873-1-thara.gopinath@linaro.org>
 <20200222005213.3873-2-thara.gopinath@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <db1a554a-1c8a-0078-def5-4b5f1ee68c99@infradead.org>
Date:   Fri, 21 Feb 2020 16:59:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200222005213.3873-2-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 4:52 PM, Thara Gopinath wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index 2a25c769eaaa..8d56902efa70 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -464,6 +464,10 @@ config HAVE_SCHED_AVG_IRQ
>  	depends on IRQ_TIME_ACCOUNTING || PARAVIRT_TIME_ACCOUNTING
>  	depends on SMP
>  
> +config HAVE_SCHED_THERMAL_PRESSURE
> +	bool "Enable periodic averaging of thermal pressure"

This prompt string makes this symbol user-configurable, but
I don't think that's what you want here.

> +	depends on SMP
> +
>  config BSD_PROCESS_ACCT
>  	bool "BSD Process Accounting"
>  	depends on MULTIUSER


-- 
~Randy

