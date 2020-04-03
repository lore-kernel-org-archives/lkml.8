Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A4EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BC4206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWypiIdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403869AbgDCSDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:03:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728219AbgDCSDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585937016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CgXbM5tM4nWTswrQ/RgYu+O+1APq3VPj1+jTCpISTXI=;
        b=XWypiIdBePENrnQSCoyRvvT7nBdjpwFCt8FKNbSsipN0Kt+SREpvOzX/F9qiao3FdtWkvZ
        6NRESfLZRW17gIxFNopDtONPQd/mGaPPtcIjLFXxo0cwLcJqoFoqJxc0ZjIXfF/IllnFlS
        xyNapmD8KTEqpvVw825r+cHBqjZr2tQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-V9u6mrzrMACNC1HS3NOGKQ-1; Fri, 03 Apr 2020 14:03:33 -0400
X-MC-Unique: V9u6mrzrMACNC1HS3NOGKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42DA88017F6;
        Fri,  3 Apr 2020 18:03:31 +0000 (UTC)
Received: from redhat.com (ovpn-114-27.phx2.redhat.com [10.3.114.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58F7510002CD;
        Fri,  3 Apr 2020 18:03:30 +0000 (UTC)
Date:   Fri, 3 Apr 2020 14:03:28 -0400
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [POC 22/23] livepatch/module: Remove obsolete copy_module_elf()
Message-ID: <20200403180328.GC30284@redhat.com>
References: <20200117150323.21801-1-pmladek@suse.com>
 <20200117150323.21801-23-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117150323.21801-23-pmladek@suse.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:03:22PM +0100, Petr Mladek wrote:
> The split livepatch modules can be relocated immedidately when they
> are loaded. There is no longer needed to preserve the elf sections.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  Documentation/livepatch/module-elf-format.rst | 18 ++++++
>  include/linux/module.h                        |  3 -
>  kernel/module.c                               | 87 ---------------------------
>  3 files changed, 18 insertions(+), 90 deletions(-)
> 
> diff --git a/Documentation/livepatch/module-elf-format.rst b/Documentation/livepatch/module-elf-format.rst
> index 9f0c997d4940..8c6b894c4661 100644
> --- a/Documentation/livepatch/module-elf-format.rst
> +++ b/Documentation/livepatch/module-elf-format.rst
> @@ -14,6 +14,7 @@ This document outlines the Elf format requirements that livepatch modules must f
>     4. Livepatch symbols
>        4.1 A livepatch module's symbol table
>        4.2 Livepatch symbol format
> +   5. Symbol table and Elf section access
>  
>  1. Background and motivation
>  ============================
> @@ -295,3 +296,20 @@ See include/uapi/linux/elf.h for the actual definitions.
>  [*]
>    Note that the 'Ndx' (Section index) for these symbols is SHN_LIVEPATCH (0xff20).
>    "OS" means OS-specific.
> +
> +5. Symbol table and Elf section access
> +======================================
> +A livepatch module's symbol table is accessible through module->symtab.
> +
> +Since apply_relocate_add() requires access to a module's section headers,
> +symbol table, and relocation section indices, Elf information is preserved for
> +livepatch modules and is made accessible by the module loader through
> +module->klp_info, which is a klp_modinfo struct. When a livepatch module loads,
> +this struct is filled in by the module loader. Its fields are documented below::
> +
> +	struct klp_modinfo {
> +		Elf_Ehdr hdr; /* Elf header */
> +		Elf_Shdr *sechdrs; /* Section header table */
> +		char *secstrings; /* String table for the section headers */
> +		unsigned int symndx; /* The symbol table section index */
> +	};

I think this file was inadvertently reverted, or at least the Symbol
table and Elf section access section was supposed to stay gone, right?

-- Joe

