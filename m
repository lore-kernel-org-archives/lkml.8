Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B831C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79A92075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lzkk0XPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgEFVQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:16:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50440 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730010AbgEFVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588799760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7DyNQyHWzxz6uGwnYuDMaMxKcoBgqV2azBIQN2WlEbE=;
        b=Lzkk0XPiz/rIXY4mx8nYhnQW8pyi26qpHoaa0SQPPc/BeUO94nhrTXSXtKx3Pk18IO0H9L
        b2YDMyghovFz1V4akvz85RAyctfe6M4N4tE79YoFh1UNK4OPOH/wbdRNFOO+8X0SRaV9Kf
        m/THqYpyonKQjgM+UoEoy8ed9wvH4Gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-4EyUww1uN9-HEr2kbOQ9Eg-1; Wed, 06 May 2020 17:15:56 -0400
X-MC-Unique: 4EyUww1uN9-HEr2kbOQ9Eg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 854D1A0BD8;
        Wed,  6 May 2020 21:15:54 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B71E4707A5;
        Wed,  6 May 2020 21:15:49 +0000 (UTC)
Date:   Wed, 6 May 2020 16:15:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 16/18] static_call: Allow early init
Message-ID: <20200506211547.2vnuhkfzhgbi27dm@treble>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.706674211@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501202944.706674211@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:29:05PM +0200, Peter Zijlstra wrote:
> In order to use static_call() to wire up x86_pmu, we need to
> initialize earlier; copy some of the tricks from jump_label to enable
> this.
> 
> Primarily we overload key->next to store a sites pointer when there
> are no modules, this avoids having to use kmalloc() to initialize the
> sites and allows us to run much earlier.
> 
> (arguably, this is much much earlier than needed for perf, but it
> might allow other uses.)
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/setup.c       |    2 +
>  arch/x86/kernel/static_call.c |    8 +++++-
>  include/linux/static_call.h   |   15 ++++++++++--
>  kernel/static_call.c          |   52 +++++++++++++++++++++++++++++++++++++++---
>  4 files changed, 71 insertions(+), 6 deletions(-)

This doesn't work when the key is defined in a module.  In
__static_call_update(), first.site_mod->mod is NULL, but
static_call_key_sites() points to the module's call sites.

This seems to fix it (sorry, also has the 'next' -> 'mods' rename).
The actual fix is in static_call_key_sites() and static_call_key_mods().

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index e112553cfce6..ee55075707f1 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -110,9 +110,10 @@ struct static_call_mod {
 struct static_call_key {
 	void *func;
 	union {
-		/* bit0 => 0 - next, 1 - sites */
+		/* bit 0: 0 = mods; 1 = sites */
 		unsigned long type;
-		struct static_call_mod *next;
+
+		struct static_call_mod *mods;
 		struct static_call_site *sites;
 	};
 };
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 783953db28c4..d78e50c5b8a3 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -94,23 +94,23 @@ static inline void static_call_sort_entries(struct static_call_site *start,
 	     static_call_site_cmp, static_call_site_swap);
 }
 
-static inline bool static_call_key_has_next(struct static_call_key *key)
+static inline bool static_call_key_has_mods(struct static_call_key *key)
 {
 	return !(key->type & 1);
 }
 
-static inline struct static_call_mod *static_call_key_next(struct static_call_key *key)
+static inline struct static_call_mod *static_call_key_mods(struct static_call_key *key)
 {
-	if (static_call_key_has_next(key))
-		return key->next->next;
+	if (!static_call_key_has_mods(key))
+		return NULL;
 
-	return NULL;
+	return key->mods;
 }
 
 static inline struct static_call_site *static_call_key_sites(struct static_call_key *key)
 {
-	if (static_call_key_has_next(key))
-		return key->next->sites;
+	if (static_call_key_has_mods(key))
+		return NULL;
 
 	return (struct static_call_site *)(key->type & ~1);
 }
@@ -118,7 +118,12 @@ static inline struct static_call_site *static_call_key_sites(struct static_call_
 void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 {
 	struct static_call_site *site, *stop;
-	struct static_call_mod *site_mod, first;
+	struct static_call_mod *site_mod;
+	struct static_call_mod first = {
+		.next = static_call_key_mods(key),
+		.mod = NULL,
+		.sites = static_call_key_sites(key),
+	};
 
 	cpus_read_lock();
 	static_call_lock();
@@ -137,17 +142,14 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 	if (WARN_ON_ONCE(!static_call_initialized))
 		goto done;
 
-	first = (struct static_call_mod){
-		.next = static_call_key_next(key),
-		.mod = NULL,
-		.sites = static_call_key_sites(key),
-	};
-
 	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
 		if (!site_mod->sites) {
 			/*
 			 * This can happen if the static call key is defined in
 			 * a module which doesn't use it.
+			 *
+			 * It also happens in the has_mods case, where the
+			 * 'first' entry has no sites associated with it.
 			 */
 			continue;
 		}
@@ -228,12 +230,12 @@ static int __static_call_init(struct module *mod,
 			if (!site_mod)
 				return -ENOMEM;
 
-			if (!static_call_key_has_next(key)) {
+			if (!static_call_key_has_mods(key)) {
 				site_mod->mod = NULL;
 				site_mod->next = NULL;
 				site_mod->sites = static_call_key_sites(key);
 
-				key->next = site_mod;
+				key->mods = site_mod;
 
 				site_mod = kzalloc(sizeof(*site_mod), GFP_KERNEL);
 				if (!site_mod)
@@ -242,8 +244,8 @@ static int __static_call_init(struct module *mod,
 
 			site_mod->mod = mod;
 			site_mod->sites = site;
-			site_mod->next = key->next;
-			key->next = site_mod;
+			site_mod->next = key->mods;
+			key->mods = site_mod;
 		}
 
 do_transform:
@@ -328,7 +330,7 @@ static void static_call_del_module(struct module *mod)
 
 		prev_key = key;
 
-		for (prev = &key->next, site_mod = key->next;
+		for (prev = &key->mods, site_mod = key->mods;
 		     site_mod && site_mod->mod != mod;
 		     prev = &site_mod->next, site_mod = site_mod->next)
 			;

