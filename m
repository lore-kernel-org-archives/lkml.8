Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DC4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014632253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMsM0SM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgAULLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:11:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23250 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbgAULLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579605104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nCBKi9+PmsfMFoDzW4j7ikn7z/mWHYKyl43DcMVv+RE=;
        b=aMsM0SM1Z1YMynr90Q9MZu+fy75KdPGE3CpWCo8fSCD0VI90g0T2xe/I0z5Awzp4CxCJsx
        GUm41CeeOTRKHLwd2CnGYcZHw9CQCsjNuWbYhbdck6eoXOWKR++VUnAd1gB+GN21ZiO1+0
        s8OMCOMKtSohHD1Vywh+qfvz+PO2U8g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-6wzhK1ZmOCy9ZlnKSxcjrg-1; Tue, 21 Jan 2020 06:11:42 -0500
X-MC-Unique: 6wzhK1ZmOCy9ZlnKSxcjrg-1
Received: by mail-wr1-f70.google.com with SMTP id f15so1174309wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:11:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nCBKi9+PmsfMFoDzW4j7ikn7z/mWHYKyl43DcMVv+RE=;
        b=CsNaxFINFpePRESDYJuxcSLWXXjOJtxDukyb2yQwWQCWA2R52zpGFRAVzp4866yvRv
         UNa+rDHfAYtbJX/8Y54Xmgijoby5kkTVK7A8QBJ9/szFpMY66ChaIivSuBy16esrfuvF
         EMUkoSj4PXd/k4aqv0jcO2i5aP/8hkrlRsBajSbxJ8nmay0tdM0tUnHu/bdQEBUj8nXg
         MKwsJ1aPocF3yL1j/JWX3aJEGaP4mQKc05DPeEy696oJ+CKdmjQcevaVACCh/7yTj3qw
         6WhB97RYbg17Zxh6tyj2ypi7zNzOd2+Cw/ZvG09pXEBGUm/phyEoHaZ/x3k0Rr4SF1IJ
         2hlA==
X-Gm-Message-State: APjAAAXkudwGNFbh1OyDlJBjZGKMSlOHfV0JH4ptoj+Pj5eD7+KxASRM
        1DUfM6SfIG8242Z/L69jnY1NNsY33JaU6kmghecrO7TzpBxyDesWZxs0kDIka9Z5xWxpEpxoDsW
        Nxk5Y0Ofgqv3lBBbwojNIh9gc
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr4767402wrw.255.1579605101037;
        Tue, 21 Jan 2020 03:11:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqygGE3nl4UgJqtbPQRpE2XRkD3JsXD4jzW9q3NxWhQM9wnKJ7bY/+s8odMR38pb826P6N5mNQ==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr4767377wrw.255.1579605100718;
        Tue, 21 Jan 2020 03:11:40 -0800 (PST)
Received: from [192.168.1.81] (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id w8sm4228305wmd.2.2020.01.21.03.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 03:11:40 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
Subject: Re: [POC 01/23] module: Allow to delete module also from inside
 kernel
To:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200117150323.21801-1-pmladek@suse.com>
 <20200117150323.21801-2-pmladek@suse.com>
Message-ID: <74863d91-9515-ce9b-2ac2-ad1e9c777163@redhat.com>
Date:   Tue, 21 Jan 2020 11:11:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200117150323.21801-2-pmladek@suse.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 1/17/20 3:03 PM, Petr Mladek wrote:
> Livepatch subsystems will need to automatically load and delete
> livepatch module when the livepatched one is being removed
> or when the entire livepatch is being removed.
> 
> The code stopping the kernel module is moved to separate function
> so that it can be reused.
> 
> The function always have rights to do the action. Also it does not
> need to search for struct module because it is already passed as
> a parameter.
> 
> On the other hand, it has to make sure that the given struct module
> can't be released in parallel. It is achieved by combining module_put()
> and module_delete() functionality in a single function.
> 
> This patch does not change the existing behavior of delete_module
> syscall.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> module: Add module_put_and_delete()
> ---
>   include/linux/module.h |   5 +++
>   kernel/module.c        | 119 +++++++++++++++++++++++++++++++------------------
>   2 files changed, 80 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index bd165ba68617..f69f3fd72dd5 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -623,6 +623,7 @@ extern void __module_get(struct module *module);
>   extern bool try_module_get(struct module *module);
>   
>   extern void module_put(struct module *module);
> +extern int module_put_and_delete(struct module *mod);
>   
>   #else /*!CONFIG_MODULE_UNLOAD*/
>   static inline bool try_module_get(struct module *module)
> @@ -632,6 +633,10 @@ static inline bool try_module_get(struct module *module)
>   static inline void module_put(struct module *module)
>   {
>   }
> +static inline int module_put_and_delete(struct module *mod)
> +{
> +	return 0;
> +}
>   static inline void __module_get(struct module *module)
>   {
>   }
> diff --git a/kernel/module.c b/kernel/module.c
> index b56f3224b161..b3f11524f8f9 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -964,62 +964,36 @@ EXPORT_SYMBOL(module_refcount);
>   /* This exists whether we can unload or not */
>   static void free_module(struct module *mod);
>   
> -SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
> -		unsigned int, flags)
> +int stop_module(struct module *mod, int flags)
>   {
> -	struct module *mod;
> -	char name[MODULE_NAME_LEN];
> -	int ret, forced = 0;
> -
> -	if (!capable(CAP_SYS_MODULE) || modules_disabled)
> -		return -EPERM;
> -
> -	if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0)
> -		return -EFAULT;
> -	name[MODULE_NAME_LEN-1] = '\0';
> +	int forced = 0;
>   
> -	audit_log_kern_module(name);
> -
> -	if (mutex_lock_interruptible(&module_mutex) != 0)
> -		return -EINTR;
> -
> -	mod = find_module(name);
> -	if (!mod) {
> -		ret = -ENOENT;
> -		goto out;
> -	}
> -
> -	if (!list_empty(&mod->source_list)) {
> -		/* Other modules depend on us: get rid of them first. */
> -		ret = -EWOULDBLOCK;
> -		goto out;
> -	}
> +	/* Other modules depend on us: get rid of them first. */
> +	if (!list_empty(&mod->source_list))
> +		return -EWOULDBLOCK;
>   
>   	/* Doing init or already dying? */
>   	if (mod->state != MODULE_STATE_LIVE) {
>   		/* FIXME: if (force), slam module count damn the torpedoes */
>   		pr_debug("%s already dying\n", mod->name);
> -		ret = -EBUSY;
> -		goto out;
> +		return -EBUSY;
>   	}
>   
>   	/* If it has an init func, it must have an exit func to unload */
>   	if (mod->init && !mod->exit) {
>   		forced = try_force_unload(flags);
> -		if (!forced) {
> -			/* This module can't be removed */
> -			ret = -EBUSY;
> -			goto out;
> -		}
> +		/* This module can't be removed */
> +		if (!forced)
> +			return -EBUSY;
>   	}
>   
>   	/* Stop the machine so refcounts can't move and disable module. */
> -	ret = try_stop_module(mod, flags, &forced);
> -	if (ret != 0)
> -		goto out;
> +	return try_stop_module(mod, flags, &forced);
> +}
>   
> -	mutex_unlock(&module_mutex);
> -	/* Final destruction now no one is using it. */
> +/* Final destruction now no one is using it. */

Nit: Looks like some copy/paste mixup

> +static void destruct_module(struct module *mod)
> +{
>   	if (mod->exit != NULL)
>   		mod->exit();
>   	blocking_notifier_call_chain(&module_notify_list,
> @@ -1033,8 +1007,44 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
>   	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
>   
>   	free_module(mod);
> +
>   	/* someone could wait for the module in add_unformed_module() */
>   	wake_up_all(&module_wq);
> +}
> +
> +SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
> +		unsigned int, flags)
> +{
> +	struct module *mod;
> +	char name[MODULE_NAME_LEN];
> +	int ret;
> +
> +	if (!capable(CAP_SYS_MODULE) || modules_disabled)
> +		return -EPERM;
> +
> +	if (strncpy_from_user(name, name_user, MODULE_NAME_LEN-1) < 0)
> +		return -EFAULT;
> +	name[MODULE_NAME_LEN-1] = '\0';
> +
> +	audit_log_kern_module(name);
> +
> +	if (mutex_lock_interruptible(&module_mutex) != 0)
> +		return -EINTR;
> +
> +	mod = find_module(name);
> +	if (!mod) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	ret = stop_module(mod, flags);
> +	if (ret)
> +		goto out;
> +
> +	mutex_unlock(&module_mutex);
> +
> +/* Final destruction now no one is using it. */
> +	destruct_module(mod);
>   	return 0;
>   out:
>   	mutex_unlock(&module_mutex);
> @@ -1138,20 +1148,41 @@ bool try_module_get(struct module *module)
>   }
>   EXPORT_SYMBOL(try_module_get);
>   
> -void module_put(struct module *module)
> +/* Must be called under module_mutex or with preemtion disabled */

Might be worth adding some asserts to check for that.

> +static void __module_put(struct module* module)
>   {
>   	int ret;
>   
> +	ret = atomic_dec_if_positive(&module->refcnt);
> +	WARN_ON(ret < 0);	/* Failed to put refcount */
> +	trace_module_put(module, _RET_IP_);
> +}
> +
> +void module_put(struct module *module)
> +{
>   	if (module) {
>   		preempt_disable();
> -		ret = atomic_dec_if_positive(&module->refcnt);
> -		WARN_ON(ret < 0);	/* Failed to put refcount */
> -		trace_module_put(module, _RET_IP_);
> +		__module_put(module);
>   		preempt_enable();
>   	}
>   }
>   EXPORT_SYMBOL(module_put);
>   
> +int module_put_and_delete(struct module *mod)
> +{
> +	int ret;
> +	mutex_lock(&module_mutex);
> +	__module_put(mod);
> +	ret = stop_module(mod, 0);
> +	mutex_unlock(&module_mutex);
> +
> +	if (ret)
> +		return ret;
> +
> +	destruct_module(mod);
> +	return 0;
> +}
> +
>   #else /* !CONFIG_MODULE_UNLOAD */
>   static inline void print_unload_info(struct seq_file *m, struct module *mod)
>   {
> 

Thanks,

-- 
Julien Thierry

