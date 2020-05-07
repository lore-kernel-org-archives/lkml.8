Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41726C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6332145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FaGuhBOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgEGSCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgEGSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:02:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1EC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:02:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b6so2357108plz.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RcV9lFh0IW1N+XHaoImBLGRzG64WEmrZADnXXHQ+xEw=;
        b=FaGuhBOb8Z469hrDfs6vsVsvoQgKcxtPvTN256HuPR18U0yw2VUUtU8/pjPfcRCDEN
         sGQZ3k0HLtLtMtSGbBqPZQ2KN6pC/7KLzY/BJ+HtHbvlLLMOHudRKh1zoCjaJb2WE3lV
         GtqAPDel/iGBpnVwe8/QLWFa8wVii5Y+bFp60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RcV9lFh0IW1N+XHaoImBLGRzG64WEmrZADnXXHQ+xEw=;
        b=pJ8+c8XnMFaUJIoq1jimgAMhPQNZb/f7i+XUrqWJ+0Rn4bN4Uwy7AXwS3aNSJek85A
         AI3P+dHLt1HXZqVGfTXmgApeSaJglC6wV57O/G8B2QurO9rr8dICBIx6uF6MLK4PEkNM
         llRy7X0rvtm4zVL6rNKTJBVsffQ8C0dcA5RuI/7X3+EpGOofbtPT7zaO5OP9MmXuN+5o
         dyYaYOTP0BSz7P9PzWtdH4ZEM/pMrDik15GjRfe8ME/WTBl4WYSTqDCcex7IDVhWt6z6
         FmFFKdGRA/bUGUWAE81oxWo7WVRykXwxM4KxqLMzaxVnJ8ekWR1MKEIbon6yIPhkwxK3
         BkOA==
X-Gm-Message-State: AGi0PuYD1lrmWsvPb7vSw6cF0dgwBxQnvl4CsmTvEoDhEEa0vddfcz4R
        ASikIyphMn7cZJqgY9dA0AwDfQ==
X-Google-Smtp-Source: APiQypJKk+TbElDSjc9LxL9Q/oaEJix7niFewv4zimIZp6EwRkySvviGZeAu9Fq+9oA2ikbs9CHxWw==
X-Received: by 2002:a17:90a:25cb:: with SMTP id k69mr1327983pje.93.1588874540257;
        Thu, 07 May 2020 11:02:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b75sm421141pjc.23.2020.05.07.11.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:02:19 -0700 (PDT)
Date:   Thu, 7 May 2020 11:02:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH RESEND] tpm: eventlog: Replace zero-length array with
 flexible-array member
Message-ID: <202005071058.A2234694ED@keescook>
References: <20200507040912.GA31382@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507040912.GA31382@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:09:12PM -0500, Gustavo A. R. Silva wrote:
> As mentioned above: "Flexible array members have incomplete type, and
> so the sizeof operator may not be applied. As a quirk of the original
> implementation of zero-length arrays, sizeof evaluates to zero."[1] So,
> the sizeof(flexible-array) can be safely removed to fix the error above.

As in "sizeof(event_header->event) always evaluated to 0, so removing it
has no effect".

> [...]
> diff --git a/drivers/char/tpm/eventlog/tpm2.c b/drivers/char/tpm/eventlog/tpm2.c
> index e741b1157525..351a2989b3c6 100644
> --- a/drivers/char/tpm/eventlog/tpm2.c
> +++ b/drivers/char/tpm/eventlog/tpm2.c
> @@ -51,8 +51,7 @@ static void *tpm2_bios_measurements_start(struct seq_file *m, loff_t *pos)
>  	int i;
>  
>  	event_header = addr;
> -	size = sizeof(struct tcg_pcr_event) - sizeof(event_header->event)
> -		+ event_header->event_size;
> +	size = sizeof(*event_header) + event_header->event_size;

That said, I think it would be better to stick to the struct_size()
idiom for dealing with flexible arrays here:

	size = struct_size(event_header, event, event_size);

-- 
Kees Cook
