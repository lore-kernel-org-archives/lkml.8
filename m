Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7598BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44850214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IKGkaEps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBFMct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:32:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37358 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBFMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:32:49 -0500
Received: by mail-ot1-f65.google.com with SMTP id d3so5303835otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iLM+7gqdqC3q396oekNhXmeqeD/6nzSHAkgAw8RRcxI=;
        b=IKGkaEpsAEhkpEYCecxs9GUUfuL6q0mDPlCzadw0HhY3rPXN9CL5BBAWqteJekBDK6
         gHdUv4wAoxpNB9mRPtDrnGP/QTjlnOBxGVh5GEs5vXFlsfiAcEbbg45BRs9B906ssBHp
         dxLSSFSB/85Jd0J8zOwY6flBEvzL43fj7aNIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iLM+7gqdqC3q396oekNhXmeqeD/6nzSHAkgAw8RRcxI=;
        b=e4fj/Dux/wu0IRvDHdGx3831J/+32dFubONslPDEXCbb9+6fBdnCFcJKyNyPR7vuwN
         bqtWT/4sD7+HXnGc6cX2uEPl7W9WT53far4/1yo+7VW2ljwfe3kBLlv6vXJ7b/YCeR1d
         NftYrSwx0V5AHUQZh+QDrQZ5Bu5M3NNFw2bXSTC6RoZCeJdCKCgegfNFfzLdvOOsbRaH
         ZrNz/f4uwJODSOJWfwlZ+wNKZwfOlkooW1V/LpL+NcyWk3BpX8JNIvpzGGNsUq1AFErv
         eFFVdO5HuVqZjAdPcMHp9zTMq3tRsh23medjW0VXOmRVMam0SaMsLIgHNa4UjVzGSMF5
         bbGQ==
X-Gm-Message-State: APjAAAVCUodix7/V8yEi/aNK+wPqob2m9pYLppOH89QboM4tliNF8qd4
        iaTJhVOxrA2O+CKciWtVAWo0nw==
X-Google-Smtp-Source: APXvYqz7Dv7a6C0TGyAiI0uDPQQDJJRkHgW/v/JXRpd1WQSzplbgixhc1y27uidc+q+YSRZxKd1WEA==
X-Received: by 2002:a05:6830:1050:: with SMTP id b16mr30676098otp.140.1580992367936;
        Thu, 06 Feb 2020 04:32:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m68sm875700oig.50.2020.02.06.04.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 04:32:47 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:32:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 09/11] kallsyms: hide layout and expose seed
Message-ID: <202002060428.08B14F1@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-10-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223950.1212394-10-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:39:48PM -0800, Kristen Carlson Accardi wrote:
> To support finer grained kaslr (fgkaslr), we need to make a couple changes
> to kallsyms. Firstly, we need to hide our sorted list of symbols, since
> this will give away our new layout. Secondly, we will export the seed used
> for randomizing the layout so that it can be used to make a particular
> layout persist across boots for debug purposes.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> ---
>  kernel/kallsyms.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 136ce049c4ad..432b13a3a033 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -698,6 +698,21 @@ const char *kdb_walk_kallsyms(loff_t *pos)
>  }
>  #endif	/* CONFIG_KGDB_KDB */
>  
> +#ifdef CONFIG_FG_KASLR
> +extern const u64 fgkaslr_seed[] __weak;
> +
> +static int proc_fgkaslr_show(struct seq_file *m, void *v)
> +{
> +	seq_printf(m, "%llx\n", fgkaslr_seed[0]);
> +	seq_printf(m, "%llx\n", fgkaslr_seed[1]);
> +	seq_printf(m, "%llx\n", fgkaslr_seed[2]);
> +	seq_printf(m, "%llx\n", fgkaslr_seed[3]);
> +	return 0;
> +}
> +#else
> +static inline int proc_fgkaslr_show(struct seq_file *m, void *v) { return 0; }
> +#endif
> +

I'd like to put the fgkaslr seed exposure behind a separate DEBUG
config, since it shouldn't be normally exposed. As such, its
infrastructure should be likely extracted from this and the main fgkaslr
patches and added back separately (and maybe it will entirely vanish
once the RNG is switched to ChaCha20).

>  static const struct file_operations kallsyms_operations = {
>  	.open = kallsyms_open,
>  	.read = seq_read,
> @@ -707,7 +722,20 @@ static const struct file_operations kallsyms_operations = {
>  
>  static int __init kallsyms_init(void)
>  {
> -	proc_create("kallsyms", 0444, NULL, &kallsyms_operations);
> +	/*
> +	 * When fine grained kaslr is enabled, we don't want to
> +	 * print out the symbols even with zero pointers because
> +	 * this reveals the randomization order. If fg kaslr is
> +	 * enabled, make kallsyms available only to privileged
> +	 * users.
> +	 */
> +	if (!IS_ENABLED(CONFIG_FG_KASLR))
> +		proc_create("kallsyms", 0444, NULL, &kallsyms_operations);
> +	else {
> +		proc_create_single("fgkaslr_seed", 0400, NULL,
> +					proc_fgkaslr_show);
> +		proc_create("kallsyms", 0400, NULL, &kallsyms_operations);
> +	}
>  	return 0;
>  }
>  device_initcall(kallsyms_init);
> -- 
> 2.24.1

In the past, making kallsyms entirely unreadable seemed to break weird
stuff in userspace. How about having an alternative view that just
contains a alphanumeric sort of the symbol names (and they will continue
to have zeroed addresses for unprivileged users)?

Or perhaps we wait to hear about this causing a problem, and deal with
it then? :)

-- 
Kees Cook
