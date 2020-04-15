Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0819FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D79206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg+TSE7U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416032AbgDOQa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:30:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43719 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415869AbgDOQaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586968222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WzpR05hduntNRWtQhVVQpv6HgaJXtMqnfrfruMQ2P7I=;
        b=fg+TSE7UFVZzJMKTJSaLgvRCXIMhEABRqexhWua9jX8eExW1yyR7nwYgwrbqXQzaB9YpoV
        S/k6vdG/1kKo7CiCd/35Z4UX646TYPmjrqdlgTwrHeLKsO72eD7plOrFegohPtJN7yl2dz
        sQuJgzsSk3NwC8tchBCUWNQbfoNA89Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-8L2yehreNNCK9naYJVjYPw-1; Wed, 15 Apr 2020 12:30:20 -0400
X-MC-Unique: 8L2yehreNNCK9naYJVjYPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6187802560;
        Wed, 15 Apr 2020 16:30:18 +0000 (UTC)
Received: from treble (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 26CF599E03;
        Wed, 15 Apr 2020 16:30:18 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:30:16 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH 1/7] livepatch: Apply vmlinux-specific KLP relocations
 early
Message-ID: <20200415163016.2tfprvxvqmcq6m6i@treble>
References: <cover.1586881704.git.jpoimboe@redhat.com>
 <8c3af42719fe0add37605ede634c7035a90f9acc.1586881704.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2004151633010.13470@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004151633010.13470@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 04:34:26PM +0200, Miroslav Benes wrote:
> Just a nit below
> 
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index e894e74905f3..d9e9b76f6054 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -234,14 +234,30 @@ void klp_shadow_free_all(unsigned long id, klp_shadow_dtor_t dtor);
> >  struct klp_state *klp_get_state(struct klp_patch *patch, unsigned long id);
> >  struct klp_state *klp_get_prev_state(unsigned long id);
> >  
> > +int klp_write_relocations(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> > +			  const char *shstrtab, const char *strtab,
> > +			  unsigned int symindex, struct module *pmod,
> > +			  const char *objname);
> > +
> >  #else /* !CONFIG_LIVEPATCH */
> >  
> > +struct klp_object;
> > +
> 
> Is the forward declaration necessary here?

Apparently not, that was leftover from a previous iteration...

> >  static inline int klp_module_coming(struct module *mod) { return 0; }
> >  static inline void klp_module_going(struct module *mod) {}
> >  static inline bool klp_patch_pending(struct task_struct *task) { return false; }
> >  static inline void klp_update_patch_state(struct task_struct *task) {}
> >  static inline void klp_copy_process(struct task_struct *child) {}
> >  
> > +static inline
> > +int klp_write_relocations(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> > +			  const char *shstrtab, const char *strtab,
> > +			  unsigned int symindex, struct module *pmod,
> > +			  const char *objname)
> > +{
> > +	return 0;
> > +}
> > +
> >  #endif /* CONFIG_LIVEPATCH */
> 
> Miroslav
> 

-- 
Josh

