Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A65C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C732073E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 22:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b1NZ3QUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCWWdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 18:33:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42778 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWWdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 18:33:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id h8so7944579pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0+ekX362XTPZJu3MhQATXIXqUXtG5s7CcnngEAL+Izo=;
        b=b1NZ3QUpB8kyqAwX+eyh8GUPAXNDdOo1fCa5qf2EFSFPVbJdg07sptzq6SiNSW34i5
         ZWmyQbOPpGEoDsMvWnvurtNfNzkCUyns53hEoX3dawG18/5impvl8lZn5WXph6sSYxA8
         jm04jXIkWWISgkibF1MGcD4GUIygaajwRfRxRQoYb421YVaARMC13jM/IlQCMSuMsY91
         Azu/HDfOmz33wfgnx4n7F8dFgSNDMnsJD1XjNMbDDueKcb6MNqCPk8fC/X9RRFeGrgKF
         s1D3IWrT7WQO4jO5rzwukZcpKmhpsS13Aby/O2uyxX96wlFbaVOKsVs/8BUrsVU97CSQ
         n7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0+ekX362XTPZJu3MhQATXIXqUXtG5s7CcnngEAL+Izo=;
        b=mrx3McRvk0jzsfzNUML9f3kt7GcLft6W+wNSFzScZ0EWNurYjpP5RC6PyW7lhK1XhS
         cpgwsidodq5u/jdSRPTAHD4if7jRwXUTjZ9TQ6hkC6+0X4OyalrCa7rI0aKX6C1OpA2b
         G4svqtNSuR/97P3wMZ1NR7bsT0natvZtbM+JlTTw1wApSUy6uST76f5oJMOM/ox9neVF
         v/X8B6p2INIW+vO4+VSQY88fLYsY1SEEBTQpd8gr9SGxm7mbEKrQtlwQuH4JurQsj1xH
         apcHWrfY3zgrOtLaUFYZSBTapxmxA0DmPzhpcuV0GYS7/sdALmeeDMzpW39GnHgobqIT
         z4ww==
X-Gm-Message-State: ANhLgQ21H2MVACMRdgfhq4HO+FLTbdhL6HLn2ha1dsnAMqecnEE8WnHB
        JdkIqlM9fQ923h17k0B3NYznvg==
X-Google-Smtp-Source: ADFU+vtefTwL6Il0Xt8K5zlmPRXAiFzgLNisLSnIcnujFjC7yBzql5SiSmblDDlkqMGnLglZXAPmpA==
X-Received: by 2002:a63:4912:: with SMTP id w18mr23539999pga.122.1585002784637;
        Mon, 23 Mar 2020 15:33:04 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e9sm14427742pfl.179.2020.03.23.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 15:33:04 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:33:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] remoteproc: Introduce "panic" callback in ops
Message-ID: <20200323223302.GC30464@xps15>
References: <20200310063817.3344712-1-bjorn.andersson@linaro.org>
 <20200310063817.3344712-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310063817.3344712-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 11:38:15PM -0700, Bjorn Andersson wrote:
> Introduce generic support for handling kernel panics in remoteproc
> drivers, in order to allow operations needed for aiding in post mortem
> system debugging, such as flushing caches etc.
> 
> The function can return a number of milliseconds needed by the remote to
> "settle" and the core will wait the longest returned duration before
> returning from the panic handler.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Change since v3:
> - Migrate from mutex_trylock() to using RCU
> - Turned the timeout to unsigned long
> 
>  drivers/remoteproc/remoteproc_core.c | 44 ++++++++++++++++++++++++++++
>  include/linux/remoteproc.h           |  3 ++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index f0a77c30c6b1..2024a98930bf 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -16,6 +16,7 @@
>  
>  #define pr_fmt(fmt)    "%s: " fmt, __func__
>  
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> @@ -43,6 +44,7 @@
>  
>  static DEFINE_MUTEX(rproc_list_mutex);
>  static LIST_HEAD(rproc_list);
> +static struct notifier_block rproc_panic_nb;
>  
>  typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
>  				 void *, int offset, int avail);
> @@ -2219,10 +2221,51 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>  }
>  EXPORT_SYMBOL(rproc_report_crash);
>  
> +static int rproc_panic_handler(struct notifier_block *nb, unsigned long event,
> +			       void *ptr)
> +{
> +	unsigned int longest = 0;
> +	struct rproc *rproc;
> +	unsigned int d;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(rproc, &rproc_list, node) {
> +		if (!rproc->ops->panic || rproc->state != RPROC_RUNNING)
> +			continue;
> +
> +		d = rproc->ops->panic(rproc);
> +		longest = max(longest, d);
> +	}
> +	rcu_read_unlock();
> +
> +	/*
> +	 * Delay for the longest requested duration before returning.
> +	 * This can be used by the remoteproc drivers to give the remote
> +	 * processor time to perform any requested operations (such as flush
> +	 * caches), where means for signalling the Linux side isn't available

There is a problem with the above sentence.

> +	 * while in panic.
> +	 */
> +	mdelay(longest);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static void __init rproc_init_panic(void)
> +{
> +	rproc_panic_nb.notifier_call = rproc_panic_handler;
> +	atomic_notifier_chain_register(&panic_notifier_list, &rproc_panic_nb);
> +}
> +
> +static void __exit rproc_exit_panic(void)
> +{
> +	atomic_notifier_chain_unregister(&panic_notifier_list, &rproc_panic_nb);
> +}
> +
>  static int __init remoteproc_init(void)
>  {
>  	rproc_init_sysfs();
>  	rproc_init_debugfs();
> +	rproc_init_panic();
>  
>  	return 0;
>  }
> @@ -2232,6 +2275,7 @@ static void __exit remoteproc_exit(void)
>  {
>  	ida_destroy(&rproc_dev_index);
>  
> +	rproc_exit_panic();
>  	rproc_exit_debugfs();
>  	rproc_exit_sysfs();
>  }
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad66683ad0..5959d6247dc0 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -369,6 +369,8 @@ enum rsc_handling_status {
>   *			expects to find it
>   * @sanity_check:	sanity check the fw image
>   * @get_boot_addr:	get boot address to entry point specified in firmware
> + * @panic:	optional callback to react to system panic, core will delay
> + *		panic at least the returned number of milliseconds
>   */
>  struct rproc_ops {
>  	int (*start)(struct rproc *rproc);
> @@ -383,6 +385,7 @@ struct rproc_ops {
>  	int (*load)(struct rproc *rproc, const struct firmware *fw);
>  	int (*sanity_check)(struct rproc *rproc, const struct firmware *fw);
>  	u32 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
> +	unsigned long (*panic)(struct rproc *rproc);
>  };
>  
>  /**
> -- 
> 2.24.0
> 
