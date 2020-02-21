Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08EC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE26206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGaegs+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgBUPLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:11:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45717 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgBUPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:11:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so1341254pfg.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EPaZAGIdQNNRx5FT0S5HGrWG97/B+Kd5Gb2TTiFcslU=;
        b=mGaegs+GAG441Kdu38Z8XuEPOfezAssXwNmHjkqBIuJGPPyfHrCB+tRQsRt3TGoU5H
         CZINBKeibmOlj1BWiK53HLb8Bi+A6GbCJpAJnojrl98BetnRejfpz6NjaaknoIzwZxu0
         gnhkp79V4FqX60EbDlJZWgoaWouPj2oFxJh7kH96gGo1JaWIrsA2FpbWOi1BsSfrgsUh
         6pB2o0tZrtueO+b7IZqZjkJ2te6J/5ty1dy7Y+wm3gWyuBQdk6Qtg9bhF2/o295DlrGl
         KVM8iRo5Q3yMAXWY9ZlinqCczsLKMZCIQ9I1SqZUe0R4enAIxYdDbY0SCHuxzp0L67U+
         PAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EPaZAGIdQNNRx5FT0S5HGrWG97/B+Kd5Gb2TTiFcslU=;
        b=ucARnVhJPIYzLILSw1B25DxGMgyl+Xu4X7Wu/DtH5XbNfB7hrtvhlqtZxLtVQnwMUq
         aCihLFWT1m68BN/K4yx4fx6I7SSSCJ+nm1ufTUmsvpdiD5kZRm3XV7iViwHGSBA5Udkl
         Q3/jPYDjKsLlDoeJNy2917wWuj8ep1W5sXnmX5yFPo1Q3Wsookh5PADYGOzh2Y2ihw5J
         kLqLEeYZ+o80WIiWDMkFK/zsIjpMXCtIEYyu9E1iVMhoownyAhnbC1lvyWjHoUZaTsle
         zA7+BTPUGjYJk+JT9KhanhbGxfXKOsrOWnPyXVYWeBvsNDoKMXVezwD9K8xJ9z671qf8
         GHmA==
X-Gm-Message-State: APjAAAVeXkTn2YfkPRf5HKZbwp/uNKSC9xUHMCs6WIwBgZ0TIsURHBO6
        osw4DSHfNQ+bi3p3JFbBlzrTt0IB
X-Google-Smtp-Source: APXvYqzh/W8p3kgkN2cAcV1BLy18fV4cmIJKyiPZSsVRc3Hr+K8waC0rKPKS+kE8XYm5WS+fUoYjAg==
X-Received: by 2002:a63:5220:: with SMTP id g32mr38280238pgb.116.1582297875614;
        Fri, 21 Feb 2020 07:11:15 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:61bc])
        by smtp.gmail.com with ESMTPSA id t11sm2925324pjo.21.2020.02.21.07.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 07:11:14 -0800 (PST)
Date:   Fri, 21 Feb 2020 07:11:10 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] kallsyms: Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-ID: <20200221151109.gxrhyaybjwxqktul@ast-mbp>
References: <20200221114404.14641-1-will@kernel.org>
 <20200221114404.14641-4-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221114404.14641-4-will@kernel.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:44:04AM +0000, Will Deacon wrote:
> kallsyms_lookup_name() and kallsyms_on_each_symbol() are exported to
> modules despite having no in-tree users and being wide open to abuse by
> out-of-tree modules that can use them as a method to invoke arbitrary
> non-exported kernel functions.
> 
> Unexport kallsyms_lookup_name() and kallsyms_on_each_symbol().
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/kallsyms.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index a9b3f660dee7..16c8c605f4b0 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -175,7 +175,6 @@ unsigned long kallsyms_lookup_name(const char *name)
>  	}
>  	return module_kallsyms_lookup_name(name);
>  }
> -EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
>  
>  int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
>  				      unsigned long),
> @@ -194,7 +193,6 @@ int kallsyms_on_each_symbol(int (*fn)(void *, const char *, struct module *,
>  	}
>  	return module_kallsyms_on_each_symbol(fn, data);
>  }
> -EXPORT_SYMBOL_GPL(kallsyms_on_each_symbol);

Looking at commit 75a66614db21 ("Ksplice: Add functions for walking kallsyms symbols")
this change will break ksplice.
But I think it's the right call. live-patching needs to find a way to be better
integrated with the core kernel.

Acked-by: Alexei Starovoitov <ast@kernel.org>
