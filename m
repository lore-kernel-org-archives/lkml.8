Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC9B2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpKxafWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgETElc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgETElb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:41:31 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77524C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:41:31 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id z15so1916383pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNzZMb4abnBJGHUUJYtxB43fFlAO5Np4UdHnHR6W5uM=;
        b=jpKxafWHlk+cpoA66DvK9wDMJ6uSsNrDv5JAzIPSZpkR7dZ/1qN1vn2FW4cxNwpMhk
         hqqKFpzUoKRBVEggvxyFhDPIM/krU98vP0TJFXr1dSjQTTPWy3A6GYtZ+YFB2ACrVRhq
         rvh1fTXWT24HsrpZPy+zocYsmtYLDNCrWgdCULHj0BDeN262PYjLyMrMn9Ku3VtM95/z
         0RvLMtPXZ6iSi7glG8HFx+xdWWAtFTUlkClRqm8krlEaXHY0vtbKqPKnwAtUVj3mD2BR
         IZ3CjF8ViEP0xT5exqelTK7hlMcoic5+PxlRFtUvPJgXvbsUcii0Ty/Xv4L/gmJC1CLS
         8SAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNzZMb4abnBJGHUUJYtxB43fFlAO5Np4UdHnHR6W5uM=;
        b=e1TdCzEw+1a0gn/aB7itLahzamCv0jAPLxXZJHMlHaKtPEE+a84XvDPuje4kFN3j+9
         6oc4ZRPxsSg04f6pOCofq6D9x+EaQ2axrBQEUlT5XWmZcgcezQi8nDqaZjJn/9l2kywW
         JvAHJ81zStquoLMLALhwDVd0s3MWHfPW9gIOlK/meyBLidlyJvMAbFMU8Tw065VLg38L
         6jiETZ/22oCeaOXVMp0X/ER8fI0iMcdsoT46BOcrl2dwkNsZoeBtWvLLmcbe9S/shR3Y
         VikdBWonJVv2CnMrZ6q2GfDN2lMAqQd1suwLNw1WuKg3cYW7IcMeb9JJdK1o98qRydaq
         uGCA==
X-Gm-Message-State: AOAM5301wmkdR3kacAwtAdduQqt6kmkTwljSsv79kNdFTFoHn50lEjZ7
        Ct9Jwc5lnaERZYeuAL/XHCI=
X-Google-Smtp-Source: ABdhPJykXVExNNSezeS6iZy49dvLFRknJCvCYO50NTOUQL2UBmGZtSpuszY2HJcDAknF7oFiC4UFBA==
X-Received: by 2002:a17:90a:332e:: with SMTP id m43mr3118241pjb.236.1589949689972;
        Tue, 19 May 2020 21:41:29 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id o201sm957807pfd.115.2020.05.19.21.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 21:41:29 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 20 May 2020 13:41:27 +0900
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200520044127.GB938@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/19 12:42), Joe Perches wrote:
> +static void __init print_cmdline(char *line)
> +{
> +#ifdef CONFIG_PRINTK
> +	const char *prefix = "Kernel command line";
> +	size_t len = strlen(line);
> +
> +	while (len > PRINTK_LOG_LINE_MAX) {
> +		char *pos = line;
> +		char *last_pos = pos + PRINTK_LOG_LINE_MAX - 1;
> +		char saved_char;
> +		/* Find last space char within the maximum line length */
> +		while ((pos = memchr(pos, ' ', len - (pos - line))) &&
> +		       (pos - line) < PRINTK_LOG_LINE_MAX - 1) {

Don't you need to also count in the 'prefix' length?

> +			last_pos = pos;
> +		}
> +		saved_char = line[last_pos - line];
> +		line[last_pos - line] = 0;
> +		pr_notice("%s: %s\n", prefix, line);
> +		prefix = "Kernel command line (continued)";
> +		line[last_pos - line] = saved_char;
> +		len -= pos - line;
> +		line += pos - line;
> +	}
> +
> +	pr_notice("%s: %s\n", prefix, line);
> +#endif
> +}

I like this in general. And I agree that we better handle this
externally, on the printk() caller side, so that printk() will
still have sane limits and won't print a 1G string for example.

I wonder if we need to export PRINTK_LOG_LINE_MAX. Maybe we can
use here something rather random and much shorter instead. E.g.
256 chars. Hmm. How many crash/monitoring tools can get confused
by multiple "Kernel command line" prefixes?

	-ss
