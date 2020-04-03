Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27C9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C04206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WswrqRlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390945AbgDCQ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:56:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23372 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgDCQ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585933001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YEhHAWV6eoa7/VaPAdgqUWSGR2q1/D+L9I10tbha8Hs=;
        b=WswrqRlhILM2mTyOBLepXocI6q8KfS/MuUaXDAfvSjn8hmTQxr5vL0beaw2ttcmHUuJJFk
        PbQRsdhbGomohI3VlECykYlfgia1RWTj0h6d2LuGJnonQSTzETtY8UXqcOPyjw8zGmzeGM
        ZEp+7vCKPH0tS/WH+zK9a38UXpYtxb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-UGSdHACePgakTn3OGQp4rA-1; Fri, 03 Apr 2020 12:56:37 -0400
X-MC-Unique: UGSdHACePgakTn3OGQp4rA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7DD8190B2A2;
        Fri,  3 Apr 2020 16:56:35 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 391B35C3F8;
        Fri,  3 Apr 2020 16:56:34 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:56:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200403165631.hrxxm3pnzqa4vxln@treble>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 06:37:16PM +0200, Peter Zijlstra wrote:
> 
> We're very close to enforcing W^X memory, refuse to load modules that
> violate this principle per construction.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  kernel/module.c |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2044,9 +2044,28 @@ static void module_enable_x(const struct
>  	frob_text(&mod->core_layout, set_memory_x);
>  	frob_text(&mod->init_layout, set_memory_x);
>  }
> +
> +static int module_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> +			       char *secstrings, struct module *mod)

A verb would be nice: "module_enforce_rwx_sections"?

Shouldn't this be under STRICT_MODULE_RWX instead of
ARCH_HAS_STRICT_MODULE_RWX?

> +{
> +	int i;
> +
> +	for (i = 0; i < hdr->e_shnum; i++) {
> +		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
> +			return -ENOEXEC;

I think you only want the error when both are set?

		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE) == (SHF_EXECINSTR|SHF_WRITE))

-- 
Josh

