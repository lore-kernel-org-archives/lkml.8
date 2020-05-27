Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B56C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8B32078B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiOtfTb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgE0I3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbgE0I3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:29:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB641C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:29:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so9492065wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ieXuEPyp84YB4GCGexw/j3cGASehKyzX4KKOE2VbBQw=;
        b=IiOtfTb5HALp4h7n/CPvhJgyDwm8hS5bTwq2E+SrwdVZ72vGOW8yYwTLWfNrzyXILt
         N/XR79Zp+D7888hHIB3T9s7iR+qtCGadav3UPlHMxaDj61jeVDgAn6qUCbjtxvc+0imP
         TuhnHNKszTK3JTFYcyjJ5u7XnYwztI0owFyQUapUBfYkkZPIwzpkcxxVCCUku7MtrtNA
         nSok9J3eqMAOJlK3KuV2OYRJJJnl3gCfcCwXGNxrOAGIQNVy4GNXJ4gD3cldG7OjURVx
         U+AWgtZ3QoclVp2Ed8uqgKWolA2YmmMkcdXH1UQf6jXZ0JkG0xFsTsPdovOXiMh2zST8
         yIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ieXuEPyp84YB4GCGexw/j3cGASehKyzX4KKOE2VbBQw=;
        b=cPlQwsuX0u2ArVzgqjBgkyR7or/mqn3puf5jfE+qb2koxKKGobWrqV3mDDO3fsqQ2N
         nsyDFy23UZ/TpHoMIPYwG2/2kwRn//DixpgWID7TJrWt001onHoq+X4o8B9unBYhz5we
         IM1/dSl0UWU2oXyKMK1V1OmZ2BN7dLbp1uGDV65Mg0jmVuCCMT9dVZhkJCY0bMAC1Jdj
         BjDG0PD5prQc8/Pyhsy9ijwI1+z8KoFVvPn2CeN6rN2Fntunxd4iKG+k4aM+H1cd3jFy
         63vNf3qSfcq4E/n5IIZiz5g+atxd5BVA4Q05jM+85qjPXvd+p0B8uMrrKV6IrJx812mv
         C8Tw==
X-Gm-Message-State: AOAM530NH0MvdU2XAYqMFjJC0W/3Cz4kPwqtmivMX4YW93is049nNf/W
        Vl0eHabmrVGtwmlqCswnzNyQfg==
X-Google-Smtp-Source: ABdhPJyp6CfVVFZ/i6wR825VQrWhVTTRp7aQCdpTaPVm81g7I1wKh+7Q0Cv9pMyWeYmavyhFa0O9bA==
X-Received: by 2002:adf:dc50:: with SMTP id m16mr23880325wrj.329.1590568152559;
        Wed, 27 May 2020 01:29:12 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h7sm2159191wml.24.2020.05.27.01.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 01:29:11 -0700 (PDT)
Date:   Wed, 27 May 2020 09:29:07 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] kdb: Re-factor kdb_printf() message write code
Message-ID: <20200527082907.wfvdsekmyzbpu3tu@holly.lan>
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
 <1590560759-21453-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590560759-21453-2-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:55:56AM +0530, Sumit Garg wrote:
> Re-factor kdb_printf() message write code in order to avoid duplication
> of code and thereby increase readability.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 61 +++++++++++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 924bc92..f6b4d47 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -542,6 +542,33 @@ static int kdb_search_string(char *searched, char *searchfor)
>  	return 0;
>  }
>  
> +static void kdb_io_write(char *cp, int len, void (*io_put_char)(u8 ch))

Don't use a function pointer here. Just pick it up from dbg_io_ops as
usual.


> +{
> +	if (len <= 0)
> +		return;

How can len ever be negative?


> +
> +	while (len--) {
> +		io_put_char(*cp);
> +		cp++;
> +	}
> +}
> +
> +static void kdb_msg_write(char *msg, int msg_len)
> +{
> +	struct console *c;
> +
> +	if (msg_len <= 0)
> +		return;

How can msg_len ever be negative?


> +
> +	if (dbg_io_ops && !dbg_io_ops->is_console)
> +		kdb_io_write(msg, msg_len, dbg_io_ops->write_char);
> +
> +	for_each_console(c) {
> +		c->write(c, msg, msg_len);
> +		touch_nmi_watchdog();
> +	}
> +}
> +
>  int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  {
>  	int diag;
> @@ -553,7 +580,6 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  	int this_cpu, old_cpu;
>  	char *cp, *cp2, *cphold = NULL, replaced_byte = ' ';
>  	char *moreprompt = "more> ";
> -	struct console *c;
>  	unsigned long uninitialized_var(flags);
>  
>  	/* Serialize kdb_printf if multiple cpus try to write at once.
> @@ -687,22 +713,11 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  	 */
>  	retlen = strlen(kdb_buffer);
>  	cp = (char *) printk_skip_headers(kdb_buffer);
> -	if (!dbg_kdb_mode && kgdb_connected) {
> +	if (!dbg_kdb_mode && kgdb_connected)
>  		gdbstub_msg_write(cp, retlen - (cp - kdb_buffer));
> -	} else {
> -		if (dbg_io_ops && !dbg_io_ops->is_console) {
> -			len = retlen - (cp - kdb_buffer);
> -			cp2 = cp;
> -			while (len--) {
> -				dbg_io_ops->write_char(*cp2);
> -				cp2++;
> -			}
> -		}
> -		for_each_console(c) {
> -			c->write(c, cp, retlen - (cp - kdb_buffer));
> -			touch_nmi_watchdog();
> -		}
> -	}
> +	else
> +		kdb_msg_write(cp, retlen - (cp - kdb_buffer));
> +
>  	if (logging) {
>  		saved_loglevel = console_loglevel;
>  		console_loglevel = CONSOLE_LOGLEVEL_SILENT;
> @@ -751,19 +766,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
>  			moreprompt = "more> ";
>  
>  		kdb_input_flush();
> -
> -		if (dbg_io_ops && !dbg_io_ops->is_console) {
> -			len = strlen(moreprompt);
> -			cp = moreprompt;
> -			while (len--) {
> -				dbg_io_ops->write_char(*cp);
> -				cp++;
> -			}
> -		}
> -		for_each_console(c) {
> -			c->write(c, moreprompt, strlen(moreprompt));
> -			touch_nmi_watchdog();
> -		}
> +		kdb_msg_write(moreprompt, strlen(moreprompt));
>  
>  		if (logging)
>  			printk("%s", moreprompt);
> -- 
> 2.7.4
> 
