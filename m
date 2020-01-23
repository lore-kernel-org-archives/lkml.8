Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE44C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E38221569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXB3f6r+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAWQwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:52:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44211 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAWQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:52:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so1573033plo.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C25w/GEX+B7a1YmYzSZutb0HdBvba9WfZTsok53isvI=;
        b=nXB3f6r+N0orzrPhauDEj9qAyXnR6jwj08hwnWiPxEtTMuP2EZEsaVy2uX31f6myhu
         CRB/ssIL9IzgSJGTdeMPID4nVlsbWGQlRzWhe5tluSX67M6+0FEmbc7+Cp9Z9JF7aIov
         12xFXy3ZIT2cvkHyHUhHpW+4kv3yB8VXslznSXTA4zR3XetCjpMMS7OEr7p3uzRuSCx6
         vCTodS9dr7epPTi/qRDAODsoFBHa/uAllFKUjNSW//2gEabJgi8RAltAHQefHNcHrPym
         VoRqai6XEySsHKIFgOrEFMLK43I+ELtx4wqsJZ+YbWcl+CdFOGpuncaFDBsTEaD2XiPD
         XQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C25w/GEX+B7a1YmYzSZutb0HdBvba9WfZTsok53isvI=;
        b=XHYgSgQHNvm91T13CBtawtlq9FrbellAHqEkl0EqPExnorqSlX+VsgImj7pTpDLhm2
         +kMvPsnRW38TZXnG9B+fFhQvUudcRYmRP/US2f75TqoiKdbbqAC8fsVSLmO0LQiW6roo
         VXX+vNnwByEEjHsdwXg6gaoo9F4ep7iTH7k62i27/0P8fos6RHaAWcXBArnjCzPZWVHD
         vEAqSxozYWRpw2i1Xr+6SGW4xLO7GsYuKiOQVKi6HdUCwzjg43BwdjklNxI89jRDKP1v
         BSLeXjITqrK38lUxyWCeUJ+i96BW2FJbwuRa4PkG+hwxeUvFzMEbbOOByZwidbOGEukb
         UHMg==
X-Gm-Message-State: APjAAAWyNrclWWrAH7tE/JC6JZk/Bz4Jm3UQuS7ZEGe4+Gag+0MK3mdJ
        J4Tz1ywDLhz6hzxmf/iSW5HARYCt
X-Google-Smtp-Source: APXvYqx+ecdqbLe2gNFYL+BiR1oLCsos0/UYR9/iT2BidZAuXH5qxWxXoBOIZ6jkLO20RUVTSem0ng==
X-Received: by 2002:a17:902:8494:: with SMTP id c20mr17746917plo.189.1579798350367;
        Thu, 23 Jan 2020 08:52:30 -0800 (PST)
Received: from workstation-portable ([103.211.17.138])
        by smtp.gmail.com with ESMTPSA id u3sm3445364pjv.32.2020.01.23.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 08:52:29 -0800 (PST)
Date:   Thu, 23 Jan 2020 22:22:24 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] kernel: module: Pass lockdep expression to RCU lists
Message-ID: <20200123165224.GA4484@workstation-portable>
References: <20200121124745.14864-1-frextrite@gmail.com>
 <20200123121010.GA9011@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123121010.GA9011@linux-8ccs>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 01:10:10PM +0100, Jessica Yu wrote:
> +++ Amol Grover [21/01/20 18:17 +0530]:
> > modules is traversed using list_for_each_entry_rcu outside an
> > RCU read-side critical section but under the protection
> > of module_mutex or with preemption disabled.
> > 
> > Hence, add corresponding lockdep expression to silence false-positive
> > lockdep warnings, and harden RCU lists.
> > 
> > list_for_each_entry_rcu when traversed inside a preempt disabled
> > section, doesn't need an explicit lockdep expression since it is
> > implicitly checked for.
> > 
> > Add macro for the corresponding lockdep expression.
> > 
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> 
> Hi Amol!
> 
> Masami already submitted a patch for this, it's been in linux-next for
> a while. See commit bf08949cc8b9 ("modules: lockdep: Suppress
> suspicious RCU usage warning").
> 

Hey Jessica,

Thank you for reviewing the patch!

Thanks
Amol

> Thanks!
> 
> Jessica
> 
> > ---
> > kernel/module.c | 12 +++++++-----
> > 1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/module.c b/kernel/module.c
> > index b56f3224b161..2425f58159dd 100644
> > --- a/kernel/module.c
> > +++ b/kernel/module.c
> > @@ -84,6 +84,8 @@
> >  * 3) module_addr_min/module_addr_max.
> >  * (delete and add uses RCU list operations). */
> > DEFINE_MUTEX(module_mutex);
> > +#define module_mutex_held() \
> > +	lockdep_is_held(&module_mutex)
> > EXPORT_SYMBOL_GPL(module_mutex);
> > static LIST_HEAD(modules);
> > 
> > @@ -214,7 +216,7 @@ static struct module *mod_find(unsigned long addr)
> > {
> > 	struct module *mod;
> > 
> > -	list_for_each_entry_rcu(mod, &modules, list) {
> > +	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> > 		if (within_module(addr, mod))
> > 			return mod;
> > 	}
> > @@ -448,7 +450,7 @@ bool each_symbol_section(bool (*fn)(const struct symsearch *arr,
> > 	if (each_symbol_in_section(arr, ARRAY_SIZE(arr), NULL, fn, data))
> > 		return true;
> > 
> > -	list_for_each_entry_rcu(mod, &modules, list) {
> > +	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> > 		struct symsearch arr[] = {
> > 			{ mod->syms, mod->syms + mod->num_syms, mod->crcs,
> > 			  NOT_GPL_ONLY, false },
> > @@ -616,7 +618,7 @@ static struct module *find_module_all(const char *name, size_t len,
> > 
> > 	module_assert_mutex_or_preempt();
> > 
> > -	list_for_each_entry_rcu(mod, &modules, list) {
> > +	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> > 		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
> > 			continue;
> > 		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
> > @@ -2040,7 +2042,7 @@ void set_all_modules_text_rw(void)
> > 		return;
> > 
> > 	mutex_lock(&module_mutex);
> > -	list_for_each_entry_rcu(mod, &modules, list) {
> > +	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> > 		if (mod->state == MODULE_STATE_UNFORMED)
> > 			continue;
> > 
> > @@ -2059,7 +2061,7 @@ void set_all_modules_text_ro(void)
> > 		return;
> > 
> > 	mutex_lock(&module_mutex);
> > -	list_for_each_entry_rcu(mod, &modules, list) {
> > +	list_for_each_entry_rcu(mod, &modules, list, module_mutex_held()) {
> > 		/*
> > 		 * Ignore going modules since it's possible that ro
> > 		 * protection has already been disabled, otherwise we'll
> > -- 
> > 2.24.1
> > 
