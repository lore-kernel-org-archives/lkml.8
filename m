Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C10C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA40E206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582005;
	bh=GwUoeHKlzK+7TgCjiNMlngu0AM0uKPGk+x42+JPepC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tLzH3yjD35Nw963ABOJV5nOuPMaKiDPfURIxbaiUn0Ht9uoe9A7kv0OeqYY7yUzov
	 l+0mRa3DAdDBe4nyhjwZ43V3KvAAXmkp8d7Q+TVA2HYTA5H5xsBn2brQA9teOEgWdl
	 7zOQ7ci5KP5Sg8Oequ6fPm+JVN5oLoyclHlcu980=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGXJNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGXJNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:13:24 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D490BC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:13:23 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id ga4so9229444ejb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=13FtjbtfLSbB7lUu2KMXehtRfJlBejW7Rr8iZY5Tpxo=;
        b=nDzT8+/vlYwD6OAFh3eCjMgEf1dSl503zdnwgMgotSNyUi0fcH8vWETzUUnuxBH01A
         x0FfzQ8ksNoPjskd8E1OpmMiR/RotwWL28mY6QuxcqxNWhwW22zwu9ye+CrhX76LbdWY
         XA1jbo4lWMU1AymNlEoag9jqAE09KwZDuY0KeWcYrYgox9EMg4dOmO98XfbS4MI0z38y
         l3eyjKKueH+OsqQ6vpMSBSiRfAIl+WTDWWxT4rlx4B8xRYUa4dHO4GLuWRZtHPCdiquc
         Q8vU3AgF9EgXR7awHe0F500NGUHfp6JZOGvxH0rUNqotEod+yhvtezKGw8tR0x3kzJjF
         rIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=13FtjbtfLSbB7lUu2KMXehtRfJlBejW7Rr8iZY5Tpxo=;
        b=HcZ4s5K0xhunq2UCjn82KrmJfdUiJviZE5PeULCnzvMiDLP4uCL4ywByF2/G0bAWI7
         X0b5EE9myevL07z448kaXfTs8pJ8xvN6Vv0bM7rX87gDWrVNtnCVpGoLuWQdDDD/pnkb
         ry7HhwxY36uEKXdCDgL1MotuT4H6n4pMEniz1WKA6krtXLcuroYnP6tNU7SGBYuXe1bN
         sqdOgbLqqTX2hxX0wvjC0Zk6UUfg84n5Sg6YbZ7ruub/Or3u3eo+kK55Q93D6ax38YRA
         +b85yps4R0X42CC+rVtvG3pSVv4W4TlISQ4Uoi+jNFINzP7f/a3Rv54Ve0ugs6aG2/Sd
         ut7g==
X-Gm-Message-State: AOAM533IT8n6mHY2iXq5T55rZKz0sFm9zNdtAIom5MQPrhC/J2HaQqtO
        hW7UJSwyn1/3VQkYHwWU6EA=
X-Google-Smtp-Source: ABdhPJwvMQA7GVtYoy+Xz6ijPiKZoA2xSYef8WE3UDmkEnx3stuv579+IF8wQyCwOkO5U/tjnFfdqA==
X-Received: by 2002:a17:906:b0d3:: with SMTP id bk19mr8662181ejb.167.1595582002571;
        Fri, 24 Jul 2020 02:13:22 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q25sm319164edb.58.2020.07.24.02.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 02:13:21 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:13:19 +0200
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
Message-ID: <20200724091319.GA517988@gmail.com>
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

> Add lock_modules() and unlock_modules() wrappers for acquiring module_mutex
> in order to remove the compile time dependency to it.
> 
> Cc: linux-mm@kvack.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/linux/module.h      | 18 ++++++++++++++++++
>  kernel/kprobes.c            |  4 ++--
>  kernel/trace/trace_kprobe.c |  4 ++--
>  3 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 2e6670860d27..8850b9692b8f 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -705,6 +705,16 @@ static inline bool is_livepatch_module(struct module *mod)
>  bool is_module_sig_enforced(void);
>  void set_module_sig_enforced(void);
>  
> +static inline void lock_modules(void)
> +{
> +	mutex_lock(&module_mutex);
> +}
> +
> +static inline void unlock_modules(void)
> +{
> +	mutex_unlock(&module_mutex);
> +}
> +
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -852,6 +862,14 @@ void *dereference_module_function_descriptor(struct module *mod, void *ptr)
>  	return ptr;
>  }
>  
> +static inline void lock_modules(void)
> +{
> +}
> +
> +static inline void unlock_modules(void)
> +{
> +}

Minor namespace nit: when introducing new locking wrappers please 
standardize on the XYZ_lock()/XYZ_unlock() nomenclature, i.e.:

	modules_lock()
	...
	modules_unlock()

Similarly to the mutex_lock/unlock(&module_mutex) API that it is 
wrapping.

Also, JFYI, the overwhelming majority of the modules related APIs use 
module_*(), i.e. singular - not plural, so 
module_lock()/module_unlock() would be the more canonical choice. 
(But both sound fine to me)

Thanks,

	Ingo
