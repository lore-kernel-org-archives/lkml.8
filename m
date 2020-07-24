Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78942C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A99206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582237;
	bh=nCFgBu3omwx54faaWMaxjDb9i8wcpM4x0LN4rc5l4LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v2+A9KbPkVJ7yLesfnDZVBjqVyM5Y4OKtOdZCscBGHwSlGJML2G2RBFsiowXR8SEO
	 BUZHcPG6ih0gAMWuN9H4QQyZvujVlDzRnXWfa2iYOBsAxNfbZm0DoNY2T8OmaLZntb
	 sjb3vdKEc3nvXT5h3Qx8yHVfKb88hn/RfE9y2nVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGXJRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgGXJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:17:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C75FC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:17:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id f12so9246423eja.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/OC350Q0A9R/G9QPy9dkketdGLXiYUcXoiXvxtiFS3I=;
        b=chuTST1JaqOVT7yYQunPdIWjX5K7+V3f26TOUaT4KfzOSmf0pRhB9CnodvRIf/ombz
         Bxw5TQ9jSLFkknPnQYCUXvfuOMFTBb9K65ELT2jsylkPekxy/bOlU0C1c78dhTmMePsA
         PlNNVcPa31LsjUFOmI79sHMe09phtsApgsxDD2xxYH7Wy2oPpRHhC4PhsZAs0a77TIGb
         Aa4ApPuru4kGYdqJ2ihY2lhuMLJnyeN1w6qUG62Zp+mCktHh+gVest/yTVxkZGNd61a/
         6gu0WeAoM1Yb4Zp4dU9+tdw7XHas/8Y3HYvS9hWtWUEiZiOkeDgGVP4fHTEocjq+E1ie
         bKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/OC350Q0A9R/G9QPy9dkketdGLXiYUcXoiXvxtiFS3I=;
        b=WrmAu7viA/P8cgKfLCo0uPY7m+tXkzgcUjR72a7IzhOb2sYjv0RqF0pf72gEe2HkFi
         TxEnc5GvcKmOjbcwWY1sXvAYH1BB+vDGbf5p70Hygp20S1Yfy0QYaX3ShNmlStqWQ06+
         CPVhS8hlrlPcFCzqNjaMbShgGd7xE+vt9Dk53d9ocGqbsuvOqPywcydWUXEBFOPY428A
         2YP4/5bIkQrHkL/OtIGGas2kgfGnwJfAIPl8zAua5sBbFzOJX9o4X6YfXcThs2/NyvEY
         /46i6UlJPSYrjqCq+8+9r9cE+oRt0ahcGi4UL+48mEv0pQzkPKT+T/M8jR2AD1e3brqJ
         SVEw==
X-Gm-Message-State: AOAM532QrcfP5M6kovwBy4z75VfjDFM41Ssj427Wv8A3MIuNDwrOa7bE
        3OHq+7VYOqOm7HLVzM9NatU=
X-Google-Smtp-Source: ABdhPJzwOcbamfMswXat/5I2ZGN5RwAMcwz8bdlQYVANNSSFvVtSOr/BB0E/b8cwXbRRmp3FTOgzLg==
X-Received: by 2002:a17:906:6499:: with SMTP id e25mr8186466ejm.352.1595582234028;
        Fri, 24 Jul 2020 02:17:14 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v5sm296033ejj.61.2020.07.24.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 02:17:13 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:17:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 1/6] kprobes: Remove dependency to the module_mutex
Message-ID: <20200724091711.GB517988@gmail.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -564,7 +564,7 @@ static void kprobe_optimizer(struct work_struct *work)
>  	cpus_read_lock();
>  	mutex_lock(&text_mutex);
>  	/* Lock modules while optimizing kprobes */
> -	mutex_lock(&module_mutex);
> +	lock_modules();
>  
>  	/*
>  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> @@ -589,7 +589,7 @@ static void kprobe_optimizer(struct work_struct *work)
>  	/* Step 4: Free cleaned kprobes after quiesence period */
>  	do_free_cleaned_kprobes();
>  
> -	mutex_unlock(&module_mutex);
> +	unlock_modules();
>  	mutex_unlock(&text_mutex);
>  	cpus_read_unlock();

BTW., it would be nice to expand on the comments above - exactly which 
parts of the modules code is being serialized against and why?

We already hold the text_mutex here, which should protect against most 
kprobes related activities interfering - and it's unclear (to me) 
which part of the modules code is being serialized with here, and the 
'lock modules while optimizing kprobes' comments is unhelpful. :-)

Thanks,

	Ingo
