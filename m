Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA529C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB80246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dZgxgB/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgB1OVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:21:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42966 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1OVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:21:25 -0500
Received: by mail-qk1-f194.google.com with SMTP id o28so3041478qkj.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 06:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zxTduCTfg/OrDpDovq9JnjmfGeVXyQFoQrsMpBvo3Ow=;
        b=dZgxgB/WmmtkL+gC2oCvv/1E5BKlgyBEvLQ2xCrhz6LQblwAVBlJxjky+Hz839DWks
         krQIYMWtkIgy7zmqyVkCkt43zuHpLcwXk2tF0PVXv895pVpU/SkY/FvJ0pAl34p6zn5K
         QGfDB8V9Ld3YPrttag7OxG/0HoI/XJtPV0tI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zxTduCTfg/OrDpDovq9JnjmfGeVXyQFoQrsMpBvo3Ow=;
        b=q1z2xlOB6Dt/juxP/VnAILCylD5xvl543YMQuAYTyJo2hrgsWt1R3qTr2InjsS2ehG
         elrz4yGVS+DS3t2Zv5S85vGKg3YPuQuBpolyc8kQ5LtG4+P+hDw8HSmRXnQPqovDvlQ3
         qmeGqIXOge0DOLYRL+ndYlI4qggOGE7I8XLJlmD4tQelOfh5tpnOoItc9rsLs1kDpYvE
         eJhNI/thacoRVAVWPb6r74LRoWVqZ794mtW+lt0bzpaNn9wzJ8gpvjyoJtmq5ZH3fXXQ
         Jjh5syCh7d4fWgoVPZv7/nMQmiGvxVB1D1OzEkt1YvURO38MDAvVDGcYoSqW3K7DLyYS
         muRw==
X-Gm-Message-State: APjAAAWmQqTDEB6GdFX+CXQJCpesboZSEUl65aCQhVswFM2LoL9XInmh
        ONhSh7rn8vZh6ndksbUB+CRRiw==
X-Google-Smtp-Source: APXvYqwsQWvWd/xsix8ctQluoCIEHDrjjsJMF1erCPPFZ/q4bQOKp13axSHWs6kQs2JP7QqCEdko1g==
X-Received: by 2002:a37:b86:: with SMTP id 128mr4411810qkl.159.1582899684016;
        Fri, 28 Feb 2020 06:21:24 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b7sm5120708qtj.78.2020.02.28.06.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:21:23 -0800 (PST)
Date:   Fri, 28 Feb 2020 09:21:22 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] Default enable RCU list lockdep debugging with PROVE_RCU
Message-ID: <20200228142122.GA97131@google.com>
References: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:54:51PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch default enables CONFIG_PROVE_RCU_LIST option with
> CONFIG_PROVE_RCU for RCU list lockdep debugging.
> 
> With this change, RCU list lockdep debugging will be default
> enabled in CONFIG_PROVE_RCU=y kernels.
> 
> Most of the RCU users (in core kernel/, drivers/, and net/
> subsystem) have already been modified to include lockdep
> expressions hence RCU list debugging can be enabled by
> default.
> 
> However, there are still chances of enountering
> false-positive lockdep splats because not everything is converted,
> in case RCU list primitives are used in non-RCU read-side critical
> section but under the protection of a lock. It would be okay to
> have a few false-positives, as long as bugs are identified, since this
> patch only affects debugging kernels.
> 
> Co-developed-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Amol Grover <frextrite@gmail.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> ---
>  kernel/rcu/Kconfig.debug | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> index 4aa02eee8f6c..ec4bb6c09048 100644
> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -9,15 +9,10 @@ config PROVE_RCU
>  	def_bool PROVE_LOCKING
>  
>  config PROVE_RCU_LIST
> -	bool "RCU list lockdep debugging"
> -	depends on PROVE_RCU && RCU_EXPERT
> -	default n
> +	def_bool PROVE_RCU
>  	help
> -	  Enable RCU lockdep checking for list usages. By default it is
> -	  turned off since there are several list RCU users that still
> -	  need to be converted to pass a lockdep expression. To prevent
> -	  false-positive splats, we keep it default disabled but once all
> -	  users are converted, we can remove this config option.
> +	  Enable RCU lockdep checking for list usages. It is default
> +	  enabled with CONFIG_PROVE_RCU.
>  
>  config TORTURE_TEST
>  	tristate
> -- 
> 2.17.1
> 
