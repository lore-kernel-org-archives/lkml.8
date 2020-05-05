Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498F4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 01:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F8B206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 01:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/e9lu+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEEBC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 21:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgEEBC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 21:02:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA90C061A0F;
        Mon,  4 May 2020 18:02:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n11so249680pgl.9;
        Mon, 04 May 2020 18:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xWI9B+TTFg6yaOaByAdyaG7ErybvgpfTYV4ZnX/gXNU=;
        b=M/e9lu+WA5gmHWd39YNtW7Ij9rPgvgYgVGjhaHSDlAU5nuFCLD3+ttURpSHFknMUCF
         3S5xUU6hUrbSAlh3O626DpXUDPYvvZbBg0Wvfy0xKtYTxxZIeIZwh5XGJOsseNKY2Rwg
         +/+bUiZ5lX+IbdkKEYn9Ttm8svMG9y2C7g2lMmZUChSKyMOwlZB9M0pEzjdrQO4zljRa
         eeHlAdMrOWlKJJ4mX1NYYk4mL8v3P/21f49HZDSGFFMbvNskVfW/Kkmrov1OgD8AdVgV
         K+kPo9INMM3503gtWzTvzshN2pDH4VD/1a9KQMo2ta1GmdLCTOWz2TC9mDEsznmBHy4l
         DItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xWI9B+TTFg6yaOaByAdyaG7ErybvgpfTYV4ZnX/gXNU=;
        b=BjG+NZuv8YTlx0uv7EYNx+OAeK+sqiiuC6liDClsZCfMhaBsjeOlpLuGnLHgcbvdlv
         h87R27B8ITLw0PGh/5BJdFiohIUb+5Y2ICZMqXO+2MUtLGxMVav4GLfluD1s4yz7PsTy
         7leZVxj1OqDBZFpGljhvj4DD08csGk7pnDCv6/502xtzMnBnMqlTG5JIkOiLRIV2+OHJ
         iV/ofteURhBF3pm/BwdacE/NUIeuzHHK0yfabJATImLS4CpKnARbeba+DGo3L+FDa6/2
         2pciQRRdwh1t/Ck1+hPrUThSm+CqZEVTXqW8pYtX3OJyB8PmxeWOjMkbMkJ+EXWxh7dT
         7arA==
X-Gm-Message-State: AGi0PuZdLuabTUcGMcavNIiQjSZLpI/pxjaN9yvDMnjyo2qUrGbBP7rQ
        f/tPGw/W+HbFwuArLSbLi44=
X-Google-Smtp-Source: APiQypIJN6mfrLxWSSorrNczpKFfHUaeTe3q/8puMAqodEisMzc29qsPQGzzG4q1wih+BNpxcMDXXg==
X-Received: by 2002:aa7:951a:: with SMTP id b26mr690679pfp.44.1588640546407;
        Mon, 04 May 2020 18:02:26 -0700 (PDT)
Received: from localhost (146.85.30.125.dy.iij4u.or.jp. [125.30.85.146])
        by smtp.gmail.com with ESMTPSA id 3sm306652pfo.27.2020.05.04.18.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 18:02:25 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 5 May 2020 10:02:19 +0900
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/3] printk: honor the max_reason field in kmsg_dumper
Message-ID: <20200505010219.GA2282345@jagdpanzerIV.localdomain>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502143555.543636-2-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/02 10:35), Pavel Tatashin wrote:
[..]
> +static bool always_kmsg_dump;
> +module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);
>  
>  /**
>   * kmsg_dump_register - register a kernel log dumper.
> @@ -3106,6 +3108,12 @@ int kmsg_dump_register(struct kmsg_dumper *dumper)
>  	spin_lock_irqsave(&dump_list_lock, flags);
>  	/* Don't allow registering multiple times */
>  	if (!dumper->registered) {
> +		if (!dumper->max_reason) {
> +			if (always_kmsg_dump)
> +				dumper->max_reason = KMSG_DUMP_MAX;
> +			else
> +				dumper->max_reason = KMSG_DUMP_OOPS;
> +		}
>  		dumper->registered = 1;
>  		list_add_tail_rcu(&dumper->list, &dump_list);
>  		err = 0;

[..]

> @@ -3157,12 +3162,9 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>  	struct kmsg_dumper *dumper;
>  	unsigned long flags;
>  
> -	if ((reason > KMSG_DUMP_OOPS) && !always_kmsg_dump)
> -		return;
> -
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(dumper, &dump_list, list) {
> -		if (dumper->max_reason && reason > dumper->max_reason)
> +		if (reason > dumper->max_reason)
>  			continue;

Why always_kmsg_dump check moved from the dumper loop entry point to the
dumper registration code? What if the user change always_ksmsg_dump
dynamically via sysfs?

	-ss
